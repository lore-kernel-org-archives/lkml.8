Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2E7208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520200;
	bh=k5vrMvpNFxsa0jCQv9KhTfdi1z81KtTwMF1gGpNRJ0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MHVrZtGDAqSe64pu7ikwl8KKsAhXx5yAgkTPaYKL8Y3urxxcll2oxj9u51CJSxU8M
	 4N5ZmZTVTTkqzEwta4aLBgea4Ya7A7wY7zYKibJqnRo0Gr0u8j1Xfoy7HGGdkOaRPC
	 3WqLwtmlO3995gTh4s37QXBS0gyI53KTRz9TvzFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbgEZTJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403969AbgEZTJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:09:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31805208A7;
        Tue, 26 May 2020 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520194;
        bh=k5vrMvpNFxsa0jCQv9KhTfdi1z81KtTwMF1gGpNRJ0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2msOS0Yf6WyLGaWTnYROkr7+6sIlp54VPMLJiipu0VUbAV8n2osq2YsvjweP7Y91
         WhvtWqOthoiq+RChdprwsEPM8pr6HzwY3I/VZdbQNQux0+W2D1nAYR0Ez3wGhhkzej
         mTkZe/RAYarbNatuZCAwzDZkX+nOLxLhg1ABq/+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 095/111] rapidio: fix an error in get_user_pages_fast() error handling
Date:   Tue, 26 May 2020 20:53:53 +0200
Message-Id: <20200526183941.927295774@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

commit ffca476a0a8d26de767cc41d62b8ca7f540ecfdd upstream.

In the case of get_user_pages_fast() returning fewer pages than
requested, rio_dma_transfer() does not quite do the right thing.  It
attempts to release all the pages that were requested, rather than just
the pages that were pinned.

Fix the error handling so that only the pages that were successfully
pinned are released.

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200517235620.205225-2-jhubbard@nvidia.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rapidio/devices/rio_mport_cdev.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -877,6 +877,11 @@ rio_dma_transfer(struct file *filp, u32
 				rmcd_error("pinned %ld out of %ld pages",
 					   pinned, nr_pages);
 			ret = -EFAULT;
+			/*
+			 * Set nr_pages up to mean "how many pages to unpin, in
+			 * the error handler:
+			 */
+			nr_pages = pinned;
 			goto err_pg;
 		}
 


