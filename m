Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326CFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03ABF206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584891;
	bh=8K0DiG5m3/Kac9wy/hVtWgjJWdFjzTJoSPEQSyGP45k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rg8ALj7t5Yj2Z7pmLToRoMWgDOxBrnzChn/Wlw3Ft3I3O7mOACEmq4bK6Bnxxy+OJ
	 um3lbbSjKWGp1t/0N0ExtP4jDc//RiYBPTRhQOdL4nnFBUyGOGnAg7B7upgUqFcwPi
	 SzgjSSDZx4yHG1T3gMr2CCeDCjdLko3S0HywFD1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbgFSQl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388653AbgFSOpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:45:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E0620A8B;
        Fri, 19 Jun 2020 14:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577907;
        bh=8K0DiG5m3/Kac9wy/hVtWgjJWdFjzTJoSPEQSyGP45k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXH5KRovbWMORMjiudY+ec7fIAnFmLCsiJLea3edysyPKSgHHKOO5dpCyUokckIcq
         Du81kK7h2NYYXh1UGlBBXK/miu5VgAmP9nNGY9loYdudQWls35DhrLCiGQFmcfpdbp
         3uqnw3CH5tLyWxBwvjS0JRkLEPP1gmQjlTfZ1NZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 001/190] ipv6: fix IPV6_ADDRFORM operation logic
Date:   Fri, 19 Jun 2020 16:30:46 +0200
Message-Id: <20200619141633.537399378@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 79a1f0ccdbb4ad700590f61b00525b390cb53905 ]

Socket option IPV6_ADDRFORM supports UDP/UDPLITE and TCP at present.
Previously the checking logic looks like:
if (sk->sk_protocol == IPPROTO_UDP || sk->sk_protocol == IPPROTO_UDPLITE)
	do_some_check;
else if (sk->sk_protocol != IPPROTO_TCP)
	break;

After commit b6f6118901d1 ("ipv6: restrict IPV6_ADDRFORM operation"), TCP
was blocked as the logic changed to:
if (sk->sk_protocol == IPPROTO_UDP || sk->sk_protocol == IPPROTO_UDPLITE)
	do_some_check;
else if (sk->sk_protocol == IPPROTO_TCP)
	do_some_check;
	break;
else
	break;

Then after commit 82c9ae440857 ("ipv6: fix restrict IPV6_ADDRFORM operation")
UDP/UDPLITE were blocked as the logic changed to:
if (sk->sk_protocol == IPPROTO_UDP || sk->sk_protocol == IPPROTO_UDPLITE)
	do_some_check;
if (sk->sk_protocol == IPPROTO_TCP)
	do_some_check;

if (sk->sk_protocol != IPPROTO_TCP)
	break;

Fix it by using Eric's code and simply remove the break in TCP check, which
looks like:
if (sk->sk_protocol == IPPROTO_UDP || sk->sk_protocol == IPPROTO_UDPLITE)
	do_some_check;
else if (sk->sk_protocol == IPPROTO_TCP)
	do_some_check;
else
	break;

Fixes: 82c9ae440857 ("ipv6: fix restrict IPV6_ADDRFORM operation")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ipv6_sockglue.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -185,14 +185,15 @@ static int do_ipv6_setsockopt(struct soc
 					retv = -EBUSY;
 					break;
 				}
-			}
-			if (sk->sk_protocol == IPPROTO_TCP &&
-			    sk->sk_prot != &tcpv6_prot) {
-				retv = -EBUSY;
+			} else if (sk->sk_protocol == IPPROTO_TCP) {
+				if (sk->sk_prot != &tcpv6_prot) {
+					retv = -EBUSY;
+					break;
+				}
+			} else {
 				break;
 			}
-			if (sk->sk_protocol != IPPROTO_TCP)
-				break;
+
 			if (sk->sk_state != TCP_ESTABLISHED) {
 				retv = -ENOTCONN;
 				break;


