Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC7FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A222063A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHUPbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:31:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43212 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgHUPbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:31:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id v12so2281727ljc.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RiowHVIdXmdWQw4sb/h6lAEadFKHLzL7PqwIIimzsFs=;
        b=N8LZfZy/tlqq0o1y729wdePWv3U9Dkqh8D1VZJdY40jOKCI7UCQ3c5srsjuRdQEcs2
         C/nZEQ/8LJnANsS1cuJsvEh3pzZytlSeAzPHLHVbwc2eVBCpzGnmJtXaYGoVtFiat4tG
         QrO4IwLLeLcNlF3tDDrqZn5+oyrJGayXf6dVTipQQTLCfpadGrGYmkSU0Y/WQb4yU5Vg
         VVrVaTN2OOzKCJ+g2Z6zIUaRbCNUn9hdMbsxwlyDGPSEL+mMNh9PLQPCHcFAIfUfKsKP
         T4puG4eOxDQN2EHva3bK1p3vrhKsfrus01pxD51fpDTQkK/xvE9uEvxBF8Bkd/cdlGYv
         Vc9g==
X-Gm-Message-State: AOAM532v/GQjoEVH9f54jqCKqkBMEs63mrjEiv9lkI/7Nq7TsDHJoj0Y
        hJGsZzWiWpfgeE9WdjSv8d+pCGnOe4E=
X-Google-Smtp-Source: ABdhPJzjz8FcMOgIuUhj09q0MInHjKvcAKGRb0sLsr90dgT5GOGFgFOstOCNXGo0SSKhlQF1TzthIw==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr1868250ljg.185.1598023890775;
        Fri, 21 Aug 2020 08:31:30 -0700 (PDT)
Received: from localhost.localdomain ([213.87.151.123])
        by smtp.googlemail.com with ESMTPSA id w11sm446050lff.62.2020.08.21.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:31:28 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: api: add kobj_to_dev.cocci script
Date:   Fri, 21 Aug 2020 18:31:00 +0300
Message-Id: <20200821153100.434332-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Examples of such patches:
893c3d82b425 watchdog: Use kobj_to_dev() API
23fd63a44460 hwmon: (nct6683) Replace container_of() with  kobj_to_dev()
224941c9424f power: supply: use kobj_to_dev
a9b9b2af40c7 backlight: lm3533_bl: Use kobj_to_dev() instead
0acb47a3a093 qlcnic: Use kobj_to_dev() instead
97cd738c44c8 gpiolib: sysfs: use kobj_to_dev
d06f9e6c8960 hwmon: (nct7802) Replace container_of() API
036855a4c3b3 hwmon : (nct6775) Use kobj_to_dev() API
baf1d9c18293 driver/base/soc: Use kobj_to_dev() API
ae243ef0afbc rtc: sysfs: use kobj_to_dev
6b060d8a09e9 i2c: use kobj_to_dev() API
9e7bd945b9a9 scsi: core: use kobj_to_dev
0d730b57b95f s390/cio: use kobj_to_dev() API
0616ca73fd35 usb: use kobj_to_dev() API
8c9b839c0b80 alpha: use kobj_to_dev()
016c0bbae1d1 netxen: Use kobj_to_dev()
6908b45eafc4 GenWQE: use kobj_to_dev()
85f4f39c80e9 pch_phub: use kobj_to_dev()
47679cde604d misc: c2port: use kobj_to_dev()
85016ff33f35 misc: cxl: use kobj_to_dev()
092462c2b522 misc: eeprom: use kobj_to_dev()
a9c9d9aca4e7 zorro: Use kobj_to_dev()
a253f1eee6c4 rapidio: use kobj_to_dev()
e3837b00b6bb drm/radeon: use kobj_to_dev()
cc29ec874b37 drm/amdgpu: use kobj_to_dev()
d122cbf1a310 drm/sysfs: use kobj_to_dev()
657fb5fbadb3 drm/i915: use kobj_to_dev()
554a60379aaa PCI: Use kobj_to_dev() instead of open-coding it
2cf83833fc9c HID: use kobj_to_dev()
aeb7ed14fe5d bridge: use kobj_to_dev instead of to_dev
8e3829c61b48 staging:iio:adis16220: Use kobj_to_dev instead of open-coding it
b0d1f807f340 driver-core: Use kobj_to_dev instead of re-implementing it

 scripts/coccinelle/api/kobj_to_dev.cocci | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 scripts/coccinelle/api/kobj_to_dev.cocci

diff --git a/scripts/coccinelle/api/kobj_to_dev.cocci b/scripts/coccinelle/api/kobj_to_dev.cocci
new file mode 100644
index 000000000000..e2cdd424aeca
--- /dev/null
+++ b/scripts/coccinelle/api/kobj_to_dev.cocci
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use kobj_to_dev() instead of container_of()
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: kobj_to_dev, container_of
+//
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+
+@r depends on !patch@
+expression ptr;
+position p;
+@@
+
+* container_of(ptr, struct device, kobj)@p
+
+
+@depends on patch@
+expression ptr;
+@@
+
+- container_of(ptr, struct device, kobj)
++ kobj_to_dev(ptr)
+
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for kobj_to_dev()")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kobj_to_dev()")
-- 
2.26.2

