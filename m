Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB918C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FA92087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443509;
	bh=lHjVCNb+Y24qQJ+20TP7JRBp6qoTPqc/m8f2Ri154yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OsYyiaZPf6Jnfo874IuNH22sl+vYq+zIu/hWVDLBqjXs9MEeYZ5R4dsWfT3VhW1/m
	 kU9rJu/wR32EZDVWpVtTdNJ6UScG7DsFKB6DMqEVWrKLXRYUautWGHOlvWZJRTv9HR
	 keWWltvysDrTw1VWi7x5vGbwj/WWwPsJ3Pt0EZeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgHZME6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbgHZMDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340C420897;
        Wed, 26 Aug 2020 12:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443426;
        bh=lHjVCNb+Y24qQJ+20TP7JRBp6qoTPqc/m8f2Ri154yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drr4RbRU0aCN/vSLebOaVPUJV0DcJSFuWT3ge1fLmr0euxeGPpHWmu1YbY7xPPYjd
         QEqVAqXADeHiBhGxJxIYl1o/7RQOrIng4TecQjZJGPyy27G6x4ymSzOICHC2qiB76H
         oKrRrjXbfdAyaS5RLbsKcEK6hfe2ERemF0Weh0wU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Laight <david.laight@aculab.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 06/16] net: sctp: Fix negotiation of the number of data streams.
Date:   Wed, 26 Aug 2020 14:02:43 +0200
Message-Id: <20200826114911.533728228@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114911.216745274@linuxfoundation.org>
References: <20200826114911.216745274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit ab921f3cdbec01c68705a7ade8bec628d541fc2b ]

The number of output and input streams was never being reduced, eg when
processing received INIT or INIT_ACK chunks.
The effect is that DATA chunks can be sent with invalid stream ids
and then discarded by the remote system.

Fixes: 2075e50caf5ea ("sctp: convert to genradix")
Signed-off-by: David Laight <david.laight@aculab.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -88,12 +88,13 @@ static int sctp_stream_alloc_out(struct
 	int ret;
 
 	if (outcnt <= stream->outcnt)
-		return 0;
+		goto out;
 
 	ret = genradix_prealloc(&stream->out, outcnt, gfp);
 	if (ret)
 		return ret;
 
+out:
 	stream->outcnt = outcnt;
 	return 0;
 }
@@ -104,12 +105,13 @@ static int sctp_stream_alloc_in(struct s
 	int ret;
 
 	if (incnt <= stream->incnt)
-		return 0;
+		goto out;
 
 	ret = genradix_prealloc(&stream->in, incnt, gfp);
 	if (ret)
 		return ret;
 
+out:
 	stream->incnt = incnt;
 	return 0;
 }


