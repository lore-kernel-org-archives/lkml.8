Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D0C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7FD2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RvO9Ri2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBZWCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:02:30 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45045 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgBZWC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582754546; x=1614290546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Ui27SSBnDNLiTnFJyNqyp0+HmPzoBOlVS3ULCIEs7E=;
  b=RvO9Ri2utTVq8PpCmVOBXAlZt5MbYhq2O+e1JEM89qSmn+8j3jRPILmW
   YGPvJ5FNGFv+Di7XJSw/4L4Z0nHE7XD6rbPpyICkO2GHunOd8UpljSQi2
   Rly7iH7Md+fpsolId9AUlVy9RHGAo1QSnfb88KFkR47V+yFfoIQsAaETB
   pEYN152oFu3D64uhxTgXmzKkdRNvygPdWl3gxtvfaeLAZCZdrzMg91LGc
   OHKJItm2pI+rx8CZTSklKNm7+Lb0B4qEQoDYM6RqXmhRxbykdcqmUMO4Y
   BX6LaDSEOGqDmMQq2f0iF4zH+DFQRD2E+/7oL93t4q2SSYatLfL8K9PiF
   Q==;
IronPort-SDR: 5eBR5xkwsC0EtmjkWAD3G9vS7f6usCdejWoFyiFeKacD193X83IsuDRSn14I8c/ujLybeGjFlz
 4+i6Ia/k/xXYNPwmZd7dk0T+WwW/T4p2I0mdcUdh+ZML28pMPf64Hr0mF2hAYO6bkCvyVLF0ZL
 S0ShLcYoB3K+Sy3uJNeHbfSBTfFY+uCzbPzSgaCjsF325Wb5OfmUGW7IQPQm4o8jKDuy302K0w
 P44YoOWfRQ6JrzT+tF7u9Sdjk6E5vB/1j+DdvsePvkzsIv5OWKx9f9WrFTtkQewr5wFrO0kjMW
 lz4=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="132290747"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 06:02:25 +0800
IronPort-SDR: L0aGCYIID6gmswWTl0klVUD4jzbPEUjjwdBNt+1nFg2UWsJkZqS9edWj0e4rFWC0pqp426kU8d
 cpUPasrx5DMAJuebe9oAhzJCMovAOy4HidxrnzO9J/I7sWQ9gsJoNPE6jm2R01fuyqypEzfqZf
 VoYQwCtmGWzvK+S56G0LpRr8URTCpKu/nctKXEz32pyGg0ghVxdB362U1SmPHVWV/pTQaC5xhx
 2Whs7rsH3/OCZjqsKoqgUNrZy2pPHhoHcEQDMSC4V00uIstI7qvr4fgxO6FCdgbLzTy/HEMyIK
 +WUv3LL4iMNYCdRrhSIfkDP2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:54:50 -0800
IronPort-SDR: cwWbOHXlgS187vh61TxRjM6guQ7ekDTpm98OcXyDB2OGhAdfCG+xrfniT9NPggwCnklbxc0dB+
 +exZW2EhASXPMZntYxbsWCex681LyalY5ySfsrJfMH8QKGwx8ZKJjPCsJNzeC4GEuM3PCwqtGR
 3lvXucSrKbzrSKMUsoSNOOVGt1tH0ohUKoTuSp56n5+fS77Zy6NEg2dlcNEdjBTYXJIuX0x/NN
 PAfilQhS/RXAuTURdERtFBjcHBPsZnc15GBqImlUTZ5K1hupUAB6RwniAwb3PI1p/XokGe03el
 ou8=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2020 14:02:25 -0800
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
Subject: [PATCH v10 09/12] RISC-V: Add SBI HSM extension definitions
Date:   Wed, 26 Feb 2020 14:02:10 -0800
Message-Id: <20200226220213.27423-10-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226220213.27423-1-atish.patra@wdc.com>
References: <20200226220213.27423-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI specification defines HSM extension that allows to start/stop a hart
by a supervisor anytime. The specification is available at

https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc

Add those definitions here.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 82ff88f06ddc..450430c15879 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -26,6 +26,7 @@ enum sbi_ext_id {
 	SBI_EXT_TIME = 0x54494D45,
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
+	SBI_EXT_HSM = 0x48534D,
 };
 
 enum sbi_ext_base_fid {
@@ -56,6 +57,19 @@ enum sbi_ext_rfence_fid {
 	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
 };
 
+enum sbi_ext_hsm_fid {
+	SBI_EXT_HSM_HART_START = 0,
+	SBI_EXT_HSM_HART_STOP,
+	SBI_EXT_HSM_HART_STATUS,
+};
+
+enum sbi_hsm_hart_status {
+	SBI_HSM_HART_STATUS_STARTED = 0,
+	SBI_HSM_HART_STATUS_STOPPED,
+	SBI_HSM_HART_STATUS_START_PENDING,
+	SBI_HSM_HART_STATUS_STOP_PENDING,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.25.0

