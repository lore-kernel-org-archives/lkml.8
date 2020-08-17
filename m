Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3735CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DC8204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690206;
	bh=b7i1MSasYwg2qXcZZCQIoOVp77wswjIW21JAHrhQWHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0m7sDoSJTLnbrJC+QbzuutTIm1XoTOH+LEjDhlYaELMmtY6MHm0JmZtWSdTzSnqw2
	 6z8eQXAbTU1GPRNe5FTWBzRRHqSFbvIbbWB5ijoHBD8YDAAxNx2EJIhl/Q/oAbT/vo
	 Q2xe34Z0kBNMwWQFkmCKrCM515aHcdBMMIlnpPbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391595AbgHQSuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbgHQPyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:54:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DDEF20657;
        Mon, 17 Aug 2020 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679645;
        bh=b7i1MSasYwg2qXcZZCQIoOVp77wswjIW21JAHrhQWHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KooOCtGWYf/EBmahwzm/0Kq9TrG3EK8pB5KaD5JRGntEP776tUGL+MTZ1kqHI1T/w
         2v6qspPYiu1Cgiedl2hYrbOErIdV0VUw99z61t1Ggo1+qA12RcTgvl/vM+GUihcqgy
         /DN8ojy0CnRKg84MHsoObLLOqmaMHiSvnhir4Bjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Surabhi Boob <surabhi.boob@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 284/393] ice: Graceful error handling in HW table calloc failure
Date:   Mon, 17 Aug 2020 17:15:34 +0200
Message-Id: <20200817143833.395968172@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Surabhi Boob <surabhi.boob@intel.com>

[ Upstream commit bcc46cb8a077c6189b44f1555b8659837f748eb2 ]

In the ice_init_hw_tbls, if the devm_kcalloc for es->written fails, catch
that error and bail out gracefully, instead of continuing with a NULL
pointer.

Fixes: 32d63fa1e9f3 ("ice: Initialize DDP package structures")
Signed-off-by: Surabhi Boob <surabhi.boob@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index d60e31f65749f..a9a89bdb6036a 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -2521,10 +2521,12 @@ enum ice_status ice_init_hw_tbls(struct ice_hw *hw)
 		es->ref_count = devm_kcalloc(ice_hw_to_dev(hw), es->count,
 					     sizeof(*es->ref_count),
 					     GFP_KERNEL);
+		if (!es->ref_count)
+			goto err;
 
 		es->written = devm_kcalloc(ice_hw_to_dev(hw), es->count,
 					   sizeof(*es->written), GFP_KERNEL);
-		if (!es->ref_count)
+		if (!es->written)
 			goto err;
 	}
 	return 0;
-- 
2.25.1



