Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1B9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC952077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202240;
	bh=aX7ifRBNjLV4P2WSjgKpSySenyZPKe/92qia74ikSpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uGNBBqBcI3+OMu5KVs7jyHOJt3/tlF7IJDQqDRNA2Ypn6BV16KjOu7jAOTZikFGwJ
	 lR30xIzuEHt8n6XpjcPYQ/k7fUg481dKwnwW+tYWFIFA15wUyf/LoFp1DKXZb3SP3h
	 j9RpJicYz/zWBJ0bTE2h5+heY/BQE4STk7YHXRm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437634AbgAPTRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732955AbgAPQz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BD420730;
        Thu, 16 Jan 2020 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193729;
        bh=aX7ifRBNjLV4P2WSjgKpSySenyZPKe/92qia74ikSpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REESr598VvRipbs6BUyv2+jkx4T+ZuYc7TQap51G9srO4pj5GzjEVjLDxdjk5iXFM
         cpqAtuOFaTzrUoO7Np85+BvyoqOlbeKJRajm7Cw47EGAxuFXTcZ4S+0mbySHC12hTI
         xbipoPb+Ne3cRV0zezS+kVAC2e6sCV83eww7JvVA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 022/671] usb: dwc3: add EXTCON dependency for qcom
Date:   Thu, 16 Jan 2020 11:44:13 -0500
Message-Id: <20200116165502.8838-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 518ead12458d..1a0404fda596 100644
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

