Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC8C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE7D206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AcgJaiUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgCRBMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:12:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45915 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgCRBMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584493922; x=1616029922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q6YXb32CE2pLZ0eeb2hmqPLZGTgurXN/jf3Ug28bkCs=;
  b=AcgJaiUV6vuVyPbt8ZI5SgQpsfKwdviyG1zzLRFOL1hDWif8122WgAqZ
   nYdfgx+B+kRAqdV+cTuu/cxxttQZEuxUiRz8InUg1jdCixdgnzB1RCxHZ
   /gXuI5o7VqyuMi06CjePf/h+ujDO5HPdiqfWEwa4WOK8roq+Z+xhcUY0X
   sIvBICuZiyObS/p95LK5HCReTFgCKZ9gn90elfcqiOjVn1TWXUgFiqq71
   MZGM7NZtZMRXSEdMsqbQ4VWMM8atL7u7rfkU2coXLzIJZ32ECQILMU95q
   UMX0DwD3km7664GWrERpfoZE2y2XwuRblfJ0o6XmYkUaXIlokGwtV7oLw
   w==;
IronPort-SDR: wFAatpMdvODMX1zChRWDVqs1d6+G2Ln4rtYk0tB6v8E5pMz27D+j40BTyg+M/NSk8EHc7ohxEc
 m54E60NKpdCUXjCq0lwAq8LuVyF4q4KLZsDf4CCgf8oyp/lAU4AHRuCwBCKS05iCZOkj964OMu
 Pk5/STvO2Dqh2yueqlMrW0PrRFDx1PiX420B8wSkCTHw84NEnMdCarsiIEuaBPWOlVScdM1jMt
 mLzNWIIxqkrNUySss2pdfxp78AYJVQtEfj/Wi4RjpaV+xpb4zt5WNGL5eNKehvp7D1psEC+Yiw
 468=
X-IronPort-AV: E=Sophos;i="5.70,565,1574092800"; 
   d="scan'208";a="133241527"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2020 09:12:00 +0800
IronPort-SDR: 8UqBuFfMUmCt5AC2V/D6yxTpIms+4dU+F5vHDKVvaZzr4m33T3SUUl4Ut6K5wtq8Oel6TYDwrC
 g0h7fqVG2mDfGB4IBvwncL0LngwFYfcvEzcWdlWVvykFkSpkoFn0cjOsjkJnj9y8y0Gjnt8o9H
 NpMgzyn/Prnb5x33EBw9CJueHl0FoJths+skGSxUEnD00FFobSIp66lNMAaH0R2X2oJxY/dV/2
 iz5hPoLmaTfHsw3n33bU68kI2c69rMkvgE7UjsVdIrY4qfKLO+zRRfi8kFdwgxdKeNBf6qUVCO
 6sNxIFXnap7juzKoUk6f4Umj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 18:03:50 -0700
IronPort-SDR: yoRFOeeKE7eFVW9hxvf+GM8dj/MQId38frm7Hi/bC+DlqYxWz845Bj4zByRLPCtR0deYwX+zCZ
 xpn/OLtNxv0ZrjMZxN2EzHJXz0AFTqabAiTbXMlOv9lW2GCTNJ6xI7CK6GucFWSI+Aa/SUODu1
 /KoQ0X+1HNDsoFaflyquRjRSZB8Qwg6B9fXIVve3keYb5M1VSBzNkqvo4WP5pxL1CwmuZm95lY
 wZhgB4lb1yoDNKBvO7/can5netrk7DCcJUZa8XlK4az1Yc4uaOvt4t0KklCypquNW8B1ixtX6Y
 JZw=
WDCIronportException: Internal
Received: from mccorma-lt.ad.shared (HELO yoda.hgst.com) ([10.86.54.125])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Mar 2020 18:12:00 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v11 08/11] RISC-V: Export SBI error to linux error mapping function
Date:   Tue, 17 Mar 2020 18:11:41 -0700
Message-Id: <20200318011144.91532-9-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318011144.91532-1-atish.patra@wdc.com>
References: <20200318011144.91532-1-atish.patra@wdc.com>
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
 arch/riscv/include/asm/sbi.h | 2 ++
 arch/riscv/kernel/sbi.c      | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 29ce2c494386..2bbfd6bada93 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -130,6 +130,8 @@ static inline unsigned long sbi_minor_version(void)
 {
 	return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
 }
+
+int sbi_err_map_linux_errno(int err);
 #else /* CONFIG_RISCV_SBI */
 /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
 void sbi_set_timer(uint64_t stime_value);
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1cc0052e1b63..7c24da59bccf 100644
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
2.25.1

