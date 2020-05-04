Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F873205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615477;
	bh=MQS8+nTmhmm2Q150ULmKPcV1bXHSwsuoTev62VM611o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ff38PeaBBvcYaf4TObh+qzn0mvvnrY5HGI/jgVu3njbQl4w+q8rd7AVTiZQsw7Vw+
	 /I9jUKMdAZ9q1deiP6yuIpcWLxRyDHXW1nLKwndbgvgR3GaCn2YYo4vICWNwAv5DNJ
	 i6b1wVd60zXJJDD7KyLL5eL8M2PxcijDRzvDqqQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgEDSEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731672AbgEDSEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:04:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DAAB206B8;
        Mon,  4 May 2020 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615471;
        bh=MQS8+nTmhmm2Q150ULmKPcV1bXHSwsuoTev62VM611o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7wq6lbXscAdKg/Dv4R1CAWGPSSjpTqOjhD08CRLcLpxAGrdA9AuA3py489pN9I/A
         Q7JIcd1fo12jy9jZ8Dy028URuzhzDeRqwWDyjIZBJkAe5Q/AeyN5+3eBycvWKR1KCs
         bXVwH4SuOYerIGYhQfWgGmTFfjGd9fqdSONSioR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.4 52/57] nvme: prevent double free in nvme_alloc_ns() error handling
Date:   Mon,  4 May 2020 19:57:56 +0200
Message-Id: <20200504165501.233875915@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

commit 132be62387c7a72a38872676c18b0dfae264adb8 upstream.

When jumping to the out_put_disk label, we will call put_disk(), which will
trigger a call to disk_release(), which calls blk_put_queue().

Later in the cleanup code, we do blk_cleanup_queue(), which will also call
blk_put_queue().

Putting the queue twice is incorrect, and will generate a KASAN splat.

Set the disk->queue pointer to NULL, before calling put_disk(), so that the
first call to blk_put_queue() will not free the queue.

The second call to blk_put_queue() uses another pointer to the same queue,
so this call will still free the queue.

Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3566,6 +3566,8 @@ static int nvme_alloc_ns(struct nvme_ctr
 
 	return 0;
  out_put_disk:
+	/* prevent double queue cleanup */
+	ns->disk->queue = NULL;
 	put_disk(ns->disk);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);


