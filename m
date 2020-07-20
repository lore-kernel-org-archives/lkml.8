Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C365C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1968D206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262164;
	bh=BAHvuzmUSWgb9bEsiSimhaySGZnh8Lb7efwhtBK/DKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kNL1j+Nepv5pwVapsmGcm+ZZHcQah9UvHgaETco0Is7C5a4OKZh9dXEKAkksu5Wkb
	 hqKgha9f6FnMFruPVo7g+ycOXAq2BG7kcPa0XKAjqt7imKOgT0OWd0PmwAOGQ2lh8T
	 UIU0AKzhYFgcoiZR2iyX6QCRuo2qI4BnxHEn63hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbgGTQWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732789AbgGTQGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:06:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CAD920672;
        Mon, 20 Jul 2020 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261173;
        bh=BAHvuzmUSWgb9bEsiSimhaySGZnh8Lb7efwhtBK/DKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZK+WlSfanQ3FzO8KuJiNc12PmIq5ccZhtNWvSwL++tB9LnlNVlcxYPMaa3NHJYOk
         215nZVSNBTP2IKR6TxoA3F/NGr7uWU1HtGLSukWlqZMsfpi8CJG1p3/BlDysqn39Hu
         H9SP33JEyMI3M8pxeYPp3MMSRUrSJpZ89esP054E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 020/244] tcp: md5: allow changing MD5 keys in all socket states
Date:   Mon, 20 Jul 2020 17:34:51 +0200
Message-Id: <20200720152826.833934777@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1ca0fafd73c5268e8fc4b997094b8bb2bfe8deea ]

This essentially reverts commit 721230326891 ("tcp: md5: reject TCP_MD5SIG
or TCP_MD5SIG_EXT on established sockets")

Mathieu reported that many vendors BGP implementations can
actually switch TCP MD5 on established flows.

Quoting Mathieu :
   Here is a list of a few network vendors along with their behavior
   with respect to TCP MD5:

   - Cisco: Allows for password to be changed, but within the hold-down
     timer (~180 seconds).
   - Juniper: When password is initially set on active connection it will
     reset, but after that any subsequent password changes no network
     resets.
   - Nokia: No notes on if they flap the tcp connection or not.
   - Ericsson/RedBack: Allows for 2 password (old/new) to co-exist until
     both sides are ok with new passwords.
   - Meta-Switch: Expects the password to be set before a connection is
     attempted, but no further info on whether they reset the TCP
     connection on a change.
   - Avaya: Disable the neighbor, then set password, then re-enable.
   - Zebos: Would normally allow the change when socket connected.

We can revert my prior change because commit 9424e2e7ad93 ("tcp: md5: fix potential
overestimation of TCP option space") removed the leak of 4 kernel bytes to
the wire that was the main reason for my patch.

While doing my investigations, I found a bug when a MD5 key is changed, leading
to these commits that stable teams want to consider before backporting this revert :

 Commit 6a2febec338d ("tcp: md5: add missing memory barriers in tcp_md5_do_add()/tcp_md5_hash_key()")
 Commit e6ced831ef11 ("tcp: md5: refine tcp_md5_do_add()/tcp_md5_hash_key() barriers")

Fixes: 721230326891 "tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets"
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3093,10 +3093,7 @@ static int do_tcp_setsockopt(struct sock
 #ifdef CONFIG_TCP_MD5SIG
 	case TCP_MD5SIG:
 	case TCP_MD5SIG_EXT:
-		if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
-			err = tp->af_specific->md5_parse(sk, optname, optval, optlen);
-		else
-			err = -EINVAL;
+		err = tp->af_specific->md5_parse(sk, optname, optval, optlen);
 		break;
 #endif
 	case TCP_USER_TIMEOUT:


