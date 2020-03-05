Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E047C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9B020870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428436;
	bh=3IeweYz10iLPB5x/FxuKK3ushj7/AQrBPdxWYnpyJ3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RilIyA8zB5GDP2BJ72JvGM2uhCz0nwlyDJ4IeK27eRgAgxdamRvpByE+TKdEM+LOr
	 RCN/jNTw5rn4wdGBdY6j1Md3d97RuA8S/76k2hprInXSJFK6enCdrQG3JGQ6ax+G5n
	 4DXb2eFdkRxe82ofxuLqTYWhuZCtrINfOA4jVvyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCERNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:13:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbgCERNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:13:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE7EF21556;
        Thu,  5 Mar 2020 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428429;
        bh=3IeweYz10iLPB5x/FxuKK3ushj7/AQrBPdxWYnpyJ3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZHtR0y4QBYCgCjdEy0G20yZqNbDOJvDxypflvWF/BItqtv/FRBFT21wyh9qLcfNH
         rK3dxe+Re5sHhjpf2gXiPa8+MjHBQF/O5eUSx1xBvdG8YUZ/4mLFAICSG98MQyHLAj
         hHoGjfKBlRualXBd1K1I4FXL5+0XAykKo3MyNgEA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        syzbot+6a86565c74ebe30aea18@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 29/67] netfilter: ipset: Fix forceadd evaluation path
Date:   Thu,  5 Mar 2020 12:12:30 -0500
Message-Id: <20200305171309.29118-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171309.29118-1-sashal@kernel.org>
References: <20200305171309.29118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jozsef Kadlecsik <kadlec@netfilter.org>

[ Upstream commit 8af1c6fbd9239877998c7f5a591cb2c88d41fb66 ]

When the forceadd option is enabled, the hash:* types should find and replace
the first entry in the bucket with the new one if there are no reuseable
(deleted or timed out) entries. However, the position index was just not set
to zero and remained the invalid -1 if there were no reuseable entries.

Reported-by: syzbot+6a86565c74ebe30aea18@syzkaller.appspotmail.com
Fixes: 23c42a403a9c ("netfilter: ipset: Introduction of new commands and protocol version 7")
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 71e93eac08319..e52d7b7597a0d 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -931,6 +931,8 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 		}
 	}
 	if (reuse || forceadd) {
+		if (j == -1)
+			j = 0;
 		data = ahash_data(n, j, set->dsize);
 		if (!deleted) {
 #ifdef IP_SET_HASH_WITH_NETS
-- 
2.20.1

