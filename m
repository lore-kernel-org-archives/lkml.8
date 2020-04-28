Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C89EC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41AC9206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100426;
	bh=v3GYUqtp8+sowplhCo6rzwKJjhSa08ts/N40sdhUJTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wOT05NgESd6oGZ3YfjOk/8aHG6vwgN5OSNOmSTiNQ87SYzPhnWlZBNjXWUCNs1Mni
	 a1T/gMQNCAnXTValmxh9aDhMa0zKIESgbQhW/1s79jS9ihm5qRYLHnbbdnmXGkYglm
	 r3s8ghIo7sv+4yzxv2JzCFfc7LLfMw5bCKVq7zFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgD1S1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbgD1S1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:27:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134C620BED;
        Tue, 28 Apr 2020 18:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098456;
        bh=v3GYUqtp8+sowplhCo6rzwKJjhSa08ts/N40sdhUJTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6b+MisxYFg43NzJOScCA3y1tQGgGBhTT5j4OPq1LozwMM4VzEse1ow/WOYzOSp4o
         1ynL3SgW7iUuYzurlmyII71Yi+BtUvbBc/QzKONLPajGhoNHcRnp8ztt0FNKyKpj3N
         0cu6ZfOHGOAhMR94rJ4VDhNkus1TuYoEW12xUfgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Haxby <john.haxby@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 048/167] ipv6: fix restrict IPV6_ADDRFORM operation
Date:   Tue, 28 Apr 2020 20:23:44 +0200
Message-Id: <20200428182231.137312434@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
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
@@ -183,15 +183,14 @@ static int do_ipv6_setsockopt(struct soc
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


