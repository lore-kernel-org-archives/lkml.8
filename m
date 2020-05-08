Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1963C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AF420A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgEHJwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:52:24 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:59216
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgEHJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:52:23 -0400
X-IronPort-AV: E=Sophos;i="5.73,367,1583190000"; 
   d="scan'208";a="348097894"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 08 May 2020 11:52:21 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nic Volanschi <eugene.volanschi@inria.fr>
Subject: [PATCH] powerpc/spufs: adjust list element pointer type
Date:   Fri,  8 May 2020 11:12:56 +0200
Message-Id: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other uses of &gang->aff_list_head, eg in spufs_assert_affinity, indicate
that the list elements have type spu_context, not spu as used here.  Change
the type of tmp accordingly.

This has no impact on the execution, because tmp is not used in the body of
the loop.

Fixes: c5fc8d2a92461 ("[CELL] cell: add placement computation for scheduling of affinity contexts")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/powerpc/platforms/cell/spufs/sched.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index f18d5067cd0f..487fcb47f10d 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -344,8 +344,7 @@ static struct spu *aff_ref_location(struct spu_context *ctx, int mem_aff,
 static void aff_set_ref_point_location(struct spu_gang *gang)
 {
 	int mem_aff, gs, lowest_offset;
-	struct spu_context *ctx;
-	struct spu *tmp;
+	struct spu_context *tmp, *ctx;
 
 	mem_aff = gang->aff_ref_ctx->flags & SPU_CREATE_AFFINITY_MEM;
 	lowest_offset = 0;

