Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFEC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296D4206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgD2OV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:21:27 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgD2OV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:21:26 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6LMN-1j5IaG1fUP-016gSa; Wed, 29 Apr 2020 16:21:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jules Irenge <jbi.octave@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wfx: avoid compiler warning on empty array
Date:   Wed, 29 Apr 2020 16:21:09 +0200
Message-Id: <20200429142119.1735196-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9VR6xSDPQ8g1NPHjws4CXVoCdGkwhOxNYK2KCEQwm7vtwokhGcO
 CYnU04XokIbuhXe8Zua9Z6fgLTEXNk+RCbcIZ4srK+52KJ4s02oc7e9STFvO7XVcgl5B7F2
 eglp9gEEofWWxonxeOCmFbegVWtUPEFVtUHH2YpxP/kZ1Bw1XRMn58D23v1za2ou9U8IO6L
 7hbaPK0cV565ri1GIipHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y1/KdhnlWZM=:jbj+5QBLT9zgufaVm/rZOE
 IpGQVwVYlS79n4eonJdiE/HEHj6bptBqv7FbbYTXnUSPdqkR2SUevxjLAPHbtRd0oIuN8lzaQ
 L6crLUrklH5H0tbTqNZ0mX8OHK9nV4b1aPrpkgqBU36Hzy1VkFmuSY7fW6Zj89GlK3HjVWuBZ
 iJ6d3r4UNMN4tsHW/67ipN9E2KVJddSp3PesTiA99os3uuavMrDS+HGzocfLYDlf8k+JJReDI
 Io77ZoxIZiCGXq1ocOJTo+k/A3wNf58w+k8ZxzqUWy5A+NKl62Jr50aFZzzZqkwyCxdyuJGT3
 MoPK03uwUslBUta75Pz1a0ICGtNwOO+/GVulccoaTl3T3JQZ4afPLLTJBo7iwVwI3Vlyk0Bli
 ehBj1srTmXR4S7syJHkpWEBaOA98o/vy6hNxqj78NuPA3lwAZ4L07OJqu5C3UoCEwCjwJ5okb
 yG7EyQ3XNypNL3nKpk72jGOVkYNSkM05nT9Lnxhce6tUq7/phCj9nDwSLk/gfC0U2up+kdw9n
 2VzFD/4iz09iCof1J52rrW0sKlGxqPdDnXFmF9zNrIC+c+43P2iaQe3IIb34yj3fRwKQWcJw8
 rpTd+PVfTsX153GQjwsmBzbBTWsZQr9mf2Xo3QMLgh4Xt8IFrDyj6YJtIwsik+cSUuqU/q0SX
 E1gyNQf6HrkvhWGKCUKpbaHyY9s2KFqum4JDqStrtsBJoL/tJ8/T2bxW7QMuhWnSnkgQBnxQC
 lY2gCD8Lfr+Z7HI9z14t/GFKvnyko8KyXlytZwr4Wua6ojbwgRfZ6kX4b4Xe80ZV8j97J0NAI
 fo36petyUrj/KBsXWvPVkQxpm/qXzimiwNDMjeXiknzeT/dSwM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF is disabled, gcc-9 produces a warning about the
wfx_sdio_of_match[] array having a declaration without a dimension:

drivers/staging/wfx/bus_sdio.c:159:34: error: array 'wfx_sdio_of_match' assumed to have one element [-Werror]
  159 | static const struct of_device_id wfx_sdio_of_match[];
      |                                  ^~~~~~~~~~~~~~~~~

Move the proper declaration up and out of the #ifdef instead.

Fixes: a7a91ca5a23d ("staging: wfx: add infrastructure for new driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/wfx/bus_sdio.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/wfx/bus_sdio.c b/drivers/staging/wfx/bus_sdio.c
index dedc3ff58d3e..c2e4bd1e3b0a 100644
--- a/drivers/staging/wfx/bus_sdio.c
+++ b/drivers/staging/wfx/bus_sdio.c
@@ -156,7 +156,13 @@ static const struct hwbus_ops wfx_sdio_hwbus_ops = {
 	.align_size		= wfx_sdio_align_size,
 };
 
-static const struct of_device_id wfx_sdio_of_match[];
+static const struct of_device_id wfx_sdio_of_match[] = {
+	{ .compatible = "silabs,wfx-sdio" },
+	{ .compatible = "silabs,wf200" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, wfx_sdio_of_match);
+
 static int wfx_sdio_probe(struct sdio_func *func,
 			  const struct sdio_device_id *id)
 {
@@ -248,15 +254,6 @@ static const struct sdio_device_id wfx_sdio_ids[] = {
 };
 MODULE_DEVICE_TABLE(sdio, wfx_sdio_ids);
 
-#ifdef CONFIG_OF
-static const struct of_device_id wfx_sdio_of_match[] = {
-	{ .compatible = "silabs,wfx-sdio" },
-	{ .compatible = "silabs,wf200" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, wfx_sdio_of_match);
-#endif
-
 struct sdio_driver wfx_sdio_driver = {
 	.name = "wfx-sdio",
 	.id_table = wfx_sdio_ids,
@@ -264,6 +261,6 @@ struct sdio_driver wfx_sdio_driver = {
 	.remove = wfx_sdio_remove,
 	.drv = {
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(wfx_sdio_of_match),
+		.of_match_table = wfx_sdio_of_match,
 	}
 };
-- 
2.26.0

