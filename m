Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E36C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4E220663
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864435;
	bh=KTP3KPkmh3b47+y7caXigZqoUifvCyiuK6/vP1+T3eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DM4bsOVxlsPgZwL3xZ/HxzygQHn9CfW+1LTkqJQfRhtRLV5sCsq7YzySywwc6pL0j
	 0ZU7MqHgXBAPETFx8MgMFx590JoYtDfx3sLdfeXpHmWoCGiaSK3sp/zl62wXYxAgbW
	 hEH0uV+q5OV3wsSm63+Y193Prv3V34dPN34+dU14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbgAXLNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:13:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732571AbgAXLNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:13:48 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA3F20663;
        Fri, 24 Jan 2020 11:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864427;
        bh=KTP3KPkmh3b47+y7caXigZqoUifvCyiuK6/vP1+T3eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MELZH6hJTxyaFvOfAFtHwlxqm//svHzYbd6j4R2TCnE/3mKYb8uy0TVdzEVwB66f7
         cxsgbnFsTEII/1Ok9Gmeq1fDdZyqk05wt0k0fk7/lLgMYuEtStIB0LFrOvnTRSkg9a
         fjk2MsG/A15kXmxiUQg3Jlgffz/ZI7PigBu/aPjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 249/639] powerpc/mm: Check secondary hash page table
Date:   Fri, 24 Jan 2020 10:26:59 +0100
Message-Id: <20200124093117.943700335@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
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
index 8692946950485..b430e4e08af69 100644
--- a/arch/powerpc/mm/dump_hashpagetable.c
+++ b/arch/powerpc/mm/dump_hashpagetable.c
@@ -342,7 +342,7 @@ static unsigned long hpte_find(struct pg_state *st, unsigned long ea, int psize)
 
 	/* Look in secondary table */
 	if (slot == -1)
-		slot = base_hpte_find(ea, psize, true, &v, &r);
+		slot = base_hpte_find(ea, psize, false, &v, &r);
 
 	/* No entry found */
 	if (slot == -1)
-- 
2.20.1



