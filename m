Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CCCC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD77724656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UggKKzIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBZWCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:02:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45043 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgBZWCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582754545; x=1614290545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JqXfvLC9I8btjifDyDxA+vz0y13stX9yiYKqjoJkjmU=;
  b=UggKKzIxrQMSHQA4QAKAbus1hkfJHhj2E+YEHIZzQslMBUdeczbjJG/2
   KLcQnnRWDIaCzovsts3rD9qtq+7HwctjnMM1+LaaP2rCSep6JZ9Dj2RDe
   wpToRwwDNigQcyOO3nvNrItyWHxdqofwwpSH7hE/5wjLoJW6shig/5Atv
   u58rqF/1isBQId7g1HIHFVdAWmvTPxxuRf1/OBo8zb3wgM0KU2iBh4LHg
   35jorpr6UR8qNp3fcUgfE9VzQ5TA94UsmFq57ZLXIMefkVmpqwiHvxlxK
   dd2NGZ7ybpCbcIeqC+EezZ+ke81fYzPf57+1j/VHCckoC+2zHLK4MPyT+
   g==;
IronPort-SDR: q6Zk/FjtH0+o4gCAUjGYVpN+tPAjO0ATV/INIBthNj5bEIaLidO8rDt0uDwNtxBq/F+lDeqmj2
 Sepn8QZC8cXitce0PxgjL5mluxIG3QqLATPSw4JM9298GhGWH2Omi1pNe6N1mME4IeYwCL4DlT
 qypzw/rC/n6QkPCwsVKQ8ZzZ6BwgeDq9/LVsrEzfobFXibpbpFyhc270p01CGin6CLjXoPGJNN
 pN0qlU89cVb0YxcbmY2m22SyFq/mbaaa99xeA7Rs5s6miwlFB+WDDhwDO7kO8e6qqVfUeTxWN1
 aE8=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="132290740"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 06:02:25 +0800
IronPort-SDR: MZlEgA5Y4GtXhCYvgdHfngCfD006+qwzyJpXeZ+KKrBn+YQou8obI7wgeZn4EUlJ+j7kiWJeld
 1/u6LrdpyH0UXB1vTO2PmE6cfGuzxbsQvGjFlbC7Gfi/gdIBKZUnTuflOlO18WpO5hz7lQV0W6
 ZXHLITwTsHCML5v2aa3AaLBjRh/barRyrD53gMfwkr9LZO17rdmyMWtnTpSH1lKHxG3rf9iE1x
 0fYA0OWn+tsoV6q3QXuW3V6r7c+GafPGF5rXZB94HvqRk00pLU5n7I0jwj1vs8FMwvy88le+qk
 gK+KC6vZWtx9P5KWwM9rr58p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:54:49 -0800
IronPort-SDR: EVY8lUPNbgljmW6HqEuqUs1GnjnBfBSafUXNYMK1AMj6XuCsBqsRkDnNQI1K0i0CCkdrN7W9V9
 ysHazwBXnlQMwZfgMr8PTvYVU9zP8Xyi9hfVBkXLxN9hZDPt5ln0P5Jv3UJDkg2dU9+tPydUPz
 gVWO1CYmsd52gIsvas27XINqLZ+RvJPkXX6yH30hsTpy6aeRfPlD4Lvlji8UTOFG3GoB+LvUgY
 gKa7m8TeX4ssIDVdSdE9QFEJx3uLqo46bT/S/VbJtIeiqdIaAr62kQniHQwh0ZLSdesWkyhoT4
 Uq4=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2020 14:02:24 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gary Guo <gary@garyguo.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v10 08/12] RISC-V: Export SBI error to linux error mapping function
Date:   Wed, 26 Feb 2020 14:02:09 -0800
Message-Id: <20200226220213.27423-9-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226220213.27423-1-atish.patra@wdc.com>
References: <20200226220213.27423-1-atish.patra@wdc.com>
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
Reviewed-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 arch/riscv/kernel/sbi.c      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 8766f6af9eb8..82ff88f06ddc 100644
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
index 932b23272be5..3a2a5352316b 100644
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

