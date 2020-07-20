Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C9AC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F5206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262628;
	bh=XTUF+o5CIluzJxCVc/liIpiAQyJPlLkC0DzwQTYaWYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQt8nJUbHPViGjYHIqD5UIsTXj/NyNEufH9FyUl995ZqPNdGESy+W+IPp2QX2A4gs
	 a23nsK6NZhKuNposOB0c3s9/RAYLvqobMlPFuEfLpXg/L8p7j1mbXCL8POWtgePgdq
	 TVp+VLBMCdb6kkiu0kBWKwaJjcRIopW239nHgmLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbgGTP6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732047AbgGTP6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:58:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8139920734;
        Mon, 20 Jul 2020 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260711;
        bh=XTUF+o5CIluzJxCVc/liIpiAQyJPlLkC0DzwQTYaWYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBc5o9365dXMvoQzbllGedCQcJjzFEtyCje2nXbp3QNtHpdLLrJFksRvcxNy1HCMy
         p64+5cLDOxYwY9wEa7yb0ierRi/vU5JRSE6vmrc5mdTOfNmy2iJsgGkcZRdTRVBOzi
         ggolMenSs3tga98gxNs1UkH1miC9FpDrmz1EE8DY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 038/215] m68k: mm: fix node memblock init
Date:   Mon, 20 Jul 2020 17:35:20 +0200
Message-Id: <20200720152821.994807772@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
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
index 6cb1e41d58d00..70a5f55ea6647 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -164,7 +164,7 @@ void __init cf_bootmem_alloc(void)
 	m68k_memory[0].addr = _rambase;
 	m68k_memory[0].size = _ramend - _rambase;
 
-	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
+	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
 
 	/* compute total pages in system */
 	num_pages = PFN_DOWN(_ramend - _rambase);
-- 
2.25.1



