Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1492067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726997;
	bh=uxgkLmEM+qRpdRQoAjDFTn3eJyZ9H2fvH5ojL6T9T60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yXDGhLABHCfqtNXZIq4EKiNQkT22nNMZRiSs2GKnmhYiupw1yg4JN4UmGTDWK+0lc
	 ka3YDU4XZGX7Wbxc/yHgID9mn8zFSqUorzrlhziVAvhfWc5ZfY8xRaHQSH704xjhFn
	 R9VvzF5XejzKsXC9bwEx/q+OZ28riYRlhfqbG1Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgFIRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732061AbgFIRrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:47:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0D6207F9;
        Tue,  9 Jun 2020 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724840;
        bh=uxgkLmEM+qRpdRQoAjDFTn3eJyZ9H2fvH5ojL6T9T60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMesLuVscIlxMrGCM4cUiH3H70+KmQIqJ6g019syGzvn+MkygQ5FxRQJa7tuQxb3O
         SFqs0Z9hbAT0p8tQTtVSX2DN5FcVfLtn/VIFMPLNKzbA1a7bRqWiRP9vxa5zRnLAqI
         vwwjDHIoH8b5MjIlyB4MsyHMl/8BC7RR4JlSXaN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?David=20Bala=C5=BEic?= <xerces9@gmail.com>,
        Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 14/36] pppoe: only process PADT targeted at local interfaces
Date:   Tue,  9 Jun 2020 19:44:14 +0200
Message-Id: <20200609173934.094297589@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609173933.288044334@linuxfoundation.org>
References: <20200609173933.288044334@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Nault <gnault@redhat.com>

We don't want to disconnect a session because of a stray PADT arriving
while the interface is in promiscuous mode.
Furthermore, multicast and broadcast packets make no sense here, so
only PACKET_HOST is accepted.

Reported-by: David Balažic <xerces9@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ppp/pppoe.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -494,6 +494,9 @@ static int pppoe_disc_rcv(struct sk_buff
 	if (!skb)
 		goto out;
 
+	if (skb->pkt_type != PACKET_HOST)
+		goto abort;
+
 	if (!pskb_may_pull(skb, sizeof(struct pppoe_hdr)))
 		goto abort;
 


