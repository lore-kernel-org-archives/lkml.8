Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B1C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BAF20757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340583;
	bh=Be9Qa6GEzWbRRy7dTkQYaBQVuBFzIUuPT0a5TYhUR9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xfwHHjSeL6ssunX5VMfrE1vDnk7GvhYF6ryVK67E+T4e/fzm81LN3I+dqLMWZ4762
	 iUw0Wt9Bb3U+5HtZofCvIpfJCgCW/8TmHzAteirnqIgm4IV+DPsdkowsd3fyUUUER3
	 YQ4ommpUpt6cnmm68wYkAskUk4rfBDAkYoeMSbvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgEANnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731327AbgEANmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:42:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B8020757;
        Fri,  1 May 2020 13:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340573;
        bh=Be9Qa6GEzWbRRy7dTkQYaBQVuBFzIUuPT0a5TYhUR9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fe2llFqXt9xTiSJXZ7atknijd83Py6zsfGiGlOojaFekN0egDBXhh7MMVHcHUpaQ7
         /0YOuJvtJIyxqaJwgcLZ5dc2zSGJTnwMf4nvkpbucQpTEr70cu3EfrwfDPXFYLpb1I
         qTbRoS2qFe1b1oF9GPklcDsBde/UzfwcN+EvvT8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
        Tuong Lien <tuong.t.lien@dektech.com.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 037/106] tipc: fix incorrect increasing of link window
Date:   Fri,  1 May 2020 15:23:10 +0200
Message-Id: <20200501131548.327398089@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuong Lien <tuong.t.lien@dektech.com.au>

commit edadedf1c5b4e4404192a0a4c3c0c05e3b7672ab upstream.

In commit 16ad3f4022bb ("tipc: introduce variable window congestion
control"), we allow link window to change with the congestion avoidance
algorithm. However, there is a bug that during the slow-start if packet
retransmission occurs, the link will enter the fast-recovery phase, set
its window to the 'ssthresh' which is never less than 300, so the link
window suddenly increases to that limit instead of decreasing.

Consequently, two issues have been observed:

- For broadcast-link: it can leave a gap between the link queues that a
new packet will be inserted and sent before the previous ones, i.e. not
in-order.

- For unicast: the algorithm does not work as expected, the link window
jumps to the slow-start threshold whereas packet retransmission occurs.

This commit fixes the issues by avoiding such the link window increase,
but still decreasing if the 'ssthresh' is lowered.

Fixes: 16ad3f4022bb ("tipc: introduce variable window congestion control")
Acked-by: Jon Maloy <jmaloy@redhat.com>
Signed-off-by: Tuong Lien <tuong.t.lien@dektech.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/link.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1065,7 +1065,7 @@ static void tipc_link_update_cwin(struct
 	/* Enter fast recovery */
 	if (unlikely(retransmitted)) {
 		l->ssthresh = max_t(u16, l->window / 2, 300);
-		l->window = l->ssthresh;
+		l->window = min_t(u16, l->ssthresh, l->window);
 		return;
 	}
 	/* Enter slow start */


