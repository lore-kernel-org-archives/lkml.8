Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C37EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FE02077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864438;
	bh=jd3CQLaNRQvA8L575dOIe2ioxcnv4Fuzj7MTweEBl84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZWTpk5ThJCVkyqK0uQkEBVuBCXC6tiTHoIv07X0DKKD1P6T7n7lesviatkPzZ81sh
	 DqvYB/wtwimXJwPIRI0oj6cRxLZvD4QSEV5rM/i7c6nhXt1heZEi+JcMrq+26W1diL
	 HX1AMBFDxkr3ymuT5DN6tQjG3voORi3XmEHKEh4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgAXLN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390093AbgAXLNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:13:54 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C670620663;
        Fri, 24 Jan 2020 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864434;
        bh=jd3CQLaNRQvA8L575dOIe2ioxcnv4Fuzj7MTweEBl84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKXXhJrueKJXXPo+jHvGEUB0m5T6cqXGSett1Pa85bitEPbxDHNQTe5VsNqHxBIOB
         wktOvNmG3ncCSWWwtFGiMAQTDwV7wMVPq9fGCzrQJn9rl4fVXV1BkwccXsnGPVdYNs
         C/MgrIex95IeefuZEUl6fb7rEbLMXKFb9uBLILjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 251/639] rbd: clear ->xferred on error from rbd_obj_issue_copyup()
Date:   Fri, 24 Jan 2020 10:27:01 +0100
Message-Id: <20200124093118.177906479@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 356889c49d84f11f446ec235bd52ca1a7d581aa0 ]

Otherwise the assert in rbd_obj_end_request() is triggered.

Fixes: 3da691bf4366 ("rbd: new request handling code")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 585378bc988cd..b942f4c8cea8c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2506,6 +2506,7 @@ again:
 		ret = rbd_obj_issue_copyup(obj_req, obj_req->xferred);
 		if (ret) {
 			obj_req->result = ret;
+			obj_req->xferred = 0;
 			return true;
 		}
 		return false;
-- 
2.20.1



