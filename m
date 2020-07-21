Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAA9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB79720684
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgGUUQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:16:02 -0400
Received: from mail.ispras.ru ([83.149.199.84]:54136 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUUQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:16:01 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id 39A094089EF1;
        Tue, 21 Jul 2020 20:15:59 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] usb: gadget: net2280: fix memory leak on probe error handling paths
Date:   Tue, 21 Jul 2020 23:15:58 +0300
Message-Id: <20200721201558.20069-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver does not release memory for device on error handling paths in
net2280_probe() when gadget_release() is not registered yet.

The patch fixes the bug like in other similar drivers.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/usb/gadget/udc/net2280.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 5eff85eeaa5a..d5fe071b2db2 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -3781,8 +3781,10 @@ static int net2280_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 done:
-	if (dev)
+	if (dev) {
 		net2280_remove(pdev);
+		kfree(dev);
+	}
 	return retval;
 }
 
-- 
2.16.4

