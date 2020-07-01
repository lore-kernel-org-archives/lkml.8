Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE99FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A10B2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="l7jruMLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgGAHz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:55:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60252 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgGAHz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:55:58 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 48544556;
        Wed,  1 Jul 2020 09:55:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593590156;
        bh=SBS3cYIeUtLrgvHJfEpKTIWd7IrgonFBNo28g+dS7hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7jruMLb0PL0NIdRMEPeknmr8nmPonICdPvRXE1BVOJ8LkdpsZ10TInTtRLkUPcD4
         cHt0Z6PkyOb4+3MIT4odXNkITMHPXguWRi1aWX3YWodACAeFflwNIOyFNnxwVqRDL3
         +GSb8tQVMUG5XsCnVqFznh48pbno9RA2oYfeIutg=
Date:   Wed, 1 Jul 2020 10:55:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] of_graph: add of_graph_is_present()
Message-ID: <20200701075552.GJ5963@pendragon.ideasonboard.com>
References: <20200701074232.13632-1-digetx@gmail.com>
 <20200701074232.13632-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701074232.13632-2-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the patch.

On Wed, Jul 01, 2020 at 10:42:31AM +0300, Dmitry Osipenko wrote:
> In some cases it's very useful to silently check whether port node exists
> at all in a device-tree before proceeding with parsing the graph. The DRM
> bridges code is one example of such case where absence of a graph in a
> device-tree is a legit condition.
> 
> This patch adds of_graph_is_present() which returns true if given
> device-tree node contains OF graph port.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/of/property.c    | 23 +++++++++++++++++++++++
>  include/linux/of_graph.h |  6 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 6a5760f0d6cd..fed7229d9d9f 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -29,6 +29,29 @@
>  
>  #include "of_private.h"
>  
> +/**
> + * of_graph_is_present() - check graph's presence
> + * @node: pointer to device_node containing graph port
> + *
> + * Return: True if @node has a port or ports (with a port) sub-node,
> + * false otherwise.
> + */
> +bool of_graph_is_present(const struct device_node *node)
> +{
> +	struct device_node *ports, *port;
> +
> +	ports = of_get_child_by_name(node, "ports");
> +	if (ports)
> +		node = ports;
> +
> +	port = of_get_child_by_name(node, "port");
> +	of_node_put(ports);
> +	of_node_put(port);
> +
> +	return !!port;
> +}
> +EXPORT_SYMBOL(of_graph_is_present);
> +
>  /**
>   * of_property_count_elems_of_size - Count the number of elements in a property
>   *
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
