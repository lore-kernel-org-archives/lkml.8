Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B042C76591
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F89824656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813739;
	bh=uPZNUo6hZRw9EESZm12SGL2n6SkjBacg92Va+/AxakM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=moLF0QJRbT+DA1wS4wvPgEOnEy5lOJ468sgklgM33Mwiv9CMnoD6MwpPVIKeyrPKP
	 +pgt1C06XKdavDyesdnuesMy/F/3z+UvNPly+C9NizFRqv70paLr1WqMqrKoZuvkLt
	 uaRHdxhFmNd1J7UOxWTvQxVEFwtdL+CHqlYf+Czc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbgB0OHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387995AbgB0OGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:06:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3818421D7E;
        Thu, 27 Feb 2020 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812414;
        bh=uPZNUo6hZRw9EESZm12SGL2n6SkjBacg92Va+/AxakM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3gSnPa0iz84SYkLVicvPEzwWgyV3lx7aL7zKx7fDJ/iO4qHPznw5kTKU1yx6fxWs
         4WC0pCbesqmYqMKObbc9yRPV++tClDtRww7264iUQc1EW7+zol+QqyqHiovd6BR/P3
         tNglbppIrYZ2WBaxMRYFqSRwltuB0LqpcAqmhO0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Masney <masneyb@onstation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.4 001/135] iommu/qcom: Fix bogus detach logic
Date:   Thu, 27 Feb 2020 14:35:41 +0100
Message-Id: <20200227132228.973307226@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

commit faf305c51aeabd1ea2d7131e798ef5f55f4a7750 upstream.

Currently, the implementation of qcom_iommu_domain_free() is guaranteed
to do one of two things: WARN() and leak everything, or dereference NULL
and crash. That alone is terrible, but in fact the whole idea of trying
to track the liveness of a domain via the qcom_domain->iommu pointer as
a sanity check is full of fundamentally flawed assumptions. Make things
robust and actually functional by not trying to be quite so clever.

Reported-by: Brian Masney <masneyb@onstation.org>
Tested-by: Brian Masney <masneyb@onstation.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/qcom_iommu.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -345,21 +345,19 @@ static void qcom_iommu_domain_free(struc
 {
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 
-	if (WARN_ON(qcom_domain->iommu))    /* forgot to detach? */
-		return;
-
 	iommu_put_dma_cookie(domain);
 
-	/* NOTE: unmap can be called after client device is powered off,
-	 * for example, with GPUs or anything involving dma-buf.  So we
-	 * cannot rely on the device_link.  Make sure the IOMMU is on to
-	 * avoid unclocked accesses in the TLB inv path:
-	 */
-	pm_runtime_get_sync(qcom_domain->iommu->dev);
-
-	free_io_pgtable_ops(qcom_domain->pgtbl_ops);
-
-	pm_runtime_put_sync(qcom_domain->iommu->dev);
+	if (qcom_domain->iommu) {
+		/*
+		 * NOTE: unmap can be called after client device is powered
+		 * off, for example, with GPUs or anything involving dma-buf.
+		 * So we cannot rely on the device_link.  Make sure the IOMMU
+		 * is on to avoid unclocked accesses in the TLB inv path:
+		 */
+		pm_runtime_get_sync(qcom_domain->iommu->dev);
+		free_io_pgtable_ops(qcom_domain->pgtbl_ops);
+		pm_runtime_put_sync(qcom_domain->iommu->dev);
+	}
 
 	kfree(qcom_domain);
 }
@@ -405,7 +403,7 @@ static void qcom_iommu_detach_dev(struct
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	unsigned i;
 
-	if (!qcom_domain->iommu)
+	if (WARN_ON(!qcom_domain->iommu))
 		return;
 
 	pm_runtime_get_sync(qcom_iommu->dev);
@@ -418,8 +416,6 @@ static void qcom_iommu_detach_dev(struct
 		ctx->domain = NULL;
 	}
 	pm_runtime_put_sync(qcom_iommu->dev);
-
-	qcom_domain->iommu = NULL;
 }
 
 static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,


