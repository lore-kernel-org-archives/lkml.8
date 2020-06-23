Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C9AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B2520707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943152;
	bh=cIGi7f44F9fI57GkzRC8e+rGive0O2H72b3r/AtLP00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/Ji/Rq5EH0NTbunxupAvXmdZqxIRJkxsC4EEOrALi0iMIOgFT1+LUITDS/Yf2yoy
	 bmi3TyQcA1heaTE3E5gkN/23466ixFk7o/EgoxPjM5TekYHZi9hIpEqeySkyx488j9
	 HkdFimTJ1NffdfRnFnQPs/VjZhzYPyLoi9SEE14M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbgFWUM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbgFWUMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:12:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C214420707;
        Tue, 23 Jun 2020 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943128;
        bh=cIGi7f44F9fI57GkzRC8e+rGive0O2H72b3r/AtLP00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPTL8iLPWw0f7ruF5HrW9Mb8+YcRFpVo5zsBqdIFxWxfMqEgVOBcGjoLY1eUfom51
         vthjilmP5Ua7ryAxfpsRP1K8+0lBkPU9BR225o5S8GAo2fxj98VlcqStixiDll5hWD
         91oantteTwiFJeMWcwpKb49dAMIpkI42VSSf271I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 240/477] firmware: imx: scu: Fix possible memory leak in imx_scu_probe()
Date:   Tue, 23 Jun 2020 21:53:57 +0200
Message-Id: <20200623195418.921054673@linuxfoundation.org>
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

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 89f12d6509bff004852c51cb713a439a86816b24 ]

'chan_name' is malloced in imx_scu_probe() and should be freed
before leaving from the error handling cases, otherwise it will
cause memory leak.

Fixes: edbee095fafb ("firmware: imx: add SCU firmware driver support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/imx/imx-scu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index b3da2e193ad2d..176ddd151375a 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -314,6 +314,7 @@ static int imx_scu_probe(struct platform_device *pdev)
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
 					chan_name, ret);
+			kfree(chan_name);
 			return ret;
 		}
 
-- 
2.25.1



