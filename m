Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24661C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CE220672
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096352;
	bh=nYYmCu2mzdlYsCUJMvY9cAUvH+NJHt5B/5k3hEAHv8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ICmQMz3FKsP8S5/WiwlYXI2Ljr6CGmNPGbc171hMvhVZoOIM2M0UrPGQA8jD6DOvN
	 fjJe9LfUoRC/MWYxyyJyfhWEsr5nk7m/xJC6Mh1yAlQirj+ncfT6l7UNzVwwYnahaG
	 yDpkFgoJTw540IDdRwa+G9k7YC+DiQlRgFEbTYl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgG3IFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbgG3IFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:05:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6488620656;
        Thu, 30 Jul 2020 08:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096345;
        bh=nYYmCu2mzdlYsCUJMvY9cAUvH+NJHt5B/5k3hEAHv8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FibWHKAjGnFzrFPktl4isB/AuA/ODGAtpgJqqX8EDPCNJYSLhon304Vv0I62oQVY4
         TolPRxDhjkzisD5+ojCaiLwZRayIhzK523AJR+yboLmhscV1Ul9NkxzRieLJc87w30
         3p40Oylelb2eYmXFOLOLeWVNMOQKWPGU/DPEC0a0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 13/19] sctp: shrink stream outq only when new outcnt < old outcnt
Date:   Thu, 30 Jul 2020 10:04:15 +0200
Message-Id: <20200730074421.165264942@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.502923740@linuxfoundation.org>
References: <20200730074420.502923740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 8f13399db22f909a35735bf8ae2f932e0c8f0e30 ]

It's not necessary to go list_for_each for outq->out_chunk_list
when new outcnt >= old outcnt, as no chunk with higher sid than
new (outcnt - 1) exists in the outqueue.

While at it, also move the list_for_each code in a new function
sctp_stream_shrink_out(), which will be used in the next patch.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -22,17 +22,11 @@
 #include <net/sctp/sm.h>
 #include <net/sctp/stream_sched.h>
 
-/* Migrates chunks from stream queues to new stream queues if needed,
- * but not across associations. Also, removes those chunks to streams
- * higher than the new max.
- */
-static void sctp_stream_outq_migrate(struct sctp_stream *stream,
-				     struct sctp_stream *new, __u16 outcnt)
+static void sctp_stream_shrink_out(struct sctp_stream *stream, __u16 outcnt)
 {
 	struct sctp_association *asoc;
 	struct sctp_chunk *ch, *temp;
 	struct sctp_outq *outq;
-	int i;
 
 	asoc = container_of(stream, struct sctp_association, stream);
 	outq = &asoc->outqueue;
@@ -56,6 +50,19 @@ static void sctp_stream_outq_migrate(str
 
 		sctp_chunk_free(ch);
 	}
+}
+
+/* Migrates chunks from stream queues to new stream queues if needed,
+ * but not across associations. Also, removes those chunks to streams
+ * higher than the new max.
+ */
+static void sctp_stream_outq_migrate(struct sctp_stream *stream,
+				     struct sctp_stream *new, __u16 outcnt)
+{
+	int i;
+
+	if (stream->outcnt > outcnt)
+		sctp_stream_shrink_out(stream, outcnt);
 
 	if (new) {
 		/* Here we actually move the old ext stuff into the new


