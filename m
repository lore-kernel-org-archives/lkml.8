Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F59C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BF124688
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="av3G+Coy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBZWCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:02:23 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45025 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgBZWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582754542; x=1614290542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9eRvqOxk9f0pqXk8BY9vVdeKP4ddTz7Ig8LSU/Egkzk=;
  b=av3G+CoyZE0r/Q3C2zarG5ogSVHHjiU7oJ3TD3r/1VWZWHAhLqFx0f7P
   RhOPevMr2xqn1MRnacqz1/HRnQkbfJ4/UhplnUVYare6xx5q+rNR5Gd+7
   qlEXe2feiMF5kMZN5m2V8tBM6kmOwhFa0DlkzsiMW7XS2J/uDGstxJf76
   1wnhLqURXLYihECcdEwxdEfB6nGHNIrsfU+AyLMdgm4HiMUE436Kob0TK
   fxn/tt/IxbMh/AROz+w39JinbkeNtk7ZY/eft4TN125LHWg8x9oXsQ7vd
   j048fUyPVSQhbtxwv1cYPWZ+57uRyPBJZ3KsUKEkqHmwD7zyMpSORb+cs
   A==;
IronPort-SDR: 6xmHzpQcMqYCtM+wPcGFw0J6sx2aGwC1I3kR6dve4goCR4U8QhGufmCOPxXQ/CXPCgdgb/0igY
 ZzIHLnIqal+V0D1RVxzeZToyjlgCay5aQ9yFrBOw8i/YLzztSJXh2zx2j1o0Xh/NbiiCzRTwGW
 36U7EI2A7Wr5SPQqVkg7RCfSgKOVHyVmRi5KAKunN+g8lRsoPHXnHgh/jOVHToBIX9VBOCw01+
 w6MlJvrVXKOU0rPGYxBgkVZff7mdjzgO9heAayU/2LkyjZxkDZVZNBTMI4naDt6pv+DTXpykI1
 s+o=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="132290717"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 06:02:22 +0800
IronPort-SDR: 2Ep4OTrXCJjyfSeUBRz+fg5VMF/JC5ImKc881u5aeg7UmNcs6ekfoO5jba4VFa3MX2MVoAK1+A
 qxs/BsgNeMhoIkbDyXfApmklIR0XXMq1D3dEYCoo6gYxi+odJgom2AsTcNUNOXTSRFVTt+pqr/
 jQ8YuLPsKIKAzs2NIYKS3D6aEg6/hr84uTouaR9zQvriERwRg1s0DmSJVigLK3BfGtiXzLVSbk
 On3iChxW82+cMrjKIz+iHBm3CWyWvjVqWHWczKw9bemU6bsO0QviAg3SBfGhLglSDHAFXo6b4e
 U3BcvYjXkJ+rcEc2un0uln56
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:54:46 -0800
IronPort-SDR: /01U1CpZGHnPJNwKNAUQk+Nj+9tnPO3Pc6OSUUQDLvreFfFJl3B8IPu8qctw5jXjM8m+BeFNmB
 mVz0CeD9WNJd12ZxigcdrSl/aBzmCePO10lDB660BYAm866o2xLMUhYmutXscs+Cq3pD/Z/s/x
 astm/m4gELs3MZrSCWt8dalBjh3AimiZOJjobq1qLof3uFk2IGJ1csqQzRaaXBPeOjAagjBlpk
 Nj28nIE2wT8woCGhpiGsQv+rzPjAbJgY0tBvK2XDBkCy7wWyZxjarooMyxJvslILjNtvxAOLPd
 gi4=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2020 14:02:21 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Borislav Petkov <bp@suse.de>,
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
Subject: [PATCH v10 03/12] RISC-V: Add SBI v0.2 extension definitions
Date:   Wed, 26 Feb 2020 14:02:04 -0800
Message-Id: <20200226220213.27423-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226220213.27423-1-atish.patra@wdc.com>
References: <20200226220213.27423-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few v0.1 SBI calls are being replaced by new SBI calls that follows
v0.2 calling convention.

This patch just defines these new extensions.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/sbi.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5a3937792b8f..1c4bdcc3b817 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -21,6 +21,9 @@ enum sbi_ext_id {
 	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
 	SBI_EXT_0_1_SHUTDOWN = 0x8,
 	SBI_EXT_BASE = 0x10,
+	SBI_EXT_TIME = 0x54494D45,
+	SBI_EXT_IPI = 0x735049,
+	SBI_EXT_RFENCE = 0x52464E43,
 };
 
 enum sbi_ext_base_fid {
@@ -33,6 +36,24 @@ enum sbi_ext_base_fid {
 	SBI_EXT_BASE_GET_MIMPID,
 };
 
+enum sbi_ext_time_fid {
+	SBI_EXT_TIME_SET_TIMER = 0,
+};
+
+enum sbi_ext_ipi_fid {
+	SBI_EXT_IPI_SEND_IPI = 0,
+};
+
+enum sbi_ext_rfence_fid {
+	SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
+	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
+	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.25.0

