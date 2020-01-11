Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D7C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B94A20848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737923;
	bh=mcjFmwhwJrbakRmABQ1xRFN6l3QsdshO9EqfWV3t6OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fgh28NXu5xz69ZU6XvmHEkQMB2Grm4zZHmylG1XMdifIvbV4iWhjkzfWzgCtmvLLh
	 ITuHjDIYymTSwO+UxswHYYKJo5d0WlCEeVY8eiVOSg3vBy1PUSFePi3DyXuEJZnzIy
	 xBGUczPUUpU6qpePcid1qow8PEGp9hkKVm0kTjFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbgAKKSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbgAKKSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:18:41 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A9020842;
        Sat, 11 Jan 2020 10:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737920;
        bh=mcjFmwhwJrbakRmABQ1xRFN6l3QsdshO9EqfWV3t6OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4QwhqXoiXRUBBEly3h4M+CMX/Qm9RO+rJdWfo3BiqYs+ceBM1ez9axlAixx60MXK
         +Kjus9Ke6fuJXbek4MlfDnMePv4SBlCNjKenf5gbIAQejuJfFd5tb7Bu/VAaf07g7c
         9CxiLhsIbiEEo3MV2ELW1sWp2IAroeuvwZkbYCkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>,
        Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        cake@lists.bufferbloat.net, netdev@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH 4.19 73/84] sch_cake: avoid possible divide by zero in cake_enqueue()
Date:   Sat, 11 Jan 2020 10:50:50 +0100
Message-Id: <20200111094911.801043901@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

[ Upstream commit 68aab823c223646fab311f8a6581994facee66a0 ]

The variables 'window_interval' is u64 and do_div()
truncates it to 32 bits, which means it can test
non-zero and be truncated to zero for division.
The unit of window_interval is nanoseconds,
so its lower 32-bit is relatively easy to exceed.
Fix this issue by using div64_u64() instead.

Fixes: 7298de9cd725 ("sch_cake: Add ingress mode")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: cake@lists.bufferbloat.net
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_cake.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1758,7 +1758,7 @@ static s32 cake_enqueue(struct sk_buff *
 						      q->avg_window_begin));
 			u64 b = q->avg_window_bytes * (u64)NSEC_PER_SEC;
 
-			do_div(b, window_interval);
+			b = div64_u64(b, window_interval);
 			q->avg_peak_bandwidth =
 				cake_ewma(q->avg_peak_bandwidth, b,
 					  b > q->avg_peak_bandwidth ? 2 : 8);


