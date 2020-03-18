Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2982C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6E820738
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D2xaVcg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCRBM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:12:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45909 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgCRBL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584493918; x=1616029918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QU8dgk7FQFxwuuDhi+CdDNB5+5QgGdGE1URwf78ixZQ=;
  b=D2xaVcg3ywbyazrl5XBOeAXXlCnENd0tq0CReX5b/yeNMVodd8DFnV7D
   Rs1zUrOIg8S6+94906MDV3HfJkUr8d26S6bDtvicDj02f2SxwnO1hOF8n
   MgM/KZQOqTNcxkowI8sgeWokPHfq9piD1Pc9ntEc3KroihDdPG9N4D3dm
   HzicYNciUXxAjI2vjcEuQMOtZxZwOk5wcWS0wgO4gKTeAmzuppHkLOCsk
   JxeWoIPYsbD1KZ9Y44YRjNr+tNu+KaKVn0JHWEiG43km5lg0iqgsZJULv
   zSLSMxa58sHGKUw/RiXdSSY4Z5HNg7sl9g9WLDTjoCv7IGx1mzzQKF8A6
   w==;
IronPort-SDR: rlMiMm9Jp72AM3uXIKEBY9LaRLULr9YBKz+q53VBraKszocanAe5S7qiqxodwZ/VOOy1QV8W5g
 00FSa7RMLHATijkBiABXDYu8Tydy53lU4NYKPC6WeTNjecsJNigd+HykVU9jDX48k6NzqqFtkP
 sWFietGQUNQASih7/zTfE+VCoq7j44DKbvXmoCdQXMJF/6OwFrZOkTzv+RYFNVwJKuA6+t34xD
 L8RvKm1WJ+coIxuq02TWFBsKdsgIpAFTRPcgqOPKQWJdMPnX2Ff3eAZzs52iHLofgz3sAqj6kB
 V3I=
X-IronPort-AV: E=Sophos;i="5.70,565,1574092800"; 
   d="scan'208";a="133241503"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2020 09:11:57 +0800
IronPort-SDR: lRqqIsZHxl005Dv+9Mwx64vUPfzGgqjPB3eexW5kc5/Se14eT+tMR5P4q92g7V12T5qYdeStTb
 oxidegeHsEGKcXWUExUlfI0/H2TVT8846KrvQ4pwnRT6pJjBQNrLFOOSzlZIluHFTTLcZjIveR
 /jyObDGlFatk7X7r4lzvjXwwyt7UAgG8Yy0S237DUK7PRC9xckoClcC6FzRrQnmrT+mk5FOE4s
 sUK2Lvln2xXyvxMuC1cA/Gz6rYMgbV0vQdmyIjHiHlfECDy/JZWpijRnBkPdt4vd/5uw9F4MKU
 oLaC1JJdDTgE48nAzB1LuKIs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 18:03:47 -0700
IronPort-SDR: cuY/ry3ZuBkV3sjJ89oVwf/QWhrmmpijLnAlXPU9Jgp98LWZ9bcP0g5O20q7/TugE+z1fJIQgD
 IclQYPBjFh019YrG6IysfFGULrPiwn9GjNhaCG9mGoigbzB8imXg5IfYquusz0jNUWu7Lx7Tqi
 gqmEHjYmRy5AN5b1q2bHfiWHwbu9RbY4KeaXjqXxdOAeB8i0/hSLWd6aH+Xfu7E3ncl4Q7RtsH
 mSfBLk/qu/61Ws+sK3WtlV7HH2Q/yU4akLth2FKMsqosy4oMruBSmZQRP+88ixbSijSPUfBKE2
 KzI=
WDCIronportException: Internal
Received: from mccorma-lt.ad.shared (HELO yoda.hgst.com) ([10.86.54.125])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Mar 2020 18:11:57 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v11 03/11] RISC-V: Add SBI v0.2 extension definitions
Date:   Tue, 17 Mar 2020 18:11:36 -0700
Message-Id: <20200318011144.91532-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318011144.91532-1-atish.patra@wdc.com>
References: <20200318011144.91532-1-atish.patra@wdc.com>
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
index 5b7b91c7e7e6..f68b6ed10a18 100644
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
2.25.1

