Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2DEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF71208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ha/iISKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCEPsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:48:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45872 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCEPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:48:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id v2so7598293wrp.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6vKPBMFAdnWYkETwAnE+NZr/Oa9B4AUuvrv5+JlUIUk=;
        b=ha/iISKtT2+pJaZKrcGZZxC8b1yqDyVkddwdovsXqroFDgNG72EvdwnjQ8q+AuEfyP
         L2Ro3c8X6ZCY6Q/IZWmBpD3df/47EMYujeereZZqX2hTSFealvoR/0Z3tj9AcyT4YhTe
         2jS7G4FspyKARvVgbl7WTdypb7H65+Ej1yhBkRnDMYujtkCWbF38hvBvz0aN3RJ60geF
         fFFLd8A5CIi3/SZ5yCJ3lUw2E810UFfw1JAgXatN9aKGhTVR+VBri4NACExWeBXUnTwX
         BJ8BaEsA/wS4Deoj02ML66A6LLuHUp6TerVrAvkUf51rWg56/hNPMG/YVdLefufbIYfz
         9sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6vKPBMFAdnWYkETwAnE+NZr/Oa9B4AUuvrv5+JlUIUk=;
        b=f4xL0M9/OGBfdtwYAmCUpbIxoQte5aVMzNVYjDL6d7WnHmT8W3NZDxwLmQyjfhdg22
         cVdfWChKqbfwOwALFjhMziut2UbHrMzlRS7/rMxuJZuwNqDvM1wtpinvMEuX09dBZnWg
         Dx7DmQGRnC5+ijRkOtN6yu/5HcnOU5sS5ABIhVun9onuDedhxGieOs8nSnfzXPoqQuvq
         sPVmbMzvV+jId27nJi5IKsVNUlYjfI3QxTB+kn8t2MInx/xdHmE0OkzQdCu/BdHK+MCN
         WNMnNpsprcNWGJ1X6LsRlqmv9BATAWS7sj293p150iYPhm+8FbeEswbaXkTjMzi8vh82
         HJgA==
X-Gm-Message-State: ANhLgQ2BuyGw7IimxG6tOU2+1mx/0hRcDD5tuclHVbEhSTasPKoqHXIw
        T3tCsCZSwrs3A0jXMPtnqj08e7kg5YA=
X-Google-Smtp-Source: ADFU+vsvtG4BngtdZbRkezZWGdyNU2MQK7sMwHpKfqFfhZqwBj0F8TEfH2yT+3tKSqzsrXBCcl8rEQ==
X-Received: by 2002:adf:a419:: with SMTP id d25mr11479372wra.210.1583423310070;
        Thu, 05 Mar 2020 07:48:30 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t187sm10175897wmt.25.2020.03.05.07.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 07:48:29 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: defconfig: enable storage for qemu
Date:   Thu,  5 Mar 2020 15:48:23 +0000
Message-Id: <1583423303-25405-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qemu versatilepb machine has some SCSI storage which cannot be used
with this defconfig.
The SCSI rely on PCI which is not enabled.
So let's enable both PCI and SCSI.

This will permit to use LAVA tests for versatilepb in kernelCI.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/configs/versatile_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 767935337413..6171b96cf9b8 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -96,3 +96,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
+CONFIG_PCI=y
+CONFIG_PCI_VERSATILE=y
+CONFIG_SCSI=y
+CONFIG_SCSI_SYM53C8XX_2=y
-- 
2.24.1

