Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED70C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D2E208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597929852;
	bh=Q1zIU5SuzkyJ10BIgp1gFKULbwqkncB9RaWdhQ0CRdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vw8JUZ+5LGrEHnXSSmBDUsaRM7GhmzsNcdwMk2JVwaj4m084XiPxaW+D+S3MXtKkI
	 TdghkYBzumIrqvIcaCSkHho7PP1qD8viXBv3xrIhpB9NwUFV3xmi273hMVDiw6/S4d
	 V2VfhHUTlf9vFL0VJdApnmXZxVR2eDWcibtybp1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgHTNYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgHTJeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:34:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0076822CA0;
        Thu, 20 Aug 2020 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916051;
        bh=Q1zIU5SuzkyJ10BIgp1gFKULbwqkncB9RaWdhQ0CRdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXJuuQtrNTArGW2DkDW5IKD6stb491fJyg2wcCIKc0rtBNqpi/gW5jTrp0aDWPl7q
         n/KdlUQv7iHIWrEzhrT9Rj+hFv1wXOxesvysCgTGDtYsj2zudhqOTxgI71WeN0j/kp
         Q2TJViNKJSK6pXyLAcvquv0CdPPs7QhBvtdPraq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 187/232] md-cluster: Fix potential error pointer dereference in resize_bitmaps()
Date:   Thu, 20 Aug 2020 11:20:38 +0200
Message-Id: <20200820091621.853179966@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e8abe1de43dac658dacbd04a4543e0c988a8d386 ]

The error handling calls md_bitmap_free(bitmap) which checks for NULL
but will Oops if we pass an error pointer.  Let's set "bitmap" to NULL
on this error path.

Fixes: afd756286083 ("md-cluster/raid10: resize all the bitmaps before start reshape")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-cluster.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 73fd50e779754..d50737ec40394 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1139,6 +1139,7 @@ static int resize_bitmaps(struct mddev *mddev, sector_t newsize, sector_t oldsiz
 		bitmap = get_bitmap_from_slot(mddev, i);
 		if (IS_ERR(bitmap)) {
 			pr_err("can't get bitmap from slot %d\n", i);
+			bitmap = NULL;
 			goto out;
 		}
 		counts = &bitmap->counts;
-- 
2.25.1



