Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2696C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1135207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o88rmhmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgBUApE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:45:04 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5901 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbgBUApC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582245903; x=1613781903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DtSFlj3fsdPpNhaIrq8wNLcKQJSd74ci7U7S/MThub8=;
  b=o88rmhmxX0G3Axm/UTB0Bjz8e1/1RQbLMYPiMRc9r3qUltN6GOzZ6Kg8
   uC4lr1lOJXVEvMcEqyiR+upk0mvxdPulFel3xgfBKqqAxBuEDXxtMtjHP
   eLBdYlFPFcA02MISNbtS8YyzlCHz6h+K3B+MiMfnVFyrGHNg2o4Sj0eVd
   PuQMGhG7XVRGvKemfxDPw0eEqeIHIh72mXfKlvAsEiuOY4a2EieaYkBAa
   4f/3rZ2idqm6frwXdF4bixIzlJJXv8jrpGpq6Mytf2P+Bsr7KP48Mvaz2
   9urIyMUrycZYFlbNzJHeYPSoFRfXbgtgaVLHN6Y4yalTfHqAnboCDPlHf
   Q==;
IronPort-SDR: juQMn/QwDVhdW7gpqEDzNX5vpAWdxGnIaRmUe/IRoHDquLLvJdm+Pfz9XM+4KNfw1V9ZNXW6xp
 drfoyy7bRSF2ZALmPKCgTut/6uXBsr1UqiV1GqSATj97AKziYc9/xMIO8jzgUD7hXW9CpwulBn
 iRfWvhDNtLyKD+RvIdvXiSWMH8wI8vlaLAboxvQIaYzg/qkxp6XY1Ow1pHcGLOxiYehXFQYqLi
 izFe/haGubYDEWgMD+GksbMpp6K5T5ZASJT4R89+zGH99HevGMaoY47PH2DbCpnV9Qh1a6Rv/Q
 nFE=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="130852803"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 08:44:50 +0800
IronPort-SDR: ZFQmZlD4zivkZ5rySKKstWr6jRJLuE+j/p3SVcreZRP5+aqQvwY4hWZJE1P1NZFaFqa/QY8UOl
 yaWj6rozQNOEQLkcoLCLzw/INDg8yV95zfxPjRHyZRCg85v397H/akb4hwGXLcY3/Q+ip2L7Ts
 6wKTZNkdDEYzy4FkYjDh21k3OJEwW9kRvYSVCuPADnRM/kwHXCVwzOadSaIPL/ueT/Cyv+wdFS
 oOJIrj1X2vk/9U80mUp2GJo7hBThfpoN3qaQvXaEEF8kPMT7ILN+CJdQsOZUTf5yiQ8A5YWf5H
 Mru4IqW+TZW/cF437x8uVllH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:37:23 -0800
IronPort-SDR: YhbK9nBOwPKYbg5fWQ6KFWrrqdqopF37cuMI5uuKwJ1R9aZGRe+hLyc4qeMNbSrKXt4nwt7Y0V
 ISHF2a5NM6b7pmBrGRhwHz9xxR9Nl4nXdnVJ4YyKixAisVcrRkhGZ5gTFY+RyK0Jbv8Ta1o/1A
 0a62oXshfla3gp4wTr8uPQ7a7kaED1wFvwebX77E+Eh31UQTpJZpmeZ616XMEedjCBPeT8claW
 ZkFd/O+M7g58p0FWjrbNEkoCi5Hymyj7zeXTQz8u3Muc0IyfYzwmTRrV37gjWZpogCLPvZ480/
 n6Y=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 16:44:48 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v9 08/12] RISC-V: Export SBI error to linux error mapping function
Date:   Thu, 20 Feb 2020 16:44:09 -0800
Message-Id: <20200221004413.12869-9-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221004413.12869-1-atish.patra@wdc.com>
References: <20200221004413.12869-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All SBI related extensions will not be implemented in sbi.c to avoid
bloating. Thus, sbi_err_map_linux_errno() will be used in other files
implementing that specific extension.

Export the function so that it can be used later.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 arch/riscv/kernel/sbi.c      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index d55d8090ab5c..abbf0a7d3b6e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -130,6 +130,7 @@ static inline unsigned long sbi_minor_version(void)
 {
 	return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
 }
+int sbi_err_map_linux_errno(int err);
 #else /* CONFIG_RISCV_SBI */
 /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
 void sbi_set_timer(uint64_t stime_value);
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 38ec99415060..d0c9516b6c0a 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -46,7 +46,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 }
 EXPORT_SYMBOL(sbi_ecall);
 
-static int sbi_err_map_linux_errno(int err)
+int sbi_err_map_linux_errno(int err)
 {
 	switch (err) {
 	case SBI_SUCCESS:
@@ -63,6 +63,7 @@ static int sbi_err_map_linux_errno(int err)
 		return -ENOTSUPP;
 	};
 }
+EXPORT_SYMBOL(sbi_err_map_linux_errno);
 
 #ifdef CONFIG_RISCV_SBI_V01
 /**
-- 
2.25.0

