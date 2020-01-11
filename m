Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D7CC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8762077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737744;
	bh=wvVGmq4XE2oHNlB21bRNNlRnCfW+IKBgGPSVORd4Cv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AliKCpHrjbvDCFgbLsw7aF8cNdJMrXZ48Qv5LexV5XAwrgx11RyleCHoqvV674sML
	 NlPZEcpeEhxf/bqHLq1sqFPoXjotrCo3pqCCnxkdeBh8NAmIlQvmT/n9+AFqw3sowr
	 sUX2t9XH5Gfrc+epZmUPzcF/3fflUvi7FCsK9UxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgAKKPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbgAKKPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:15:39 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829B8206DA;
        Sat, 11 Jan 2020 10:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737739;
        bh=wvVGmq4XE2oHNlB21bRNNlRnCfW+IKBgGPSVORd4Cv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o64/MTMN9A7kA/X8wAE8npMGyvzo+nNEF5PgtY5aRlkAixcc2xP0+jzqKKi0ubvYE
         uagvpltgHoVlReWBcjM5n4e5nxKsbL41CpA4KdneaWG1PA80Dxp3BKI6PUv/p1H9dz
         xD2RQAndPn+NK7T1CojlqGIXkUDgPgtCMF70gznE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/84] bpf: Clear skb->tstamp in bpf_redirect when necessary
Date:   Sat, 11 Jan 2020 10:50:12 +0100
Message-Id: <20200111094859.445688692@linuxfoundation.org>
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

From: Lorenz Bauer <lmb@cloudflare.com>

[ Upstream commit 5133498f4ad1123a5ffd4c08df6431dab882cc32 ]

Redirecting a packet from ingress to egress by using bpf_redirect
breaks if the egress interface has an fq qdisc installed. This is the same
problem as fixed in 'commit 8203e2d844d3 ("net: clear skb->tstamp in forwarding paths")

Clear skb->tstamp when redirecting into the egress path.

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/bpf/20191213180817.2510-1-lmb@cloudflare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index e6fa88506c00..91b950261975 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2007,6 +2007,7 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	skb->dev = dev;
+	skb->tstamp = 0;
 
 	__this_cpu_inc(xmit_recursion);
 	ret = dev_queue_xmit(skb);
-- 
2.20.1



