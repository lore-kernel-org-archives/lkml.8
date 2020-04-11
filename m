Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E9AC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67BB2166E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646244;
	bh=sGcawhSCorjKNqb+a3+qFPoK9A8AmdvKn3bP+dfMO2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CpvQClFm2Chgfg1XGxf5CeWH9gYh3WVAEN8LTqGDWm294mhfx8mEwbL0PVr3uSO9a
	 sJD23oDTyQPvzYMJf3ME/GdXiYUUxD8otv1bn3VLSuu5NwGgyzkKlK1zU14PlkGnO8
	 +I6NHVrqR0oJwFopF5wh95stK8US7TtzIyML41PA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDKXEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgDKXDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:03:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5266A20787;
        Sat, 11 Apr 2020 23:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646236;
        bh=sGcawhSCorjKNqb+a3+qFPoK9A8AmdvKn3bP+dfMO2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2gGz70CNE7A5+wyXWIek7tcslYdFzX6ABnASUg7txSeh89OKW+NDFeiy29VKQU20/
         nXsBpLP6m/bvQcwetyPPW3CBYZF0ASTiTP9FRQY7P83ow8SdSazPte0mmVSFbzLC51
         kiqXaFjyq7I6Pkr4pNhzDC4/rBFhvP1tXEjzAsu4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhu Yanjun <yanjunz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 006/149] RDMA/rxe: Set sys_image_guid to be aligned with HW IB devices
Date:   Sat, 11 Apr 2020 19:01:23 -0400
Message-Id: <20200411230347.22371-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yanjun <yanjunz@mellanox.com>

[ Upstream commit d0ca2c35dd15a3d989955caec02beea02f735ee6 ]

The RXE driver doesn't set sys_image_guid and user space applications see
zeros. This causes to pyverbs tests to fail with the following traceback,
because the IBTA spec requires to have valid sys_image_guid.

 Traceback (most recent call last):
   File "./tests/test_device.py", line 51, in test_query_device
     self.verify_device_attr(attr)
   File "./tests/test_device.py", line 74, in verify_device_attr
     assert attr.sys_image_guid != 0

In order to fix it, set sys_image_guid to be equal to node_guid.

Before:
 5: rxe0: ... node_guid 5054:00ff:feaa:5363 sys_image_guid
 0000:0000:0000:0000

After:
 5: rxe0: ... node_guid 5054:00ff:feaa:5363 sys_image_guid
 5054:00ff:feaa:5363

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Link: https://lore.kernel.org/r/20200323112800.1444784-1-leon@kernel.org
Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 0946a301a5c5d..4afdd2e208839 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -103,6 +103,8 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_fast_reg_page_list_len	= RXE_MAX_FMR_PAGE_LIST_LEN;
 	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
 	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
+	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
+			rxe->ndev->dev_addr);
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 }
-- 
2.20.1

