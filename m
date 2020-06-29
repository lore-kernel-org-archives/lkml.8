Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A6FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A385B20702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460478;
	bh=k4BViiCZTFDLFtenuQ6Xj6HOd+D0BxckrvynWJCnYMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XfEWahi8uZxXt3r62ytmFtFk5BwSmnJKlAIY4t84mzygIb6gc6EwWMiMDn/bUOBhc
	 2FPCgcyxLOCUuH7+4VIie3IalQWxQLLgigkbXojVqsn49gW7W0/b4utmMvS09+jhBO
	 YQHyDSOH3L81rqxtzayYzNwKO0oYpbMo8dPlBNC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbgF2Tyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387460AbgF2Tk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0452483F;
        Mon, 29 Jun 2020 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444352;
        bh=k4BViiCZTFDLFtenuQ6Xj6HOd+D0BxckrvynWJCnYMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnqLJ3/3NFrBS4TYWGgWit0a0SvAKGLBNTanNWC+1V85QADOs+MKOoWqM9F6PPyEZ
         m1mBR06rsnF9lqnqBdphrT2LQvgy6SKO4OgQJUbTzT6G0VXd2wNgwqgWkIoHlMT/Ox
         ViLCUpmUstlhjCZLxmqF+UDCjwfALU7mq9CPgw5g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Neal Cardwell <ncardwell@google.com>,
        Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 027/178] tcp_cubic: fix spurious HYSTART_DELAY exit upon drop in min RTT
Date:   Mon, 29 Jun 2020 11:22:52 -0400
Message-Id: <20200629152523.2494198-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
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
index 1b3d032a4df2a..ee6c38a73325d 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -404,6 +404,8 @@ static void hystart_update(struct sock *sk, u32 delay)
 
 	if (hystart_detect & HYSTART_DELAY) {
 		/* obtain the minimum delay of more than sampling packets */
+		if (ca->curr_rtt > delay)
+			ca->curr_rtt = delay;
 		if (ca->sample_cnt < HYSTART_MIN_SAMPLES) {
 			if (ca->curr_rtt == 0 || ca->curr_rtt > delay)
 				ca->curr_rtt = delay;
-- 
2.25.1

