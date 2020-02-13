Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684D2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3B0218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgBMNiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:38:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32992 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbgBMNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:38:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AEB7029520D
Subject: Re: [PATCH] drm/mediatek: Update the fb property
 mtk_plane_atomic_async_update
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20200213120103.823501-1-enric.balletbo@collabora.com>
Message-ID: <7cd36a53-30d9-7efb-4864-78f994268f1b@collabora.com>
Date:   Thu, 13 Feb 2020 14:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200213120103.823501-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/2/20 13:01, Enric Balletbo i Serra wrote:
> Commit 920fffcc8912 ("drm/mediatek: update cursors by using async atomic
> update") added support to async updates of cursors by using the new atomic
> interface for that. Unfortunately, introduced two issues. The first one is
> that since then, the drm_atomic_helper_async_commit triggers a WARNING due
> current fb is not the new fb. The second one, is that we get a black screen
> connecting the external display on Elm device and another WARNING due vblank
> wait timed out.
> 
> Swap the fb in mtk_plane_atomic_async_update to fix both issues.
> 
> Fixes: 920fffcc8912 ("drm/mediatek: update cursors by using async atomic update")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

I just noticed this, which should fix the problem too, so you can ignore this patch.

https://patchwork.kernel.org/patch/11379571/

> 
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> index 914cc7619cd7..7eb10115e72a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -116,6 +116,7 @@ static void mtk_plane_atomic_async_update(struct drm_plane *plane,
>  	plane->state->src_h = new_state->src_h;
>  	plane->state->src_w = new_state->src_w;
>  	state->pending.async_dirty = true;
> +	swap(plane->state->fb, new_state->fb);
>  
>  	mtk_drm_crtc_async_update(new_state->crtc, plane, new_state);
>  }
> 
