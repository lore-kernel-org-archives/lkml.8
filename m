Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C59C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061502085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338338;
	bh=8u5vfo0W6dwew4wkxSb7nqRjuWXE9FNdYdLLyBEAE/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Q+zdDVFbUZRaC8JcJlIiDH3GDGbzSrLdU6iwXUOXd8bqmgkb99jkt/HHwtv1DNYA
	 bFTrqtyIr1C12Qj0/c7bseoczBz97RcyGreJY79YqU6pqJBcFPKkQrHjHTHB1HzdED
	 D85nlt8U1b7xTWkMkPX9MMJETrCr/2mxO00XKOm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgBJMi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgBJMhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:12 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B591520661;
        Mon, 10 Feb 2020 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338231;
        bh=8u5vfo0W6dwew4wkxSb7nqRjuWXE9FNdYdLLyBEAE/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jyu1VzRKK3ndX7scbQLs04EUSl/ZSGe/lO2RCTTQZd/YHn25m7JW9zjfF0NeZ43M2
         6bAmkBZ29BemFwVuk2poW1akFBV0KFXX8blCQiNOa37FIhAOd01kYkq4vtAywF748o
         SrIZXlgduh2mL6dV8UFL6u8epyTIehoDUR0InkNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 075/309] powerpc/ptdump: Fix W+X verification
Date:   Mon, 10 Feb 2020 04:30:31 -0800
Message-Id: <20200210122413.072268305@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit d80ae83f1f932ab7af47b54d0d3bef4f4dba489f upstream.

Verification cannot rely on simple bit checking because on some
platforms PAGE_RW is 0, checking that a page is not W means
checking that PAGE_RO is set instead of checking that PAGE_RW
is not set.

Use pte helpers instead of checking bits.

Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/0d894839fdbb19070f0e1e4140363be4f2bb62fc.1578989540.git.christophe.leroy@c-s.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/ptdump/ptdump.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -173,10 +173,12 @@ static void dump_addr(struct pg_state *s
 
 static void note_prot_wx(struct pg_state *st, unsigned long addr)
 {
+	pte_t pte = __pte(st->current_flags);
+
 	if (!IS_ENABLED(CONFIG_PPC_DEBUG_WX) || !st->check_wx)
 		return;
 
-	if (!((st->current_flags & pgprot_val(PAGE_KERNEL_X)) == pgprot_val(PAGE_KERNEL_X)))
+	if (!pte_write(pte) || !pte_exec(pte))
 		return;
 
 	WARN_ONCE(1, "powerpc/mm: Found insecure W+X mapping at address %p/%pS\n",


