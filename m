Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7318C3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D4D24654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055799;
	bh=Vs7DEG0fjOuXsXQAQeshA/K3bR3pQWvBOTpuKjABMno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uoF6nnh/C4XwJJaPRnNoO2zrQg2NhZJ76a73kT/X9hdP5uWhe+MKf6C02GJWqZCCR
	 ptmXsc1C91C/MNCjFEAxLgG4VOd7jmC0zKqTx8IPMR1LkFMNrZyW0/+mqr4e4IlecR
	 zow4DLMk3XZdowm2mLGw9N6ji32ma4uym3EIX+sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgBRT4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbgBRT4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:56:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 601652465D;
        Tue, 18 Feb 2020 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055795;
        bh=Vs7DEG0fjOuXsXQAQeshA/K3bR3pQWvBOTpuKjABMno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fwc3xQJcWv44fh5J+3EB4Ct/JvM5qyCpcaLZr7u/uaYR/6fLfdcP2x5O3shkOnPte
         yZYcW634xKCZppMpKHeLeaeykCYy9eYBvShUnVAP/pp1ROtQHLb1giryRpVGxSJFXL
         xS/RbQodi/gdIJT6CDKf5Lv070L8ZNTLvITH+1CY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sujith Pandel <sujith_pandel@dell.com>,
        David Milburn <dmilburn@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 24/38] nvme: fix the parameter order for nvme_get_log in nvme_get_fw_slot_info
Date:   Tue, 18 Feb 2020 20:55:10 +0100
Message-Id: <20200218190421.514862902@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190418.536430858@linuxfoundation.org>
References: <20200218190418.536430858@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Zhang <yi.zhang@redhat.com>

commit f25372ffc3f6c2684b57fb718219137e6ee2b64c upstream.

nvme fw-activate operation will get bellow warning log,
fix it by update the parameter order

[  113.231513] nvme nvme0: Get FW SLOT INFO log error

Fixes: 0e98719b0e4b ("nvme: simplify the API for getting log pages")
Reported-by: Sujith Pandel <sujith_pandel@dell.com>
Reviewed-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3449,7 +3449,7 @@ static void nvme_get_fw_slot_info(struct
 	if (!log)
 		return;
 
-	if (nvme_get_log(ctrl, NVME_NSID_ALL, 0, NVME_LOG_FW_SLOT, log,
+	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, log,
 			sizeof(*log), 0))
 		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
 	kfree(log);


