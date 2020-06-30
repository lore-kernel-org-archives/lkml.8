Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65622C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E43B2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgF3HLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:11:07 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:40992 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730600AbgF3HLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:11:06 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 4BB6D1F407;
        Tue, 30 Jun 2020 09:11:04 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Tue, 30 Jun 2020 09:11:04 +0200
Date:   Tue, 30 Jun 2020 09:11:04 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v1 3/6] vt/vt: Enable mode change via escape sequence
Message-ID: <eecb16842e26e1fe7ca6a4e70ead40b69efe4d0b.1593499846.git.tammo.block@gmail.com>
References: <cover.1593499846.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593499846.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables userspace to enable one of the mouse protocols and choose
one of the new event types by escape sequences.

They are not a bitmasks, but mutually exclusive.

And don't forget to reset protocol value also if resetting vc.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 673177d4e859..e2324d8e4e74 100644
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
+			case 1006:		/* SRG protocol */
+				vc->vc_protocol_mouse = on_off * 1;
+				break;
+			case 1015:		/* URXVT protocol */
+				vc->vc_protocol_mouse = on_off * 2;
 				break;
 			}
 		} else {
@@ -2067,6 +2079,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	vc->state.charset	= 0;
 	vc->vc_need_wrap	= 0;
 	vc->vc_report_mouse	= 0;
+	vc->vc_protocol_mouse	= 0;
 	vc->vc_utf              = default_utf8;
 	vc->vc_utf_count	= 0;
 
-- 
2.27.0

