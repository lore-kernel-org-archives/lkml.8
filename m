Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32774C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DBF20692
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607933;
	bh=WLjTGfAMIh/dxbygmZhyz+9HAKYXuj2WS8AFJSWjkck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Be5goNo+0wa/Y70wxxu+o3maKDCX2VqT9JsCotgezLcfU8R5ncYC3V8RtXkJ90B59
	 rq7MjuzP4EO4v/RhpUaJ31dlVuWdGgRijgBprHyM0bIOlk/LO2hwMhKIU/HHmBRwtE
	 xJ0S++DmidXf98a+I7uMX/sEmAlMwH/CBcALDL7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgDKMZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgDKMQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:16:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7085420692;
        Sat, 11 Apr 2020 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607399;
        bh=WLjTGfAMIh/dxbygmZhyz+9HAKYXuj2WS8AFJSWjkck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/CJL9xZErB6US2fSGzXl3U67ugv05eOfR7tEQdCtWN8Jfc9hqI0pGcMptWrveV1v
         IdKp5S/EBiiMt4YUTGN2yVhgoXybluv+MoUX+mBX7Z5QZkh9+NsZrVYvNxvRCwkkLs
         AQufKc4ERsCgdQ7dWVqPhUVZnfLIHbE9hZyJDfTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4.19 22/54] rxrpc: Fix sendmsg(MSG_WAITALL) handling
Date:   Sat, 11 Apr 2020 14:09:04 +0200
Message-Id: <20200411115510.720343132@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
References: <20200411115508.284500414@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 498b577660f08cef5d9e78e0ed6dcd4c0939e98c upstream.

Fix the handling of sendmsg() with MSG_WAITALL for userspace to round the
timeout for when a signal occurs up to at least two jiffies as a 1 jiffy
timeout may end up being effectively 0 if jiffies wraps at the wrong time.

Fixes: bc5e3a546d55 ("rxrpc: Use MSG_WAITALL to tell sendmsg() to temporarily ignore signals")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rxrpc/sendmsg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -62,8 +62,8 @@ static int rxrpc_wait_for_tx_window_noni
 
 	rtt = READ_ONCE(call->peer->rtt);
 	rtt2 = nsecs_to_jiffies64(rtt) * 2;
-	if (rtt2 < 1)
-		rtt2 = 1;
+	if (rtt2 < 2)
+		rtt2 = 2;
 
 	timeout = rtt2;
 	tx_start = READ_ONCE(call->tx_hard_ack);


