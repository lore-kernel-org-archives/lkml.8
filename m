Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E70C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 11:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45D2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 11:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipkc0c9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgAOLdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:33:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56083 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgAOLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 06:33:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so17478649wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 03:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bjtZ5eSDKVKPCaPVF0QkrfK9h+NZ0t3IhMm/2SNFSYY=;
        b=Ipkc0c9TvwHgCZpX171XDuHI2ImOVWFpZtsbC93JtqSRfDcXVUGgkbmufiP1m+wyYj
         7VGmqsyGr2dLptJC8qPssX4wuvXLiF9WlHY98MUbVf1JjJpPmVuKGAi5ISEqoN9Ln25W
         +y+y51ISOrXX8TfWGHCOTTlMAeoPMoxFQProTGu261lv+WkKU2PqWRxoZ4iNTO4jZMcl
         qXHSRnFTQt+NN+t1nPHSRuoMYNZmhI3CmSLdVQFXiVEsyLS0tKtldAa9l//ghx+5vdWU
         l5cLKPQaXociYaFR4s43AbDnzxq53CSYpPwZaaekRXUCA4P5nwGuBCwMfvz9j5qrDHe4
         qXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bjtZ5eSDKVKPCaPVF0QkrfK9h+NZ0t3IhMm/2SNFSYY=;
        b=gcPpdz0Tiuf1BAd3Eq3Bl4ZelbxJu2/IohvyqY2Ipfzj+MVlF4GZTkNQm60fIYugbR
         Q4FOgOjmNcNL8js/BXQ5udzzT06TKSDcNhTXvLJZfvIDHdY1YFvYkX8JICC+c5ODTj3n
         wBlD73Mwq9nB81mJFRzowiRcRiF5cpX8CiYWh1JMqf57R6HuSysBOWwqxw/h9S1ccAoP
         J28u63dyuliLQs8mU2mljAStFvQnRan085u6po1TdDYqgr39frxdPCmGEvVHoKbG5oEC
         QzP0hqP/h+02ZGT1hRFWXVturjmfwmDJ9X/nT7kHYRkIm2+LtSYQxqVH1o9lSERL5Tkr
         YsYQ==
X-Gm-Message-State: APjAAAXobxaEVifafrnW3A9gXu1ebtOA3S9tR3p/Uv6+F7vepnP3ljeL
        zkXukgC/Amubmmux8MW2b4Q=
X-Google-Smtp-Source: APXvYqxam+VTA908+XGqxn+E6SO3/si0ritI029uDRCZAPoh0ozQqwfgoeJc7oTFItean/5norE7hA==
X-Received: by 2002:a1c:498a:: with SMTP id w132mr30992904wma.10.1579087999863;
        Wed, 15 Jan 2020 03:33:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:a58:8166:7500:34f4:3149:a617:3dd])
        by smtp.gmail.com with ESMTPSA id h17sm24892867wrs.18.2020.01.15.03.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 03:33:19 -0800 (PST)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Mao Han <han_mao@c-sky.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: delete temporary files
Date:   Wed, 15 Jan 2020 13:32:42 +0200
Message-Id: <20200115113243.23096-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Temporary files used in the VDSO build process linger on even after make
mrproper: vdso-dummy.o.tmp, vdso.so.dbg.tmp.

Delete them once they're no longer needed.

Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
---
 arch/riscv/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 49a5852fd07d..33b16f4212f7 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -58,7 +58,8 @@ quiet_cmd_vdsold = VDSOLD  $@
       cmd_vdsold = $(CC) $(KBUILD_CFLAGS) $(call cc-option, -no-pie) -nostdlib -nostartfiles $(SYSCFLAGS_$(@F)) \
                            -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp && \
                    $(CROSS_COMPILE)objcopy \
-                           $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@
+                           $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
+                   rm $@.tmp
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@

base-commit: dc6fcba72f0435b7884f2e92fd634bb9f78a2c60
-- 
2.17.1

