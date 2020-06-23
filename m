Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EC4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F322E20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946223;
	bh=PO6z4E1RvorJii8ydbCrTv+qwvupsdcyw1g8L4SwrZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hLEYbqxHB822EpyN3dtAS/Z26KNZYz4fbfnt6J+UKTKkB1b4nx1oMVClTHFipP+69
	 YpOI+5QMNiLw0f2cvZqCkuovDO2t4MCodIv0HxlLu92UeAubk3to4TiWVkTDaXf3me
	 MAccFXy3bEuq/CjLG2M21Whrt/lYaCkOdUBlmLN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391578AbgFWUi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391569AbgFWUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:38:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F419D21531;
        Tue, 23 Jun 2020 20:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944696;
        bh=PO6z4E1RvorJii8ydbCrTv+qwvupsdcyw1g8L4SwrZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wubgelqaJFs2pvlQRKQJr4etRME5cHXwnZokoQXo6JEmAjRS03IDxEoi64a3OvWLV
         nMu1vsOwGZ+q1T7fveydOIj/s+lz0aXVbiXlqd4vxl3MUu0d7290gvQ6k9dR9VtzpO
         7GJmmlumpVG+vA2zEqugq4cBPW8elL0alIh40opE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/206] powerpc/ps3: Fix kexec shutdown hang
Date:   Tue, 23 Jun 2020 21:56:57 +0200
Message-Id: <20200623195321.328662178@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 8c7009d001d96..894f62d77a777 100644
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



