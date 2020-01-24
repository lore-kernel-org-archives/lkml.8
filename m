Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D85C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92409206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860410;
	bh=maeMNMQTEB9QDEHdX6dLnQmt1fBj7Sr6eZDP1VuBc2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCfyGm8fbi/rk3a8NnGB1Z9kAxuMHk0Sk0tfcXBdOnwYHzWTDZIhAVWtYuq3AFg4Y
	 lytg62U1ab3J5L0eWsuvt93FDJXueXRmHP36ETS8lDe33M0F4Hs+2A11N8XB057xBy
	 +lSj1W3OmknU/DhzxFb0Tyhb2PD0+vAisly3URxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbgAXKGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbgAXKGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:06:48 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D147A206F0;
        Fri, 24 Jan 2020 10:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860407;
        bh=maeMNMQTEB9QDEHdX6dLnQmt1fBj7Sr6eZDP1VuBc2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2qaZbYYSS48yxNgYzKf07LIDp+CQeg3Hem9BG7z7Qn1iTPJWafjetrTDb5zW/PG8
         x5k1V5rh1apXg5ycXaNMVjV4Uf+acVjFYOVnJcvIn5gYccewc7Hy+hntimePclsBdq
         jtVndskTEJB0174jgrPuNGJQwILWWRRjCDKSYrgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 328/343] net: netem: correct the parents backlog when corrupted packet was dropped
Date:   Fri, 24 Jan 2020 10:32:26 +0100
Message-Id: <20200124093002.948209940@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit e0ad032e144731a5928f2d75e91c2064ba1a764c ]

If packet corruption failed we jump to finish_segs and return
NET_XMIT_SUCCESS. Seeing success will make the parent qdisc
increment its backlog, that's incorrect - we need to return
NET_XMIT_DROP.

Fixes: 6071bd1aa13e ("netem: Segment GSO packets on enqueue")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_netem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 64c3cfa357363..328b043edf074 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -603,6 +603,8 @@ finish_segs:
 		}
 		/* Parent qdiscs accounted for 1 skb of size @prev_len */
 		qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));
+	} else if (!skb) {
+		return NET_XMIT_DROP;
 	}
 	return NET_XMIT_SUCCESS;
 }
-- 
2.20.1



