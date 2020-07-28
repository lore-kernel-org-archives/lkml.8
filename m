Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F399C433FB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D9C20792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595956288;
	bh=xmaCUO7w5bqGCiLrpTvKhPLilEJbllIwuDFeA8NymgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bX48zgtcvbtv4h8Y7Ol+USV8Cdbwhozp33moOKADAW8KA7GOsPy1GPTHABAckVOvs
	 sA5qLhZ8GoNQuS8ZH0pvc3Ry3kOxMummSzjeP0oSZt3LWHcWvZX0/ZD3SVZ8LhVRIs
	 zhvKv2T9lOwujhkosp6mPqYKDEqU3MkmVrTZAt1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgG1RLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1RLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:11:17 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9053320825;
        Tue, 28 Jul 2020 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956277;
        bh=xmaCUO7w5bqGCiLrpTvKhPLilEJbllIwuDFeA8NymgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jA5G6/nO/8dGBaSvYbruAtnBFneMRAQUHzq+O7pfnNG3/7UjAgII1kSLRBoefe2p8
         D6RX4+XjPlVScObPbFGn9HGSK/C6Uj0tfc7UfYw5njmvPoI1nTejF0VYHCPZ+QMIDJ
         8t+pS2Vt5lKWx7imCan382QlJlsmI70q2GMOcI4c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/4] mm: swap: Fix kerneldoc of swap_vma_readahead()
Date:   Tue, 28 Jul 2020 19:11:07 +0200
Message-Id: <20200728171109.28687-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728171109.28687-1-krzk@kernel.org>
References: <20200728171109.28687-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    mm/swap_state.c:742: warning: Function parameter or member 'fentry' not described in 'swap_vma_readahead'
    mm/swap_state.c:742: warning: Excess function parameter 'entry' description in 'swap_vma_readahead'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 mm/swap_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 66e750f361ed..d034dbf9d0d5 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -725,7 +725,7 @@ static void swap_ra_info(struct vm_fault *vmf,
 
 /**
  * swap_vma_readahead - swap in pages in hope we need them soon
- * @entry: swap entry of this memory
+ * @fentry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
  *
-- 
2.17.1

