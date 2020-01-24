Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC987C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A56720663
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864564;
	bh=BGAs65A5uHPOctSwKnFmknk5vcZ+ub2oIcEfkZW/eYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m58CWOrCQKh2Oa13CMIGqe/++5yiy5s8yUt+X9ULCtE23iqjbZcrVj3pMA+f3Tqn7
	 o3ea47hQr4ihKYRTIkWgVH9mN/A60b3z+ikj2P06LGzNOqVfDIBFNFSCV6KxL1wyfY
	 hm0UpBQAFtNMyw+zqVZpkmN2jP4VLNuoyLdHD9Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390318AbgAXLQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388173AbgAXLQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:16:02 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A19720663;
        Fri, 24 Jan 2020 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864562;
        bh=BGAs65A5uHPOctSwKnFmknk5vcZ+ub2oIcEfkZW/eYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXSgjsP/tsG/I50NVF2b7niSzgNkj27RcDoG1hy2cxzwpONI/hdD/4rjahjxHoYE3
         Z6y+9XjzRcyqFPnjLSRHjisNOGSxZ/j95I7VtoS6Rbr41RIRcubt/HCMu1ULGc6kUh
         8LZxKkqyIxZzZj3ypfSQZoZ2IFqb79jZVebrxjPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 287/639] bus: ti-sysc: Fix sysc_unprepare() when no clocks have been allocated
Date:   Fri, 24 Jan 2020 10:27:37 +0100
Message-Id: <20200124093122.828644962@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit aaa29bb01cc4bf5a87dbdb219efba3b09f259d8e ]

If we return early before ddata->clocks have been allocated we will get a
NULL pointer dereference in sysc_unprepare(). Let's fix this by returning
early when no clocks are allocated.

Fixes: 0eecc636e5a2 ("bus: ti-sysc: Add minimal TI sysc interconnect target driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 2813f9ed57c0d..54c8c8644df2e 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1400,6 +1400,9 @@ static void sysc_unprepare(struct sysc *ddata)
 {
 	int i;
 
+	if (!ddata->clocks)
+		return;
+
 	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
 		if (!IS_ERR_OR_NULL(ddata->clocks[i]))
 			clk_unprepare(ddata->clocks[i]);
-- 
2.20.1



