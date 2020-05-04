Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7623EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416F2206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615383;
	bh=N1YW4eOq1xrTYSyvdUAfjj0+WyAOAXq11HUYhdrCdI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cxmOvJBc05csSnVo0Xdqaz7/mAgl+NR3aqLoxqj2dJ+x1367sLLPigI5YFWC5mQJG
	 libIRLEq6L9/JBP9Qz2hrXEVia4nj5UmVAzezGJfaknbygomsXpbVPWUES+SHPS+Ox
	 hFqAcbyEwnd36vBKjcKRoxhfCtvKwE32o8Z8ob0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbgEDSDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731426AbgEDSC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:02:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFAD620707;
        Mon,  4 May 2020 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615379;
        bh=N1YW4eOq1xrTYSyvdUAfjj0+WyAOAXq11HUYhdrCdI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MA6BjrDZ6O7HzCuZrsb6Lw00JMGE10Cdk4H+N73rxU228ppTO3jqplJXUc7Pj32nb
         B8VyW+NCGuB8Xmh9nQIiaq+JkX1qXi62OyJxJ97zpKMWqGS3nW8idPAG36eb5wU+se
         TmSJGIaq/MGcHwPDBUHdJGBuYIHC6Ry6WkmmxHt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 15/57] mmc: sdhci-msm: Enable host capabilities pertains to R1b response
Date:   Mon,  4 May 2020 19:57:19 +0200
Message-Id: <20200504165457.732443080@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

commit 9d8cb58691f85cef687512262acb2c7109ee4868 upstream.

MSM sd host controller is capable of HW busy detection of device busy
signaling over DAT0 line. And it requires the R1B response for commands
that have this response associated with them.

So set the below two host capabilities for qcom SDHC.
 - MMC_CAP_WAIT_WHILE_BUSY
 - MMC_CAP_NEED_RSP_BUSY

Recent development of the mmc core in regards to this, revealed this as
being a potential bug, hence the stable tag.

Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/1587363626-20413-2-git-send-email-vbadigan@codeaurora.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-msm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1944,6 +1944,8 @@ static int sdhci_msm_probe(struct platfo
 		goto clk_disable;
 	}
 
+	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);


