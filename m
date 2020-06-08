Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B554C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302F820760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664091;
	bh=gIPMWsm4ABPCize5QULWOmfap6esL9krjFHVmOk7eLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E2AA3Fbj0CibTO+TMjOl20vQZy/PtZt08BtteYOJyyfjHwOGNbaVqH+h1C90Zo2PZ
	 Y8FNODioIrPJWvneY6QXMw4Fy82cw8JtyKrHyMnOw5kEmj89O9EZa4Gxx44S1gizaD
	 aRIYq67aO8OgGn+NDwihQNqae+Wbbg8D5fqyEmzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgFIAyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgFHXJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:09:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 483BC208B8;
        Mon,  8 Jun 2020 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657767;
        bh=gIPMWsm4ABPCize5QULWOmfap6esL9krjFHVmOk7eLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jb97ttQrecBOA4dUUzSc+83oiF7UcGx3ZHKsIsaqpptNpzD5XMGrZkf+pst+Xt6ro
         6i5TvtUjwkNmVVh6wy1blMQ88xD1IosG+09xAise72ejAk/h7u9fsI62akxWQZJFft
         H9oMwVQS0mEKCPIADQ73yGdUyvZwGGFgyEh1SP4Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 151/274] ice: Fix error return code in ice_add_prof()
Date:   Mon,  8 Jun 2020 19:04:04 -0400
Message-Id: <20200608230607.3361041-151-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit f8d530ac29fe9248f5e58ca5bcf4c368f8393ccf ]

Fix to return a error code from the error handling case
instead of 0, as done elsewhere in this function.

Fixes: 31ad4e4ee1e4 ("ice: Allocate flow profile")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 42bac3ec5526..e7a2671222d2 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -2962,8 +2962,10 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
 
 	/* add profile info */
 	prof = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*prof), GFP_KERNEL);
-	if (!prof)
+	if (!prof) {
+		status = ICE_ERR_NO_MEMORY;
 		goto err_ice_add_prof;
+	}
 
 	prof->profile_cookie = id;
 	prof->prof_id = prof_id;
-- 
2.25.1

