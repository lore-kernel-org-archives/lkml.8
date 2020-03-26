Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6478EC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E9D206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ZstCYDJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgCZN6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:58:48 -0400
Received: from mout01.posteo.de ([185.67.36.65]:60713 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZN6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:58:47 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2DB3B160066
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:58:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1585231126; bh=XyEa0WG0QHRf+iVZSq+e8NoSnQfqAo4Q8SUDQl1ZTRg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZstCYDJ3+WokglLD2lK42lskQdZUKZjGChX9klhY/WFG5uEDRwHOt+gSc1qTrrgtR
         F7pTV5nn+/UHUK2PvKkLppOuR9IXU+5UnBCm+e+pkaoxCDE8+FnbPAtkCrTfcLobqq
         sjsL+BjwVO5mXBchCRZGBN6p36Vvu2OPlLuIlW32Cyme0xN+3u1QG/mi6QEBCzOwG5
         9vXMSRkNtgxIgIkqa3FFBLnTjekZmcl/g/Ki2VCTc8BF8ZM/q9pyedjiThFVvXbJQT
         coH3E6q5L0Iw7APmgky1Z42hpLQRlgpM4127PmP2zZcZDhN/y/kDHcZ1rb0jpYx6Fk
         kbmCiycP10CRw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48p65x5G97z6tmL;
        Thu, 26 Mar 2020 14:58:45 +0100 (CET)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/mm: Mark setup_emu2phys_nid() static
Date:   Thu, 26 Mar 2020 14:58:42 +0100
Message-Id: <20200326135842.3875-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make function static because it is used only in this file.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/mm/numa_emulation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 7f1d2034df1e..c5174b4e318b 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -324,7 +324,7 @@ static int __init split_nodes_size_interleave(struct numa_meminfo *ei,
 			0, NULL, NUMA_NO_NODE);
 }
 
-int __init setup_emu2phys_nid(int *dfl_phys_nid)
+static int __init setup_emu2phys_nid(int *dfl_phys_nid)
 {
 	int i, max_emu_nid = 0;
 
-- 
2.17.1

