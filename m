Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6381EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE98206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048947;
	bh=u0Quab+B5xAY1WdEbEgSNg29A46PeZKLIIvqfGttVbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJ1MH4rhXiicYqB05Arl/px9MIVdQOQs2A5+vglO0AOrcUQimnPha7EEeDOCo5aFg
	 WIxelIZPolugiUn8CjyAeBXSDbRYRpizITd3K/x5lQKUvDsZh2agSkrZgU3DpbyiAe
	 /RUh398A0dNPT0mEJ384SVp9kqYVTrQC5462vHB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405933AbgDPOzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441792AbgDPN4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:56:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0E002078B;
        Thu, 16 Apr 2020 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045391;
        bh=u0Quab+B5xAY1WdEbEgSNg29A46PeZKLIIvqfGttVbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKjtalq5KxvW+QqI/ovkajGY2gk0GNawie+XW/tVBhReSLtC7ZU6OP9oa1zP9am3X
         Vz+bmHcMdbIQhQRzScXdvPX3nepb6t4CvefUa0F146IdUzANx+3XY9ddL9knIYtVj5
         GI2dAB/QDxSRCW4gjT8aI4ypop3OZq/ykAf80S60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 5.6 115/254] io_uring: ensure openat sets O_LARGEFILE if needed
Date:   Thu, 16 Apr 2020 15:23:24 +0200
Message-Id: <20200416131340.594170498@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 08a1d26eb894a9dcf79f674558a284ad1ffef517 upstream.

OPENAT2 correctly sets O_LARGEFILE if it has to, but that escaped the
OPENAT opcode. Dmitry reports that his test case that compares openat()
and IORING_OP_OPENAT sees failures on large files:

---
 fs/io_uring.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2571,6 +2571,8 @@ static int io_openat_prep(struct io_kioc
 	req->open.how.mode = READ_ONCE(sqe->len);
 	fname = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	req->open.how.flags = READ_ONCE(sqe->open_flags);
+	if (force_o_largefile())
+		req->open.how.flags |= O_LARGEFILE;
 
 	req->open.filename = getname(fname);
 	if (IS_ERR(req->open.filename)) {


