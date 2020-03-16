Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30829C5ACBF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B3A20724
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326179;
	bh=MJ4NnFk1gq0C26Lqhv6kKTg7klRqtEZAytuFlAGKwLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ykQ1dt3L7ABtnqcBvBhXDyN3VmhyXZRc2rykihLEoMvhnlDgtWLvt+j4Tz/QBpboO
	 r0i2cE9NWy42j8UhfG2P4bKffTDi5DtRb4SLw99ur/i7jsRABwsEdgTi9OdVXdPd4P
	 ngEocnHbWVTqmdIBztgbCymb+/SVPiArD+Iut2Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgCPCgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbgCPCfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:35:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5579B20738;
        Mon, 16 Mar 2020 02:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326151;
        bh=MJ4NnFk1gq0C26Lqhv6kKTg7klRqtEZAytuFlAGKwLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUMUCVxjlcY8ddq7HGCuAXjWWDB7QR+9XHEejm2p5JjEK7GvVcHTm+NvpsrZCwbrJ
         EpND66Q9bAzsl8UJ3My3lciyJ95uC0q8kKa2PJ5NMkeOLm/3Y+qkUa9/XwPPeQNKIM
         bNrOtTHEcLN8rrwoOgi7uw8ocmZGMMtHt1bV/Xag=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 2/7] powerpc: Include .BTF section
Date:   Sun, 15 Mar 2020 22:35:42 -0400
Message-Id: <20200316023548.2347-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023548.2347-1-sashal@kernel.org>
References: <20200316023548.2347-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit cb0cc635c7a9fa8a3a0f75d4d896721819c63add ]

Selecting CONFIG_DEBUG_INFO_BTF results in the below warning from ld:
  ld: warning: orphan section `.BTF' from `.btf.vmlinux.bin.o' being placed in section `.BTF'

Include .BTF section in vmlinux explicitly to fix the same.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200220113132.857132-1-naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 876ac9d52afcb..9b1e297be6730 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -255,6 +255,12 @@ SECTIONS
 		*(.branch_lt)
 	}
 
+#ifdef CONFIG_DEBUG_INFO_BTF
+	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {
+		*(.BTF)
+	}
+#endif
+
 	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
 		*(.opd)
 	}
-- 
2.20.1

