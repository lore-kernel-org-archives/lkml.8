Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B02C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AE020784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585760162;
	bh=DfNGjTiudtEt3OA0uTaA0pmUfogkjBLImsS9OuaHvYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=izpXfv4ni7pRBduDNjEaw3m6IHQn5c+POWwZ8XRySU4ZzD+D1Qb4kqbxh3bKHv+8l
	 f7VSnZ5BOUrPa7cyK4YEPuyuVcvOMeAREtnqf6Pdfwl341Jb55OHWFIbemxd3uvc0i
	 Ylbq3s5Le0njyGKwJ64MYmf08bFbBLlI2W1uWANc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbgDAQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733222AbgDAQXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:23:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D53214D8;
        Wed,  1 Apr 2020 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758189;
        bh=DfNGjTiudtEt3OA0uTaA0pmUfogkjBLImsS9OuaHvYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hnu8/hBMigqp0LODp1Hk5DZgEx7ZoybltqXVcaupwGB/3uJUikiwxu9koDzWxdruY
         9U7+9xJt/O6yKNzUlXhfBSRH1RHFBcNtiGatTpvs0pVoDTMqDHISr8wnWFDL5ShFkN
         UNPlI8kKUwk0us6pG644FA4dPW1x9ofnz6Zfc170=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 012/116] net: dsa: Fix duplicate frames flooded by learning
Date:   Wed,  1 Apr 2020 18:16:28 +0200
Message-Id: <20200401161543.661131044@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 0e62f543bed03a64495bd2651d4fe1aa4bcb7fe5 ]

When both the switch and the bridge are learning about new addresses,
switch ports attached to the bridge would see duplicate ARP frames
because both entities would attempt to send them.

Fixes: 5037d532b83d ("net: dsa: add Broadcom tag RX/TX handler")
Reported-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/tag_brcm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -141,6 +141,8 @@ static struct sk_buff *brcm_tag_rcv_ll(s
 	/* Remove Broadcom tag and update checksum */
 	skb_pull_rcsum(skb, BRCM_TAG_LEN);
 
+	skb->offload_fwd_mark = 1;
+
 	return skb;
 }
 


