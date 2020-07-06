Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD5EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDD820715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRLWDhxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgGFK61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbgGFK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:58:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471DDC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:58:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so12349203wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GiGrEgHB6p9bW28i26l9Y9DwOHOOikiXfBRmCrHGooM=;
        b=oRLWDhxfuKYt5Uo3pX8l9mZx28DdRDLEXxO+WZNjazbUH+dGo/5SBEeC4IzqB2HHNA
         kRSIgWm04o7etAQIAxoIviPnZm36pc5/glr76docZjfRKT9M/uI1HCX4Nrtoj+xdzEyU
         ow4TFkh5coQWPV+TA/C4EKB5mT7PFqrTTA677piVtLA2OVBn4IY47zkKrp5t9yM7P7ml
         Vj+/7Qm4tqoR4P5yzdntAHjr7kR8GN7FEicuLAy+KXXKPxYJyuWiYoGYQIv1QLClgVDL
         8pFCWxFlONT/Cn+nCI7n54cKvv291Pd/pTCofsSAj1gvLIPVVL19P+XxR7xRzbiZdwv1
         fovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GiGrEgHB6p9bW28i26l9Y9DwOHOOikiXfBRmCrHGooM=;
        b=LrcIU98JMsduKkv30i/jZbfj8JGN8Ofh7jMwByjpEknQQ7kyMwOFIvLsnGHlp9hTHB
         gFMcppiSrYJkZTAkwuLjtrwZiSJhh8j+kcbAuhKnB3/ZaII5qISqd9WbWaz4+XWgUEF+
         4nXLaw4WCJk67KHeKn73rZ5ikyADQpbdh61WKbgM5NQxQGtzdwvMRemiz/Z8hAvmdAQz
         ueg2m/CzJ5eBuvCXiw8lHg/9F7YF0Su0cu9wiOX9VxK0d6PjMm6Sm+FiBkd46dteyILz
         UVn3SNhp/lVFAGqZ4LSuRzPVurce0fAwEMYfC91xbPxwOscHRbedBzirUv4WYRAy2Bx6
         sXkg==
X-Gm-Message-State: AOAM531PrubC11yl+HYYSM7WjLhRUhnEw6SFCHFhioVhYgp9frEmQTe4
        G3H1dZTpbAt8hELfBl6g5ibkf+CT6Uc=
X-Google-Smtp-Source: ABdhPJxqVJVmG4Yb+JFOkBOebLAvhLGEoD1DBBpwSZGSktBmon/N3vyaLBp+D/ZUKU0xZxYrlLYM5A==
X-Received: by 2002:a05:6000:11cc:: with SMTP id i12mr47383024wrx.224.1594033104832;
        Mon, 06 Jul 2020 03:58:24 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id e23sm22417662wme.35.2020.07.06.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:58:24 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:58:23 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v3 3/6] vt/vt: Enable mode change via escape sequence
Message-ID: <6bcf9322878e5712365b231a7d653e1470df9f1a.1594032517.git.tammo.block@gmail.com>
References: <cover.1594032517.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594032517.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables userspace to enable one of the mouse protocols and choose
one of the new event types by escape sequences.

And don't forget to reset protocol value also if resetting vc.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 673177d4e859..3699e488ef19 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1896,13 +1896,25 @@ static void set_mode(struct vc_data *vc, int on_off)
 					clr_kbd(vc, decarm);
 				break;
 			case 9:
-				vc->vc_report_mouse = on_off ? 1 : 0;
+				vc->vc_report_mouse = on_off * TIOCL_REPORTBTNPRESS;
 				break;
 			case 25:		/* Cursor on/off */
 				vc->vc_deccm = on_off;
 				break;
 			case 1000:
-				vc->vc_report_mouse = on_off ? 2 : 0;
+				vc->vc_report_mouse = on_off * TIOCL_REPORTRELEASE;
+				break;
+			case 1002:
+				vc->vc_report_mouse = on_off * TIOCL_REPORTDRAG;
+				break;
+			case 1003:
+				vc->vc_report_mouse = on_off * TIOCL_REPORTANYMOVE;
+				break;
+			case 1006:
+				vc->vc_protocol_mouse = on_off * VC_PMOUSE_SRG;
+				break;
+			case 1015:
+				vc->vc_protocol_mouse = on_off * VC_PMOUSE_URXVT;
 				break;
 			}
 		} else {
@@ -2067,6 +2079,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	vc->state.charset	= 0;
 	vc->vc_need_wrap	= 0;
 	vc->vc_report_mouse	= 0;
+	vc->vc_protocol_mouse	= VC_PMOUSE_X10;
 	vc->vc_utf              = default_utf8;
 	vc->vc_utf_count	= 0;
 
-- 
2.27.0

