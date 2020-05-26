Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A03C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DF220888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520480;
	bh=dw6to2wRQ3SmfWu7X9TKk6vCDa1Vn/DKpM9BwBWsZAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpX6Jr91lx7YZ7zqEbDh4MwutoUrk+67KxJHo0cBc9AewSR5XwrwdC7DxB0N5nf9l
	 eXE13INQ6bdDjvLqTcGCfX9gungUVdpHxOPF1i4qLy8dpSBKygydD4ttcTz8dPM7VZ
	 F7iNpkMAULAaeZMNh3GBKFX8zK/WsXhrEegS1CKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391915AbgEZTOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392165AbgEZTOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:14:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3C2E20776;
        Tue, 26 May 2020 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520470;
        bh=dw6to2wRQ3SmfWu7X9TKk6vCDa1Vn/DKpM9BwBWsZAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uR68SBQSt5qWhpjlFuijJ6XvO0HGyXqKP80f64pIJHtnSGfvhKTjKKO+vCTPHaS1D
         J+c/Jnlc53nBvSAb0giYFjMB7wclRaVrGGi49uxgkacLBGcty+yM6Nj8TWTDmyTLm0
         oaXAjk4nRHdJngYRwJeaNq3WlWsI/w/TqEJWRVLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 5.6 092/126] staging: kpc2000: fix error return code in kp2000_pcie_probe()
Date:   Tue, 26 May 2020 20:53:49 +0200
Message-Id: <20200526183945.637923263@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
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
 


