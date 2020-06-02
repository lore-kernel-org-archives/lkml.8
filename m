Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE8FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D6E20679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYFHd5Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFBL2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgFBL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:28:11 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F860C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 04:28:11 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u7so1812161vsp.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrsaCGMsxTtIoOCqcMdZ4C1bTw37N0EwvD0GhGKPg5c=;
        b=SYFHd5CjZsRD9rFmDi8LwQKJOJTS7RfvhSKpKPMnELMZ8rVW0lpSB1QuuO2kjuIPsr
         oPvRfgssA3LmCl4WaderkbkKnWiKcJjswpuuTRuiAX+ucQEpf0taxKXhu94aqPzWour+
         d5JDDAS5T8tyERQplHTrPsXV9sLYbxIqVNaAhAqONeV+LQ8jgY5CDviWH7J5wSkK7Q8S
         MYLzmYMYavojrfKdN2LFWWg06yKrOUu73kC9yf/kxBKi33fT5Z2kycLNl+ihMS8p2A9O
         +xsmS3eng/+tmoFFnN3J4p+4jUf0wCIvqwJeIy5sbSPlxe0d+QWVUvX9kmnBdaRhli5X
         1vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrsaCGMsxTtIoOCqcMdZ4C1bTw37N0EwvD0GhGKPg5c=;
        b=W0/GH22YnhvrgFuO+E5+t7/Cx6kyoXeRa6ekpeeYvGupUpC967t5wlafgwvk6zXeoT
         VHEWQXJR1xSGf7clKdCmL2t6jvPdNpvaMezUE1jaIuRgwmmuEy7aDb0aXg6IMN1IMkRC
         1Vf52K54lTRkO4TTH8tVc4hRShIe5xYwB2JrXXZ2PqHi67m/qi2oZJmhbvJnTAZwJRAQ
         0UPskca2TFcsq7d0mLEJ17ud5E9PQp1rK/VWqhYJOE7ia0w6qlfcyHp5DSfmqYLtiHhp
         fILB03od03IVGTw4M5vvgA9pCPqorhDAWtNlGo0js3+dLWGs0ES2CpwlRE/jAemA/nFI
         J6MQ==
X-Gm-Message-State: AOAM530I9/S28YWVGUbqjL3xLjiCGe5C+n8DMNQJ/4dddcbJYkBuXYG3
        JmAp4AnRQB0bQelRS9gkv8jCVJ1NmLXlv6cn44k=
X-Google-Smtp-Source: ABdhPJxvkp0xKNancykWUqW+vOfVHn5HOQRf+uGXkTljBAdGL8i/zKpsdyfyx6meJ41TYU3KfR/jxJbBl9Y23HbGgLM=
X-Received: by 2002:a67:3291:: with SMTP id y139mr5489124vsy.37.1591097290771;
 Tue, 02 Jun 2020 04:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200511115524.22602-1-Rodrigo.Siqueira@amd.com>
 <20200511115524.22602-3-Rodrigo.Siqueira@amd.com> <CACvgo53KfLkTg4UvT5E+afX+z4FjMcpdctD5=v32WJs6TS5s5g@mail.gmail.com>
In-Reply-To: <CACvgo53KfLkTg4UvT5E+afX+z4FjMcpdctD5=v32WJs6TS5s5g@mail.gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 2 Jun 2020 12:24:53 +0100
Message-ID: <CACvgo50pYWM8DQuGjJwiZdO1vJvmg-XG08a+MYSWDmgVezN7Gw@mail.gmail.com>
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

On Tue, 12 May 2020 at 12:34, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> Hi Rodrigo,
>
> On Mon, 11 May 2020 at 12:55, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
> >
> > From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> >
> > The compute_crc() function is responsible for calculating the
> > framebuffer CRC value; due to the XRGB format, this function has to
> > ignore the alpha channel during the CRC computation. Therefore,
> > compute_crc() set zero to the alpha channel directly in the input
> > framebuffer, which is not a problem since this function receives a copy
> > of the original buffer. However, if we want to use this function in a
> > context without a buffer copy, it will change the initial value. This
> > patch makes compute_crc() calculate the CRC value without modifying the
> > input framebuffer.
> >
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c | 31 +++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index 258e659ecfba..686d25e7b01d 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -9,33 +9,40 @@
> >
> >  #include "vkms_drv.h"
> >
> > +static u32 get_pixel_from_buffer(int x, int y, const u8 *buffer,
> > +                                const struct vkms_composer *composer)
> > +{
> > +       int src_offset = composer->offset + (y * composer->pitch)
> > +                                         + (x * composer->cpp);
> > +
> > +       return *(u32 *)&buffer[src_offset];
> > +}
> > +
> >  /**
> >   * compute_crc - Compute CRC value on output frame
> >   *
> > - * @vaddr_out: address to final framebuffer
> > + * @vaddr: address to final framebuffer
> >   * @composer: framebuffer's metadata
> >   *
> >   * returns CRC value computed using crc32 on the visible portion of
> >   * the final framebuffer at vaddr_out
> >   */
> > -static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
> > +static uint32_t compute_crc(const u8 *vaddr,
> > +                           const struct vkms_composer *composer)
> >  {
> > -       int i, j, src_offset;
> > +       int x, y;
> >         int x_src = composer->src.x1 >> 16;
> >         int y_src = composer->src.y1 >> 16;
> >         int h_src = drm_rect_height(&composer->src) >> 16;
> >         int w_src = drm_rect_width(&composer->src) >> 16;
> > -       u32 crc = 0;
> > +       u32 crc = 0, pixel = 0;
> >
> > -       for (i = y_src; i < y_src + h_src; ++i) {
> > -               for (j = x_src; j < x_src + w_src; ++j) {
> > -                       src_offset = composer->offset
> > -                                    + (i * composer->pitch)
> > -                                    + (j * composer->cpp);
> > +       for (y = y_src; y < y_src + h_src; ++y) {
> > +               for (x = x_src; x < x_src + w_src; ++x) {
> >                         /* XRGB format ignores Alpha channel */
> > -                       memset(vaddr_out + src_offset + 24, 0,  8);
> > -                       crc = crc32_le(crc, vaddr_out + src_offset,
> > -                                      sizeof(u32));
> > +                       pixel = get_pixel_from_buffer(x, y, vaddr, composer);
> > +                       bitmap_clear((void *)&pixel, 0, 8);
> > +                       crc = crc32_le(crc, (void *)&pixel, sizeof(u32));
> >                 }
> >         }
> >
> IMHO using something like the following makes the code far simpler and clearer.
>
> offset = composer->offset + (y_src * composer->pitch) + (x_src * composer->cpp);
>
> for (i = 0; i < h_src; i++, offset += composer->pitch) {
>    for (j = 0; j < w_src; j++, offset += composer->cpp) {
>       pixel = get_pixel_from_buffer(vaddr, offset);
>       crc = crc32_le(crc, &pixel, sizeof(u32); // cast should not be needed
>    }
> }
>
> With the bitmap_clear() and related comment moved into get_pixel_from_buffer().
>
If you fold the bitmap_clear() in get_pixel_from_buffer(), and drop
the cast (unless I'm missing something and it's really needed) for
crc32_le() this patch is:

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

I would suggest (but it's not a requirement) that you simplify the
loop/offset calculation as separate patch in v5.

-Emil
