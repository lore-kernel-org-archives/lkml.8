Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C21820724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948051;
	bh=vuwR82FXEG2ONTEVTegCD/Tz5P1hRaBWdSnejHldVFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NV1l2cVphZLzhPRITJTOgyYO5L5j2k0C5TtMU+vadcKcqvo3f7Ti2N24zkVB+eoz9
	 4IOmBjvZB/OvLd0TScYOxnlkmUGuGMYa7WnmjcTK3YhZ1I+NWgScOc106oxe54xKyY
	 ZeBo5FjhlNHqfkCndFTxOVWdg1ovqP/qubNVmcFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbgFWVeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388876AbgFWULL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:11:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B925E2078A;
        Tue, 23 Jun 2020 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943071;
        bh=vuwR82FXEG2ONTEVTegCD/Tz5P1hRaBWdSnejHldVFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQ81r/k3mkXGMSopB0J2WlIV54te6scK0P8zopoZAB05jDBxUkL9SbWHzAuTixCXl
         aAsnCneLFidE+FY8z4IeFT8EMlp5A/4L/QwBy8JhYf1sn01mZ+gVtNg8C7nQu6ghO4
         XgA1w1xft7jSQyjmVCtt/SWoaq4QaieLGJe8BKZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 249/477] RDMA/efa: Fix setting of wrong bit in get/set_feature commands
Date:   Tue, 23 Jun 2020 21:54:06 +0200
Message-Id: <20200623195419.338239184@linuxfoundation.org>
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

From: Gal Pressman <galpress@amazon.com>

[ Upstream commit cc8a635e24acf2793605f243c913c51b8c3702ab ]

When using a control buffer the ctrl_data bit should be set in order to
indicate the control buffer address is valid, not ctrl_data_indirect
which is used when the control buffer itself is indirect.

Fixes: e9c6c5373088 ("RDMA/efa: Add common command handlers")
Link: https://lore.kernel.org/r/20200512152204.93091-2-galpress@amazon.com
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/efa/efa_com_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index eea5574a62e84..69f842c92ff64 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -388,7 +388,7 @@ static int efa_com_get_feature_ex(struct efa_com_dev *edev,
 
 	if (control_buff_size)
 		EFA_SET(&get_cmd.aq_common_descriptor.flags,
-			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT, 1);
+			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA, 1);
 
 	efa_com_set_dma_addr(control_buf_dma_addr,
 			     &get_cmd.control_buffer.address.mem_addr_high,
@@ -540,7 +540,7 @@ static int efa_com_set_feature_ex(struct efa_com_dev *edev,
 	if (control_buff_size) {
 		set_cmd->aq_common_descriptor.flags = 0;
 		EFA_SET(&set_cmd->aq_common_descriptor.flags,
-			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT, 1);
+			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA, 1);
 		efa_com_set_dma_addr(control_buf_dma_addr,
 				     &set_cmd->control_buffer.address.mem_addr_high,
 				     &set_cmd->control_buffer.address.mem_addr_low);
-- 
2.25.1



