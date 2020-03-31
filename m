Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA28C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552F72072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645932;
	bh=gD6t3oz/Bnkm3v+I+eFaQsz569OQ/YgUwl2kZxVodm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z2jOv5yyennqROXwDwzKhlwJ1jJHroSASM1JUrw+FskBk4kbuBjeDX+GI/0LVDlio
	 aGmb+eFOasEH28AlHJghN2VFIVdh1ReGoK6JFI9W+LWXawcseY5PE5R3pNjCMpqyXW
	 9ow4AyGKZiTFW28D7qBhOfsY9Me1b8EifvtDc2jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbgCaJML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730642AbgCaJMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:12:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A188320772;
        Tue, 31 Mar 2020 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645926;
        bh=gD6t3oz/Bnkm3v+I+eFaQsz569OQ/YgUwl2kZxVodm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4IPg2i3F57UDtJnYaNuN9Kj/Mhg59s4n3YoXWC9+wP4YFjdDaxA8x42x5pEfvktX
         fo3Sj/8JjvEWv3lDVL7eAB10tfEMjnVTJgUVhRS4a8c8CJJEDTbAW12IIWAKh4urp/
         IrQ2rdLTemYeL6n+GYfpxwLchbRkxHKzANoiaLHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 035/155] tcp: also NULL skb->dev when copy was needed
Date:   Tue, 31 Mar 2020 10:57:55 +0200
Message-Id: <20200331085422.335257079@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 07f8e4d0fddbf2f87e4cefb551278abc38db8cdd ]

In rare cases retransmit logic will make a full skb copy, which will not
trigger the zeroing added in recent change
b738a185beaa ("tcp: ensure skb->dev is NULL before leaving TCP stack").

Cc: Eric Dumazet <edumazet@google.com>
Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
Fixes: 28f8bfd1ac94 ("netfilter: Support iif matches in POSTROUTING")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2976,8 +2976,12 @@ int __tcp_retransmit_skb(struct sock *sk
 
 		tcp_skb_tsorted_save(skb) {
 			nskb = __pskb_copy(skb, MAX_TCP_HEADER, GFP_ATOMIC);
-			err = nskb ? tcp_transmit_skb(sk, nskb, 0, GFP_ATOMIC) :
-				     -ENOBUFS;
+			if (nskb) {
+				nskb->dev = NULL;
+				err = tcp_transmit_skb(sk, nskb, 0, GFP_ATOMIC);
+			} else {
+				err = -ENOBUFS;
+			}
 		} tcp_skb_tsorted_restore(skb);
 
 		if (!err) {


