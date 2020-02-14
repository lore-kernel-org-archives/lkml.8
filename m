Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F53AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF6424654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704137;
	bh=6HEabNHqFEipAWICMy3lsoue89B8JCjd2vU/ihVA3RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSxpexaTF8Pkf1vYk6b/0kNJbSwk30d0viA9S0n+3ML/noceTqzxECDslFWep6/yn
	 T83pROsizcgMGbn/2qSV+IUVoYm0uv5y4PkK9TIrRH/dI+3bByFTB6NGGNb1CYJ07F
	 +ZK8qki4akZwA2CvhztTzQZ+eu0/f6R57ufz6fns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgBNPvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:51:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730817AbgBNPvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF621222C4;
        Fri, 14 Feb 2020 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695497;
        bh=6HEabNHqFEipAWICMy3lsoue89B8JCjd2vU/ihVA3RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AssHX7Pe37VnQ2Ri7G+1epC7594MSDUyl7vkEbI016arb3ckEjgU8Rm47XocAzTd6
         mnEFJSNAs9GFJIC1WJfrlfreVAoh7cNDObCVW6Ag0drpIVpk/Wt3SFRNirbzJlnJVs
         WNueAO7vLwae5THKZ0GRgZP32deDt7+LvJe0/A+w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Blakey <paulb@mellanox.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 125/542] netfilter: flowtable: Fix missing flush hardware on table free
Date:   Fri, 14 Feb 2020 10:41:57 -0500
Message-Id: <20200214154854.6746-125-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Blakey <paulb@mellanox.com>

[ Upstream commit 0f34f30a1be80f3f59efeaab596396bc698e7337 ]

If entries exist when freeing a hardware offload enabled table,
we queue work for hardware while running the gc iteration.

Execute it (flush) after queueing.

Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
Signed-off-by: Paul Blakey <paulb@mellanox.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_flow_table_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index e33a73cb1f42e..640a46fd710d2 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -554,6 +554,7 @@ void nf_flow_table_free(struct nf_flowtable *flow_table)
 	cancel_delayed_work_sync(&flow_table->gc_work);
 	nf_flow_table_iterate(flow_table, nf_flow_table_do_cleanup, NULL);
 	nf_flow_table_iterate(flow_table, nf_flow_offload_gc_step, flow_table);
+	nf_flow_table_offload_flush(flow_table);
 	rhashtable_destroy(&flow_table->rhashtable);
 }
 EXPORT_SYMBOL_GPL(nf_flow_table_free);
-- 
2.20.1

