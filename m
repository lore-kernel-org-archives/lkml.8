Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C7C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177FF2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257777;
	bh=LmL5IQBeypXgesntFYQKh5sWIvUcHxZNKZSbikfsc0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YjiC9tZgMtYSTX+ci2KugGz9nWuWw7G7iSFxNBl3lETTPxpnFIYHgjJIsSsLbRehW
	 MFG9nnY+jJSMU6TiPykCBmVr00GKWEkyvFNikEVVDSNcrf20whVeqh9lLq1yggcZsc
	 6473l8Pv0miELq1FiUH+Z0F2x9zSgSiT1FVEYXdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbgCCRtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731796AbgCCRte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:49:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49D020CC7;
        Tue,  3 Mar 2020 17:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257773;
        bh=LmL5IQBeypXgesntFYQKh5sWIvUcHxZNKZSbikfsc0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ks6IA1mpWXBowY17CfGxNGGnT6Gb0w96XClH6xlR7ZDQ2T8FBLxWQHnWrBpFx3ZPU
         9xb1nvQVF9xXmbl4h9W5Afe7FXup99B/tMM4Vw5KtNyC66o5Ya9kFndtzvnrBb3oiC
         lZlAPW2owCtiiNeQIDxNsFHjSCqzMNpniB0212U0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.5 123/176] nvme-pci: Hold cq_poll_lock while completing CQEs
Date:   Tue,  3 Mar 2020 18:43:07 +0100
Message-Id: <20200303174319.029189064@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>

commit 9515743bfb39c61aaf3d4f3219a645c8d1fe9a0e upstream.

Completions need to consumed in the same order the controller submitted
them, otherwise future completion entries may overwrite ones we haven't
handled yet. Hold the nvme queue's poll lock while completing new CQEs to
prevent another thread from freeing command tags for reuse out-of-order.

Fixes: dabcefab45d3 ("nvme: provide optimized poll function for separate poll queues")
Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1078,9 +1078,9 @@ static int nvme_poll(struct blk_mq_hw_ct
 
 	spin_lock(&nvmeq->cq_poll_lock);
 	found = nvme_process_cq(nvmeq, &start, &end, -1);
+	nvme_complete_cqes(nvmeq, start, end);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
-	nvme_complete_cqes(nvmeq, start, end);
 	return found;
 }
 


