Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CFDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5300C2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924376;
	bh=qrdaKOIVavS/UpsqEh0jTdT1tTtGvj0c6xdHIGU2Kmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gK/at7c6juyvk6O1E7VxdiksCX3iKBKQmvBoaH7ZsGAcGY0Qa3DGx+FvuaFM8cbqw
	 Q+VtP/Z5VwDQrysKGVSz17veSRzqlmfgihO8VA9pN7aaUoRPHJ+30RcUadmh9b1JMa
	 gKa9jgjEfmPS86VAgMtzVpOQVghZ7C4KE70MSXSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgHTLwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730567AbgHTKCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:02:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1745D22BEF;
        Thu, 20 Aug 2020 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917768;
        bh=qrdaKOIVavS/UpsqEh0jTdT1tTtGvj0c6xdHIGU2Kmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fTGqHqGC1kJrcIopdVL/vpc51mfMJqTNuB7tLQZslX2OUqMuDEU7fjiICuRpR3Qz
         NQzXHGLbyigIYIOiwP1Svx4HWqd3ADqkVH0pgk2FmNAhB1GZIvb+wCg4RBMOlMVjK4
         zAipVpdQb9IzsyKVvywauGtx404ySaMk5m5Lxf98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qingyu Li <ieatmuttonchuan@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 151/212] net/nfc/rawsock.c: add CAP_NET_RAW check.
Date:   Thu, 20 Aug 2020 11:22:04 +0200
Message-Id: <20200820091610.039789422@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qingyu Li <ieatmuttonchuan@gmail.com>

[ Upstream commit 26896f01467a28651f7a536143fe5ac8449d4041 ]

When creating a raw AF_NFC socket, CAP_NET_RAW needs to be checked first.

Signed-off-by: Qingyu Li <ieatmuttonchuan@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/rawsock.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -344,10 +344,13 @@ static int rawsock_create(struct net *ne
 	if ((sock->type != SOCK_SEQPACKET) && (sock->type != SOCK_RAW))
 		return -ESOCKTNOSUPPORT;
 
-	if (sock->type == SOCK_RAW)
+	if (sock->type == SOCK_RAW) {
+		if (!capable(CAP_NET_RAW))
+			return -EPERM;
 		sock->ops = &rawsock_raw_ops;
-	else
+	} else {
 		sock->ops = &rawsock_ops;
+	}
 
 	sk = sk_alloc(net, PF_NFC, GFP_ATOMIC, nfc_proto->proto, kern);
 	if (!sk)


