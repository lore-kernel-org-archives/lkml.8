Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE73AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A615920722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="X+IRvj1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgGAFpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 01:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAFpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 01:45:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422AC03E979;
        Tue, 30 Jun 2020 22:45:51 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 686F4556;
        Wed,  1 Jul 2020 07:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593582347;
        bh=mGWu/1XJbM4KGrtlPmkgFMmfJiW0pibp/qTE2B02jfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+IRvj1JQdnrCzqeSPqQAnKWc5n8pBOvwmPEoRCo5kDbAhlzI3O/ybiM5Np6j7AcY
         dgzuPrtz48/lWFwu1e2QbuxWjOqaKlvmXg5/9wFfT6mRXC62oAxi/4sUBPKdgntwbW
         lBNa3k/xfcURd85HCkcaeh3ovjlEG2f4hwBIP6lA=
Date:   Wed, 1 Jul 2020 08:45:43 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] of_graph: add of_graph_is_present()
Message-ID: <20200701054543.GA5963@pendragon.ideasonboard.com>
References: <20200701021617.12030-1-digetx@gmail.com>
 <20200701021617.12030-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701021617.12030-2-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the patch.

On Wed, Jul 01, 2020 at 05:16:16AM +0300, Dmitry Osipenko wrote:
> In some case, like a DRM display code for example, it's useful to silently
> check whether port node exists at all in a device-tree before proceeding
> with parsing of the graph.
> 
> This patch adds of_graph_is_present() which returns true if given
> device-tree node contains OF graph port.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/of/property.c    | 52 +++++++++++++++++++++++++++++++++-------
>  include/linux/of_graph.h |  6 +++++
>  2 files changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 6a5760f0d6cd..e12b8b491837 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -29,6 +29,48 @@
>  
>  #include "of_private.h"
>  
> +/**
> + * of_graph_get_first_local_port() - get first local port node
> + * @node: pointer to a local endpoint device_node

It's not an endpoint.

> + *
> + * Return: First local port node associated with local endpoint node linked
> + *	   to @node. Use of_node_put() on it when done.
> + */
> +static struct device_node *
> +of_graph_get_first_local_port(const struct device_node *node)
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
> +
> +/**
> + * of_graph_is_present() - check graph's presence
> + * @node: pointer to a device_node checked for the graph's presence
> + *
> + * Return: True if @node has a port or ports sub-node, false otherwise.
> + */
> +bool of_graph_is_present(const struct device_node *node)
> +{
> +	struct device_node *local;
> +
> +	local = of_graph_get_first_local_port(node);
> +	if (!local)
> +		return false;
> +
> +	of_node_put(local);
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(of_graph_is_present);
> +
>  /**
>   * of_property_count_elems_of_size - Count the number of elements in a property
>   *
> @@ -608,15 +650,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
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
> +		port = of_graph_get_first_local_port(parent);

I think this introduces a bug below in the function, where parent is
used and is expected to point to the ports node if available. I'd leave
this part of the change out, and inline +of_graph_get_first_local_port()
in of_graph_is_present().

>  		if (!port) {
>  			pr_err("graph: no port node found in %pOF\n", parent);
>  			return NULL;
> diff --git a/include/linux/of_graph.h b/include/linux/of_graph.h
> index 01038a6aade0..4d7756087b6b 100644
> --- a/include/linux/of_graph.h
> +++ b/include/linux/of_graph.h
> @@ -38,6 +38,7 @@ struct of_endpoint {
>  	     child = of_graph_get_next_endpoint(parent, child))
>  
>  #ifdef CONFIG_OF
> +bool of_graph_is_present(const struct device_node *node);
>  int of_graph_parse_endpoint(const struct device_node *node,
>  				struct of_endpoint *endpoint);
>  int of_graph_get_endpoint_count(const struct device_node *np);
> @@ -56,6 +57,11 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
>  					     u32 port, u32 endpoint);
>  #else
>  
> +static inline bool of_graph_is_present(const struct device_node *node)
> +{
> +	return false;
> +}
> +
>  static inline int of_graph_parse_endpoint(const struct device_node *node,
>  					struct of_endpoint *endpoint)
>  {

-- 
Regards,

Laurent Pinchart
