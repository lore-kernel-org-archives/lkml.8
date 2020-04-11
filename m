Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15531C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D426020644
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586608135;
	bh=m6UpdZbBu/gB4E8paV2q3e5QitPKAE175Dg7yd/O5Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V83XrMcS6PrQjgSAGBNAdqnbLYHyL6waQKHQ49vRqooOb9lTzzMu/NWsQhaKy34mb
	 SW1/DYKhZPdGZFDhmcxwh4+yPbnsw6q62JhQIw/rXVYBlh2Y5kxnB4e9znN3NzKVjM
	 V76wXebBqwqiU08OU9bBNtYArZ3Ucc5AeZLAHSG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgDKM2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgDKMLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:11:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CEE420787;
        Sat, 11 Apr 2020 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607112;
        bh=m6UpdZbBu/gB4E8paV2q3e5QitPKAE175Dg7yd/O5Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0R31cTRFqwCpP4+ILJ+ibSIanBycKLc7h4WlNJsDZq1Xp9aIdy8F2FEt2qNUpliZX
         kMZWBt9pytXaCtQoAg5jbFAcVZOmXuFPYFxi+l2XuBIkvpsXTLqbqClXZNKXdqruDh
         voMTqj2D3ZO2sKoiU4HuNAG25XI2b+Vm+R1/guxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4.9 12/32] net: dsa: tag_brcm: Fix skb->fwd_offload_mark location
Date:   Sat, 11 Apr 2020 14:08:51 +0200
Message-Id: <20200411115419.981067370@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115418.455500023@linuxfoundation.org>
References: <20200411115418.455500023@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

When the backport of upstream commit
0e62f543bed03a64495bd2651d4fe1aa4bcb7fe5 ("net: dsa: Fix duplicate
frames flooded by learning") was done the assignment of
skb->fwd_offload_mark would land in brcm_tag_xmit() which is incorrect,
it should have been in brcm_tag_rcv().

Fixes: 5e845dc62f38 ("net: dsa: Fix duplicate frames flooded by learning")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/dsa/tag_brcm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -84,8 +84,6 @@ static struct sk_buff *brcm_tag_xmit(str
 		brcm_tag[2] = BRCM_IG_DSTMAP2_MASK;
 	brcm_tag[3] = (1 << p->port) & BRCM_IG_DSTMAP1_MASK;
 
-	skb->offload_fwd_mark = 1;
-
 	return skb;
 
 out_free:
@@ -148,6 +146,8 @@ static int brcm_tag_rcv(struct sk_buff *
 	skb->dev->stats.rx_packets++;
 	skb->dev->stats.rx_bytes += skb->len;
 
+	skb->offload_fwd_mark = 1;
+
 	netif_receive_skb(skb);
 
 	return 0;


