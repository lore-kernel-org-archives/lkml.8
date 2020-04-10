Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97610C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F1D20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7rtRQg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJOAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:00:38 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53522 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDJOAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:00:38 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so813805pjb.3;
        Fri, 10 Apr 2020 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1a+J/VSCDEYtPxuIGfotTeR8A4qskaLUqo89avV/nNM=;
        b=X7rtRQg2F2y5HnaOB3E/66R23Fdnh7LbEckT3JStHwSndwBbtrMqBlAHe6ZIyfJZzY
         GftL8g4CP6041yghnQVWTJbC0Mm6PDvaZ6TSSLmfpDoZZMIXeWix4cmVzJyLD5e+2f+s
         SRuK2viQy4dewGUG2MvNNpWmM8onKSVM+w5KZWol7yUcyAt9MR9fvAHezW8R/tFQgdEv
         drlv5YUznIy9q3GyIaQcywmyvTNE6u2JsgkJaYtSz2uLPEp7GkevqlICRHawoy58YTm7
         zfUtHHPRGvj/81NOWOlEcFjrYzGGeBwHX/QkV7OADlPM8M2i0dgBNYdd+2EDytX8+psl
         lWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1a+J/VSCDEYtPxuIGfotTeR8A4qskaLUqo89avV/nNM=;
        b=qo662Cgh/bh6QThNRir6PcDw1asEw6hILiqC9tj8x9A2zsw8Mw8Wz7V46bsWsP5CvZ
         RF6lLfXPI8vc1YROIGM93EP/RN0IGxelK0xPLGkeChFjg8WNeWSlhTTFYF43zt0Ounui
         +/navnRLO+Pu3wSaXW3f2bJTeyGTy4yo9PlgkxltksfZmVxY3/UqfaNtj7hFcGihOCRP
         ZrFiZbzyGUUTrXTMKyr19VVQys3EBcsrRggtc2iXet41LB/RWhR//9AbyxPjnSekUz/j
         xnIIvGP8TFru8yEMFSANIcOhHT3QYhl0OzMCAmmmslT789PqcslmfzXUZynHnuXVyRWE
         owzg==
X-Gm-Message-State: AGi0PuZVgqeHAmH5CxqAe/GemUnetIdDQwpYs9B7U9QHNexmrUznNQRo
        yN5d68TUX2fpWh4YlveUa69VZ6V3LNY=
X-Google-Smtp-Source: APiQypLVzFRlDTxzirlPjh0x1uwj8dt4ug1V/teIlyKKJST1IWEBVxy7YCh8UMWKEmPnHkv/kcKa9g==
X-Received: by 2002:a17:90a:14c6:: with SMTP id k64mr5558404pja.39.1586527235976;
        Fri, 10 Apr 2020 07:00:35 -0700 (PDT)
Received: from i7.zsun.org.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n21sm1636860pgd.93.2020.04.10.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 07:00:35 -0700 (PDT)
From:   sztsian@gmail.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     sztsian@gmail.com, linux-kernel@vger.kernel.org, icenowy@aosc.io
Subject: [PATCH 0/1] Bluetooth: btrtl: Add support for RTL8761B
Date:   Fri, 10 Apr 2020 22:00:09 +0800
Message-Id: <20200410140010.105317-1-sztsian@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zamir SUN <sztsian@gmail.com>

This patch adds support for the RTL8761B USB Bluetooth dongle.

When I got the RTL8761B dongle, I see it is actually recognised as
RTL8761A in my system (5.5.15-200.fc31.x86_64 on Fedora). And the
userspace cannot detect bluetooth devices in such situation.

[34689.158047] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
[34689.159083] Bluetooth: hci0: RTL: rom_version status=0 version=1
[34689.159088] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_fw.bin
[34689.159498] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_config.bin
[34689.159522] bluetooth hci0: Direct firmware load for rtl_bt/rtl8761a_config.bin failed with error -2
[34689.159529] Bluetooth: hci0: RTL: cfg_sz -2, total sz 20204
[34691.248484] Bluetooth: hci0: command 0xfc20 tx timeout

With great help from Icenowy Zheng she helped identifying the firmware
from the vendor-provided Windows driver. After applying this patch along
with the firmware I am able to use this dongle.

Note, I don't have RTL8761A device, so I would appreciate if someone 
can help test in case this patch breaks RTL8761A.

Ziqian SUN (Zamir) (1):
  Bluetooth: btrtl: Add support for RTL8761B

 drivers/bluetooth/btrtl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.2

