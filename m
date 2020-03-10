Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458FC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CB9208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845501;
	bh=boie7kjDXkrMgYA2kRh557Gzikic9mujKoVkRXup9ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hZe8aVYqH+SmaQV7ninpmkvGBDQ8M+OnmTfrdHwXjVBBQ04eylpiv0XhUVBp4xAVE
	 hnZbLSbHfQ1RJSL/4tBab9+spBhw0K4wnX1B1MBuYjPs9tCJ9sSV4FfJPwjhO84oni
	 6xVuiCBcV5oY9T8h9corgZCllZGNCVy9qzMaI2Zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgCJNDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgCJNDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C37820409;
        Tue, 10 Mar 2020 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845429;
        bh=boie7kjDXkrMgYA2kRh557Gzikic9mujKoVkRXup9ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgUqaEibi53ZQ6Suf2yOo8ZSOwFH3pun5Uneo9OwPQhVewZzlOZKAxwnwAIS2BUDd
         /Ub544ehoRvcuwYmCLSSd0PVXv65h2HNpsDEZntEwAQM9puA6zWorLzS9RsHm6Szr9
         FFC5iABsjXji4VNaJuJtmaydSC2tUBey98TLDOWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.5 179/189] dmaengine: coh901318: Fix a double lock bug in dma_tc_handle()
Date:   Tue, 10 Mar 2020 13:40:16 +0100
Message-Id: <20200310123657.728086134@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 36d5d22090d13fd3a7a8c9663a711cbe6970aac8 upstream.

The caller is already holding the lock so this will deadlock.

Fixes: 0b58828c923e ("DMAENGINE: COH 901 318 remove irq counting")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200217144050.3i4ymbytogod4ijn@kili.mountain
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/coh901318.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1947,8 +1947,6 @@ static void dma_tc_handle(struct coh9013
 		return;
 	}
 
-	spin_lock(&cohc->lock);
-
 	/*
 	 * When we reach this point, at least one queue item
 	 * should have been moved over from cohc->queue to
@@ -1969,8 +1967,6 @@ static void dma_tc_handle(struct coh9013
 	if (coh901318_queue_start(cohc) == NULL)
 		cohc->busy = 0;
 
-	spin_unlock(&cohc->lock);
-
 	/*
 	 * This tasklet will remove items from cohc->active
 	 * and thus terminates them.


