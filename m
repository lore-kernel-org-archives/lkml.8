Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BE4C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B3A24653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271625;
	bh=MpOLrtBpFCiszf4oe87gUXnv6QKAfqqQwxxRDU9gY+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBtcMKSWRbMicPd3JA3i31q44pbezxps4i29PGK4CjiwjmmJ7MPQOM0Cx4pTPhx8U
	 6/tg/0/m44CUzq6RJ0fA3fftrFNTz5SUtr1p10cL1G93O1YkV4nKMJH4V4ORSio+Ti
	 lc5FYeKEoGlBAQQqDjgPima1E25zrl0SQ3hXas7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgBUHxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:53:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730144AbgBUHxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:53:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 156EF2465D;
        Fri, 21 Feb 2020 07:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271620;
        bh=MpOLrtBpFCiszf4oe87gUXnv6QKAfqqQwxxRDU9gY+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wLSxlcRjdT8zhhGu+3TEkjNHOMAkYm1SsUPqSqajWx3a3SKGpIESUJaPOidasM9C
         FeVFRhbY7pkEwJbgfGps2NUcuqIsMNelpNkMdcSACdLw+lbaXbUfYoKzUe+Kub9Czt
         WLCOv/JPHjv1EPVh8VM0CCINuT40UlshiL0SQq50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 197/399] fbdev: fix numbering of fbcon options
Date:   Fri, 21 Feb 2020 08:38:42 +0100
Message-Id: <20200221072421.968666513@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit fd933c00ebe220060e66fb136a7050a242456566 ]

Three shall be the number thou shalt count, and the number of the
counting shall be three. Four shalt thou not count...

One! Two! Five!

Fixes: efb985f6b265 ("[PATCH] fbcon: Console Rotation - Add framebuffer console documentation")
Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190827110854.12574-2-peda@axentia.se
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/fb/fbcon.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index ebca41785abea..65ba402551374 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -127,7 +127,7 @@ C. Boot options
 	is typically located on the same video card.  Thus, the consoles that
 	are controlled by the VGA console will be garbled.
 
-4. fbcon=rotate:<n>
+5. fbcon=rotate:<n>
 
 	This option changes the orientation angle of the console display. The
 	value 'n' accepts the following:
@@ -152,21 +152,21 @@ C. Boot options
 	Actually, the underlying fb driver is totally ignorant of console
 	rotation.
 
-5. fbcon=margin:<color>
+6. fbcon=margin:<color>
 
 	This option specifies the color of the margins. The margins are the
 	leftover area at the right and the bottom of the screen that are not
 	used by text. By default, this area will be black. The 'color' value
 	is an integer number that depends on the framebuffer driver being used.
 
-6. fbcon=nodefer
+7. fbcon=nodefer
 
 	If the kernel is compiled with deferred fbcon takeover support, normally
 	the framebuffer contents, left in place by the firmware/bootloader, will
 	be preserved until there actually is some text is output to the console.
 	This option causes fbcon to bind immediately to the fbdev device.
 
-7. fbcon=logo-pos:<location>
+8. fbcon=logo-pos:<location>
 
 	The only possible 'location' is 'center' (without quotes), and when
 	given, the bootup logo is moved from the default top-left corner
-- 
2.20.1



