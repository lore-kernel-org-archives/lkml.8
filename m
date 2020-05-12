Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8917C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BA22075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbge21sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgELLha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:37:28 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3044C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:37:26 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id o8so2139155vkd.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3KKWLl8HkCXQ+MjcPLWxrbD4LKOdKANjNPpG/Ugus0=;
        b=Vbge21sbZsurEnSDxiksRTO9LZRl3h2o3BB6q1sAGyp/DOuqkK9GiqIwfc1pn2rKaQ
         +FOZP1b81+/JyMT6ifVCGu6OuMY8LeGnbZMahPjvjNxM8MiDlDifwD608MPe8WxX2RcB
         tEiqz96bDFDg0Hp/zaEQhF9th2wdMK/Dw15F4sxHzJVApsdZJP8RoHkvv2IJOmd54QWs
         DF6a8YPJC1TSjX/ZCfJVpcSSvVsW5ZniqxI3vPjuCEuakvdiRcbFRgJALcargyo7JKye
         E1z4azcfHOLWj19CKF53Dniupqfd0fYW3VRrKj9vEz91uXYLPR3j7bHxv1KYNEHIX8Qk
         MJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3KKWLl8HkCXQ+MjcPLWxrbD4LKOdKANjNPpG/Ugus0=;
        b=o1WRLpkTYFRRIQ5UEj+yj4yinPYoeEVHYS1u7AG6y+vmZ+PL1J5Bjy/sxxb0ATQHrZ
         +BDyX5rAyyoKxw+JfvYENieek54CPZZBJUhurk/qqv4O/W7GrcJqYy21J+rTh3925qyS
         sPt0PucqRSMroko+OixIqQkec+wc1LGKj3J9g2rRBXSOMq8johLre09YlEKfrz63FeOO
         WFEJ3vFQABG7QvVdOTfQadK9VWJewPbbaw/f4kLzPAIkpVnCdG3ucuQ+XSFVwM2QHToS
         uE+1GDDT4qYTfUDnXMjEPpjzW5iW0otm/M6Yu1UdYx7RLcLgGrrKS9nICeI5caSH3iW1
         Xzdg==
X-Gm-Message-State: AGi0PuYf34vSbZBON8BAgwx/nwhbEXQgnep0mc50jWvuyJbAif/kppga
        m3LPO0YoE/hUI/LmKp9UxWIetwrUe+Vd4CzoxCY=
X-Google-Smtp-Source: APiQypIQM2/qGTsyEbGNVjZeO6kaUSKCSi0gcRXR6wsSfcpJVHlkk5f8mQh/QXyXnkH5Y0GCjhYJfKkFAWpoM6ISnAE=
X-Received: by 2002:a1f:2f91:: with SMTP id v139mr15017877vkv.22.1589283445902;
 Tue, 12 May 2020 04:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200511115524.22602-1-Rodrigo.Siqueira@amd.com> <20200511115524.22602-3-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20200511115524.22602-3-Rodrigo.Siqueira@amd.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 12 May 2020 12:34:47 +0100
Message-ID: <CACvgo53KfLkTg4UvT5E+afX+z4FjMcpdctD5=v32WJs6TS5s5g@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] drm/vkms: Compute CRC without change input data
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

On Mon, 11 May 2020 at 12:55, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
>
> From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>
> The compute_crc() function is responsible for calculating the
> framebuffer CRC value; due to the XRGB format, this function has to
> ignore the alpha channel during the CRC computation. Therefore,
> compute_crc() set zero to the alpha channel directly in the input
> framebuffer, which is not a problem since this function receives a copy
> of the original buffer. However, if we want to use this function in a
> context without a buffer copy, it will change the initial value. This
> patch makes compute_crc() calculate the CRC value without modifying the
> input framebuffer.
>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 31 +++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 258e659ecfba..686d25e7b01d 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -9,33 +9,40 @@
>
>  #include "vkms_drv.h"
>
> +static u32 get_pixel_from_buffer(int x, int y, const u8 *buffer,
> +                                const struct vkms_composer *composer)
> +{
> +       int src_offset = composer->offset + (y * composer->pitch)
> +                                         + (x * composer->cpp);
> +
> +       return *(u32 *)&buffer[src_offset];
> +}
> +
>  /**
>   * compute_crc - Compute CRC value on output frame
>   *
> - * @vaddr_out: address to final framebuffer
> + * @vaddr: address to final framebuffer
>   * @composer: framebuffer's metadata
>   *
>   * returns CRC value computed using crc32 on the visible portion of
>   * the final framebuffer at vaddr_out
>   */
> -static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
> +static uint32_t compute_crc(const u8 *vaddr,
> +                           const struct vkms_composer *composer)
>  {
> -       int i, j, src_offset;
> +       int x, y;
>         int x_src = composer->src.x1 >> 16;
>         int y_src = composer->src.y1 >> 16;
>         int h_src = drm_rect_height(&composer->src) >> 16;
>         int w_src = drm_rect_width(&composer->src) >> 16;
> -       u32 crc = 0;
> +       u32 crc = 0, pixel = 0;
>
> -       for (i = y_src; i < y_src + h_src; ++i) {
> -               for (j = x_src; j < x_src + w_src; ++j) {
> -                       src_offset = composer->offset
> -                                    + (i * composer->pitch)
> -                                    + (j * composer->cpp);
> +       for (y = y_src; y < y_src + h_src; ++y) {
> +               for (x = x_src; x < x_src + w_src; ++x) {
>                         /* XRGB format ignores Alpha channel */
> -                       memset(vaddr_out + src_offset + 24, 0,  8);
> -                       crc = crc32_le(crc, vaddr_out + src_offset,
> -                                      sizeof(u32));
> +                       pixel = get_pixel_from_buffer(x, y, vaddr, composer);
> +                       bitmap_clear((void *)&pixel, 0, 8);
> +                       crc = crc32_le(crc, (void *)&pixel, sizeof(u32));
>                 }
>         }
>
IMHO using something like the following makes the code far simpler and clearer.

offset = composer->offset + (y_src * composer->pitch) + (x_src * composer->cpp);

for (i = 0; i < h_src; i++, offset += composer->pitch) {
   for (j = 0; j < w_src; j++, offset += composer->cpp) {
      pixel = get_pixel_from_buffer(vaddr, offset);
      crc = crc32_le(crc, &pixel, sizeof(u32); // cast should not be needed
   }
}

With the bitmap_clear() and related comment moved into get_pixel_from_buffer().

-Emil
