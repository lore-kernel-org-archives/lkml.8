Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F22C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCF420674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931036;
	bh=WIKSys58th+7AjM3t2XfP0sozcAs5fjDqMdZLR227Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V8XKniPgzol4p6CQOTrNmt/HQKS61YCFPoiTEBcEcOWpnK+Ac1DOZx+3UkO/PWms2
	 UjIzFUBOK15c2zuueHB4CCiMyTn7eBspjrGMkiQcLmcp0Ngl1CvfA9kefgArcs5znZ
	 h0uVqGXpHX/hPPNrjvCS/RfjtkHpAFeeOfxIYrFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHTNnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgHTJ33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:29:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE4922CB1;
        Thu, 20 Aug 2020 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915768;
        bh=WIKSys58th+7AjM3t2XfP0sozcAs5fjDqMdZLR227Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7cD8eWeIDK0BfKcK65tV0zDTuHKSdGVC4giS1YOYha0rTiwLSh+hAc18pTyUjRSR
         M7SuYe55UDlViWQS/YNXXqNll6GgWbf6TMwukgMm1N+gNtTr1RIvXqPNM3+CfIxXb4
         vUGVmRJBNbA4H4j8SwCItYDdwuznxPbXfTenYGkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Dorminy <jdorminy@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.8 098/232] dm ebs: Fix incorrect checking for REQ_OP_FLUSH
Date:   Thu, 20 Aug 2020 11:19:09 +0200
Message-Id: <20200820091617.578250486@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Dorminy <jdorminy@redhat.com>

commit 4cb6f22612511ff2aba4c33fb0f281cae7c23772 upstream.

REQ_OP_FLUSH was being treated as a flag, but the operation
part of bio->bi_opf must be treated as a whole. Change to
accessing the operation part via bio_op(bio) and checking
for equality.

Signed-off-by: John Dorminy <jdorminy@redhat.com>
Acked-by: Heinz Mauelshagen <heinzm@redhat.com>
Fixes: d3c7b35c20d60 ("dm: add emulated block size target")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-ebs-target.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -363,7 +363,7 @@ static int ebs_map(struct dm_target *ti,
 	bio_set_dev(bio, ec->dev->bdev);
 	bio->bi_iter.bi_sector = ec->start + dm_target_offset(ti, bio->bi_iter.bi_sector);
 
-	if (unlikely(bio->bi_opf & REQ_OP_FLUSH))
+	if (unlikely(bio_op(bio) == REQ_OP_FLUSH))
 		return DM_MAPIO_REMAPPED;
 	/*
 	 * Only queue for bufio processing in case of partial or overlapping buffers


