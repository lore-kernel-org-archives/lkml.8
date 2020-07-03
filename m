Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7496CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5269420747
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gf70XC+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGCBLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCBLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:11:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08925C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 18:11:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so11349280pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GR99GIZZjMuYiZzLF19Koiioj28kl/2jLD/QPVbsMmo=;
        b=Gf70XC+FENM8wk9LD/IhT3t17C7HyY4bCdWxH2/yBHTDClzfDME3YPjnA3reqYxscT
         tan/vmiTxI4TScYutZAEUAubtTfmezTcSfcMxG8/xTshXGM4haDnyswOHyd4QuZXFPwT
         FPrSXRYFiRANfbKgOi9wsvCyIvCwZ/PkLVkqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GR99GIZZjMuYiZzLF19Koiioj28kl/2jLD/QPVbsMmo=;
        b=ozaP9521sbGUhSkT7zGjWFYy9fDS0EOAxjMoQPGuPQW0mohHumgi0zGSTRZwdqqeYx
         KcD9kfxi/JirJwXCZZo5jDH6g3JsxxtU8aOetUboWMUWgKAETzAPopTdAk5wyOtG9sXP
         IUbOFKwI6a3OAcPc1UU2ACjK+h4WGOqyY5OsPO2n4tRi0ENwi0e3HDN8fqbupEHTtqcf
         h8PdmiyqHqh5g0+Q2vo3aN5ZaEO8nAqb89lxveloxL0tIVrBxVZvRLoZr2kZR9iXTGzy
         Ao3VMFVgUxGRCOrphEY5vGUX5buRbXbcbGOUOqJ1o8hsRicJXCPnQzHI5yqK9rSrUbpZ
         op2g==
X-Gm-Message-State: AOAM530Al51G8tdu2i7YOu1kkUbf//LZWZbulXST8y3O5Cl95FNoBdpt
        cF1g/X6JB6uXwekpZx1ls/g7hQ==
X-Google-Smtp-Source: ABdhPJytWvIWeK1ATDg3B20v4sgj59qnn+uhC1n/GMs05mdtVBs9Gt4NyvBkIjNx6BlJ/vdoEyr9xQ==
X-Received: by 2002:a62:cdc4:: with SMTP id o187mr9910453pfg.200.1593738707606;
        Thu, 02 Jul 2020 18:11:47 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id e12sm9662721pfd.69.2020.07.02.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 18:11:47 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: add Realtek 8822CE to blacklist_table
Date:   Fri,  3 Jul 2020 09:11:32 +0800
Message-Id: <20200703091124.1.I63705bf6abab9cb79c14f7959a59b201af2b8827@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Realtek 8822CE controller to the blacklist_table
to support the wideband speech capability.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0e143c0cecf2a1..34a84c64e4c83e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -359,6 +359,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_IGNORE },
 
+	/* Realtek 8822CE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
-- 
2.27.0.212.ge8ba1cc988-goog

