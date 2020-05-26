Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BBCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 02:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0448A206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 02:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbgEZCJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 22:09:00 -0400
Received: from emcscan.emc.com.tw ([192.72.220.5]:48817 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388417AbgEZCI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 22:08:59 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 22:08:58 EDT
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="35733622"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 26 May 2020 09:59:17 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(20966:0:AUTH_RELAY)
        (envelope-from <jingle.wu@emc.com.tw>); Tue, 26 May 2020 09:59:16 +0800 (CST)
Received: from 49.216.87.26
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(2480:0:AUTH_LOGIN)
        (envelope-from <jingle.wu@emc.com.tw>); Tue, 26 May 2020 09:59:15 +0800 (CST)
From:   "Jingle.Wu" <jingle.wu@emc.com.tw>
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
Cc:     phoenix@emc.com.tw, dave.wang@emc.com.tw, josh.chen@emc.com.tw,
        "Jingle.Wu" <jingle.wu@emc.com.tw>
Subject: [PATCH] Input: elantench - Remove read registers in attr Signed-off-by: Jingle Wu <jingle.wu@emc.com.tw>
Date:   Wed, 27 May 2020 01:59:40 +0800
Message-Id: <20200526175940.4298-1-jingle.wu@emc.com.tw>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/input/mouse/elantech.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2d8434b7b623..5bdf2b19118e 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1280,7 +1280,7 @@ static ssize_t elantech_set_int_attr(struct psmouse *psmouse,
 			    elantech_show_int_attr,			       \
 			    elantech_set_int_attr)
 
-ELANTECH_INT_ATTR(reg_07, 0x07);
+/*ELANTECH_INT_ATTR(reg_07, 0x07);
 ELANTECH_INT_ATTR(reg_10, 0x10);
 ELANTECH_INT_ATTR(reg_11, 0x11);
 ELANTECH_INT_ATTR(reg_20, 0x20);
@@ -1289,13 +1289,13 @@ ELANTECH_INT_ATTR(reg_22, 0x22);
 ELANTECH_INT_ATTR(reg_23, 0x23);
 ELANTECH_INT_ATTR(reg_24, 0x24);
 ELANTECH_INT_ATTR(reg_25, 0x25);
-ELANTECH_INT_ATTR(reg_26, 0x26);
+ELANTECH_INT_ATTR(reg_26, 0x26);*/
 ELANTECH_INFO_ATTR(debug);
 ELANTECH_INFO_ATTR(paritycheck);
 ELANTECH_INFO_ATTR(crc_enabled);
 
 static struct attribute *elantech_attrs[] = {
-	&psmouse_attr_reg_07.dattr.attr,
+	/*&psmouse_attr_reg_07.dattr.attr,
 	&psmouse_attr_reg_10.dattr.attr,
 	&psmouse_attr_reg_11.dattr.attr,
 	&psmouse_attr_reg_20.dattr.attr,
@@ -1304,7 +1304,7 @@ static struct attribute *elantech_attrs[] = {
 	&psmouse_attr_reg_23.dattr.attr,
 	&psmouse_attr_reg_24.dattr.attr,
 	&psmouse_attr_reg_25.dattr.attr,
-	&psmouse_attr_reg_26.dattr.attr,
+	&psmouse_attr_reg_26.dattr.attr,*/
 	&psmouse_attr_debug.dattr.attr,
 	&psmouse_attr_paritycheck.dattr.attr,
 	&psmouse_attr_crc_enabled.dattr.attr,
-- 
2.17.1

