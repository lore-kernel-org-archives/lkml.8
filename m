Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D014C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFAC20735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549763;
	bh=Zb2q7FIeXzFHGV5URxwb82rv0SspNQ/Ggeon+/n54N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zUsL05UFDY22vZVGa7aPiHFZ96TwZuyArVsovF9TUx8T191ow9aSoYiYMxfeVinlA
	 +BbDsquiUEQsVRzWGKg1P63SFBWhvWzA2OLEn1eEpOyVOu23lvov7Pr1WRdN+9cb9M
	 6zEXBzfnUpXde7VbEmtPHl+Bd7KGsXoRtxluv7lQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgDVKCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgDVKCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:02:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FBD02076C;
        Wed, 22 Apr 2020 10:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549756;
        bh=Zb2q7FIeXzFHGV5URxwb82rv0SspNQ/Ggeon+/n54N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+zOSzPKTKXLzPAr7beVNciAyOGkzKNue7o1OgWPyfulQtFcMM8ZW//8lXYTOEl0l
         xMpkQ8ApNGUkhk6WwmD9fJ5aDZdN/zwniMnvgQC93PzC/TiIo28KqAchaAMv5905ef
         j56fvF/UHcq91/bp77apiWxfk+/FWEcD65vtn5EA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Jani Nikula <jani.nikula@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.4 093/100] fbdev: potential information leak in do_fb_ioctl()
Date:   Wed, 22 Apr 2020 11:57:03 +0200
Message-Id: <20200422095039.680764821@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit d3d19d6fc5736a798b118971935ce274f7deaa82 upstream.

The "fix" struct has a 2 byte hole after ->ywrapstep and the
"fix = info->fix;" assignment doesn't necessarily clear it.  It depends
on the compiler.  The solution is just to replace the assignment with an
memcpy().

Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200113100132.ixpaymordi24n3av@kili.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/core/fbmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1132,7 +1132,7 @@ static long do_fb_ioctl(struct fb_info *
 	case FBIOGET_FSCREENINFO:
 		if (!lock_fb_info(info))
 			return -ENODEV;
-		fix = info->fix;
+		memcpy(&fix, &info->fix, sizeof(fix));
 		unlock_fb_info(info);
 
 		ret = copy_to_user(argp, &fix, sizeof(fix)) ? -EFAULT : 0;


