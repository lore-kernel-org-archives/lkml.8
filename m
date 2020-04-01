Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BF3C2BA17
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B35320658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758914;
	bh=mSvL+Ku0/hfoZ6yGDCwrJ/EfR1GzJJRFMJ8SJ4QiRoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S+6n7kgrw+YBiqUsjPwuEc/M0Jo4slM2S4pSbwUEdqupq+R90n4+IxKh/BEsZ88Qc
	 U2MCmlzzTPo4CxXkm7H1dTwtxnKRPXZym9ubeaw7YoYtx1lWEtFeVEWiz/lc6EoQ6r
	 cX3P1gOTzKFQp4QwD7gwAl1taWx+TnZOEredkXPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbgDAQfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387563AbgDAQfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:35:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E036B2063A;
        Wed,  1 Apr 2020 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758910;
        bh=mSvL+Ku0/hfoZ6yGDCwrJ/EfR1GzJJRFMJ8SJ4QiRoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGBV2cA9CiGy0VIKRXxJU1SSZqkIRg9xlDcDUmPHoHxniFGQEgog2O0XdizUTzpOQ
         qA9wIjkdUKKBndUcKyRGo595i5syWaUonWQ1tZmAMYzTrMYWYxGck19B/nWNdWtdaG
         r3Adl1Z9VcHnU77DzcL4XGasAyHAIqQRztYBhqOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 002/102] powerpc: Include .BTF section
Date:   Wed,  1 Apr 2020 18:17:05 +0200
Message-Id: <20200401161531.429011705@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

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
index 50d3650608558..c20510497c49d 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -315,6 +315,12 @@ SECTIONS
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



