Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A4FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78542078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJN6+nbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDJOyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:54:40 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:35230 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:54:39 -0400
Received: by mail-pj1-f43.google.com with SMTP id mn19so848799pjb.0;
        Fri, 10 Apr 2020 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vXnmY4GE13NUJnVdfudjFEgcp4akceqh2aSAgwoRhs=;
        b=sJN6+nbUp9CQyEABDgtKY6PzKTjYmaoHMB6heJqOcy6ubzQ/qQqEQhyAwZ8r/lB1H5
         oNhstTpqfWgucUe9m/UbPeWXkEoREsmal6r4x3R2X4SSkFyudSvFca/kY8FY6Ww3/GdN
         3uJNDB9682re4EFv+EWnpgi7tKIq5r2pMcJntpjbkseZ+u2qPHejXEebZN4FVyqxkEzj
         c26zRYzxeUEKbgjMRfCht3kRp8k6V82b9rNUYGkN6DyLIV3Ed5PtfNpPfLO8JuMpbhON
         uJ8uRndounQ4Xzm4yXiRwclgMj9aciTwVRar4me6CUf/S4kZVfdCM+tt6hY4+Xdzv7G9
         oY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vXnmY4GE13NUJnVdfudjFEgcp4akceqh2aSAgwoRhs=;
        b=K8TVD7/BpdpImzeXgVASs2A6L54MiCetPOHB9x0tt2F25zjgJAMWngEMBBiTnDQs30
         chAx3CR2qPVefHX0cH4xE8GE35fnQfuRlpA6+rt5Kx22YTDfnmVIiN19jao9NPLM6jln
         F33y26Jzocz58vC+t1On5EOTWkxKaKUf8VKUHoLcRrq2AlUEiOeAEptegeLBAONqHA7m
         ejOvtnQF12JstvSekbXxDGcL9Jrm5I2pgpvQBqu1EFklNEAvYz1s8nY4QJJlfxbCFJer
         wJoIU42zGPtbwEH9EJQ/aH1Larlfe7QLaWSWoNM7MTBpg9M2IJ342SuM5ykfHC5EnDYn
         3C/A==
X-Gm-Message-State: AGi0PuYgGAgnofhz9YZpp7lsyq9xYRBbbFnKP2iqy9UIIPzzm1ENK03s
        Ix/jW8QiRUibYKn8Ph6Y1QlnppFBa6U=
X-Google-Smtp-Source: APiQypItUorcpj1+EyaaNOcVMOhsDaJY1S+vjPvXicH5vbmM7moa/7ui7cJ0JIIoyTl3GGTCpi/9vA==
X-Received: by 2002:a17:902:968a:: with SMTP id n10mr4738564plp.96.1586530477380;
        Fri, 10 Apr 2020 07:54:37 -0700 (PDT)
Received: from i7.zsun.org.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v5sm1951230pfn.105.2020.04.10.07.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 07:54:36 -0700 (PDT)
From:   sztsian@gmail.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     sztsian@gmail.com, linux-kernel@vger.kernel.org, icenowy@aosc.io
Subject: [PATCH v2 0/1] Bluetooth: btrtl: Add support for RTL8761B
Date:   Fri, 10 Apr 2020 22:54:19 +0800
Message-Id: <20200410145420.108868-1-sztsian@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ziqian SUN (Zamir) <sztsian@gmail.com>

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

Icenowy Zheng offered great help by identifying the firmware
from the vendor-provided Windows driver. After applying this patch along
with the firmware I am able to use this dongle.

Note, I don't have RTL8761A device, so I would appreciate if someone 
can help test in case this patch breaks RTL8761A.
The RTL8761A information is from the following Github issue
https://github.com/lwfinger/rtlwifi_new/issues/58

[   41.468873] Bluetooth: hci0: rtl: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8761

Ziqian SUN (Zamir) (1):
  Bluetooth: btrtl: Add support for RTL8761B

 drivers/bluetooth/btrtl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.2

