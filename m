Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0203DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46DA20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859627;
	bh=R9KdXV7L1b3TSiiLfRys04FVfI9mVRkjd1uT/dLhNqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r2RPGny+z8cwL0ZAqWgMGDQ6zm/kavElO2agfAu8GjOUfpAjNf3O9sLP8ZmO+0Ftf
	 dCf+/yO17V1vxZRCgNnto25oQUNfhQHJnB9/6xgSeohOoyJ42zQPiKVV7UyKXv43Na
	 HW2TY8ZN8xcJwMxK6MnewecYJrZmWH0/4+9fYkVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbgAXJxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgAXJxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:53:45 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B00820709;
        Fri, 24 Jan 2020 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859624;
        bh=R9KdXV7L1b3TSiiLfRys04FVfI9mVRkjd1uT/dLhNqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2k0gaAm6vu2KPRRyxFg1E3xEOVdDP3kNOHgL9uW5wdq9mx7Mo0iCd6Pxd5Qrqj10
         Tzs9TVSytX2zqEfG51iKXIUJaqnOFS2pR8C0qcunzwN6KV56ubyMeYL6AGcxJQ6ms1
         Sw9KK4kUu5pEaHcCM6ucZCzDNYsGUacEWw3yf/Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 136/343] powerpc/mm: Check secondary hash page table
Date:   Fri, 24 Jan 2020 10:29:14 +0100
Message-Id: <20200124092937.855687291@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rashmica Gupta <rashmica.g@gmail.com>

[ Upstream commit 790845e2f12709d273d08ea7a2af7c2593689519 ]

We were always calling base_hpte_find() with primary = true,
even when we wanted to check the secondary table.

mpe: I broke this when refactoring Rashmica's original patch.

Fixes: 1515ab932156 ("powerpc/mm: Dump hash table")
Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/dump_hashpagetable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/dump_hashpagetable.c
index 5c4c93dcff190..f666d74f05f51 100644
--- a/arch/powerpc/mm/dump_hashpagetable.c
+++ b/arch/powerpc/mm/dump_hashpagetable.c
@@ -343,7 +343,7 @@ static unsigned long hpte_find(struct pg_state *st, unsigned long ea, int psize)
 
 	/* Look in secondary table */
 	if (slot == -1)
-		slot = base_hpte_find(ea, psize, true, &v, &r);
+		slot = base_hpte_find(ea, psize, false, &v, &r);
 
 	/* No entry found */
 	if (slot == -1)
-- 
2.20.1



