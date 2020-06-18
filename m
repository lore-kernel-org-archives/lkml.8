Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D58C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D99221E6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445638;
	bh=+Y3vcEEULt0GKtFd7fOe5BMMh6Rp0D9edGTeM/qXb6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=atuKi4fl84zmEeWXET3ZSy+exK2Q1dFvLc0gfh1ixnZBVulb5jkjfIA8km/dvS/m/
	 F6dQ+qGJM9PI08t37998zJHez1KKM90JXHMJNs4fQtzIv8li1L3t3eawQYwCcpNDlt
	 ToXY5ps3IS71CBrDLOGYCbIr+69RJ6h1uVbdvg+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgFRCAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731173AbgFRBYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:24:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CC320CC7;
        Thu, 18 Jun 2020 01:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443460;
        bh=+Y3vcEEULt0GKtFd7fOe5BMMh6Rp0D9edGTeM/qXb6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJlikB84FNyDS1uRNn3v43g4U3BmFMd+M3XxYZgk5b7ulcYRBd+/05GKt/yIKXNXL
         x1IAanVhbFjgA2ashQpGmmJan1Tn5Kj5nApEc2NQVQ64Blf0zNbGd6kshFbPalJemz
         lk6SG9ykHKZkgXDp3qEoYDSHTFUuQlS498Xr4sC4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 094/172] powerpc/ps3: Fix kexec shutdown hang
Date:   Wed, 17 Jun 2020 21:21:00 -0400
Message-Id: <20200618012218.607130-94-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geoff Levand <geoff@infradead.org>

[ Upstream commit 126554465d93b10662742128918a5fc338cda4aa ]

The ps3_mm_region_destroy() and ps3_mm_vas_destroy() routines
are called very late in the shutdown via kexec's mmu_cleanup_all
routine.  By the time mmu_cleanup_all runs it is too late to use
udbg_printf, and calling it will cause PS3 systems to hang.

Remove all debugging statements from ps3_mm_region_destroy() and
ps3_mm_vas_destroy() and replace any error reporting with calls
to lv1_panic.

With this change builds with 'DEBUG' defined will not cause kexec
reboots to hang, and builds with 'DEBUG' defined or not will end
in lv1_panic if an error is encountered.

Signed-off-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/7325c4af2b4c989c19d6a26b90b1fec9c0615ddf.1589049250.git.geoff@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/ps3/mm.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 8c7009d001d9..894f62d77a77 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -212,13 +212,14 @@ void ps3_mm_vas_destroy(void)
 {
 	int result;
 
-	DBG("%s:%d: map.vas_id    = %llu\n", __func__, __LINE__, map.vas_id);
-
 	if (map.vas_id) {
 		result = lv1_select_virtual_address_space(0);
-		BUG_ON(result);
-		result = lv1_destruct_virtual_address_space(map.vas_id);
-		BUG_ON(result);
+		result += lv1_destruct_virtual_address_space(map.vas_id);
+
+		if (result) {
+			lv1_panic(0);
+		}
+
 		map.vas_id = 0;
 	}
 }
@@ -316,19 +317,20 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 	int result;
 
 	if (!r->destroy) {
-		pr_info("%s:%d: Not destroying high region: %llxh %llxh\n",
-			__func__, __LINE__, r->base, r->size);
 		return;
 	}
 
-	DBG("%s:%d: r->base = %llxh\n", __func__, __LINE__, r->base);
-
 	if (r->base) {
 		result = lv1_release_memory(r->base);
-		BUG_ON(result);
+
+		if (result) {
+			lv1_panic(0);
+		}
+
 		r->size = r->base = r->offset = 0;
 		map.total = map.rm.size;
 	}
+
 	ps3_mm_set_repository_highmem(NULL);
 }
 
-- 
2.25.1

