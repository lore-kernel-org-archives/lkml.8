Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CC9C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D18A214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858607;
	bh=s4GsLQ3Nay7jIeN2aeWUG5EVdhTwGoAYzbUUuzGRars=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OSeogSqZ5fCzd2Gi8MXrvjqEDJusBsv3YcPXZIbWOFbttbKkdVWDokPdRho955rAS
	 NywBVcDdFbfgiQINi+Pc7ed402DtppLHcIPdlp+ZWHzpVGXEOnjROu0FopaBUPrPa+
	 t4nYbCogg6mYcd2sWm8o6NYuve83s6UgC3YDGyLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgAXJgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:36:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgAXJgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:36:46 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C832087E;
        Fri, 24 Jan 2020 09:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858605;
        bh=s4GsLQ3Nay7jIeN2aeWUG5EVdhTwGoAYzbUUuzGRars=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xIQt1/P/sSfHGdJNXj5i8TE9ikNwLbeNHfic2K2I9aqVUU772to6v2nvE76XyH81E
         zomCrGTFYKxesNpV8IIyG9w21Rs6EYL+SMYh42xrFSSeqaPrJ6mJRORC3SK94JGXyl
         e7M/z+eUBDT6wVyJKqIG8QZ+4fogw/5Anql+g8fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 004/343] tipc: fix wrong timeout input for tipc_wait_for_cond()
Date:   Fri, 24 Jan 2020 10:27:02 +0100
Message-Id: <20200124092920.128807644@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tung Nguyen <tung.q.nguyen@dektech.com.au>

commit 12db3c8083fcab4270866a88191933f2d9f24f89 upstream.

In function __tipc_shutdown(), the timeout value passed to
tipc_wait_for_cond() is not jiffies.

This commit fixes it by converting that value from milliseconds
to jiffies.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Signed-off-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/socket.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -487,7 +487,7 @@ static void __tipc_shutdown(struct socke
 	struct sock *sk = sock->sk;
 	struct tipc_sock *tsk = tipc_sk(sk);
 	struct net *net = sock_net(sk);
-	long timeout = CONN_TIMEOUT_DEFAULT;
+	long timeout = msecs_to_jiffies(CONN_TIMEOUT_DEFAULT);
 	u32 dnode = tsk_peer_node(tsk);
 	struct sk_buff *skb;
 


