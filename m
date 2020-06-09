Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FD92067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726726;
	bh=FqvRd8mOZagwPH3YzoQJ04VsMlcPF40sFUnUv+c4Hg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GUfVMeUNVHSMWMl1QCVC0uVqXLcZbC6umX2+ZXcDYeJlsY/mQt6UqhG59F29ICGMV
	 6g+cEsJm0nzd24fuTDTtLg0q3QQqLjTqD/yze3lsIRGhOJKPYP35G5fppKeaxPkMJX
	 J54wZiANe5aWF78I3c8nbYWsJ36U89wkOb6cJw8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbgFIRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732559AbgFIRtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:49:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD7CA20814;
        Tue,  9 Jun 2020 17:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724985;
        bh=FqvRd8mOZagwPH3YzoQJ04VsMlcPF40sFUnUv+c4Hg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzPsVaswd8gr7RW1a0Td864t+ga+N8vS2IwQh3Pf2rQFYx8Kn9ZrBvtaUPsEJAwZv
         CVZPcJOaFAa/68SGgncDrb+RGJ3IJMlmN0Jurq6GiAjPqevblKXll7cPbFzCyco9e3
         OPnXAuEXhC2C9HHwKcuSlk3REAJ8hrcngTNqSV1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?David=20Bala=C5=BEic?= <xerces9@gmail.com>,
        Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/46] pppoe: only process PADT targeted at local interfaces
Date:   Tue,  9 Jun 2020 19:44:22 +0200
Message-Id: <20200609174023.446194633@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
References: <20200609174022.938987501@linuxfoundation.org>
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
 drivers/net/ppp/pppoe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index fa7121dcab67..202a0f415e1e 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -497,6 +497,9 @@ static int pppoe_disc_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!skb)
 		goto out;
 
+	if (skb->pkt_type != PACKET_HOST)
+		goto abort;
+
 	if (!pskb_may_pull(skb, sizeof(struct pppoe_hdr)))
 		goto abort;
 
-- 
2.25.1



