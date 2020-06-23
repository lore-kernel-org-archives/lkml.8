Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BC3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191452078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948600;
	bh=vKNoM1ApIz1lnjdBHNegq3LBINjhr/lVwMFcuHsoekE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W5N0GdYEqsJzYJEDQ/S36eMEbUMGB9B2gl7YTil43IT4gkyW82I/Y6EIgiPQNFFt+
	 7UCQ9e95MIfq/I4Kwlu1qnGRK3vkhSey79AeGp6+V1I/evie29KTuhJoiaJfKWJmg/
	 tmP01CDOZ/oNPFb8MvCXLQpch+Fk6LWsNHqYCE+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbgFWVnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387627AbgFWUD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:03:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60DC2137B;
        Tue, 23 Jun 2020 20:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942635;
        bh=vKNoM1ApIz1lnjdBHNegq3LBINjhr/lVwMFcuHsoekE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TEHhYfvYrPQthqmkM5Bj94vu0ksWhT3WFTSCAvazcb/GZb+y36T++aX/6KGyRw7f
         MANF3/vRV8THKuVfX4AZ7C9AY56Yl9qnRaNpODngKg3VjMmKTs2v7l//p7TRw8jIt0
         mNGQ6VjhCyb00oCXVdRG3pAYw23kCt53LCGz2agI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Mike Christie <mchristi@redhat.com>,
        Sudhakar Panneerselvam <sudhakar.panneerselvam@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 076/477] scsi: vhost: Notify TCM about the maximum sg entries supported per command
Date:   Tue, 23 Jun 2020 21:51:13 +0200
Message-Id: <20200623195411.214148222@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudhakar Panneerselvam <sudhakar.panneerselvam@oracle.com>

[ Upstream commit 5ae6a6a915033bfee79e76e0c374d4f927909edc ]

vhost-scsi pre-allocates the maximum sg entries per command and if a
command requires more than VHOST_SCSI_PREALLOC_SGLS entries, then that
command is failed by it. This patch lets vhost communicate the max sg limit
when it registers vhost_scsi_ops with TCM. With this change, TCM would
report the max sg entries through "Block Limits" VPD page which will be
typically queried by the SCSI initiator during device discovery. By knowing
this limit, the initiator could ensure the maximum transfer length is less
than or equal to what is reported by vhost-scsi.

Link: https://lore.kernel.org/r/1590166317-953-1-git-send-email-sudhakar.panneerselvam@oracle.com
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Sudhakar Panneerselvam <sudhakar.panneerselvam@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index c39952243fd32..8b104f76f3245 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2280,6 +2280,7 @@ static struct configfs_attribute *vhost_scsi_wwn_attrs[] = {
 static const struct target_core_fabric_ops vhost_scsi_ops = {
 	.module				= THIS_MODULE,
 	.fabric_name			= "vhost",
+	.max_data_sg_nents		= VHOST_SCSI_PREALLOC_SGLS,
 	.tpg_get_wwn			= vhost_scsi_get_fabric_wwn,
 	.tpg_get_tag			= vhost_scsi_get_tpgt,
 	.tpg_check_demo_mode		= vhost_scsi_check_true,
-- 
2.25.1



