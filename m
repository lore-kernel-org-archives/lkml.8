Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D26C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE77A24672
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2O7QCmf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBRTek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:34:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54290 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBRTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id n3so1790866wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GIsVr9Du1tvwTcb5uCrDYvsZclteV5H/OmCi1XkJbsI=;
        b=2O7QCmf9iFPFkRv0VE4t1kzuscHCsPiDVYzPZdeRD/9yAPEt88zBVFrmtSMmlZ3421
         rsxYMRWVL65/PAVSI+vSUD4Mc5D6Q71LrCBmrFVh6CoqVkFk9c3CPvosbjK7rSBUbtzg
         x+J0N0FjpraNAXztDPn6ZHeBPGRkfGD+mJZrT3LOlUMtdJVb4THClxuIne79PZiKtf+p
         Axb1FxrlwfXgmNaVy7zxMnu5Q9ueOgmTV01D2AX1SHUrRlJsXeBZN0BcRyLyeZdghWF5
         wx7bviISHxlfdi0b8mECPUKlhhT99egizBIh0rpqYep8hAgoOE9ZcK0pS/38Pb6BzwN0
         Q2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GIsVr9Du1tvwTcb5uCrDYvsZclteV5H/OmCi1XkJbsI=;
        b=OIUx9UcX6PphTmyz8v3EvyarKTxYtP3/Imap5eFxn+1ByvH2IqBSIgMwEBp/oq25Me
         BfEZVI8/x7Ld171u6sH8fPi4ZYkNwS4tmYSg/v56LhXn+z+dkceWfK1m49zDI0QI0xH+
         MNmcq6eGvO7lgnaLVn5aKlxQkAEQPCCo6ChjPZqqnzC1pyfRc0lk3zwaswkrg9dJMwmh
         QyE6HE+PINtwC0VRg9dYEteJsdfdgfqZbePpm0DVbGvHWzxGIXe9hGGABVsN+veU5Ivj
         97k4O5rw4fyiA9duMAgg5+V7AYDJbvX171wmhdlQH8a9FRUo0eL0Pz8AWL1Zg4z1u58Z
         0/Gg==
X-Gm-Message-State: APjAAAXCRG6/G5aXl4s3IpB+XuJHG4K/HCCl7qWTv2MSnj6u1KygfKug
        TqjCHGOMnKLO2i29ENgbTEGngw==
X-Google-Smtp-Source: APXvYqxR5PXmj0VVyv0YT2k0zGTYVu+qYbvCaTD7nmPRrFBNPj3tgodO+1GzG5jCiyAA9mno7qDhuw==
X-Received: by 2002:a1c:1fc5:: with SMTP id f188mr4899137wmf.55.1582054396803;
        Tue, 18 Feb 2020 11:33:16 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:16 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 02/20] usb: gadget: legacy: inode: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:45 +0000
Message-Id: <1582054383-35760-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
shortname (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/gadget/legacy/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index b47938dff1a2..e3dfc2180555 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1736,7 +1736,7 @@ static struct usb_gadget_driver gadgetfs_driver = {
 	.suspend	= gadgetfs_suspend,
 
 	.driver	= {
-		.name		= (char *) shortname,
+		.name		= shortname,
 	},
 };
 
-- 
2.24.1

