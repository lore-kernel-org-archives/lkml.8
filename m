Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BE9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6C7246A7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194918;
	bh=U/NqnCQwVQ2UCt5lWGUmMYs4JvLuZDr4nhfNOLOb7kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RITYFGN6SRoIWnMG8r9Felgl1/j1zADCLP14ggGctNtYnDIkaWGEPYCE/sUc8gZrB
	 GmTAjUVj5xczyL7PZP8RFiNGxEyXFm4qEfrPRi1NbRSQqflXIB7gOtL6vjoRw7L9c5
	 e2XhNBdx3JJVGzwHvF7Nj9xjRzQNlA6KcqMcfS7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbgAPRPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391055AbgAPROj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:14:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D0C9246A7;
        Thu, 16 Jan 2020 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194879;
        bh=U/NqnCQwVQ2UCt5lWGUmMYs4JvLuZDr4nhfNOLOb7kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHKMWfTkMU9QrS+PAuRp/ZcmxWryEppv/yE3Kp0HLmP2xtRDDUJy3pBNsFcOssH+o
         mNTIPemZzEAum5RUQzLvMKIInJ7zOxjsIwRUS/8h6ml1XbeGAArJGHc1JUzjm0w0RE
         VbiR5HfPBOXoc9ZDar0I2JoxHqQ9K4Z2H3BygQME=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 668/671] usb: dwc3: Allow building USB_DWC3_QCOM without EXTCON
Date:   Thu, 16 Jan 2020 12:05:06 -0500
Message-Id: <20200116170509.12787-405-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Gonzalez <marc.w.gonzalez@free.fr>

[ Upstream commit 77a4946516fe488b6a33390de6d749f934a243ba ]

Keep EXTCON support optional, as some platforms do not need it.

Do the same for USB_DWC3_OMAP while we're at it.

Fixes: 3def4031b3e3f ("usb: dwc3: add EXTCON dependency for qcom")
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 1a0404fda596..5d22f4bf2a9f 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -52,7 +52,8 @@ comment "Platform Glue Driver Support"
 
 config USB_DWC3_OMAP
 	tristate "Texas Instruments OMAP5 and similar Platforms"
-	depends on EXTCON && (ARCH_OMAP2PLUS || COMPILE_TEST)
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on EXTCON || !EXTCON
 	depends on OF
 	default USB_DWC3
 	help
@@ -113,7 +114,8 @@ config USB_DWC3_ST
 
 config USB_DWC3_QCOM
 	tristate "Qualcomm Platform"
-	depends on EXTCON && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on EXTCON || !EXTCON
 	depends on OF
 	default USB_DWC3
 	help
-- 
2.20.1

