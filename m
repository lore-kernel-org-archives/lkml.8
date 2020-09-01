Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C34C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D55E2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="BpZgKGoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbgIAPsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:48:41 -0400
Received: from mx4.wp.pl ([212.77.101.12]:32719 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731588AbgIAPo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:44:58 -0400
Received: (wp-smtpd smtp.wp.pl 31785 invoked from network); 1 Sep 2020 17:44:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1598975094; bh=0TkTRTTd/MctTe5GI7P3dkE8JPMJ2kvU+Sh6IzYUwwI=;
          h=From:To:Cc:Subject;
          b=BpZgKGoI2vxuvDAMOWuwlOaIhaPypqM3wZfW4WsN8OFySN8ssUKax0EwxOmLT7OrA
           7DVIpGyzGltoAY8hxvsmL2sG0dZF8boGD/Ay17JtS/JGc2hf6NnookkUNRCrFHu+G0
           lTgXrqnY1EUwHgFwxXH4DzjWBfbUJ6e/txb6Aftg=
Received: from 188.146.234.2.nat.umts.dynamic.t-mobile.pl (HELO localhost) (antoni.przybylik@wp.pl@[188.146.234.2])
          (envelope-sender <antoni.przybylik@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gregkh@linuxfoundation.org>; 1 Sep 2020 17:44:54 +0200
From:   Antoni Przybylik <antoni.przybylik@wp.pl>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Antoni Przybylik <antoni.przybylik@wp.pl>
Subject: [PATCH] staging: gdm724x: gdm_tty: replaced macro with an inline function
Date:   Tue,  1 Sep 2020 17:44:37 +0200
Message-Id: <20200901154437.110056-1-antoni.przybylik@wp.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: f1f5b46372db9c67cbcc3a4a70c1c0b8
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [oTHR]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This approach is more elegant and prevents some problems related to
macros such as operator precedence in expanded  expression.

Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
---
 drivers/staging/gdm724x/gdm_tty.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 6e813693a766..e789b7348dee 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -27,8 +27,6 @@
 
 #define MUX_TX_MAX_SIZE 2048
 
-#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
-
 static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
 static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
 static DEFINE_MUTEX(gdm_table_lock);
@@ -36,6 +34,11 @@ static DEFINE_MUTEX(gdm_table_lock);
 static const char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
 static char *DEVICE_STRING[TTY_MAX_COUNT] = {"GCT-ATC", "GCT-DM"};
 
+inline int gdm_tty_ready(gdm *gdm)
+{
+	return (gdm && gdm->tty_dev && gdm->port.count);
+}
+
 static void gdm_port_destruct(struct tty_port *port)
 {
 	struct gdm *gdm = container_of(port, struct gdm, port);
@@ -119,7 +122,7 @@ static int gdm_tty_recv_complete(void *data,
 {
 	struct gdm *gdm = tty_dev->gdm[index];
 
-	if (!GDM_TTY_READY(gdm)) {
+	if (!gdm_tty_ready(gdm)) {
 		if (complete == RECV_PACKET_PROCESS_COMPLETE)
 			gdm->tty_dev->recv_func(gdm->tty_dev->priv_dev,
 						gdm_tty_recv_complete);
@@ -146,7 +149,7 @@ static void gdm_tty_send_complete(void *arg)
 {
 	struct gdm *gdm = arg;
 
-	if (!GDM_TTY_READY(gdm))
+	if (!gdm_tty_ready(gdm))
 		return;
 
 	tty_port_tty_wakeup(&gdm->port);
@@ -160,7 +163,7 @@ static int gdm_tty_write(struct tty_struct *tty, const unsigned char *buf,
 	int sent_len = 0;
 	int sending_len = 0;
 
-	if (!GDM_TTY_READY(gdm))
+	if (!gdm_tty_ready(gdm))
 		return -ENODEV;
 
 	if (!len)
@@ -187,7 +190,7 @@ static int gdm_tty_write_room(struct tty_struct *tty)
 {
 	struct gdm *gdm = tty->driver_data;
 
-	if (!GDM_TTY_READY(gdm))
+	if (!gdm_tty_ready(gdm))
 		return -ENODEV;
 
 	return WRITE_SIZE;
-- 
2.28.0

