Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C836FC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5BF2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597687808;
	bh=DbhteEiKX5tPboPVUEYxtkdGCR+nSetH5b4ksEH+Ig4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h1N8NGBlYW6gwhSw5y1jn9Uya9CT3K5gxsTD+jp0/SfQ3emACY3VOypdVTZwjGKGU
	 H4OEN/eFil6gg8Qwb7zRhrLPdV9JXUewdaqB4Ya/bcEVW+5aKbkzvNQqL52i2KAu+J
	 tY57pX36sV9DG/WEfSnuTH4cSw3G0NmRW+QdBag0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbgHQSKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388426AbgHQQHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:07:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D1320658;
        Mon, 17 Aug 2020 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680470;
        bh=DbhteEiKX5tPboPVUEYxtkdGCR+nSetH5b4ksEH+Ig4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlrhGHLkTSl5Eu+fpj22hvsVpbMyjy7DrMYNZJBpgv0aHoBoxB8+XpyZVuuRCfiYP
         B9ak4mKK2lsuqC87c5ni42/7ieMSX0Y/sYLCHq28TJoCyrJOjAyN4+5XcPKvAYipkB
         vuz+kgFGFiXScK3RIE571x12GePR9JpZs4hKNfj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Surabhi Boob <surabhi.boob@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 192/270] ice: Graceful error handling in HW table calloc failure
Date:   Mon, 17 Aug 2020 17:16:33 +0200
Message-Id: <20200817143805.355574548@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
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
index cbd53b586c36f..6cfe8eb7f47dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1535,10 +1535,12 @@ enum ice_status ice_init_hw_tbls(struct ice_hw *hw)
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



