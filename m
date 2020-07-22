Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E93AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8BB20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgGVTCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:02:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47508 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgGVTCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:02:07 -0400
Received: from x2f7fa19.dyn.telefonica.de ([2.247.250.25] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyK06-0005NH-5R; Wed, 22 Jul 2020 21:01:58 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, kever.yang@rock-chips.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/of: Consider the state in which the ep is disabled
Date:   Wed, 22 Jul 2020 21:01:56 +0200
Message-ID: <3361390.LkKjKlf5PX@phil>
In-Reply-To: <20200707112526.18438-1-hjc@rock-chips.com>
References: <20200707112526.18438-1-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. Juli 2020, 13:25:26 CEST schrieb Sandy Huang:
> don't mask possible_crtcs if remote-point is disabled.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

changes in v2:
- drop additional of_node_put, as ep will be put with the next
  iteration of for_each_endpoint_of_node()


As this touches a pretty central function is there something
to keep in mind in regards to other DRM drivers?
[question for the broader audience ;-) ]

Heiko

> ---
>  drivers/gpu/drm/drm_of.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index fdb05fbf72a0..565f05f5f11b 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -66,6 +66,9 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>  	uint32_t possible_crtcs = 0;
>  
>  	for_each_endpoint_of_node(port, ep) {
> +		if (!of_device_is_available(ep))
> +			continue;
> +
>  		remote_port = of_graph_get_remote_port(ep);
>  		if (!remote_port) {
>  			of_node_put(ep);
> 




