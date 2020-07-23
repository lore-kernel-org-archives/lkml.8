Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DDEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148052084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgGWHU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:20:29 -0400
Received: from out28-125.mail.aliyun.com ([115.124.28.125]:55421 "EHLO
        out28-125.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGWHU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:20:28 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08760107|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0079633-0.000303186-0.991734;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.I6IjCRk_1595488814;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I6IjCRk_1595488814)
          by smtp.aliyun-inc.com(10.147.42.253);
          Thu, 23 Jul 2020 15:20:25 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        keescook@chromium.org, hns@goldelico.com, ebiederm@xmission.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH] MIPS: CI20: Update defconfig for EFUSE.
Date:   Thu, 23 Jul 2020 15:19:50 +0800
Message-Id: <20200723071950.130007-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200723071950.130007-1-zhouyanjie@wanyeetech.com>
References: <20200723071950.130007-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 19c968222934 ("MIPS: DTS: CI20: make DM9000 Ethernet
controller use NVMEM to find the default MAC address") add EFUSE
node for DM9000 in CI20, however, the EFUSE driver is not selected,
which will cause the DM9000 to fail to read the MAC address from
EFUSE, causing the following issue:

[FAILED] Failed to start Raise network interfaces.

Fix this problem by select CONFIG_JZ4780_EFUSE by default in the
ci20_defconfig.

Fixes: 19c968222934 ("MIPS: DTS: CI20: make DM9000 Ethernet
controller use NVMEM to find the default MAC address").

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 arch/mips/configs/ci20_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index f433fad16073..ba26ba4de09a 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -140,6 +140,7 @@ CONFIG_INGENIC_OST=y
 CONFIG_MEMORY=y
 CONFIG_PWM=y
 CONFIG_PWM_JZ4740=m
+CONFIG_JZ4780_EFUSE=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_AUTOFS_FS=y
-- 
2.11.0

