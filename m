Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC9EC2D0A9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56898208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892588;
	bh=O8sbMn7Pvn99MTZ61vvAbPtt75NieU4YRkG3Qh3NqLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WsMM86WGYuf1AWSsDCMkdqVCbiDvsgsIgqp1y//wilJCFmQmOj2HjRRA6j9sRmdyZ
	 EVoMH7AIbjH67H+J+7a51Lw4vcIFNuYXKr0EKOKsqR8i8PAqZxsUojQkWRfDcKFBK3
	 SaVuQyt1upYQe4HWsFWdsYSuzRXJlUZwpn9bN7GY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgG0X3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgG0XYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A5920FC3;
        Mon, 27 Jul 2020 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892241;
        bh=O8sbMn7Pvn99MTZ61vvAbPtt75NieU4YRkG3Qh3NqLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADMVAtkyNTFjYb8aufIGF544EHZr0f9MKN4vbzqS5ZzOwVAr66aqW0HbU9zM/Frxo
         cxtAOH5p1pPg/ImotE0GVvAiIYGB5DKSTEVAxfZ3eCZjTbj0ASae4g7MBhxDDf9H4s
         T9JKK4b3q/4EUgLr2LEzBf8l5SL6iSmX2J0OOTVg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincent Chen <vincent.chen@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 11/25] riscv: kasan: use local_tlb_flush_all() to avoid uninitialized __sbi_rfence
Date:   Mon, 27 Jul 2020 19:23:31 -0400
Message-Id: <20200727232345.717432-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232345.717432-1-sashal@kernel.org>
References: <20200727232345.717432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

[ Upstream commit 4cb699d0447be8e0906539f93cbe41e19598ee5a ]

It fails to boot the v5.8-rc4 kernel with CONFIG_KASAN because kasan_init
and kasan_early_init use uninitialized __sbi_rfence as executing the
tlb_flush_all(). Actually, at this moment, only the CPU which is
responsible for the system initialization enables the MMU. Other CPUs are
parking at the .Lsecondary_start. Hence the tlb_flush_all() is able to be
replaced by local_tlb_flush_all() to avoid using uninitialized
__sbi_rfence.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/kasan_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index ec0ca90dd9000..7a580c8ad6034 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -44,7 +44,7 @@ asmlinkage void __init kasan_early_init(void)
 				(__pa(((uintptr_t) kasan_early_shadow_pmd))),
 				__pgprot(_PAGE_TABLE)));
 
-	flush_tlb_all();
+	local_flush_tlb_all();
 }
 
 static void __init populate(void *start, void *end)
@@ -79,7 +79,7 @@ static void __init populate(void *start, void *end)
 			pfn_pgd(PFN_DOWN(__pa(&pmd[offset])),
 				__pgprot(_PAGE_TABLE)));
 
-	flush_tlb_all();
+	local_flush_tlb_all();
 	memset(start, 0, end - start);
 }
 
-- 
2.25.1

