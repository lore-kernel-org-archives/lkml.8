Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F93C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEFD207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KYcnLUNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbgE0Nf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:35:28 -0400
Received: from mail-m964.mail.126.com ([123.126.96.4]:58900 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387664AbgE0Nf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=3DyG6h3I4Y9QuJnn1o
        Dt9FDzi0q1kTIE4vr9uP1Hf8Y=; b=KYcnLUNVxO6wHCp0XK4d5TSzi445ljV8J4
        ruv/SA+S5CdLgJYZNQVEwilx0YJa3dsYuTbgXcZVhb076F1/aHDYVaYqqNqhvdJt
        jyzuQWKakGfEdlkt7oeyoBr7oV5rud+vKiJhG0pwBPwk6Efh2QR1ZbPA7X89FT3X
        PtnXPZPKM=
Received: from localhost.localdomain (unknown [122.194.9.250])
        by smtp9 (Coremail) with SMTP id NeRpCgBHa2sqbM5eBKQPPw--.188S3;
        Wed, 27 May 2020 21:33:32 +0800 (CST)
From:   chenxb_99091@126.com
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Xuebing Chen <chenxb_99091@126.com>
Subject: Re:Re:[PATCH] drm: fix setting of plane_mask in pan_display_atomic()  function for linux-4.4
Date:   Wed, 27 May 2020 21:33:27 +0800
Message-Id: <1590586407-4109-1-git-send-email-chenxb_99091@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NeRpCgBHa2sqbM5eBKQPPw--.188S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyDAw1ftrWDJw48Zw43ZFb_yoW8Cr1fpF
        4xAF95KF18ta1UCasFgan7Zr13ua1xWr1xWr1Ygr1Y9ryUtFy7tFsrZ3y3Wa4jqry3Gw13
        twn8CasF9F15ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b8Oz3UUUUU=
X-Originating-IP: [122.194.9.250]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiJQ0xxV3WD2bedwABsW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuebing Chen <chenxb_99091@126.com>

On Mon, May 25, 2020 at 04:34:28PM +0200, Daniel Vetter wrote:
> On Sat, May 23, 2020 at 11:49:07AM +0800, chenxb_99091@126.com wrote:
> > From: Xuebing Chen <chenxb_99091@126.com>
> > 
> > The <include/drm/drm_crtc.h> provides drm_for_each_plane_mask macro and
> > plane_mask is defined as bitmask of plane indices, such as
> > 1<<drm_plane_index(plane). This patch fixes error setting of plane_mask
> > in pan_display_atomic() function.
> > 
> > Signed-off-by: Xuebing Chen <chenxb_99091@126.com>
> 
> What kernel is this patch against? Latest upstream doesn't have any such
> code anymore ... I'm assuming that Ville fixed this in one of his patches,
> but I can't find the right one just now.

This bug is still present in the longterm-supported versions of kernel 4.4.y, 
including the latest kernel v4.4.224,
See https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/?h=v4.4.224



> -Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_fb_helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index e449f22..6a9f7ee 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -1256,7 +1256,7 @@ retry:
> >  			goto fail;
> >  
> >  		plane = mode_set->crtc->primary;
> > -		plane_mask |= drm_plane_index(plane);
> > +		plane_mask |= 1 << drm_plane_index(plane);
> >  		plane->old_fb = plane->fb;
> >  	}
> >  
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



