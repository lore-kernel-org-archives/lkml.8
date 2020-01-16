Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF6C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D59206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200308;
	bh=NE7o8wGwYJ4rjiJeaGJRDrJ2DBqgYq0Fg6u5U9yMqoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zUEYEmq8bXT7WUeWwzdz92LjqKD1dqfc19Kazh1m0Jw/9PoDMFOKSb4rcOgRwXGe5
	 GX3FXNP84hHz4/1st8PrBqMU8JEikbR/UW8SkU1DmWBE54BIU57h0s1EHSKClPpghZ
	 qaflzjCeWNDSeZg1nqFtS8duqnVh1zPsMJKwOJTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390266AbgAPSpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389984AbgAPRKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:10:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E512468A;
        Thu, 16 Jan 2020 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194642;
        bh=NE7o8wGwYJ4rjiJeaGJRDrJ2DBqgYq0Fg6u5U9yMqoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7CKVKRhDPAkbPDQr8a0XQIKVBagtlA2dLLyVOMACdFP6eMeaXp05JlaRt5sC9qeR
         Yv/reEqkUppbSm1DDhoJyDirGmKp3qSVSnwsLdVV+W0y2RMbY9pl248kfPek8noNTM
         UA03Z3muismBTWHeV30hOXOb4xS97gl0PV3NXxMQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 499/671] powerpc/64s/radix: Fix memory hot-unplug page table split
Date:   Thu, 16 Jan 2020 12:02:17 -0500
Message-Id: <20200116170509.12787-236-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 31f210cf42d4b308eacef89b6cb0b1459338b8de ]

create_physical_mapping expects physical addresses, but splitting
these mapping on hot unplug is supplying virtual (effective)
addresses.

Fixes: 4dd5f8a99e791 ("powerpc/mm/radix: Split linear mapping on hot-unplug")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190724084638.24982-2-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/pgtable-radix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 69caeb5bccb2..5404a631d583 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -717,8 +717,8 @@ static int __meminit stop_machine_change_mapping(void *data)
 
 	spin_unlock(&init_mm.page_table_lock);
 	pte_clear(&init_mm, params->aligned_start, params->pte);
-	create_physical_mapping(params->aligned_start, params->start, -1);
-	create_physical_mapping(params->end, params->aligned_end, -1);
+	create_physical_mapping(__pa(params->aligned_start), __pa(params->start), -1);
+	create_physical_mapping(__pa(params->end), __pa(params->aligned_end), -1);
 	spin_lock(&init_mm.page_table_lock);
 	return 0;
 }
-- 
2.20.1

