Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B46DC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ACD24670
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609634;
	bh=wRlQUgsCy4+MCKKHrC6POl2QDk1hXQxl+V6vpyY36C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UcNBwwI9kBirtCOzk32iRYpLzeOXRDQZx47Xnu65wR6cX6UDmTv4IEiNslEpw1e3T
	 yvP+7BC9nOmhU6dIMevQ5HG1DyaT3XcuoBGZg11ZfQ3eg4z9kKTe4zBAQJI2zBuVy9
	 4E84FLBjnmLN+t0jpCAfEK9Z6SgjdXydhrnDGavA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgBMPYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:24:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbgBMPX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:26 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D7A20848;
        Thu, 13 Feb 2020 15:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607405;
        bh=wRlQUgsCy4+MCKKHrC6POl2QDk1hXQxl+V6vpyY36C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJ6uQsaVvYyorUVH+TedbuPj9GXgCCfzRAdEAMyi8DL3UcaCQB1GLYWUpLaz0llK2
         MnQlUZiRQx9Wcz9JxLtzauI1fN/gRX1337STDzYGYCMQoHbZABuJDdDJfX44Tcehfw
         VKjpT58pRbUkIGEMtbwM7L8ylXYTwRr0Y1JzYpz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4.9 009/116] rxrpc: Fix insufficient receive notification generation
Date:   Thu, 13 Feb 2020 07:19:13 -0800
Message-Id: <20200213151846.347582601@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit f71dbf2fb28489a79bde0dca1c8adfb9cdb20a6b ]

In rxrpc_input_data(), rxrpc_notify_socket() is called if the base sequence
number of the packet is immediately following the hard-ack point at the end
of the function.  However, this isn't sufficient, since the recvmsg side
may have been advancing the window and then overrun the position in which
we're adding - at which point rx_hard_ack >= seq0 and no notification is
generated.

Fix this by always generating a notification at the end of the input
function.

Without this, a long call may stall, possibly indefinitely.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/input.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -582,8 +582,7 @@ ack:
 				  immediate_ack, true,
 				  rxrpc_propose_ack_input_data);
 
-	if (sp->hdr.seq == READ_ONCE(call->rx_hard_ack) + 1)
-		rxrpc_notify_socket(call);
+	rxrpc_notify_socket(call);
 	_leave(" [queued]");
 }
 


