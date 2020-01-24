Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ED8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA962087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863661;
	bh=hHZ0r5koTcCu61eYNLhQfmBQtmAHcR0VNmlmXonSSHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nqKbHvSyMUxp5ejll9crCLML0Y6Fc7up//Sp49fGkmrrZ6rKZTW3KoA8CnL4ICUEy
	 a0LFxuuoO7pzTo1+q5uJORHLJLPvkZSWYBQUspAynCeQfloSoiHVVRzoZXym0dEIH2
	 yA3on3hnFut7qcFILqz3/uVbEp+FUiknXSNciVJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgAXLBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387461AbgAXLA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:00:57 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318342075D;
        Fri, 24 Jan 2020 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863656;
        bh=hHZ0r5koTcCu61eYNLhQfmBQtmAHcR0VNmlmXonSSHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5iOOhtuBtQRt82j4OoBCDrqpST9Rf3zDcHt2o5jOAm4n/c8B+//Wh7moLui6Fa85
         lprU4V+9mAR/nK8jO3ahuliXbjdPVRw9ehYWW9C11SPFg1hs1oY4Tz5bvs3tVrrvIy
         csYab+egRtE3zJx8lfwoCkkqJGPEWNDLZBh4dfBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/639] usb: dwc3: add EXTCON dependency for qcom
Date:   Fri, 24 Jan 2020 10:23:29 +0100
Message-Id: <20200124093052.344471658@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3def4031b3e3fbb524cbd01555b057a6cef0d5e6 ]

Like the omap back-end, we get a link error with CONFIG_EXTCON=m
when building the qcom back-end into the kernel:

drivers/usb/dwc3/dwc3-qcom.o: In function `dwc3_qcom_probe':
dwc3-qcom.c:(.text+0x13dc): undefined reference to `extcon_get_edev_by_phandle'
dwc3-qcom.c:(.text+0x1b18): undefined reference to `devm_extcon_register_notifier'
dwc3-qcom.c:(.text+0x1b9c): undefined reference to `extcon_get_state'

Do the same thing as OMAP and add an explicit dependency on
EXTCON.

Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 518ead12458d0..1a0404fda596b 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -113,7 +113,7 @@ config USB_DWC3_ST
 
 config USB_DWC3_QCOM
 	tristate "Qualcomm Platform"
-	depends on ARCH_QCOM || COMPILE_TEST
+	depends on EXTCON && (ARCH_QCOM || COMPILE_TEST)
 	depends on OF
 	default USB_DWC3
 	help
-- 
2.20.1



