Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40439C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3CB2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980646;
	bh=KZR/Ez5I0vI5NACVotVlfYFD1yU907tuWKBtUQ3nkUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qf0ic6KJxqPqVnMoXvd8z2knhl9YjBMevbws8xII5p9DCvhaJS3P7K+RoQCtp3tpx
	 qvQCEHjd2dHeZSsjvOWpoprsoCLUg0RxtunoKa1ZaT9SMULjtTVCjDS/+qM6cl0qqu
	 nHoiF4jPyVaS7pLTuz0uNKrxiuZlEPcVCFkNpgLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbgIARRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbgIAPOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:14:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDA32078B;
        Tue,  1 Sep 2020 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973247;
        bh=KZR/Ez5I0vI5NACVotVlfYFD1yU907tuWKBtUQ3nkUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tra0Pqy5/CmRFntPMmisO83/0FFluhLvNTv4qw4K1IVKd3cPH9vHINO/ZYdXXGEVN
         3qkvifeVXXSds2hEvZVSf7UxNL8pLHG8Gq53vK/qlcelfEbHNElFvG7iuQBtXfOTwm
         RbwBImEDSNNMBofO9AK0R92Z2nOkCh7TTY0/tzI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.4 58/62] usb: host: ohci-exynos: Fix error handling in exynos_ohci_probe()
Date:   Tue,  1 Sep 2020 17:10:41 +0200
Message-Id: <20200901150923.656117905@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tang Bin <tangbin@cmss.chinamobile.com>

commit 1d4169834628d18b2392a2da92b7fbf5e8e2ce89 upstream.

If the function platform_get_irq() failed, the negative value
returned will not be detected here. So fix error handling in
exynos_ohci_probe(). And when get irq failed, the function
platform_get_irq() logs an error message, so remove redundant
message here.

Fixes: 62194244cf87 ("USB: Add Samsung Exynos OHCI diver")
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20200826144931.1828-1-tangbin@cmss.chinamobile.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/ohci-exynos.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -166,9 +166,8 @@ skip_phy:
 	hcd->rsrc_len = resource_size(res);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "Failed to get IRQ\n");
-		err = -ENODEV;
+	if (irq < 0) {
+		err = irq;
 		goto fail_io;
 	}
 


