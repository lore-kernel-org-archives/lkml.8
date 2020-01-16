Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892BC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C0A20661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200653;
	bh=icTij0F7f80egybZcx7W2o90CPhv3Yys7sg0eCYk/qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hAw2T0ZwSs8A/iib4PTtbmoQvEByGwoM9l4iippUcNft19SejoEpIGrtcezzoAuHB
	 P5JULvtHmguPELujMRe1WydjLLvmIKuUhcai5m40C4QEt93o/swEOPsTmCt8rs4fgL
	 vhSDFqC5QMMEpvJ2Du8hTlNYMUvLBxqsLxEmxD6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbgAPRI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389519AbgAPRIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:08:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFD79217F4;
        Thu, 16 Jan 2020 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194533;
        bh=icTij0F7f80egybZcx7W2o90CPhv3Yys7sg0eCYk/qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjAwLvkPjlFTcXXVYXUm+WGHeiaGK+w1X6NXzJQ3rnw13scCe+b4xriWrKF+JsGG8
         tHrrtoaMtK/fgks55p/jUVe+7Mx6mbmnbpAHWrCMsRuOybXZuux7uAIFfIvI9/RNwB
         k0xhRKj++ObswL77WOoovWsNnD9U+06r9Xm6H2NY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fred Klassen <fklassen@appneta.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 421/671] net/udp_gso: Allow TX timestamp with UDP GSO
Date:   Thu, 16 Jan 2020 12:00:59 -0500
Message-Id: <20200116170509.12787-158-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fred Klassen <fklassen@appneta.com>

[ Upstream commit 76e21533a48bb42d1fa894f93f6233bf4554f45e ]

Fixes an issue where TX Timestamps are not arriving on the error queue
when UDP_SEGMENT CMSG type is combined with CMSG type SO_TIMESTAMPING.
This can be illustrated with an updated updgso_bench_tx program which
includes the '-T' option to test for this condition. It also introduces
the '-P' option which will call poll() before reading the error queue.

    ./udpgso_bench_tx -4ucTPv -S 1472 -l2 -D 172.16.120.18
    poll timeout
    udp tx:      0 MB/s        1 calls/s      1 msg/s

The "poll timeout" message above indicates that TX timestamp never
arrived.

This patch preserves tx_flags for the first UDP GSO segment. Only the
first segment is timestamped, even though in some cases there may be
benefital in timestamping both the first and last segment.

Factors in deciding on first segment timestamp only:

- Timestamping both first and last segmented is not feasible. Hardware
can only have one outstanding TS request at a time.

- Timestamping last segment may under report network latency of the
previous segments. Even though the doorbell is suppressed, the ring
producer counter has been incremented.

- Timestamping the first segment has the upside in that it reports
timestamps from the application's view, e.g. RTT.

- Timestamping the first segment has the downside that it may
underreport tx host network latency. It appears that we have to pick
one or the other. And possibly follow-up with a config flag to choose
behavior.

v2: Remove tests as noted by Willem de Bruijn <willemb@google.com>
    Moving tests from net to net-next

v3: Update only relevant tx_flag bits as per
    Willem de Bruijn <willemb@google.com>

v4: Update comments and commit message as per
    Willem de Bruijn <willemb@google.com>

Fixes: ee80d1ebe5ba ("udp: add udp gso")
Signed-off-by: Fred Klassen <fklassen@appneta.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 0c0522b79b43..aa343654abfc 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -227,6 +227,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	seg = segs;
 	uh = udp_hdr(seg);
 
+	/* preserve TX timestamp flags and TS key for first segment */
+	skb_shinfo(seg)->tskey = skb_shinfo(gso_skb)->tskey;
+	skb_shinfo(seg)->tx_flags |=
+			(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP);
+
 	/* compute checksum adjustment based on old length versus new */
 	newlen = htons(sizeof(*uh) + mss);
 	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
-- 
2.20.1

