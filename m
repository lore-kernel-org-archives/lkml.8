Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59009C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220482468D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580219970;
	bh=zZf8c5U7fLLNQMm+qitPFQ+bq0WSO61rPIjPlrn69Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZL5Unn4eVDJuW4ryUgqUcR2Z/s1wgKo/c/SP9dNR+dxCT9IkcldfNKTTrigP1tsRy
	 JVbCGbVMWd5AjPEPHO5MAhROsllj5TjcJMbZ7IJpOWPPLM1/QZ/otZCVtyxULWyELN
	 PKtZCmkB8SSqkhTOVt71po8IXGI/RZTOblMJjZE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA1N73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:59:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgA1N7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:59:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E065024685;
        Tue, 28 Jan 2020 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219965;
        bh=zZf8c5U7fLLNQMm+qitPFQ+bq0WSO61rPIjPlrn69Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJGF/wPjJWvRs4xJAWSV1B9VkEdMIigmUcDAwjtJJxvfJvBpYjQJzEPY4vVkLdV5H
         fDOQ6bucQXkrxIBI2MYNzJr2SRuc63E36rjXUY7UK7sowCW/V0ouZHXO7IBqxkQez4
         hLWc00mexKh/R4mULMeLk9M9GHaqKZpkWrotXAtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Subject: [PATCH 4.14 15/46] tcp_bbr: improve arithmetic division in bbr_update_bw()
Date:   Tue, 28 Jan 2020 14:57:49 +0100
Message-Id: <20200128135751.969497560@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

[ Upstream commit 5b2f1f3070b6447b76174ea8bfb7390dc6253ebd ]

do_div() does a 64-by-32 division. Use div64_long() instead of it
if the divisor is long, to avoid truncation to 32-bit.
And as a nice side effect also cleans up the function a bit.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_bbr.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -678,8 +678,7 @@ static void bbr_update_bw(struct sock *s
 	 * bandwidth sample. Delivered is in packets and interval_us in uS and
 	 * ratio will be <<1 for most connections. So delivered is first scaled.
 	 */
-	bw = (u64)rs->delivered * BW_UNIT;
-	do_div(bw, rs->interval_us);
+	bw = div64_long((u64)rs->delivered * BW_UNIT, rs->interval_us);
 
 	/* If this sample is application-limited, it is likely to have a very
 	 * low delivered count that represents application behavior rather than


