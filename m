Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C7DC11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85FE24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ac3Gh8O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgBUApN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:45:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5901 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbgBUApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582245904; x=1613781904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=37uvvoOiKvDtqugsaFLZ7LIIksjflF/Df/E9QV5jylU=;
  b=Ac3Gh8O3jBqzxRktwFO2lp7qzIRkk5v09X07IzgwF6ukGD+CIbY7JWOL
   fKoW5bTjNqkV0xqeoDMoLZvN+/A77X8SsCGF1Rc6u/cEQP3tJgWO0jIhm
   C20pcYq7VroAH+d+erz3Sg0h7veDKNZX2PSFWfhQAH3ZI4wURBF+dhLec
   tWRwTYToZuip81yIme2FwHHWMsbxHxDcav7Mz2m8lqDodLMOhSErCqVLq
   1eNqaX2yvEM6iMFGXBL7QT9AnrezgTvZ8Mt/bAhIClqShLB1co74fmgQS
   TO7ZzHPu0BoXtdcwaYHdi5B5R0c19WN2CQiPFDLXNcEDvB7enwT9RyTkC
   g==;
IronPort-SDR: jGOhXvproomBQ71okRbBAqDkysvNA+CFAhLDNDXVOhYY6Zet3nUXqOCdnHicLM0bu+kLmDTTJM
 rZTW2jeF6zR5+HUPRAJHOBTgFINpQ9WxNcxb8R3clmlVaodPM3W6DxezmEIxIp0RMfB6UHnMYD
 gZUMsQlVdVCxruZqtdYQF8ib7mhbhvuxPp0P/Z7cOjrUXZ3g98rKClIj9v9nkpGbjGKq6TjGxK
 rhsDov7UB0OkrtGpswi76Mk30zR5lTQrs8m8XeKiZSK78Jk7NsEth0vPuHRaChBELQbhaYB1is
 lKo=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="130852804"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 08:44:50 +0800
IronPort-SDR: NEiPOYofCCVEHI4Z/eu4XoaV++iZExlmdeV5uh4KYJq7KKPqfjVQ2nH+UuqyZRuDfpUPFZIKGh
 ndj8yzqXDSj+K4143TmnIjKDhRHbX27WfR0j1FHnYvoG+T4ob+42XNbQQNCVPj/i+VN7bXFc3o
 85ug5w4mPXjXQPMBAo580gLTvb2UuaSB6qi0dw7W/FAsSk0Y/tm1xMoY+aa54pxVcUNyXEky7M
 aum71H61JXPNeWaHotR5ZoRdqh46Zm4+RMrfEuvneYlyrEpCybdUrN2qp9EKcwplf0njJ4oSU4
 pthk2iCkUGEt83cj79Y9FgQ9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:37:24 -0800
IronPort-SDR: cv3KQs6GxuvQneycJ3ZkjFHK11NakiFw9nfmzS6wDQDhSZDIe3W3g0X12a8FoXYvvENIKo+riC
 UAibA676YcT6Q/0eKCGSqO+6Q1p9c2dT4zUiePdDEcegmiEOcLylyQBlSkrvjKUZOoNeVvFnWo
 Hx6gmDQHn2cf/LGO4IME1AKQUlhm2BItiADXiTFQbvEShOp++lHtfG/Ox6HuNrps/l6QvdKnxH
 K9ZPhRkvfSLyqLxvZYdY/uNMtx+cFoTOYXdTy1WZ4nspNT33yoXxHW34mgn8D/HlbpnduNrsrH
 +U0=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 16:44:49 -0800
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
Subject: [PATCH v9 09/12] RISC-V: Add SBI HSM extension definitions
Date:   Thu, 20 Feb 2020 16:44:10 -0800
Message-Id: <20200221004413.12869-10-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221004413.12869-1-atish.patra@wdc.com>
References: <20200221004413.12869-1-atish.patra@wdc.com>
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
---
 arch/riscv/include/asm/sbi.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index abbf0a7d3b6e..0981a0c97eda 100644
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
+	SBI_HSM_HART_STATUS_AVAILABLE = 0,
+	SBI_HSM_HART_STATUS_NOT_AVAILABLE,
+	SBI_HSM_HART_STATUS_START_PENDING,
+	SBI_HSM_HART_STATUS_STOP_PENDING,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.25.0

