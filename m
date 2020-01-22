Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8378C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14422071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699647;
	bh=CVWYUqlclg5fm/jt+Yb59GU6VCCcr/xuHkuCWRqPg9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UHBreexeBE5iXcATBcAhjqvo4iKS98/25qO5ORGsNCaVmTDMhTXsoABJ9R8dIEbd9
	 oyWLp+Lb5F/QP+exC6LKfIG1EfmyLhI3TqUgF3EWF6sOE1ZpecraiT/1q3Syd8TkE+
	 MTXCOsKg3P9xLSMpgAlW8T0eYvd5Nj2Onq97bQxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgAVN11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731165AbgAVN1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:27:23 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5DC20678;
        Wed, 22 Jan 2020 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699643;
        bh=CVWYUqlclg5fm/jt+Yb59GU6VCCcr/xuHkuCWRqPg9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrT/bjAzn1B2onmB9T1sjuFHYMorafiaUB31ul+/a/uzaRZb6hrVmo6TD6czXtYD8
         9bvlYm4ijYz5KWB+f8W2DwkGO9zEg7FrDbN7gCOTe3vsvLLisCI+yvKyiVJzBxV3o4
         Z9TjuD4IeXL++TkOJxopTSpLVEDlmU39tzEGbIu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 206/222] scsi: hisi_sas: Return directly if init hardware failed
Date:   Wed, 22 Jan 2020 10:29:52 +0100
Message-Id: <20200122092848.450149077@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

commit 547fde8b5a1923050f388caae4f76613b5a620e0 upstream.

Need to return directly if init hardware failed.

Fixes: 73a4925d154c ("scsi: hisi_sas: Update all the registers after suspend and resume")
Link: https://lore.kernel.org/r/1573551059-107873-3-git-send-email-john.garry@huawei.com
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3423,6 +3423,7 @@ static int hisi_sas_v3_resume(struct pci
 	if (rc) {
 		scsi_remove_host(shost);
 		pci_disable_device(pdev);
+		return rc;
 	}
 	hisi_hba->hw->phys_init(hisi_hba);
 	sas_resume_ha(sha);


