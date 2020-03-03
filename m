Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF3FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687C20656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258146;
	bh=jPbait31Nq3x3jUTF6nn8BsKvJQzlHCmTaDNjuBZ8jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tEtSS/dGNDWiOuCRUjeZUaNwwgNWqqCTQTJqeQBl/UvPlRx27oorQx1mY75Fle91U
	 RIlpjdYZoGKx9lb8G/+zIpMNTL0aznPUmNdk1ICzGny2i6Zrq3mfPzDsh7YCvsjmfk
	 BItHRx6K4Y+1MEMcV4c6pagFAQbvcb3cYB+wjHsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbgCCRzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:55:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732755AbgCCRzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:55:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55BB2072D;
        Tue,  3 Mar 2020 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258142;
        bh=jPbait31Nq3x3jUTF6nn8BsKvJQzlHCmTaDNjuBZ8jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJvvYR8RDJcwW14gGoKLm6s7zjNdINcNJoJdvStlrsEWm2kmgkEXBThLZKTkyPrK8
         b9JyyorJjI9ClITJdkIfBqey+dnHlfvV0MHfhm08h15HULd9XZlIxCWUKXnV3fP2Zr
         o+RrMnkiKRow9mzcXZfm0oFHDub8YJuVVtj2TOoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 086/152] io_uring: fix 32-bit compatability with sendmsg/recvmsg
Date:   Tue,  3 Mar 2020 18:43:04 +0100
Message-Id: <20200303174312.327597911@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit d876836204897b6d7d911f942084f69a1e9d5c4d upstream.

We must set MSG_CMSG_COMPAT if we're in compatability mode, otherwise
the iovec import for these commands will not do the right thing and fail
the command with -EINVAL.

Found by running the test suite compiled as 32-bit.

Cc: stable@vger.kernel.org
Fixes: aa1fa28fc73e ("io_uring: add support for recvmsg()")
Fixes: 0fa03c624d8f ("io_uring: add support for sendmsg()")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1657,6 +1657,11 @@ static int io_send_recvmsg(struct io_kio
 		else if (force_nonblock)
 			flags |= MSG_DONTWAIT;
 
+#ifdef CONFIG_COMPAT
+		if (req->ctx->compat)
+			flags |= MSG_CMSG_COMPAT;
+#endif
+
 		msg = (struct user_msghdr __user *) (unsigned long)
 			READ_ONCE(sqe->addr);
 


