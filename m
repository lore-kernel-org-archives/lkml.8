Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D16EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4856C20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608508;
	bh=L6Unl/yQarUggp0kDEWUXmpEJITy9UQ/aTfweNDq+ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A+fQKwm+0FmvjUut0M1jUExfwixJZojWxgPsiV5MzlJ8xfekUx2Ih7GR8FHCkuhlr
	 X2Kygje2UCplwAoGXcpAjqLwgu2SK8EnNoSvHHuXU4DZCjJaWR8dg/XfOs4v9HpNkK
	 KTn0rF7b81G/F2ajvlrq5bXdZ897hOkRXekl2ykg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgBMPlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgBMP2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:30 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E2A206DB;
        Thu, 13 Feb 2020 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607710;
        bh=L6Unl/yQarUggp0kDEWUXmpEJITy9UQ/aTfweNDq+ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nME+ozZUjiZqlp6a99kWl33ZLWPDVk4sdq92ChE5Y3E1ET8TnWLyTFg6sChAk1RcC
         x9vJSCMqvVrnUTJ4ioFEQgvOcekRATEtmKNxtlOPkOr7kJ9oLWCwf9h4jMbmnceTCh
         5a9J614PK89Zc94DgXWLwtDjzTHOTU8jS1WjUElk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.5 047/120] rtc: mt6397: drop free_irq of devm_ allocated irq
Date:   Thu, 13 Feb 2020 07:20:43 -0800
Message-Id: <20200213151917.688841306@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 751438bc0f10f75633144acd6ff145f7260706d5 upstream.

The devm_request_threaded_irq function allocates irq that is
released when a driver detaches. Thus, there is no reason to
explicitly call free_irq in probe function.

Fixes: 851b87148aa2 ("rtc: mt6397: improvements of rtc driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Link: https://lore.kernel.org/r/20191113021720.9527-1-weiyongjun1@huawei.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-mt6397.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -297,15 +297,7 @@ static int mtk_rtc_probe(struct platform
 
 	rtc->rtc_dev->ops = &mtk_rtc_ops;
 
-	ret = rtc_register_device(rtc->rtc_dev);
-	if (ret)
-		goto out_free_irq;
-
-	return 0;
-
-out_free_irq:
-	free_irq(rtc->irq, rtc);
-	return ret;
+	return rtc_register_device(rtc->rtc_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP


