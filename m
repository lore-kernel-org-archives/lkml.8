Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15278C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAAB62076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgFZH1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:27:45 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:37541 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728341AbgFZH1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:27:45 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 245001F566;
        Fri, 26 Jun 2020 09:22:24 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Fri, 26 Jun 2020 09:22:24 +0200
Date:   Fri, 26 Jun 2020 09:22:24 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v0 2/5] Make it possible to enable/disable SRG mouse reporting
Message-ID: <d0951dcf5fb4cf8bfa19940953bce55ad0ee0510.1593155911.git.tammo.block@gmail.com>
References: <cover.1593155911.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593155911.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The report protocol stored in vc_report_mouse is not a bitmask, the
protocols are mutually exclusive, last one wins. Values are chosen to
maximize compatibility.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 48a8199f7845..d52ac57034e0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1890,13 +1890,22 @@ static void set_mode(struct vc_data *vc, int on_off)
 					clr_kbd(vc, decarm);
 				break;
 			case 9:
-				vc->vc_report_mouse = on_off ? 1 : 0;
+				vc->vc_report_mouse = on_off ? TIOCL_REPORTBTNPRESS : 0;
 				break;
 			case 25:		/* Cursor on/off */
 				vc->vc_deccm = on_off;
 				break;
 			case 1000:
-				vc->vc_report_mouse = on_off ? 2 : 0;
+				vc->vc_report_mouse = on_off ? TIOCL_REPORTRELEASE : 0;
+				break;
+			case 1002:
+				vc->vc_report_mouse = on_off ? TIOCL_REPORTDRAG : 0;
+				break;
+			case 1003:
+				vc->vc_report_mouse = on_off ? TIOCL_REPORTANYMOVE : 0;
+				break;
+			case 1006:
+				vc->vc_proto_mouse = on_off ? 1 : 0;
 				break;
 			}
 		} else {
-- 
2.27.0

