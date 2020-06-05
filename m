Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32691C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC280207D8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360262;
	bh=h1LcBw55r4LP8d1ELU0w81ims4oDlKhJhKPLveqyyLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nB/sCCrBFVoFmHMbyhmP6VEpQ8VeSJ/yc74s/TjIzVNBv9R5T1uds1nMuMXf6BCv2
	 2keq7K4H6qCmq06xGJhMI5YaQOttTQoEdrOb7ky8IotF3MJ7MVt0d8q3bZNkN0cwZJ
	 9iP1q8HL6qIqJQfDwctqUxdnbArk/FCdSWk1MmBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgFEMa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgFEMZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:25:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 319D1206DC;
        Fri,  5 Jun 2020 12:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359929;
        bh=h1LcBw55r4LP8d1ELU0w81ims4oDlKhJhKPLveqyyLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYVti2W2nsO3hTHidSapypTsL6+b9Pbha09eZs4cyMsqdwwgrXai63DsHbRZofCF+
         hF60cZH3jGVU2vJS6jEJbpU6+Ulo5H5MrnQpteTIWNaKrv9ENspmt4gLJJ4yH4Db1F
         WN3Cy30slrV1aIthVGciRpgNzcwOghcqU5fUaDSo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heinrich Kuhn <heinrich.kuhn@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 09/17] nfp: flower: fix used time of merge flow statistics
Date:   Fri,  5 Jun 2020 08:25:08 -0400
Message-Id: <20200605122517.2882338-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122517.2882338-1-sashal@kernel.org>
References: <20200605122517.2882338-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinrich Kuhn <heinrich.kuhn@netronome.com>

[ Upstream commit 5b186cd60f033110960a3db424ffbd6de4cee528 ]

Prior to this change the correct value for the used counter is calculated
but not stored nor, therefore, propagated to user-space. In use-cases such
as OVS use-case at least this results in active flows being removed from
the hardware datapath. Which results in both unnecessary flow tear-down
and setup, and packet processing on the host.

This patch addresses the problem by saving the calculated used value
which allows the value to propagate to user-space.

Found by inspection.

Fixes: aa6ce2ea0c93 ("nfp: flower: support stats update for merge flows")
Signed-off-by: Heinrich Kuhn <heinrich.kuhn@netronome.com>
Signed-off-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/flower/offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index 7ca5c1becfcf..c5dcfdd69773 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -1440,7 +1440,8 @@ __nfp_flower_update_merge_stats(struct nfp_app *app,
 		ctx_id = be32_to_cpu(sub_flow->meta.host_ctx_id);
 		priv->stats[ctx_id].pkts += pkts;
 		priv->stats[ctx_id].bytes += bytes;
-		max_t(u64, priv->stats[ctx_id].used, used);
+		priv->stats[ctx_id].used = max_t(u64, used,
+						 priv->stats[ctx_id].used);
 	}
 }
 
-- 
2.25.1

