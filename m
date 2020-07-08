Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355B3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A90C2078A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgGHGd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:33:27 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:55970 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbgGHGd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:33:27 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 1C9A4BC11C;
        Wed,  8 Jul 2020 06:33:24 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: W1 DALLAS'S 1-WIRE BUS
Date:   Wed,  8 Jul 2020 08:33:18 +0200
Message-Id: <20200708063318.12871-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/w1/slaves/w1_ds2408.c | 2 +-
 drivers/w1/w1_netlink.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index 83f8d94bb814..faf5c7c561da 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -285,7 +285,7 @@ static ssize_t status_control_write(struct file *filp, struct kobject *kobj,
 /*
  * This is a special sequence we must do to ensure the P0 output is not stuck
  * in test mode. This is described in rev 2 of the ds2408's datasheet
- * (http://datasheets.maximintegrated.com/en/ds/DS2408.pdf) under
+ * (https://datasheets.maximintegrated.com/en/ds/DS2408.pdf) under
  * "APPLICATION INFORMATION/Power-up timing".
  */
 static int w1_f29_disable_test_mode(struct w1_slave *sl)
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index fa490aa4407c..83b37ee2417d 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -547,7 +547,7 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 
 	/* If any unknown flag is set let the application know, that way
 	 * applications can detect the absence of features in kernels that
-	 * don't know about them.  http://lwn.net/Articles/587527/
+	 * don't know about them.  https://lwn.net/Articles/587527/
 	 */
 	if (cn->flags & ~(W1_CN_BUNDLE)) {
 		w1_netlink_send_error(cn, msg, nsp->portid, -EINVAL);
-- 
2.27.0

