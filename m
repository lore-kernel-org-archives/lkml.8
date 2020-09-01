Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81728C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A78F208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973219;
	bh=mg5iWGS1BY1vJNmmAxsLZKacHGgFFjwrUb8e8RjDbV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tls2IQW0pChESTbRkTGCYJcLb2+Hr7X4epgD4UTAs4u1BxAJCffpf4R13gZuYcLTT
	 Nl9EZl10ew0bO1/L0hdLc19m41gLgLkWc46aefv3PUWMXyvLbOxHNJeyoewoEEzRUk
	 CR32ilX2B0Zx9KQeQ3KX4G+lHxg6Ahxz+Bqz8M1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgIAPNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbgIAPND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:13:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0774D20FC3;
        Tue,  1 Sep 2020 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973182;
        bh=mg5iWGS1BY1vJNmmAxsLZKacHGgFFjwrUb8e8RjDbV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyGQI1dn3WJ0zom3eYKGqKjdYn6uDsRLckrLj3pGA4iz3RfRW00TdHjH6NhvOdtGd
         +/FdflVZ7L9zTaWnCNlEG9r3AO32vHBAGX+HgLN65NKOkXn7z1jud4dAU3kGHEtWCD
         Ec/mRr6ig8ctT/3o3OPCNWn1hjthx3FoId3bPOjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Kennedy <george.kennedy@oracle.com>,
        syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
Subject: [PATCH 4.4 40/62] fbcon: prevent user font height or width change from causing potential out-of-bounds access
Date:   Tue,  1 Sep 2020 17:10:23 +0200
Message-Id: <20200901150922.753818663@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Kennedy <george.kennedy@oracle.com>

commit 39b3cffb8cf3111738ea993e2757ab382253d86a upstream.

Add a check to fbcon_resize() to ensure that a possible change to user font
height or user font width will not allow a font data out-of-bounds access.
NOTE: must use original charcount in calculation as font charcount can
change and cannot be used to determine the font data allocated size.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Cc: stable <stable@vger.kernel.org>
Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/1596213192-6635-1-git-send-email-george.kennedy@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/console/fbcon.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2117,6 +2117,9 @@ static void updatescrollmode(struct disp
 	}
 }
 
+#define PITCH(w) (((w) + 7) >> 3)
+#define CALC_FONTSZ(h, p, c) ((h) * (p) * (c)) /* size = height * pitch * charcount */
+
 static int fbcon_resize(struct vc_data *vc, unsigned int width, 
 			unsigned int height, unsigned int user)
 {
@@ -2126,6 +2129,24 @@ static int fbcon_resize(struct vc_data *
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
+	if (ops->p && ops->p->userfont && FNTSIZE(vc->vc_font.data)) {
+		int size;
+		int pitch = PITCH(vc->vc_font.width);
+
+		/*
+		 * If user font, ensure that a possible change to user font
+		 * height or width will not allow a font data out-of-bounds access.
+		 * NOTE: must use original charcount in calculation as font
+		 * charcount can change and cannot be used to determine the
+		 * font data allocated size.
+		 */
+		if (pitch <= 0)
+			return -EINVAL;
+		size = CALC_FONTSZ(vc->vc_font.height, pitch, FNTCHARCNT(vc->vc_font.data));
+		if (size > FNTSIZE(vc->vc_font.data))
+			return -EINVAL;
+	}
+
 	virt_w = FBCON_SWAP(ops->rotate, width, height);
 	virt_h = FBCON_SWAP(ops->rotate, height, width);
 	virt_fw = FBCON_SWAP(ops->rotate, vc->vc_font.width,
@@ -2587,7 +2608,7 @@ static int fbcon_set_font(struct vc_data
 	int size;
 	int i, csum;
 	u8 *new_data, *data = font->data;
-	int pitch = (font->width+7) >> 3;
+	int pitch = PITCH(font->width);
 
 	/* Is there a reason why fbconsole couldn't handle any charcount >256?
 	 * If not this check should be changed to charcount < 256 */
@@ -2603,7 +2624,7 @@ static int fbcon_set_font(struct vc_data
 	if (fbcon_invalid_charcount(info, charcount))
 		return -EINVAL;
 
-	size = h * pitch * charcount;
+	size = CALC_FONTSZ(h, pitch, charcount);
 
 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
 


