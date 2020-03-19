Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AACC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120C8208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624237;
	bh=N3h6q8tCGOh4BWQmsC7dtfhBTXK5drPci7XihK3wjb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jWm9oXuOsqlzWLUA/zlmyoXX8dWTcJOU7HS8/nuCZCMpjyrSmHN4CjyyEI3xlqCPr
	 r3w8ikeIIqv79X7i/BggcehFrVLPvFbLNOOu/+QP14l3E5VXvciqKw//Nw7mtw2en7
	 ZcBkNVMqB/Btk9xyMv/Kh5dt+IqkV3rAcBYq6Xl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgCSNXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729237AbgCSNXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:23:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13BEE208D6;
        Thu, 19 Mar 2020 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624231;
        bh=N3h6q8tCGOh4BWQmsC7dtfhBTXK5drPci7XihK3wjb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwlFPMALFK32UEJNp7mKDPFykN7+oiB0O5RwhWAw8RUwV9WJNE4iCsjQUapNdtJ2Q
         8qCe6FeACYc8vDwm+80zlrfu4FHR0vHpp4Ql3df2eC4jbK8WQyMd+xNKKjzArLoSoQ
         mMaxODPd1aLaWU+KeLlZ+aPCYZFjUjU4SX5A9Vm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Igor Druzhinin <igor.druzhinin@citrix.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 24/60] scsi: libfc: free response frame from GPN_ID
Date:   Thu, 19 Mar 2020 14:04:02 +0100
Message-Id: <20200319123927.044337409@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123919.441695203@linuxfoundation.org>
References: <20200319123919.441695203@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Druzhinin <igor.druzhinin@citrix.com>

[ Upstream commit ff6993bb79b9f99bdac0b5378169052931b65432 ]

fc_disc_gpn_id_resp() should be the last function using it so free it here
to avoid memory leak.

Link: https://lore.kernel.org/r/1579013000-14570-2-git-send-email-igor.druzhinin@citrix.com
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_disc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 9c5f7c9178c66..2b865c6423e29 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -628,6 +628,8 @@ static void fc_disc_gpn_id_resp(struct fc_seq *sp, struct fc_frame *fp,
 	}
 out:
 	kref_put(&rdata->kref, fc_rport_destroy);
+	if (!IS_ERR(fp))
+		fc_frame_free(fp);
 }
 
 /**
-- 
2.20.1



