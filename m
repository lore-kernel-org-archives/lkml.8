Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630C32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863778;
	bh=fy19I0vOwJrBMY/7U50STJKg69HUaZHsyoy2OiGgDaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WF1vrvxHs1/BgGA6ZUEYafveQnNivZ8uHqz6xOB/J4xkBp//RJPNcLgF22WUvOvRI
	 +EoVOPSUCi249i/06Hyd/uNwIl+m3HfwjIjmCfyXDDLcbhBGMcMgztAiwR1FIs5Nmd
	 +M+EwDS5V52G9wscX+wojQ74iW6SfFrx0Dmosb08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbgAXLC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:02:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732881AbgAXLC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:02:56 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FFA92071A;
        Fri, 24 Jan 2020 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863776;
        bh=fy19I0vOwJrBMY/7U50STJKg69HUaZHsyoy2OiGgDaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEHmf4CuRL04S0ayblWujW0V17KZxV97yKONUaPgfODO/shPobPdJyPoxwhOnVh6a
         FZsi5qAq22EnZp1SnscKq2pHkjkW10fzbmvfjkXKgV1htbMuEroQTw6x/TVmclAr4S
         8/m/AxAuQbMXcDA7kg8sHTZwHhXJznDDZc5TsJCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/639] net: always initialize pagedlen
Date:   Fri, 24 Jan 2020 10:24:02 +0100
Message-Id: <20200124093056.417796600@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit aba36930a35e7f1fe1319b203f25c05d6c119936 ]

In ip packet generation, pagedlen is initialized for each skb at the
start of the loop in __ip(6)_append_data, before label alloc_new_skb.

Depending on compiler options, code can be generated that jumps to
this label, triggering use of an an uninitialized variable.

In practice, at -O2, the generated code moves the initialization below
the label. But the code should not rely on that for correctness.

Fixes: 15e36f5b8e98 ("udp: paged allocation with gso")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_output.c  | 3 ++-
 net/ipv6/ip6_output.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index d63091812342f..fbf30122e8bf2 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -940,7 +940,7 @@ static int __ip_append_data(struct sock *sk,
 			unsigned int fraglen;
 			unsigned int fraggap;
 			unsigned int alloclen;
-			unsigned int pagedlen = 0;
+			unsigned int pagedlen;
 			struct sk_buff *skb_prev;
 alloc_new_skb:
 			skb_prev = skb;
@@ -957,6 +957,7 @@ alloc_new_skb:
 			if (datalen > mtu - fragheaderlen)
 				datalen = maxfraglen - fragheaderlen;
 			fraglen = datalen + fragheaderlen;
+			pagedlen = 0;
 
 			if ((flags & MSG_MORE) &&
 			    !(rt->dst.dev->features&NETIF_F_SG))
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index eed9231c90ad5..9886a84c25117 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1357,7 +1357,7 @@ emsgsize:
 			unsigned int fraglen;
 			unsigned int fraggap;
 			unsigned int alloclen;
-			unsigned int pagedlen = 0;
+			unsigned int pagedlen;
 alloc_new_skb:
 			/* There's no room in the current skb */
 			if (skb)
@@ -1381,6 +1381,7 @@ alloc_new_skb:
 			if (datalen > (cork->length <= mtu && !(cork->flags & IPCORK_ALLFRAG) ? mtu : maxfraglen) - fragheaderlen)
 				datalen = maxfraglen - fragheaderlen - rt->dst.trailer_len;
 			fraglen = datalen + fragheaderlen;
+			pagedlen = 0;
 
 			if ((flags & MSG_MORE) &&
 			    !(rt->dst.dev->features&NETIF_F_SG))
-- 
2.20.1



