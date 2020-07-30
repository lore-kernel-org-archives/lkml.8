Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0423DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD016206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096454;
	bh=jwBMaRCMCmIwWAsHBxvq7ha/QAOrmwnZ1+/LfzauMcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z+8BptIK8ooA07boDOJyrzhC7XBBnNXntFBvusumM6fPPrQUt4vLnOrYIM4Fi0epX
	 UtBycX9/5rn5tEFJrxz0ftWnY9goN2wIL6aaD3GIFm1du0PrtB5gDMOMxot+kGpGPE
	 f+giUQj7zaP4mrxkJvUJgObk4tqginjk6jHI9Om0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgG3IHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbgG3IHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:07:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B192074B;
        Thu, 30 Jul 2020 08:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096449;
        bh=jwBMaRCMCmIwWAsHBxvq7ha/QAOrmwnZ1+/LfzauMcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stdrkrZqFpAZd8OeqRusNAhujMjmUKaNbb+mHj8PWNjDDL2M5eJOTx1bmdl+ENU5T
         kg6mQARqYfj/Z2Ras31U9tk5A8XnNmxbgP9GBeTMTnkg2Mq8JpRQaAecxPKTEc13Lw
         DjDvtpdJNszxkLQnrS/6nk8f8qokbvok3CaTNJPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 13/17] sctp: shrink stream outq when fails to do addstream reconf
Date:   Thu, 30 Jul 2020 10:04:39 +0200
Message-Id: <20200730074421.111265800@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.449233408@linuxfoundation.org>
References: <20200730074420.449233408@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 3ecdda3e9ad837cf9cb41b6faa11b1af3a5abc0c ]

When adding a stream with stream reconf, the new stream firstly is in
CLOSED state but new out chunks can still be enqueued. Then once gets
the confirmation from the peer, the state will change to OPEN.

However, if the peer denies, it needs to roll back the stream. But when
doing that, it only sets the stream outcnt back, and the chunks already
in the new stream don't get purged. It caused these chunks can still be
dequeued in sctp_outq_dequeue_data().

As its stream is still in CLOSE, the chunk will be enqueued to the head
again by sctp_outq_head_data(). This chunk will never be sent out, and
the chunks after it can never be dequeued. The assoc will be 'hung' in
a dead loop of sending this chunk.

To fix it, this patch is to purge these chunks already in the new
stream by calling sctp_stream_shrink_out() when failing to do the
addstream reconf.

Fixes: 11ae76e67a17 ("sctp: implement receiver-side procedures for the Reconf Response Parameter")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -1143,11 +1143,13 @@ struct sctp_chunk *sctp_process_strreset
 		nums = ntohs(addstrm->number_of_streams);
 		number = stream->outcnt - nums;
 
-		if (result == SCTP_STRRESET_PERFORMED)
+		if (result == SCTP_STRRESET_PERFORMED) {
 			for (i = number; i < stream->outcnt; i++)
 				SCTP_SO(stream, i)->state = SCTP_STREAM_OPEN;
-		else
+		} else {
+			sctp_stream_shrink_out(stream, number);
 			stream->outcnt = number;
+		}
 
 		*evp = sctp_ulpevent_make_stream_change_event(asoc, flags,
 			0, nums, GFP_ATOMIC);


