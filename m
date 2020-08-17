Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0573FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE135204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690758;
	bh=3LE1sERH2op8tr81KcVJnW6F9WEIbmmNSLlI6nSbYV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZV+XDWPO5h0uZcCv68KEVcUuzsY0JG9dFLQvAjz3SWgsF9SL0Notjium/MzfUW0gD
	 +nUO6QmYerHm7PaESywhEjcMD8EnKW4NLLSz3Z7E2hQs3lyM+RtkcuWzg+ZmFflD07
	 h6F5Jo4L0sWaAc5JsMP+sgRGVSdGEu1AQi7MOcVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391838AbgHQS7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387600AbgHQPss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 572B82065D;
        Mon, 17 Aug 2020 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679327;
        bh=3LE1sERH2op8tr81KcVJnW6F9WEIbmmNSLlI6nSbYV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4g6RgcQsWlqqPvXs2BJEf1ouaVcKhT1BpFx7OfUnTx7kCS5Q+L2N32mr1ekZ+GlD
         IgSTN8XNmLnFgSkRhl9zBamd56n4d7tZ+UOfWdCOw3fCj60VPOfQx6Yk02fihbpw8Z
         YAlZo7TPsXYKKCQCiZXX0UO4ek4FFX39Bw5rs/NQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 173/393] iavf: fix error return code in iavf_init_get_resources()
Date:   Mon, 17 Aug 2020 17:13:43 +0200
Message-Id: <20200817143828.013398792@linuxfoundation.org>
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

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 753f3884f253de6b6d3a516e6651bda0baf4aede ]

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: b66c7bc1cd4d ("iavf: Refactor init state machine")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a21ae74bcd1b6..8deff711cc02c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1863,8 +1863,10 @@ static int iavf_init_get_resources(struct iavf_adapter *adapter)
 
 	adapter->rss_key = kzalloc(adapter->rss_key_size, GFP_KERNEL);
 	adapter->rss_lut = kzalloc(adapter->rss_lut_size, GFP_KERNEL);
-	if (!adapter->rss_key || !adapter->rss_lut)
+	if (!adapter->rss_key || !adapter->rss_lut) {
+		err = -ENOMEM;
 		goto err_mem;
+	}
 	if (RSS_AQ(adapter))
 		adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_RSS;
 	else
-- 
2.25.1



