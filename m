Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043A3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB47E20739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FQSvnTVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgFPB1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgFPB1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:27:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FA5C061A0E;
        Mon, 15 Jun 2020 18:27:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 49F82F9;
        Tue, 16 Jun 2020 03:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592270834;
        bh=yVhdm4SmO3wkXqvKwAY69etuikCBZKRYuD4KmrUh1q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQSvnTVBX3f5SqO3sC1FJmr87CZEgDB2GeYpJ6t1MWr7iPx3WCHsMIeMWAHX5JZcI
         pOrrNnySCtO4QjgIPkebFxXT7BA54jdQ6PDbGpZsuuJ9yLFv1kNM3GFqVsnb47mXX7
         O3+D9HQC4H79Ays/zPN9+DcJXivDaescPY1p2scA=
Date:   Tue, 16 Jun 2020 04:26:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/6] drm/of: Make drm_of_find_panel_or_bridge() to
 check graph's presence
Message-ID: <20200616012652.GG1629@pendragon.ideasonboard.com>
References: <20200614172234.8856-1-digetx@gmail.com>
 <20200614172234.8856-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200614172234.8856-3-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the patch.

On Sun, Jun 14, 2020 at 08:22:30PM +0300, Dmitry Osipenko wrote:
> When graph isn't defined in a device-tree, the of_graph_get_remote_node()
> prints a noisy error message, telling that port node is not found. This is
> undesirable behaviour in our case because absence of a panel/bridge graph
> is a valid case. Let's check presence of the local port in a device-tree
> before proceeding with parsing the graph.
> 
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/drm_of.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index b50b44e76279..e0652c38f357 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -239,13 +239,24 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
>  				struct drm_bridge **bridge)
>  {
>  	int ret = -EPROBE_DEFER;
> -	struct device_node *remote;
> +	struct device_node *local, *remote;
>  
>  	if (!panel && !bridge)
>  		return -EINVAL;
>  	if (panel)
>  		*panel = NULL;
>  
> +	/*
> +	 * of_graph_get_remote_node() produces a noisy error message if port
> +	 * node isn't found and the absence of the port is a legit case here,
> +	 * so at first we silently check presence of the local port.
> +	 */
> +	local = of_graph_get_local_port(np);
> +	if (!local)
> +		return -ENODEV;
> +
> +	of_node_put(local);
> +

The code looks fine, but you may want to take into account my proposal
in 1/7 to instead create a of_graph_has_port() function. The could would
be simpler here.

>  	remote = of_graph_get_remote_node(np, port, endpoint);
>  	if (!remote)
>  		return -ENODEV;

-- 
Regards,

Laurent Pinchart
