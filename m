Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA74C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029CB20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCINA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:00:27 -0400
Received: from v6.sk ([167.172.42.174]:34458 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgCINA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:00:26 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 472DE60EEF;
        Mon,  9 Mar 2020 13:00:25 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] USB: EHCI: ehci-mv: use a unique bus name
Date:   Mon,  9 Mar 2020 14:00:14 +0100
Message-Id: <20200309130014.548168-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309130014.548168-1-lkundrak@v3.sk>
References: <20200309130014.548168-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case there are multiple Marvell EHCI blocks in system, we need a
different bus name for each one. Otherwise debugfs gets mildly upset about
a directory name in usb/ehci:

  debugfs: Directory 'mv ehci' with parent 'ehci' already present!

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index ddb668963955f..1300c457d9ed6 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -115,7 +115,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	if (usb_disabled())
 		return -ENODEV;
 
-	hcd = usb_create_hcd(&ehci_platform_hc_driver, &pdev->dev, "mv ehci");
+	hcd = usb_create_hcd(&ehci_platform_hc_driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd)
 		return -ENOMEM;
 
-- 
2.25.1

