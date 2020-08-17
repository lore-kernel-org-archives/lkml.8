Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB43C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7293A20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691403;
	bh=/u610J051YLC42YLmGhLdhRzg2RFOI1y6QVRsg1ftOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WN7HDQpXG+i9nijSlubAyKLDX4+G/9Fxn0QQxHsADFsuFUB8fhSDpFbv1WnWkXURN
	 XTsN0mI7Z09tyOjWAW2KQJSFcl71uEpdZmhj//pW+20PnN+zzhPjIKYowOA0tRTV6s
	 SPRWAjDmtQRbinSheVgeBfqcw66sAcY5KoUX9YV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgHQPlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbgHQPe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:34:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E46233FE;
        Mon, 17 Aug 2020 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678465;
        bh=/u610J051YLC42YLmGhLdhRzg2RFOI1y6QVRsg1ftOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ehh5VuiMyup1E+GTy8H51sj3PGKYyqJPKavhl9PpKEN9PLLdY0YQ6AIkIUkiGz+9K
         wAGljlChiXLmvpTwe5SfVUv7+82rOaqp3O0z6iWNsnKwroWOs0EhzKjPPf7AV9gWe5
         PfEIbItkGU/Sej7gaYw7roNZn3OV4WTT01Dh5TTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Surabhi Boob <surabhi.boob@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 343/464] ice: Graceful error handling in HW table calloc failure
Date:   Mon, 17 Aug 2020 17:14:56 +0200
Message-Id: <20200817143850.201190433@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
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
index 6698612048625..504a02b071cee 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -3152,10 +3152,12 @@ enum ice_status ice_init_hw_tbls(struct ice_hw *hw)
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



