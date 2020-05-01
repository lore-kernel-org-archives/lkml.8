Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A713C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6755620757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341566;
	bh=i+vswq2Sq0i46k/4EmnFtanhfLKPKz4eNWg/fl2UibM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K36UMBlKC1vb4fMEtKEbDDl4CjlAn3FL58LyUGIMQj2dEu77yy9VD1nRDDXWwgWK6
	 OTdRiO6pTVmtKVbbQWajj6ggU4DgrzwIKGXeRIq2BiAI0CGHePPxFRSZYA0CCAlS0A
	 QXk7Nr1iMbkNKn0xHvslKtvYSHFj7VB4es9A6hrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgEAN7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbgEAN3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:29:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 271DC24955;
        Fri,  1 May 2020 13:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339748;
        bh=i+vswq2Sq0i46k/4EmnFtanhfLKPKz4eNWg/fl2UibM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzRK8TrQ0WuFinT7FX4s2hLMO7Z2QE92EdecS7zQfq2tvLgT4hJNo+JWlAkEuzSQf
         jB8zZuWsltbQ7FJmp4nEwIIfLFWWqeHs4BsvHHyoJmKFi5TFXqOvAxfWDB4EQkuEY2
         0UsTu/+a7KA9sRtHXVte9p7SMjWSyc4Qf5YWuLME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Haxby <john.haxby@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 20/80] ipv6: fix restrict IPV6_ADDRFORM operation
Date:   Fri,  1 May 2020 15:21:14 +0200
Message-Id: <20200501131520.810371371@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Haxby <john.haxby@oracle.com>

[ Upstream commit 82c9ae440857840c56e05d4fb1427ee032531346 ]

Commit b6f6118901d1 ("ipv6: restrict IPV6_ADDRFORM operation") fixed a
problem found by syzbot an unfortunate logic error meant that it
also broke IPV6_ADDRFORM.

Rearrange the checks so that the earlier test is just one of the series
of checks made before moving the socket from IPv6 to IPv4.

Fixes: b6f6118901d1 ("ipv6: restrict IPV6_ADDRFORM operation")
Signed-off-by: John Haxby <john.haxby@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ipv6_sockglue.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -184,15 +184,14 @@ static int do_ipv6_setsockopt(struct soc
 					retv = -EBUSY;
 					break;
 				}
-			} else if (sk->sk_protocol == IPPROTO_TCP) {
-				if (sk->sk_prot != &tcpv6_prot) {
-					retv = -EBUSY;
-					break;
-				}
-				break;
-			} else {
+			}
+			if (sk->sk_protocol == IPPROTO_TCP &&
+			    sk->sk_prot != &tcpv6_prot) {
+				retv = -EBUSY;
 				break;
 			}
+			if (sk->sk_protocol != IPPROTO_TCP)
+				break;
 			if (sk->sk_state != TCP_ESTABLISHED) {
 				retv = -ENOTCONN;
 				break;


