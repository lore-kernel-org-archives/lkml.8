Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5598C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD0E20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgEFQcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:32:45 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:58596 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbgEFQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:32:44 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B68C980500;
        Wed,  6 May 2020 18:32:38 +0200 (CEST)
Date:   Wed, 6 May 2020 18:32:37 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 1/6] of_graph: add of_graph_get_local_port()
Message-ID: <20200506163237.GA19296@ravnborg.org>
References: <20200418170703.1583-1-digetx@gmail.com>
 <20200418170703.1583-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418170703.1583-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=cgQggk8NgEdHG04IN60A:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

On Sat, Apr 18, 2020 at 08:06:58PM +0300, Dmitry Osipenko wrote:
> In some case, like a DRM display code for example, it's useful to silently
> check whether port node exists at all in a device-tree before proceeding
> with parsing the graph.
> 
> This patch adds of_graph_get_local_port() which returns pointer to a local
> port node, or NULL if graph isn't specified in a device-tree for a given
> device node.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Nice little helper function.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Rob - OK to commit to drm-misc-next?

	Sam

> ---
>  drivers/of/property.c    | 32 +++++++++++++++++++++++---------
>  include/linux/of_graph.h |  7 +++++++
>  2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 252e4f600155..5dbeccaabb86 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -608,15 +608,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>  	 * parent port node.
>  	 */
>  	if (!prev) {
> -		struct device_node *node;
> -
> -		node = of_get_child_by_name(parent, "ports");
> -		if (node)
> -			parent = node;
> -
> -		port = of_get_child_by_name(parent, "port");
> -		of_node_put(node);
> -
> +		port = of_graph_get_local_port(parent);
>  		if (!port) {
>  			pr_err("graph: no port node found in %pOF\n", parent);
>  			return NULL;
> @@ -765,6 +757,28 @@ struct device_node *of_graph_get_remote_port(const struct device_node *node)
>  }
>  EXPORT_SYMBOL(of_graph_get_remote_port);
>  
> +/**
> + * of_graph_get_local_port() - get local port node
> + * @node: pointer to a local endpoint device_node
> + *
> + * Return: First local port node associated with local endpoint node linked
> + *	   to @node. Use of_node_put() on it when done.
> + */
> +struct device_node *of_graph_get_local_port(const struct device_node *node)
> +{
> +	struct device_node *ports, *port;
> +
> +	ports = of_get_child_by_name(node, "ports");
> +	if (ports)
> +		node = ports;
> +
> +	port = of_get_child_by_name(node, "port");
> +	of_node_put(ports);
> +
> +	return port;
> +}
> +EXPORT_SYMBOL(of_graph_get_local_port);
> +
>  int of_graph_get_endpoint_count(const struct device_node *np)
>  {
>  	struct device_node *endpoint;
> diff --git a/include/linux/of_graph.h b/include/linux/of_graph.h
> index 01038a6aade0..1fdeb72c7765 100644
> --- a/include/linux/of_graph.h
> +++ b/include/linux/of_graph.h
> @@ -54,6 +54,7 @@ struct device_node *of_graph_get_remote_port_parent(
>  struct device_node *of_graph_get_remote_port(const struct device_node *node);
>  struct device_node *of_graph_get_remote_node(const struct device_node *node,
>  					     u32 port, u32 endpoint);
> +struct device_node *of_graph_get_local_port(const struct device_node *node);
>  #else
>  
>  static inline int of_graph_parse_endpoint(const struct device_node *node,
> @@ -116,6 +117,12 @@ static inline struct device_node *of_graph_get_remote_node(
>  	return NULL;
>  }
>  
> +static inline struct device_node *of_graph_get_local_port(
> +					const struct device_node *node)
> +{
> +	return NULL;
> +}
> +
>  #endif /* CONFIG_OF */
>  
>  #endif /* __LINUX_OF_GRAPH_H */
> -- 
> 2.26.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
