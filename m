Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0108EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB759215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667394;
	bh=Ilb8ASHpcXiU5PhVWvIrDDUIWrz3HYM4gDRRrZQ3H3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YCDNDEnSGhSoDNPtoKWIUwGyulXxnYLRjDSh4IH3RdsGI2pq06qSYKxeYo3LEMALq
	 x8cdG10SglWjKLdJD4VZS3sjdebPcyTH9hyFNefkv5pNaQrEbXLkH2yTHgOpOloii9
	 p1+I6CATaJ4RpjMBMk3ZH278HHrGcpiuzwMr9S5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbgE1MDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389029AbgE1L5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:57:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A6621775;
        Thu, 28 May 2020 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667051;
        bh=Ilb8ASHpcXiU5PhVWvIrDDUIWrz3HYM4gDRRrZQ3H3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQYb/q2ztO7q/aF++sjrjOqYKlWqDYTWAIzQWQh/5uVI7uQUtD05YtMb7DmYPNIcW
         ZwDG/BMzc3xnU2KuuezqBucgQdyKyhf3laOY4ZgHvX26sUgnzoystSbjfKLxkleKTf
         3D5dgthsMGzrerYt+lwb4LgxXFWpwthPli8ft+1w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roman Mashak <mrv@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/17] net sched: fix reporting the first-time use timestamp
Date:   Thu, 28 May 2020 07:57:12 -0400
Message-Id: <20200528115724.1406376-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115724.1406376-1-sashal@kernel.org>
References: <20200528115724.1406376-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Mashak <mrv@mojatatu.com>

[ Upstream commit b15e62631c5f19fea9895f7632dae9c1b27fe0cd ]

When a new action is installed, firstuse field of 'tcf_t' is explicitly set
to 0. Value of zero means "new action, not yet used"; as a packet hits the
action, 'firstuse' is stamped with the current jiffies value.

tcf_tm_dump() should return 0 for firstuse if action has not yet been hit.

Fixes: 48d8ee1694dd ("net sched actions: aggregate dumping of actions timeinfo")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Roman Mashak <mrv@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/act_api.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 0c82d7ea6ee1..c48b750de2fc 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -67,7 +67,8 @@ static inline void tcf_tm_dump(struct tcf_t *dtm, const struct tcf_t *stm)
 {
 	dtm->install = jiffies_to_clock_t(jiffies - stm->install);
 	dtm->lastuse = jiffies_to_clock_t(jiffies - stm->lastuse);
-	dtm->firstuse = jiffies_to_clock_t(jiffies - stm->firstuse);
+	dtm->firstuse = stm->firstuse ?
+		jiffies_to_clock_t(jiffies - stm->firstuse) : 0;
 	dtm->expires = jiffies_to_clock_t(stm->expires);
 }
 
-- 
2.25.1

