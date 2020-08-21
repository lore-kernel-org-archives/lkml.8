Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99711C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B46F2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bartavi.nl header.i=@bartavi.nl header.b="DU9mh1XJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bartavi.nl header.i=@bartavi.nl header.b="DU9mh1XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHUOct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUOcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:32:48 -0400
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Aug 2020 07:32:47 PDT
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFFC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:32:47 -0700 (PDT)
Received: from smtp.soverin.net (unknown [10.10.3.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id B364E600DF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:32:44 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [159.69.232.142]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bartavi.nl; s=soverin;
        t=1598020364; bh=d0d600mOuaRwk2pd+47jPHrWgSsBHwS+AdjY8auuIFg=;
        h=From:To:Cc:Subject:Date:From;
        b=DU9mh1XJfCzkIeIPZ/tDrqZYOiCUDn/IlEIS9+wx9R2UbcyBiriGizc0mLmB0Yb24
         lyQUATO0rV6bCAzidrNLcsOdsZAkWZk+lcuE++2kqot1JZE6BwH1BGMgl6CcnrXhcR
         42nhr2Elg9wZ7hLo7lV9fFMsgBCLqpeeH0BaBKVp8MzOUZSQdM4jwiW+vmm/fbbt5s
         HLuCp2uvcU8QDET3DDrKCt/MspFA/fX0Pj2CAwpEPQKXL7uh+MR8aGCzHKhylw2UWP
         DKkj2Mm7BiZ0kM2gjFIeS4NgqSOv97MnFVxMgyNEpDhXlI0Y5PVF8uHC4oh06ZA8yk
         2cbw8bfMCT0ag==
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bartavi.nl; s=soverin;
        t=1598020364; bh=d0d600mOuaRwk2pd+47jPHrWgSsBHwS+AdjY8auuIFg=;
        h=From:To:Cc:Subject:Date:From;
        b=DU9mh1XJfCzkIeIPZ/tDrqZYOiCUDn/IlEIS9+wx9R2UbcyBiriGizc0mLmB0Yb24
         lyQUATO0rV6bCAzidrNLcsOdsZAkWZk+lcuE++2kqot1JZE6BwH1BGMgl6CcnrXhcR
         42nhr2Elg9wZ7hLo7lV9fFMsgBCLqpeeH0BaBKVp8MzOUZSQdM4jwiW+vmm/fbbt5s
         HLuCp2uvcU8QDET3DDrKCt/MspFA/fX0Pj2CAwpEPQKXL7uh+MR8aGCzHKhylw2UWP
         DKkj2Mm7BiZ0kM2gjFIeS4NgqSOv97MnFVxMgyNEpDhXlI0Y5PVF8uHC4oh06ZA8yk
         2cbw8bfMCT0ag==
From:   Bart Groeneveld <avi@bartavi.nl>
To:     linux-kernel@vger.kernel.org
Cc:     Bart Groeneveld <avi@bartavi.nl>
Subject: [PATCH] net: Use standardized (IANA) local port range
Date:   Fri, 21 Aug 2020 16:32:41 +0200
Message-Id: <20200821143241.46798-1-avi@bartavi.nl>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IANA specifies User ports as 1024-49151,
and Private ports (local/ephemeral/dynamic/w/e) as 49152-65535 [1].

This means Linux uses 32768-49151 'illegally'.
This is not just a matter of following specifications:
IANA actually assigns numbers in this range [1].

I understand that Linux uses 61000-65535 for masquarading/NAT [2],
so I left the high value at 60999.
This means the high value still does not follow the specification,
but it also doesn't conflict with it.

This change will effectively halve the available ephemeral ports,
increasing the risk of port exhaustion. But:
a) I don't think that warrants ignoring standards.
	Consider for example setting up a (corporate) firewall blocking
	all unknown external services.
	It will only allow outgoing trafiic at port 80,443 and 49152-65535.
	A Linux computer behind such a firewall will not be able to connect
	to *any* external service *half of the time*.
	Of course, the firewall can be adjusted to also allow 32768-49151,
	but that allows computers to use some services against the policy.
b) It is only an issue with more than 11848 *outgoing* connections.
	I think that is a niche case (I know, citation needed, but still).
	If someone finds themselves in such a niche case,
	they can still modify ip_local_port_range.

This patch keeps the low and high value at different parity,
as to optimize port assignment [3].

[1]: https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.txt
[2]: https://marc.info/?l=linux-kernel&m=117900026927289
[3]: See for example commit 1580ab63fc9a03593072cc5656167a75c4f1d173

Signed-off-by: Bart Groeneveld <avi@bartavi.nl>
---
 Documentation/networking/ip-sysctl.rst | 4 ++--
 net/ipv4/af_inet.c                     | 2 +-
 net/ipv4/inet_connection_sock.c        | 2 +-
 net/ipv4/inet_hashtables.c             | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 837d51f9e1fa..5048b326f773 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1024,7 +1024,7 @@ ip_local_port_range - 2 INTEGERS
 	If possible, it is better these numbers have different parity
 	(one even and one odd value).
 	Must be greater than or equal to ip_unprivileged_port_start.
-	The default values are 32768 and 60999 respectively.
+	The default values are 49152 and 60999 respectively.
 
 ip_local_reserved_ports - list of comma separated ranges
 	Specify the ports which are reserved for known third-party
@@ -1047,7 +1047,7 @@ ip_local_reserved_ports - list of comma separated ranges
 	ip_local_port_range, e.g.::
 
 	    $ cat /proc/sys/net/ipv4/ip_local_port_range
-	    32000	60999
+	    49152	60999
 	    $ cat /proc/sys/net/ipv4/ip_local_reserved_ports
 	    8080,9148
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 4307503a6f0b..f95a9ffffdc9 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1838,7 +1838,7 @@ static __net_init int inet_init_net(struct net *net)
 	 * Set defaults for local port range
 	 */
 	seqlock_init(&net->ipv4.ip_local_ports.lock);
-	net->ipv4.ip_local_ports.range[0] =  32768;
+	net->ipv4.ip_local_ports.range[0] =  49152;
 	net->ipv4.ip_local_ports.range[1] =  60999;
 
 	seqlock_init(&net->ipv4.ping_group_range.lock);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index b457dd2d6c75..322bcfce0737 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -196,7 +196,7 @@ inet_csk_find_open_port(struct sock *sk, struct inet_bind_bucket **tb_ret, int *
 	attempt_half = (sk->sk_reuse == SK_CAN_REUSE) ? 1 : 0;
 other_half_scan:
 	inet_get_local_port_range(net, &low, &high);
-	high++; /* [32768, 60999] -> [32768, 61000[ */
+	high++; /* [49152, 60999] -> [49152, 61000[ */
 	if (high - low < 4)
 		attempt_half = 0;
 	if (attempt_half) {
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 239e54474b65..547b95a4891a 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -695,7 +695,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	l3mdev = inet_sk_bound_l3mdev(sk);
 
 	inet_get_local_port_range(net, &low, &high);
-	high++; /* [32768, 60999] -> [32768, 61000[ */
+	high++; /* [49152, 60999] -> [49152, 61000[ */
 	remaining = high - low;
 	if (likely(remaining > 1))
 		remaining &= ~1U;
-- 
2.28.0

