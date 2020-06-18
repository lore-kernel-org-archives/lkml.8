Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A69521924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442820;
	bh=D3F8OeDLQgHlOhxrNCZPhck53CQnJDDLhPaT7YaAwrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f2S9kHBeh4sIIvJ+VmcTh+7oPONHJTBEPg2jLPfjQ3SVp6XiPQKhqGCFnXh1MmUdW
	 L0+DWsZ1IAShClDQU3xqnUitWOlAojyoVhrRtAO8j2XRHdj53IMx+puRXTun/gu4Va
	 KNwYvl8ekVLeNXIA3eLDiYwKcyDf+bDXoNjAhQds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgFRBNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbgFRBM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:12:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 357CD20EDD;
        Thu, 18 Jun 2020 01:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442748;
        bh=D3F8OeDLQgHlOhxrNCZPhck53CQnJDDLhPaT7YaAwrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWaF37sJvBryMdy7DM/uqodwaiskEYnqZum8Uumx51IGDc4P0zQUgYMlohe5+aDb4
         esyO1TFdik4NS8iQGoJudPBFZAlnaEr4gatkZcZRSQLu2o/oh2pm0XuYFW/WwgoWDN
         RV6iNiP3Zyfq0vQbsXotVRyb8VFnP9m+a3Y7pJGo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 200/388] USB: ohci-sm501: fix error return code in ohci_hcd_sm501_drv_probe()
Date:   Wed, 17 Jun 2020 21:04:57 -0400
Message-Id: <20200618010805.600873-200-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit b919e077cccfbb77beb98809568b2fb0b4d113ec ]

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 7d9e6f5aebe8 ("usb: host: ohci-sm501: init genalloc for local memory")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20200506135625.106910-1-weiyongjun1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-sm501.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index c158cda9e4b9..cff965240327 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -157,9 +157,10 @@ static int ohci_hcd_sm501_drv_probe(struct platform_device *pdev)
 	 * the call to usb_hcd_setup_local_mem() below does just that.
 	 */
 
-	if (usb_hcd_setup_local_mem(hcd, mem->start,
-				    mem->start - mem->parent->start,
-				    resource_size(mem)) < 0)
+	retval = usb_hcd_setup_local_mem(hcd, mem->start,
+					 mem->start - mem->parent->start,
+					 resource_size(mem));
+	if (retval < 0)
 		goto err5;
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval)
-- 
2.25.1

