Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBA5C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CD320738
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RYSw8BuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCRBME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:12:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45921 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgCRBMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584493922; x=1616029922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xCh5EcWg1UbmYSHwnD5yeHwu/JGfSdyf7cc5m5mfEz8=;
  b=RYSw8BuW5hJcsWkUqN7xE5GzGGaCjWJISBsl7nmq4Z9wnMUPt6kaEv6x
   YWbg20fdwYVEnLv3eqm+ULolFRGjOAFNJK0x9l2C6nAGp+YYBM4cxYIaJ
   nJHnoWSSjkktb6E7NbkyIYI8pTTtC8XyhZB8R29f6Ax36ir7gjoDreZC5
   vVkb6h72dFVO4QfBuXCihE28HQYc4jk2BctMOFfC8GwX4Ve3OuP+QOj1b
   jtlbm1VTddc5NXJEu2KQKEMhm7oyQyUiCaZvO2IpcMN6nRWUtAPfCeF3L
   j6icy+rQctrmtFcED5JDwujwvfvAV+LoUXNWa/2Qy74dAfdUxlsD/uSeY
   w==;
IronPort-SDR: Bvij74n3rU/bIfZvglQ6etfzYsvvUizLvwkfcutKE4xaqY73SScYoY2MKh/Y1B2CENZoxxQvO1
 aT/TbJ3f6W76wH5ZCumwo0p3IVKnpb3NfYbqjiw9DMe1ANmdOK+b+5w0Sox13a0iJunKz5Ubg5
 tncHISNH+MDWv1IJ7j51pelxG/7hyJDymt1R5TRDoUCjhBqv8FVkzJ8ZY+YijwjKjO9BB5KnAb
 bKJ/asN40+rRTwSROY3cmjJpRIfOborYhvpU+cFgpPDzd4jE59EgUDz4VBm0OSOop3noDgB0bE
 i2c=
X-IronPort-AV: E=Sophos;i="5.70,565,1574092800"; 
   d="scan'208";a="133241529"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2020 09:12:01 +0800
IronPort-SDR: gdvrnAB+sutWunDoQdVQeSgI7cszhmIlVGXazyzAKNvla813GEMQkgsqtk5/OOQLrDIj5mXrTd
 2cUScCjuK0n+XFkjRRYgSyzPrmLqvwTTichk9xCDHtOp+G5etVhZ3LXYH/Azyrq+0CgE6pvUni
 qYD2UUzNGEV8kBpgbQlfMEpEG99ln+FMu/MD5h+/FdzqWqvI5KL20neELyARjtkDhap6yXp2Ow
 ERAHcXD188DYQYjIe74yT9Ciu0+AdWyAXOzuTN+WxWsoIEklm9ecM4U81RL9bVC7BWz97cBdJc
 rcWMl9cgetXn8dE/tqKqiLRI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 18:03:51 -0700
IronPort-SDR: Blpugzal/wrvgi3r2PFIdN+O3rEneO0z/piL/obUU5vOcv3MCa2nqoK8BeTUBsKnIJdnx06p0i
 NKBSn2CG5jeAA6dz6O46XONecDtT2Nk87WszCmFmEHuQpp7P1ECYgBY0iM39qA05Mh+7ojsh8f
 oiFm/z4laBd9QlhOv3H+jp0IuOte3NpfnzcTj99xfI0BBMzL2GZDkuJ9STHsfXfn64A3XcVYLe
 FZWhkLWDOHikhlJ6n8rebHKdKT2+nwP8tUSmwecRgVMwdIM+lo6mmEc7B53w8+his0aJGFpmpQ
 1+o=
WDCIronportException: Internal
Received: from mccorma-lt.ad.shared (HELO yoda.hgst.com) ([10.86.54.125])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Mar 2020 18:12:01 -0700
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
Subject: [PATCH v11 09/11] RISC-V: Add SBI HSM extension definitions
Date:   Tue, 17 Mar 2020 18:11:42 -0700
Message-Id: <20200318011144.91532-10-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318011144.91532-1-atish.patra@wdc.com>
References: <20200318011144.91532-1-atish.patra@wdc.com>
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
index 2bbfd6bada93..653edb25d495 100644
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
2.25.1

