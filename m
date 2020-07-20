Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97BCC433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DF022D04
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263125;
	bh=wxgYB4Ga8dIT1hCDuystHs20ZPtwGYzVHZ80NqcdTa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ESurbORoatyA9d1tdIgiVwIJBdpTuw+x5fefg6f9JDzWBHKOJm7mfe2YZlCbh4BBv
	 r3trmcJqwRU5Z/HQjwiP0r3Ou4ib5LknS4L+5ZeNpVhsPQGmxTWTQ7KQJF0Iy3xN0p
	 XAKP4XCLN4lmFn/pFse/N/Swi11Ian/KHzXWAVhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbgGTQio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbgGTPuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:50:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0189D20657;
        Mon, 20 Jul 2020 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260219;
        bh=wxgYB4Ga8dIT1hCDuystHs20ZPtwGYzVHZ80NqcdTa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2RW03OHszT6QVXjSFYQSZZNPZ0dVnsL4ChZFxgWcY94HacsLSm+kbhAYogIAveQVP
         wbSEwLJIJS8gC8T0ierYZm0Pk8WkT7extl459l5Yb4nzCsZ61K+TgMfFp3PGLOV8uj
         LQVcXgcSERXsQ6x7aixQl/JPretyPUzKcIOm8uR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 023/133] m68k: mm: fix node memblock init
Date:   Mon, 20 Jul 2020 17:36:10 +0200
Message-Id: <20200720152804.845314173@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Dureghello <angelo.dureghello@timesys.com>

[ Upstream commit c43e55796dd4d13f4855971a4d7970ce2cd94db4 ]

After pulling 5.7.0 (linux-next merge), mcf5441x mmu boot was
hanging silently.

memblock_add() seems not appropriate, since using MAX_NUMNODES
as node id, while memblock_add_node() sets up memory for node id 0.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/mm/mcfmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index f5453d944ff5e..c5e26222979ad 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -160,7 +160,7 @@ void __init cf_bootmem_alloc(void)
 	m68k_memory[0].addr = _rambase;
 	m68k_memory[0].size = _ramend - _rambase;
 
-	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
+	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
 
 	/* compute total pages in system */
 	num_pages = PFN_DOWN(_ramend - _rambase);
-- 
2.25.1



