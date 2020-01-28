Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7F9C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B11C24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221431;
	bh=MmPHgSdmgUAHYvpQyf5S2BR4VlzdMAVZWLDg1tLXtZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bBWbs8xsgra/7iasyL34Q0dgxmecY9gSj6taIMjPMpHmYvC2cxwpRUOvQkmelzHOl
	 c8ePLUCl4QeCcLGmvpFBsyZVjwVTPayoD27xd+HjrjF+yGVHCIxoMd8t+2e4OO1ZfV
	 grEI2jXKjuxndPGFFd0nsCY4fdOYu9aQlGPp4dnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbgA1OXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731553AbgA1OXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:23:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E3A24681;
        Tue, 28 Jan 2020 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221425;
        bh=MmPHgSdmgUAHYvpQyf5S2BR4VlzdMAVZWLDg1tLXtZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+YKM4q/AMBPViziYzhj42DkSWovmJmiboM+95bFr4kAw0WlffYin95otO+aOls/B
         dU5mBfJbA7F2zKMVUUenffLpPAb+2oyfUVqabLEeduv/9/nJtR9G8zl6ZrXH1e8oVn
         PwcqbLtgeRgkCnPtcL7ub5cJ4SR+hNyjQrnlBJ7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 218/271] net: netem: correct the parents backlog when corrupted packet was dropped
Date:   Tue, 28 Jan 2020 15:06:07 +0100
Message-Id: <20200128135908.772991031@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
index 11c4c93f5ded7..e06491314d592 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -609,6 +609,8 @@ finish_segs:
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



