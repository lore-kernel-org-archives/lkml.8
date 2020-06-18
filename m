Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D60C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0E620885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446663;
	bh=uPVJfn4eW6yGGsUiXpVMaywucoc7azMIcy2PSIJ8+B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hh9MNu80XuKfbUaVXA1CbEfLsnizwcEZVDR70NPOtXaAlZUm7Eap+MI6A++I7ZLwq
	 zMnRq9yZHXLSu9nlFXVIm4unvGcGVJ/E6SnokBj7hFmizSPVNWV00/e1oZFVzd9okR
	 KORnwyrYiqCCY9Vx+RD7YSN70uJ24aoyi2SeMfLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbgFRCRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729834AbgFRBTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D01721D7E;
        Thu, 18 Jun 2020 01:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443192;
        bh=uPVJfn4eW6yGGsUiXpVMaywucoc7azMIcy2PSIJ8+B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yH8JnJBhEqCCaZ+GqjryQr1EDgD+rSG4rMDGFvlLIyqn1gaJMkbA8vZoVxvDvHejN
         RZEGHOq0/ZQMrwnNqKJ/QZq+beK3X+GwNvnJFJvs7VS2JUrClimnsPWCpKurJsKW8Z
         uwB33W2y2FPk2R37wShBGL0Q8iJZB0cy6+GfG3rQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 153/266] powerpc/ps3: Fix kexec shutdown hang
Date:   Wed, 17 Jun 2020 21:14:38 -0400
Message-Id: <20200618011631.604574-153-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
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
index 423be34f0f5f..f42fe4e86ce5 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -200,13 +200,14 @@ void ps3_mm_vas_destroy(void)
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
@@ -304,19 +305,20 @@ static void ps3_mm_region_destroy(struct mem_region *r)
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

