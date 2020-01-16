Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FF9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D9A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218345;
	bh=D2JDALk0Xq3IA0lFatgD2Tnhdb9kJsSbsj1r7YIGito=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwKWqaasn7zE3T7XE+cmym4chnGTIV/6oERdlBzoUuDkvy18nXIPxlbVAFAcFhqal
	 ywINKapFqx5Sce7KPJDBlEwfBDTCedGuHyw11nt5YwZkta8ivjVB0fM/YshjLNqJss
	 c/TlRTdFkcuZX0wtdmXEOBe2QoRgwdOVXpW/0cys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbgAPXWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733030AbgAPXWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:22:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A162072E;
        Thu, 16 Jan 2020 23:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216956;
        bh=D2JDALk0Xq3IA0lFatgD2Tnhdb9kJsSbsj1r7YIGito=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sy+ZiIKDqAZHMq4pjsmUzD/unHM9HKHuyZbLUqbFvh3YXaZIe8XvRHtzfGRyb3YOm
         WKfaUhK0LxEeoCaMz9vvnQyZwbNvKvd0wj4SY0O7l2r5AZY/jXDpCppLGyPTzrKyHa
         bhBsiIoEraZBKItAqGsQjeScJy8uORPb/JfeN2sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangyang Li <liyangyang20@huawei.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 073/203] RDMA/hns: Bugfix for qpc/cqc timer configuration
Date:   Fri, 17 Jan 2020 00:16:30 +0100
Message-Id: <20200116231750.543451509@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

commit 887803db866a7a4e1817a3cb8a3eee4e9879fed2 upstream.

qpc/cqc timer entry size needs one page, but currently they are fixedly
configured to 4096, which is not appropriate in 64K page scenarios. So
they should be modified to PAGE_SIZE.

Fixes: 0e40dc2f70cd ("RDMA/hns: Add timer allocation support for hip08")
Link: https://lore.kernel.org/r/1571908917-16220-3-git-send-email-liweihang@hisilicon.com
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -87,8 +87,8 @@
 #define HNS_ROCE_V2_MTT_ENTRY_SZ		64
 #define HNS_ROCE_V2_CQE_ENTRY_SIZE		32
 #define HNS_ROCE_V2_SCCC_ENTRY_SZ		32
-#define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		4096
-#define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		4096
+#define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		PAGE_SIZE
+#define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
 #define HNS_ROCE_V2_MAX_INNER_MTPT_NUM		2
 #define HNS_ROCE_INVALID_LKEY			0x100


