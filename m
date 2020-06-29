Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947D2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AD420656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461819;
	bh=ZjfaqJcqCoYR9S2k6hGkT0Xs4RvC6KD+LU81NfTLZvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LB00W6THg+Gsjvl/QAltuNlUr9qBmKtdJyxG5kj9yUdYurKKgk+FwPCx0o81Mf2MH
	 W4h9KgoIAAA1qg/eqq0kkPQIiL8BNhqilRZaJKzfEtf+2owOqLpYZ34dqn96mcPgDI
	 kjbWcDzGA/CtUvVf2oPdvTbRpp0jxiZuNr2rMVag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgF2UQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732197AbgF2TaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C5525221;
        Mon, 29 Jun 2020 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444939;
        bh=ZjfaqJcqCoYR9S2k6hGkT0Xs4RvC6KD+LU81NfTLZvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6arOE5KCaLv8VkpBgyyBSWCOSggRgyvkK4gOljLq23kS5HDYo4wjPXlK48MjIbTs
         RlB3HZduMfZVVVxHS9TA50Y3LODVHeKb9JfQ75Qn0twIao/Iw1tdo9ir18Uj1LjPJq
         hBzSKVfg8BKc55jzG0IE7kSEiMk93mDf21r80fG4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Neal Cardwell <ncardwell@google.com>,
        Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 036/131] tcp_cubic: fix spurious HYSTART_DELAY exit upon drop in min RTT
Date:   Mon, 29 Jun 2020 11:33:27 -0400
Message-Id: <20200629153502.2494656-37-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neal Cardwell <ncardwell@google.com>

[ Upstream commit b344579ca8478598937215f7005d6c7b84d28aee ]

Mirja Kuehlewind reported a bug in Linux TCP CUBIC Hystart, where
Hystart HYSTART_DELAY mechanism can exit Slow Start spuriously on an
ACK when the minimum rtt of a connection goes down. From inspection it
is clear from the existing code that this could happen in an example
like the following:

o The first 8 RTT samples in a round trip are 150ms, resulting in a
  curr_rtt of 150ms and a delay_min of 150ms.

o The 9th RTT sample is 100ms. The curr_rtt does not change after the
  first 8 samples, so curr_rtt remains 150ms. But delay_min can be
  lowered at any time, so delay_min falls to 100ms. The code executes
  the HYSTART_DELAY comparison between curr_rtt of 150ms and delay_min
  of 100ms, and the curr_rtt is declared far enough above delay_min to
  force a (spurious) exit of Slow start.

The fix here is simple: allow every RTT sample in a round trip to
lower the curr_rtt.

Fixes: ae27e98a5152 ("[TCP] CUBIC v2.3")
Reported-by: Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_cubic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 78bfadfcf3426..8b5ba0a5cd386 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -403,6 +403,8 @@ static void hystart_update(struct sock *sk, u32 delay)
 
 	if (hystart_detect & HYSTART_DELAY) {
 		/* obtain the minimum delay of more than sampling packets */
+		if (ca->curr_rtt > delay)
+			ca->curr_rtt = delay;
 		if (ca->sample_cnt < HYSTART_MIN_SAMPLES) {
 			if (ca->curr_rtt == 0 || ca->curr_rtt > delay)
 				ca->curr_rtt = delay;
-- 
2.25.1

