Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F63C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66148206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046264;
	bh=TngxyyCp0Rdwo2YoXhGFlYACMiVZ+4ahpshlX/svg6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AxAKg9NeKbDOu1rnftbCqfmhC06wEGOk7UBLI+eG5cFK2q92aXyaZ5NqyMY/pjo/r
	 TcIaOcXVxsa0J+vYV0IxKScVr0k/HMDuYj+QqZ6m3a7te84M0LdKhi02MwwktiuuNB
	 3rtVwRY4vHW5SYONUkZOOZ0MF2TKEyRtSxKNGBkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgDPOLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898635AbgDPNqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:46:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8812222D;
        Thu, 16 Apr 2020 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044813;
        bh=TngxyyCp0Rdwo2YoXhGFlYACMiVZ+4ahpshlX/svg6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWv1Uisz52l/Y86Url45+TtUmTu+/hYE4vaLokyafetPCjSKnFyNhHtbgbQGZrhpX
         EkePN5zgb2qR2gi+kK61Wx84e2bmrN0HLB565U5Gu4wuTfPSaPwAq6bzW0492lO2MD
         zpcHGwM7u5wIaWRt6ror/bdRQ1Sk+6CWj2piRDkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 112/232] io_uring: remove bogus RLIMIT_NOFILE check in file registration
Date:   Thu, 16 Apr 2020 15:23:26 +0200
Message-Id: <20200416131329.139822140@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit c336e992cb1cb1db9ee608dfb30342ae781057ab upstream.

We already checked this limit when the file was opened, and we keep it
open in the file table. Hence when we added unit_inflight to the count
we want to register, we're doubly accounting these files. This results
in -EMFILE for file registration, if we're at half the limit.

Cc: stable@vger.kernel.org # v5.1+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3092,13 +3092,6 @@ static int __io_sqe_files_scm(struct io_
 	struct sk_buff *skb;
 	int i;
 
-	if (!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
-		unsigned long inflight = ctx->user->unix_inflight + nr;
-
-		if (inflight > task_rlimit(current, RLIMIT_NOFILE))
-			return -EMFILE;
-	}
-
 	fpl = kzalloc(sizeof(*fpl), GFP_KERNEL);
 	if (!fpl)
 		return -ENOMEM;


