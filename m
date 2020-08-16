Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFF6C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EF820674
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597571411;
	bh=MuzYdBgIYAbxUvBCWqa1bdzBfGD5XqPgC8ntMwWo7bA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SDnvs+Tgu6RTgzmdKNYtvDDVMCZI53J5O/dgFmBbeAVWbeRg3qXLoF0MzWi+mflUZ
	 0bU8vq+tjkpdeFHXXAo5APtqsMTt7PeLixDL8nRtc3li/ECFVPfiLir6CUelIhRRO/
	 AjkeYvZR6eR5ArOhXmCv2bgWSKO/MY6WQhHnGpyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHPJuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 05:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgHPJuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 05:50:07 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EBEC20674;
        Sun, 16 Aug 2020 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597571407;
        bh=MuzYdBgIYAbxUvBCWqa1bdzBfGD5XqPgC8ntMwWo7bA=;
        h=From:To:Cc:Subject:Date:From;
        b=fu1cgfs6CoYs37t+152Bvt+oazE4LrVD62DksEJXhosjXOCKOAvylbL67rL/Neq5J
         Es7UuOKxkDUleQtenXXT/L8w0NLbTPy0GrPUAL8cV2cyY40tMv576FS+LepyedUH0W
         CP3kcbinNbWBqEjk3eqAonbABQPmlYd0Toicru3M=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: renesas-xhci: add version 0x2020 as valid
Date:   Sun, 16 Aug 2020 15:19:49 +0530
Message-Id: <20200816094949.349878-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices in wild are reporting firmware version as 0x2020, so add
that as well

Reported by: Anastasios Vacharakis <vacharakis@gmail.com>
Reported by: Glen Journeay <journeay@gmail.com>
Fixes: 2478be82de44 ("usb: renesas-xhci: Add ROM loader for uPD720201")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208911
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
Greg, this fixes regression for folks with preprogrammed controllers with
firmware version 0x2020, please mark as stable material

 drivers/usb/host/xhci-pci-renesas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 59b1965ad0a3..03875cd28ddd 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -50,14 +50,16 @@
 #define RENESAS_RETRY	10000
 #define RENESAS_DELAY	10
 
-#define ROM_VALID_01 0x2013
-#define ROM_VALID_02 0x2026
+#define ROM_VALID_01 0x2020
+#define ROM_VALID_02 0x2013
+#define ROM_VALID_03 0x2026
 
 static int renesas_verify_fw_version(struct pci_dev *pdev, u32 version)
 {
 	switch (version) {
 	case ROM_VALID_01:
 	case ROM_VALID_02:
+	case ROM_VALID_03:
 		return 0;
 	}
 	dev_err(&pdev->dev, "FW has invalid version :%d\n", version);
-- 
2.26.2

