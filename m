Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49D5C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DF62087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592379;
	bh=iPx38k3mMcCJ+riztXVJPgkP4xb3An7I8mthAfHsqDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YqGF7++FPDssAtb1GNYsLi6wcAPNRs49u1vknNDPYp+/cg0NL31dQwt2c3hkaKC9e
	 B88KaxIdyEhWELhT8UfQBHAYAQzSMPE5TXwFGXI+/5vw3iLa9M4kU3IE/1a1ma115o
	 2gmcKXicjylKScINNZVKBWiy3YIQznnTjRMtxCpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbgIHTLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbgIHQFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:05:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F046722583;
        Tue,  8 Sep 2020 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579959;
        bh=iPx38k3mMcCJ+riztXVJPgkP4xb3An7I8mthAfHsqDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlbG6LtmsmMQ+fBxhQ0XNZ5OXK2/lbT5BDJ72HpdyUz2TYkGPELoNB2mFRk3Ev6Ka
         DcqiUCFKjv+E2v9U3WhklD8UR5SM3mKByN688TQT1Mhf/uIEG1MQkxWCyVLMyICgnW
         Ij8zZafaUg+vn4JmQbH1e8YPKkSYY/AaK1vpxkyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 102/129] mmc: cqhci: Add cqhci_deactivate()
Date:   Tue,  8 Sep 2020 17:25:43 +0200
Message-Id: <20200908152234.933730101@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

commit 0ffa6cfbd94982e6c028a8924b06a96c1b91bed8 upstream.

Host controllers can reset CQHCI either directly or as a consequence of
host controller reset. Add cqhci_deactivate() which puts the CQHCI
driver into a state that is consistent with that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Link: https://lore.kernel.org/r/1583503724-13943-2-git-send-email-vbadigan@codeaurora.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/cqhci.c |    6 +++---
 drivers/mmc/host/cqhci.h |    6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -299,16 +299,16 @@ static void __cqhci_disable(struct cqhci
 	cq_host->activated = false;
 }
 
-int cqhci_suspend(struct mmc_host *mmc)
+int cqhci_deactivate(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
 
-	if (cq_host->enabled)
+	if (cq_host->enabled && cq_host->activated)
 		__cqhci_disable(cq_host);
 
 	return 0;
 }
-EXPORT_SYMBOL(cqhci_suspend);
+EXPORT_SYMBOL(cqhci_deactivate);
 
 int cqhci_resume(struct mmc_host *mmc)
 {
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -230,7 +230,11 @@ irqreturn_t cqhci_irq(struct mmc_host *m
 		      int data_error);
 int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
 struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
-int cqhci_suspend(struct mmc_host *mmc);
+int cqhci_deactivate(struct mmc_host *mmc);
+static inline int cqhci_suspend(struct mmc_host *mmc)
+{
+	return cqhci_deactivate(mmc);
+}
 int cqhci_resume(struct mmc_host *mmc);
 
 #endif


