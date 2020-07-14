Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556F1C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2735022B51
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753289;
	bh=bI0/qwc2zKiJvpANqNzd0zDdKboGYWu7C8PdxDM/ibc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yn6uXmpfGzOP42gcTAAnnC5UeZF7Y4z0URSnRTdAeS2gi2goxcP9bchHYK8DwDLkK
	 iIOVSpjGTuCchCHDDbsB7iMRgaMIv9kAIzRLq+jesb5pACNvSz2Aa51kTWnS3GqqyW
	 JfeLHp6ygsl2kx/l7n1OkPLq0E2MuwOsHBC6xLKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgGNTB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731323AbgGNS77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:59:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7536E229CA;
        Tue, 14 Jul 2020 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753199;
        bh=bI0/qwc2zKiJvpANqNzd0zDdKboGYWu7C8PdxDM/ibc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jH1211bnCTiEIFHZf8mzIa9nFuBFVn1rAukeZw4nEYUspa9keODQaqzoL2geojtlj
         rDFl0JkcbJPJApCjzqRMEh6gTxIqWONDvAwsCD788jwk8+t22E62cSSPBxsN4V07nk
         bIkGNLMM8xLCWdU6C0njb2j75L8h7eNJHej6YYOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.7 127/166] io_uring: fix missing msg_name assignment
Date:   Tue, 14 Jul 2020 20:44:52 +0200
Message-Id: <20200714184121.915085982@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

commit dd821e0c95a64b5923a0c57f07d3f7563553e756 upstream.

Ensure to set msg.msg_name for the async portion of send/recvmsg,
as the header copy will copy to/from it.

Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3587,6 +3587,7 @@ static int io_sendmsg_prep(struct io_kio
 	if (req->flags & REQ_F_NEED_CLEANUP)
 		return 0;
 
+	io->msg.msg.msg_name = &io->msg.addr;
 	io->msg.iov = io->msg.fast_iov;
 	ret = sendmsg_copy_msghdr(&io->msg.msg, sr->msg, sr->msg_flags,
 					&io->msg.iov);
@@ -3774,6 +3775,7 @@ static int __io_compat_recvmsg_copy_hdr(
 
 static int io_recvmsg_copy_hdr(struct io_kiocb *req, struct io_async_ctx *io)
 {
+	io->msg.msg.msg_name = &io->msg.addr;
 	io->msg.iov = io->msg.fast_iov;
 
 #ifdef CONFIG_COMPAT


