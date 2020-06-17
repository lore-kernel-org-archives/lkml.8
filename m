Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91B9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AA32078D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJezgYXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFQJDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:03:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124DC061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:03:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v24so627102plo.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O8uusENFHgtRiLU833qE274616Po1yGCg5u4oskG+Pc=;
        b=BJezgYXOSuWVS6fopqT6ic6EXVlT4CnCbhywI6aSA+lD5URJTr9n4660kaqw0qb8RL
         N5Ia+vAa6op1xONrEv+0OQ8cJX2cxKWf4YeQOpo27ZqoXvVmeakNsAQoXHYK6BAHUIhi
         ONf1+fdHrU5zC2GOeLgQl5AOiYtpnJa78Agz7K5VkGstFCBObC4xOeiifszZCN7/lqBy
         PsG2LGaNdh2kaYWigLmATnheEjRzkan8JKA/NLGPJLDMoMuqn79v387mGkWbPabO0qwi
         qnF9pI0/PkOM0kM05ioKKhthnLRsnQzhqhHmDiyaC/K1UEFCUbhXJBlh8EW2S5NCGjtt
         r54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O8uusENFHgtRiLU833qE274616Po1yGCg5u4oskG+Pc=;
        b=Z6XAwiKSLXW9JXF9W9v0di9Uxg/lx9x8tlz9+UQ/eichuV0s0MthiZ/vMl2EQnh3nK
         Cw6HSR+4R8UsOpwumfIhkqcLk53yYPjtyk1qvQkURoDgsNK1jZDqT4x0vOsxMuS4uAxL
         ia7UA6DZVutL1exK7LVWEKW12hRn4dQWr3uUNr/339VUvsimrh8bNngSQ7t+ShGhbVNu
         ZjQsGeGbaejpKKocIv+EuaeLRwWcrQixgHmycPpl/XBHHEsg1q2MfsdGO8JgzI5z0Fab
         EMYjPs3ahLalsqZKuuFdZ/CrEFIed481nuGLCFcrpTmtRuJczMbTj5Gp6qqYI3g0/neh
         8pqw==
X-Gm-Message-State: AOAM532UpTcH0wPtiuOwz4qDVN/RNjO27cgYUsWFdCBq6X3UZcSmYwY3
        zSP6BgAa511eLbWx+PDMP790ikNtg4Y=
X-Google-Smtp-Source: ABdhPJyWwTn9mkKYeHt3moriBB1llX8dynovBjZ9NI5N5zPBLZzrO3Bqsz0HOtk1lgZ8FwyRE07RHg==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4mr5681414plo.315.1592384610948;
        Wed, 17 Jun 2020 02:03:30 -0700 (PDT)
Received: from localhost (g228.115-65-196.ppp.wakwak.ne.jp. [115.65.196.228])
        by smtp.gmail.com with ESMTPSA id b5sm19768965pfg.191.2020.06.17.02.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:03:29 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: Fix boot oops when DEBUG_VM is enabled
Date:   Wed, 17 Jun 2020 18:02:46 +0900
Message-Id: <20200617090247.1680188-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since v5.8-rc1 OpenRISC Linux fails to boot when DEBUG_VM is enabled.
This has been bisected to commit 42fc541404f2 ("mmap locking API: add
mmap_assert_locked() and mmap_assert_write_locked()").

The added locking checks exposed the issue that OpenRISC was not taking
this mmap lock when during page walks for DMA operations.  This patch
locks and unlocks the mmap lock for page walking.

Fixes: 42fc541404f2 ("mmap locking API: add mmap_assert_locked() and mmap_assert_write_locked()"
Cc: Michel Lespinasse <walken@google.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index c152a68811dd..345727638d52 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -74,8 +74,11 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
 	 * We need to iterate through the pages, clearing the dcache for
 	 * them and setting the cache-inhibit bit.
 	 */
+	mmap_read_lock(&init_mm);
 	error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
 			NULL);
+	mmap_read_unlock(&init_mm);
+
 	if (error)
 		return ERR_PTR(error);
 	return cpu_addr;
@@ -85,9 +88,11 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
 {
 	unsigned long va = (unsigned long)cpu_addr;
 
+	mmap_read_lock(&init_mm);
 	/* walk_page_range shouldn't be able to fail here */
 	WARN_ON(walk_page_range(&init_mm, va, va + size,
 			&clear_nocache_walk_ops, NULL));
+	mmap_read_unlock(&init_mm);
 }
 
 void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
-- 
2.26.2

