Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A265BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6DB20829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824072;
	bh=1YqJ8DeqJXMlgEc1ELrfj/EAODkaBVufJMnrx/jj3vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jt3tIjOiSCgNVa+c4UoxvYk9ZZF7Zj7kHW8uXBY5026RwGzyhw4EXCkX6O6stOvAX
	 gJRhQPIIA7hv0rmIpALLnDnRcrmF9e1MPNvF+1Cn6iN/Bwf117+5e/bFEbW4qHID8p
	 /PZvgS6qBhxDqXoPqX1p66EefWucofNtvIZX6Cdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgERRrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730261AbgERRrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:47:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3345F20835;
        Mon, 18 May 2020 17:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824065;
        bh=1YqJ8DeqJXMlgEc1ELrfj/EAODkaBVufJMnrx/jj3vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TaXp/+JqAFrKYiB0DeALoYDZEgczNMxjyIfi/eYk8v9cJcQTU+GBadktGDVcqHmBF
         PwxgfYpqsrtx36UgEKA807VPrv1M/dX4vqE7aFeF8E1nRCx6IkKgurR9tA88aIPutU
         PGwlJcrzebcujYRxrKEYsdEIfYkVRcNm5OeJKQfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 040/114] blktrace: fix trace mutex deadlock
Date:   Mon, 18 May 2020 19:36:12 +0200
Message-Id: <20200518173510.751929221@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 2967acbb257a6a9bf912f4778b727e00972eac9b upstream.

A previous commit changed the locking around registration/cleanup,
but direct callers of blk_trace_remove() were missed. This means
that if we hit the error path in setup, we will deadlock on
attempting to re-acquire the queue trace mutex.

Fixes: 1f2cac107c59 ("blktrace: fix unlocked access to init/start-stop/teardown")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/blktrace.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -591,7 +591,7 @@ static int __blk_trace_setup(struct requ
 		return ret;
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 	return 0;
@@ -637,7 +637,7 @@ static int compat_blk_trace_setup(struct
 		return ret;
 
 	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 


