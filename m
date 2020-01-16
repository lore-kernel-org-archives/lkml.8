Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295AAC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73472072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217274;
	bh=kcKimjZ/F04mIujS2dcuHR3C5pbwPkFxsld3aEHeQTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rf/OpkJgg+8ChzcdgP6vlgWvcchGOrexkgdoqCWjP90JaFxIXI3h+N5zQAkKyh9bS
	 +vCMYy5RzZx5tZvT1rNT4RRss7CMRyai1Wr6tgS7ldrG05tZwGz8j8BHGvHce1irYu
	 tjryE/I49sJxmUfNuxUpwgGMHHVkhqTmfN39FIpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389864AbgAPX1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:27:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731453AbgAPX1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:27:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4484A20684;
        Thu, 16 Jan 2020 23:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217269;
        bh=kcKimjZ/F04mIujS2dcuHR3C5pbwPkFxsld3aEHeQTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZAx2PHl9IkXUlHcIsHYq1ksP1PueHkzuUq3lDuTiIFFUOigyiZVdKg3KGxTROLd3
         o5NVStTKWqE1V0S7IqyRJJui5+MfhZ7ek7wOCddsl0R4kVXSDhd2VCKYVeuFuxQes/
         yjf8M6I+JT0qb73Z7w50/0qcM756rYiqogOlcrJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.19 14/84] RDMA: Fix goto target to release the allocated memory
Date:   Fri, 17 Jan 2020 00:17:48 +0100
Message-Id: <20200116231715.299861353@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 4a9d46a9fe14401f21df69cea97c62396d5fb053 upstream.

In bnxt_re_create_srq(), when ib_copy_to_udata() fails allocated memory
should be released by goto fail.

Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
Link: https://lore.kernel.org/r/20190910222120.16517-1-navid.emamdoost@gmail.com
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1446,7 +1446,7 @@ struct ib_srq *bnxt_re_create_srq(struct
 			dev_err(rdev_to_dev(rdev), "SRQ copy to udata failed!");
 			bnxt_qplib_destroy_srq(&rdev->qplib_res,
 					       &srq->qplib_srq);
-			goto exit;
+			goto fail;
 		}
 	}
 	if (nq)


