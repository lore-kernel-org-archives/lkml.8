Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7735CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4598520842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341831;
	bh=MQME8RmHCXQ+80Jmqz/myZYOwRd/DK3J3t6F3j6xck8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GyAbjx6ut/xvkjLBqYFZNTcuu9fP1AFuVnmYPnxXcoVKYSZzdb8iTzSr3JJUehSxZ
	 q+A5jmmnOcPzD3gkX6H3YsSRIBcjfuYkThnKq/b17pvvpCobxK5IA9vkDR7PejziWF
	 k72uY+C2DvnR3Vujgl5KB4fBM+0fXt3vbtnbnuYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgBJNhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgBJMfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:04 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07EC720873;
        Mon, 10 Feb 2020 12:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338104;
        bh=MQME8RmHCXQ+80Jmqz/myZYOwRd/DK3J3t6F3j6xck8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cV3K10GI904h931KFoE+kPFvvP6jVEoAjEVAOBoku0v/NExeyWOWY9UbGiSGUn2j5
         9mnNq7u8Ea9VEpEKtIfg1gku0mXqhhptydh1UQnJ0uNGQjY/da+RnXHUeC6T5IiKSY
         87yi+ulKN93A4xGFNfPUYQLQBxiPtpcsAAvcFmIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4.19 023/195] rxrpc: Fix insufficient receive notification generation
Date:   Mon, 10 Feb 2020 04:31:21 -0800
Message-Id: <20200210122308.097972331@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
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
 net/rxrpc/input.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -612,10 +612,8 @@ ack:
 				  false, true,
 				  rxrpc_propose_ack_input_data);
 
-	if (sp->hdr.seq == READ_ONCE(call->rx_hard_ack) + 1) {
-		trace_rxrpc_notify_socket(call->debug_id, serial);
-		rxrpc_notify_socket(call);
-	}
+	trace_rxrpc_notify_socket(call->debug_id, serial);
+	rxrpc_notify_socket(call);
 
 unlock:
 	spin_unlock(&call->input_lock);


