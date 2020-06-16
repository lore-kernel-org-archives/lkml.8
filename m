Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012E0207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323476;
	bh=KBOFYH+yltsllB5kxgRuQLTpngYArcwUB4vOgu0wmTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nHCf8CXzn2jce5cIR5nhtAE8DkOL3sAZzCjSZ2MxT/pWj0ec3/itGs0AqVhpOAkY/
	 vcWMTkpmy+Q+VXl9IIIj7Kv69RrcxVdLeRk2jtmue1W/1WmOZxNgIY52+nEIUue0WU
	 t6xicaHDUNP0PPzpjbWbj6v4wEdYByN5M4oxjNm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgFPPtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732509AbgFPPt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:49:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B93320776;
        Tue, 16 Jun 2020 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322568;
        bh=KBOFYH+yltsllB5kxgRuQLTpngYArcwUB4vOgu0wmTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDcWO1vCmG8UIy7XlfzS3FXlzBiI08u9OOaFEqP7RgwDvZ2tBPD6IQNs9HIfr/pu0
         dyAWP67egWiJ6hTBgOEo28nkJXn+yaUs7jb0wUQVjof93rTiD2tOWEfNp9VQJM+HW0
         eoRW7yrV3walhZESc8kN+fnx/zm/MnpSYXBmNUuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 019/161] csky: Fixup abiv2 syscall_trace break a4 & a5
Date:   Tue, 16 Jun 2020 17:33:29 +0200
Message-Id: <20200616153107.324638939@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit e0bbb53843b5fdfe464b099217e3b9d97e8a75d7 ]

Current implementation could destory a4 & a5 when strace, so we need to get them
from pt_regs by SAVE_ALL.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/abiv2/inc/abi/entry.h | 2 ++
 arch/csky/kernel/entry.S        | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 9023828ede97..ac8f65a3e75a 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -13,6 +13,8 @@
 #define LSAVE_A1	28
 #define LSAVE_A2	32
 #define LSAVE_A3	36
+#define LSAVE_A4	40
+#define LSAVE_A5	44
 
 #define KSPTOUSP
 #define USPTOKSP
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 9718388448a4..ff908d28f0a0 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -170,8 +170,10 @@ csky_syscall_trace:
 	ldw	a3, (sp, LSAVE_A3)
 #if defined(__CSKYABIV2__)
 	subi	sp, 8
-	stw	r5, (sp, 0x4)
-	stw	r4, (sp, 0x0)
+	ldw	r9, (sp, LSAVE_A4)
+	stw	r9, (sp, 0x0)
+	ldw	r9, (sp, LSAVE_A5)
+	stw	r9, (sp, 0x4)
 #else
 	ldw	r6, (sp, LSAVE_A4)
 	ldw	r7, (sp, LSAVE_A5)
-- 
2.25.1



