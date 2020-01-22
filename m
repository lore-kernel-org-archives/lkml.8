Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97370C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655312468C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699391;
	bh=Ty9RH+RLqMXgUyZ5xZoWxctM3JahlJeZFqmLUuI2JFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WGYUZHpiHUJ1qmFEUF/kyeJyuEulki3y7T6Z+aRpsd6qFfooUh6gZ2VSy88JyhPRW
	 8vC7MszI6DDJLv+cbQib2UhWD7D4d4atQkqRaO63IrYYY8qtubunXiqzDS5HgwoRqC
	 h0B9kOQRepqu9JpRHwD7soyUdX2elYIo7iTZFYdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgAVNXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbgAVNXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:07 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA472205F4;
        Wed, 22 Jan 2020 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699386;
        bh=Ty9RH+RLqMXgUyZ5xZoWxctM3JahlJeZFqmLUuI2JFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2vcqi8P2uaK3X3G+Rw/mqI3GXfrHZrLKPROK/dHL+r27VDTUhJCaH/XLjcvBTAio
         QQs9FhHMP/9+SAsrG4QDy1pVchcRPWwaVDsnvpWoETZrmvsZvTjvCZuzhaJuCq1Ymk
         DHHe7vBMf7S1fUSFKDDhYkVts6oYN7ILWFxr0a2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 5.4 111/222] bpf: Sockmap, skmsg helper overestimates push, pull, and pop bounds
Date:   Wed, 22 Jan 2020 10:28:17 +0100
Message-Id: <20200122092841.682573648@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

commit 6562e29cf6f0ddd368657d97a8d484ffc30df5ef upstream.

In the push, pull, and pop helpers operating on skmsg objects to make
data writable or insert/remove data we use this bounds check to ensure
specified data is valid,

 /* Bounds checks: start and pop must be inside message */
 if (start >= offset + l || last >= msg->sg.size)
     return -EINVAL;

The problem here is offset has already included the length of the
current element the 'l' above. So start could be past the end of
the scatterlist element in the case where start also points into an
offset on the last skmsg element.

To fix do the accounting slightly different by adding the length of
the previous entry to offset at the start of the iteration. And
ensure its initialized to zero so that the first iteration does
nothing.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
Fixes: 7246d8ed4dcce ("bpf: helper to pop data from messages")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/20200111061206.8028-5-john.fastabend@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/filter.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2231,10 +2231,10 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_
 	/* First find the starting scatterlist element */
 	i = msg->sg.start;
 	do {
+		offset += len;
 		len = sk_msg_elem(msg, i)->length;
 		if (start < offset + len)
 			break;
-		offset += len;
 		sk_msg_iter_var_next(i);
 	} while (i != msg->sg.end);
 
@@ -2346,7 +2346,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_
 	   u32, len, u64, flags)
 {
 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
-	u32 new, i = 0, l, space, copy = 0, offset = 0;
+	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
 	u8 *raw, *to, *from;
 	struct page *page;
 
@@ -2356,11 +2356,11 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_
 	/* First find the starting scatterlist element */
 	i = msg->sg.start;
 	do {
+		offset += l;
 		l = sk_msg_elem(msg, i)->length;
 
 		if (start < offset + l)
 			break;
-		offset += l;
 		sk_msg_iter_var_next(i);
 	} while (i != msg->sg.end);
 
@@ -2506,7 +2506,7 @@ static void sk_msg_shift_right(struct sk
 BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	   u32, len, u64, flags)
 {
-	u32 i = 0, l, space, offset = 0;
+	u32 i = 0, l = 0, space, offset = 0;
 	u64 last = start + len;
 	int pop;
 
@@ -2516,11 +2516,11 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_m
 	/* First find the starting scatterlist element */
 	i = msg->sg.start;
 	do {
+		offset += l;
 		l = sk_msg_elem(msg, i)->length;
 
 		if (start < offset + l)
 			break;
-		offset += l;
 		sk_msg_iter_var_next(i);
 	} while (i != msg->sg.end);
 


