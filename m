Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE3D2074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgGFJrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:47:47 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56608 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgGFJrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:47:47 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jsNio-0007ip-Tk; Mon, 06 Jul 2020 11:47:34 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, kever.yang@rock-chips.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/of: Consider the state in which the ep is disabled
Date:   Mon, 06 Jul 2020 11:47:34 +0200
Message-ID: <5521346.QZMSPK5NSd@diego>
In-Reply-To: <20200706075944.11558-1-hjc@rock-chips.com>
References: <20200706075944.11558-1-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy,

Am Montag, 6. Juli 2020, 09:59:44 CEST schrieb Sandy Huang:
> don't mask possible_crtcs if remote-point is disabled.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/drm_of.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index fdb05fbf72a0..f5f250435add 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -66,6 +66,11 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>  	uint32_t possible_crtcs = 0;
>  
>  	for_each_endpoint_of_node(port, ep) {
> +		if (!of_device_is_available(ep)) {
> +			of_node_put(ep);

You'd only need the of_node_put here, if you were exiting the loop.

With the "continue" below, the next iteration of for_each_endpoint_of_node
will do the put on "ep"


Heiko

> +			continue;
> +		}
> +
>  		remote_port = of_graph_get_remote_port(ep);
>  		if (!remote_port) {
>  			of_node_put(ep);
> 




