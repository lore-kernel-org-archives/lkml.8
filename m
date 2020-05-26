Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94514C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A0520776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520545;
	bh=Oqu2yOvrwuOCvuThZiTy/2R+0TTTq6zMYRIblVN+r5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O7gVHG1SxfiE0XkcAUdWlnc6cutNpo1aMUJ/8rFQgQ52btSV/NpmnQJpIBAtUEg+2
	 yVkGbWbg48Wbx1tbaWU86xyt8jyYSzFuowjoPbIuWgkjPLCZLj9qMCYiEm1zn+zGIH
	 pkjJI4Vm4vvq19sNifHbc4UQ27lQnwyjA5RGQKDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392053AbgEZTPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392008AbgEZTPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:15:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB2120776;
        Tue, 26 May 2020 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520541;
        bh=Oqu2yOvrwuOCvuThZiTy/2R+0TTTq6zMYRIblVN+r5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NE+8B0KZoT/dlLad8bvpCw2f5eI2sIa8htJqhb1235g2xWPf/TwAmw6IYmNTeXapo
         8GUtBL5V/4ELrrcJ0OuJ3y1DJIGttukE/4fJlhySdnOlNEEBO0C9CxNpzmAyUl3UcV
         IL1/BbH8PIbAdi33vhfR0jIXA2/tAfpY9x8vB5rs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 121/126] rxrpc: Trace discarded ACKs
Date:   Tue, 26 May 2020 20:54:18 +0200
Message-Id: <20200526183947.534926009@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit d1f129470e6cb79b8b97fecd12689f6eb49e27fe ]

Add a tracepoint to track received ACKs that are discarded due to being
outside of the Tx window.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rxrpc.h | 35 +++++++++++++++++++++++++++++++++++
 net/rxrpc/input.c            | 12 ++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index ab75f261f04a..ba9efdc848f9 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1541,6 +1541,41 @@ TRACE_EVENT(rxrpc_notify_socket,
 		      __entry->serial)
 	    );
 
+TRACE_EVENT(rxrpc_rx_discard_ack,
+	    TP_PROTO(unsigned int debug_id, rxrpc_serial_t serial,
+		     rxrpc_seq_t first_soft_ack, rxrpc_seq_t call_ackr_first,
+		     rxrpc_seq_t prev_pkt, rxrpc_seq_t call_ackr_prev),
+
+	    TP_ARGS(debug_id, serial, first_soft_ack, call_ackr_first,
+		    prev_pkt, call_ackr_prev),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	debug_id	)
+		    __field(rxrpc_serial_t,	serial		)
+		    __field(rxrpc_seq_t,	first_soft_ack)
+		    __field(rxrpc_seq_t,	call_ackr_first)
+		    __field(rxrpc_seq_t,	prev_pkt)
+		    __field(rxrpc_seq_t,	call_ackr_prev)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->debug_id		= debug_id;
+		    __entry->serial		= serial;
+		    __entry->first_soft_ack	= first_soft_ack;
+		    __entry->call_ackr_first	= call_ackr_first;
+		    __entry->prev_pkt		= prev_pkt;
+		    __entry->call_ackr_prev	= call_ackr_prev;
+			   ),
+
+	    TP_printk("c=%08x r=%08x %08x<%08x %08x<%08x",
+		      __entry->debug_id,
+		      __entry->serial,
+		      __entry->first_soft_ack,
+		      __entry->call_ackr_first,
+		      __entry->prev_pkt,
+		      __entry->call_ackr_prev)
+	    );
+
 #endif /* _TRACE_RXRPC_H */
 
 /* This part must be outside protection */
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index e438bfd3fdf5..2f22f082a66c 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -866,8 +866,12 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 
 	/* Discard any out-of-order or duplicate ACKs (outside lock). */
 	if (before(first_soft_ack, call->ackr_first_seq) ||
-	    before(prev_pkt, call->ackr_prev_seq))
+	    before(prev_pkt, call->ackr_prev_seq)) {
+		trace_rxrpc_rx_discard_ack(call->debug_id, sp->hdr.serial,
+					   first_soft_ack, call->ackr_first_seq,
+					   prev_pkt, call->ackr_prev_seq);
 		return;
+	}
 
 	buf.info.rxMTU = 0;
 	ioffset = offset + nr_acks + 3;
@@ -879,8 +883,12 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 
 	/* Discard any out-of-order or duplicate ACKs (inside lock). */
 	if (before(first_soft_ack, call->ackr_first_seq) ||
-	    before(prev_pkt, call->ackr_prev_seq))
+	    before(prev_pkt, call->ackr_prev_seq)) {
+		trace_rxrpc_rx_discard_ack(call->debug_id, sp->hdr.serial,
+					   first_soft_ack, call->ackr_first_seq,
+					   prev_pkt, call->ackr_prev_seq);
 		goto out;
+	}
 	call->acks_latest_ts = skb->tstamp;
 
 	call->ackr_first_seq = first_soft_ack;
-- 
2.25.1



