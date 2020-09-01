Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB28BC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11CD2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975340;
	bh=AC80ehk6MWnB6KDYF3opTQgFibhyfg/7C7NTDOOw+IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ZWKyNidDi0z9G4ri5D4cAMiiVkCXlNq4blDribnRIa/1cSkd5rvS5Mi1lmB4kGdg
	 FFB/QRYTwZpNYakiBStm4TMwX80aDR8i/7M8yadmEk0ofxpADxl5qOPH3qSFcBnbGw
	 Ryea8IUMOnqKJKUvBGuLZD4b/FpaF30ZW9vEJ364=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbgIAPs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbgIAPpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:45:18 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C28206FA;
        Tue,  1 Sep 2020 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975117;
        bh=AC80ehk6MWnB6KDYF3opTQgFibhyfg/7C7NTDOOw+IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1bDjcCZJF7cijzu+axAS0D9uTO1xk1pq4jCzdNbLX58kNl+sk0evyuByTDanyIODI
         48Y9QuZ1IVGXK7IbqdRuXyBR8tqV15rx8gE87O+IBjqJcc+XNC1B32zceS0nA88Lis
         76KPmqK/R15ywjHA37DUipCI1s3+3CXuz1pEa9Ek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andres Freund <andres@anarazel.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 186/255] io_uring: clear req->result on IOPOLL re-issue
Date:   Tue,  1 Sep 2020 17:10:42 +0200
Message-Id: <20200901151009.598705719@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 56450c20fe10d4d93f58019109aa4e06fc0b9206 upstream.

Make sure we clear req->result, which was set to -EAGAIN for retry
purposes, when moving it to the reissue list. Otherwise we can end up
retrying a request more than once, which leads to weird results in
the io-wq handling (and other spots).

Cc: stable@vger.kernel.org
Reported-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1810,6 +1810,7 @@ static void io_iopoll_complete(struct io
 
 		req = list_first_entry(done, struct io_kiocb, list);
 		if (READ_ONCE(req->result) == -EAGAIN) {
+			req->result = 0;
 			req->iopoll_completed = 0;
 			list_move_tail(&req->list, &again);
 			continue;


