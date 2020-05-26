Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82477C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58275208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520168;
	bh=dw6to2wRQ3SmfWu7X9TKk6vCDa1Vn/DKpM9BwBWsZAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1szQlJYyKqfUUpXb7h5x/GcGEIQrcV14wCDEvnQ4vbTQODCru6h1tv6VVcc+CVXR
	 YtmWr4l+ofqrd6evHYAP9JzlJvn1HhY/Wk9DL+fv+Kyf/nUJEEVZq5whr/vJtHhs9W
	 qYzJjkuNQk3k0B3RlpuciDNFGrGwptZaW7KCdEfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391870AbgEZTJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391851AbgEZTJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:09:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29DF20776;
        Tue, 26 May 2020 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520162;
        bh=dw6to2wRQ3SmfWu7X9TKk6vCDa1Vn/DKpM9BwBWsZAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5FNa9mhnqr0pEhBOxet3EO9b/VWMwtzSg67qFUar4gY8n7xyb2DaxoHBEU1Tfo/f
         k8FfWx+4L9Jz5QaimjgO7h2r8TcBNq6lPeaPm2vD2g6gSp06J9jAhATCQMh9Hc6PKV
         Rx+yl8YrsqgwbYvAfGhkmPlgcpTk19WC0qNdA28c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 5.4 083/111] staging: kpc2000: fix error return code in kp2000_pcie_probe()
Date:   Tue, 26 May 2020 20:53:41 +0200
Message-Id: <20200526183940.773554433@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit b17884ccf29e127b16bba6aea1438c851c9f5af1 upstream.

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function. Also
removed var 'rv' since we can use 'err' instead.

Fixes: 7dc7967fc39a ("staging: kpc2000: add initial set of Daktronics drivers")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200506134735.102041-1-weiyongjun1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/kpc2000/kpc2000/core.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -298,7 +298,6 @@ static int kp2000_pcie_probe(struct pci_
 {
 	int err = 0;
 	struct kp2000_device *pcard;
-	int rv;
 	unsigned long reg_bar_phys_addr;
 	unsigned long reg_bar_phys_len;
 	unsigned long dma_bar_phys_addr;
@@ -445,11 +444,11 @@ static int kp2000_pcie_probe(struct pci_
 	if (err < 0)
 		goto err_release_dma;
 
-	rv = request_irq(pcard->pdev->irq, kp2000_irq_handler, IRQF_SHARED,
-			 pcard->name, pcard);
-	if (rv) {
+	err = request_irq(pcard->pdev->irq, kp2000_irq_handler, IRQF_SHARED,
+			  pcard->name, pcard);
+	if (err) {
 		dev_err(&pcard->pdev->dev,
-			"%s: failed to request_irq: %d\n", __func__, rv);
+			"%s: failed to request_irq: %d\n", __func__, err);
 		goto err_disable_msi;
 	}
 


