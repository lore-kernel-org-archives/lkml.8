Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8EFC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080E120848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737941;
	bh=xbjLjqMsyS/r2kCZ+WdQUsx0A7curaXmnYmXfRrP0C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MhxcPZ739DgKThMeF7nD/Tr5GTvzcDBe69z57gdbsUVU1jMbLRRMrnBQHWaRcd7zB
	 Ea9wQb3/iFyhxF3UvRhyk4ZdEnktnvkWDvFuNSpj6uhPU1h7kpx7UFzhtPYzNHDoOV
	 Sp3pvBgG64nvYDVgYbe8VooWj5xSpDeza9Qhl/Ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgAKKS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:18:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbgAKKS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:18:58 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD6520848;
        Sat, 11 Jan 2020 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737938;
        bh=xbjLjqMsyS/r2kCZ+WdQUsx0A7curaXmnYmXfRrP0C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ySk7VGCzP7/J+Sh+qj+03uTopM8vmo32fzoXuqHL1f3gndAj87EfocZY4J6VaGLz9
         KpfMgcfGdY954o0L6dxNncQt+b19Dob4buJGjlwIy0FYPBjGJ3E6lcctfTxeKnuwZi
         gaZ7G0q89+xrybfICz+RCVUm348os9iSDjzVUAuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pengcheng Yang <yangpc@wangsu.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 75/84] tcp: fix "old stuff" D-SACK causing SACK to be treated as D-SACK
Date:   Sat, 11 Jan 2020 10:50:52 +0100
Message-Id: <20200111094912.008450153@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pengcheng Yang <yangpc@wangsu.com>

[ Upstream commit c9655008e7845bcfdaac10a1ed8554ec167aea88 ]

When we receive a D-SACK, where the sequence number satisfies:
	undo_marker <= start_seq < end_seq <= prior_snd_una
we consider this is a valid D-SACK and tcp_is_sackblock_valid()
returns true, then this D-SACK is discarded as "old stuff",
but the variable first_sack_index is not marked as negative
in tcp_sacktag_write_queue().

If this D-SACK also carries a SACK that needs to be processed
(for example, the previous SACK segment was lost), this SACK
will be treated as a D-SACK in the following processing of
tcp_sacktag_write_queue(), which will eventually lead to
incorrect updates of undo_retrans and reordering.

Fixes: fd6dad616d4f ("[TCP]: Earlier SACK block verification & simplify access to them")
Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1716,8 +1716,11 @@ tcp_sacktag_write_queue(struct sock *sk,
 		}
 
 		/* Ignore very old stuff early */
-		if (!after(sp[used_sacks].end_seq, prior_snd_una))
+		if (!after(sp[used_sacks].end_seq, prior_snd_una)) {
+			if (i == 0)
+				first_sack_index = -1;
 			continue;
+		}
 
 		used_sacks++;
 	}


