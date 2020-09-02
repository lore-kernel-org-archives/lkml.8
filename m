Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEF3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0C020639
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="nQ4KIhzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgIBQQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:16:40 -0400
Received: from mx3.wp.pl ([212.77.101.9]:46386 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbgIBQQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:16:25 -0400
Received: (wp-smtpd smtp.wp.pl 12462 invoked from network); 2 Sep 2020 18:16:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1599063380; bh=TtJS+HIXNquG/4RotPjKkCWhjDhR7eI0A8TOlVPI5TE=;
          h=From:To:Cc:Subject;
          b=nQ4KIhzmDDfe4a/FvrHXxX3BvSkcD1f0JOrSU2NzeRDhYMzWYtozjemW9vO+aF26X
           NYOsP0Ovy5kM6pPXCagjhWLy7AFu4C4yW7MK9SoHc0M35Zl+QFTe+jWeDqP5rCfOok
           Tj2dW2HGeJQFpTCGFM/4g+M5bqg2yHHaH3rG6Y74=
Received: from 188.146.102.178.nat.umts.dynamic.t-mobile.pl (HELO localhost) (antoni.przybylik@wp.pl@[188.146.102.178])
          (envelope-sender <antoni.przybylik@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gregkh@linuxfoundation.org>; 2 Sep 2020 18:16:20 +0200
From:   Antoni Przybylik <antoni.przybylik@wp.pl>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Antoni Przybylik <antoni.przybylik@wp.pl>
Subject: [PATCH v2 1/2] staging: gdm724x: gdm_tty: replaced macro with a function
Date:   Wed,  2 Sep 2020 18:16:16 +0200
Message-Id: <20200902161616.64638-1-antoni.przybylik@wp.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: a67d8e816817753c22be7aa74a62fbd1
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0100004 [sdei]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This approach is more elegant and prevents some problems related to
macros such as operator precedence in expanded expression.

Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
---
 drivers/staging/gdm724x/gdm_tty.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 6e813693a766..34a13d98c029 100644
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
 
+inline int gdm_tty_ready(struct gdm *gdm)
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

