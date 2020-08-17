Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91074C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0EB2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597687623;
	bh=3N8MtWemgelhVh//K1SS5aIJzLRX7vaaoNR0NvUqAYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ujaoS18Z0+k9TqoJEwUJX1vut+P/vGZN6ESanKPYwvVQmOz0vtvrqZE/WLAFtGz6
	 VtMiGATW0+Mj+9oDQr9H+a0QXKIkMQcSwyFdbRPJ2XIyauIqjX7TN5eMO7Al9HlJ5q
	 AEsJxKMTmMP26DqxJDcfyP9YrtpVyjxPDCi/bnko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390323AbgHQSHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388338AbgHQQIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:08:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7A222BF3;
        Mon, 17 Aug 2020 16:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680523;
        bh=3N8MtWemgelhVh//K1SS5aIJzLRX7vaaoNR0NvUqAYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibLacF0V6FkoDuN3zII+XXcodIktx5gNMRQO1gTHfwgEHMxaDfyFo6x+0+EKDDa+Y
         FTFHSZjk38P/74sk0wfI3aPKvPyS40KaArYie/g1kohzYxWKID4COqlQ0+8wzvA9ff
         G6sqjazdvtMZEK0kGgedWeS4vPnLoucFTHzeQK04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qingyu Li <ieatmuttonchuan@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 220/270] net/nfc/rawsock.c: add CAP_NET_RAW check.
Date:   Mon, 17 Aug 2020 17:17:01 +0200
Message-Id: <20200817143806.734423500@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
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
@@ -332,10 +332,13 @@ static int rawsock_create(struct net *ne
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


