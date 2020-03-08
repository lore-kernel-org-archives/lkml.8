Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8892CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9C820828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583661214;
	bh=5bpP4wMCQfaX+IKe4Ot/2AMhW1qZtJCQhDHd5qDbi0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RtuGZXa0UbRRy7S0uFuRogu/fyTP9Loqw8qa/DJRxasWyY8+fG0Gz5viGlWvH75qv
	 uTGbj/74lIS9zqJjdAUVzzMo6k24+X/uI1ly47ieEmguVtXDhpnsSe6kEXOWMpbx8e
	 Za7RlRpSyL8YmmBzlRlmCHLRh6LbUIeb2NRFcbfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCHJxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgCHJxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 05:53:30 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB6B20828;
        Sun,  8 Mar 2020 09:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661210;
        bh=5bpP4wMCQfaX+IKe4Ot/2AMhW1qZtJCQhDHd5qDbi0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZ3cuu0ct5yXdL2CfQe9Xou1gpghhwYdyQxzpU69tPebqcnlA6BwdgX/Q7dopJX6P
         p80MIGbibANWcaQod6FczX+BWexkzJOY8AZN6yaySIsljcvkMF50NuUUaAJmdTpswt
         HvvmBYjYFuOr8dXNrJ8XTUhrpnCKtTXRIn970HJo=
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com,
        greentime.hu@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH V3 04/11] riscv: Add CSR defines related to VECTOR extension
Date:   Sun,  8 Mar 2020 17:49:47 +0800
Message-Id: <20200308094954.13258-5-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Follow the spec to define the regs' bits and regs' number.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/asm/csr.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 435b65532e29..49b93b638680 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -24,6 +24,12 @@
 #define SR_FS_CLEAN	_AC(0x00004000, UL)
 #define SR_FS_DIRTY	_AC(0x00006000, UL)
 
+#define SR_VS           _AC(0x01800000, UL) /* Vector Status */
+#define SR_VS_OFF       _AC(0x00000000, UL)
+#define SR_VS_INITIAL   _AC(0x00800000, UL)
+#define SR_VS_CLEAN     _AC(0x01000000, UL)
+#define SR_VS_DIRTY     _AC(0x01800000, UL)
+
 #define SR_XS		_AC(0x00018000, UL) /* Extension Status */
 #define SR_XS_OFF	_AC(0x00000000, UL)
 #define SR_XS_INITIAL	_AC(0x00008000, UL)
@@ -31,9 +37,9 @@
 #define SR_XS_DIRTY	_AC(0x00018000, UL)
 
 #ifndef CONFIG_64BIT
-#define SR_SD		_AC(0x80000000, UL) /* FS/XS dirty */
+#define SR_SD		_AC(0x80000000, UL) /* FS/VS/XS dirty */
 #else
-#define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
+#define SR_SD		_AC(0x8000000000000000, UL) /* FS/VS/XS dirty */
 #endif
 
 /* SATP flags */
@@ -102,6 +108,13 @@
 #define CSR_MIP			0x344
 #define CSR_MHARTID		0xf14
 
+#define CSR_VSTART		0x8
+#define CSR_VXSAT		0x9
+#define CSR_VXRM		0xa
+#define CSR_VL			0xc20
+#define CSR_VTYPE		0xc21
+#define CSR_VLENB		0xc22
+
 #ifdef CONFIG_RISCV_M_MODE
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
-- 
2.17.0

