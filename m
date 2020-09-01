Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1299C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9757920E65
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974620;
	bh=ZtBz4H4zHKmKdeBV2j6B7ls2H3PJ6PDwFiAz16xd6zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vCunYsj8UHQWtYnqrqYfw8SwPtqnIGknN0dd8+VJoRtDoUTTE3sVdVwNRfz2r8oFz
	 +fpIp4tj3B15ClG9qJSOQZxv9SdpstPfQ4+vNNWqekngcPFKGUNB5WurewY9hs6pQ7
	 QDYEIx4/0cPnZgNV8rJKyPBfxnDbhs5Ae6mDOD3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgIAPgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731161AbgIAPfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:35:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E7A21534;
        Tue,  1 Sep 2020 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974540;
        bh=ZtBz4H4zHKmKdeBV2j6B7ls2H3PJ6PDwFiAz16xd6zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcG1eAF90iosU/QfsmnhvX+rM5hSsf51O/VPlfO0/pRVRO2dRA4/JDkLTJQB4Dk2J
         TrivLwdeWhMl//Emc3f+0kGDyhX+Id9CD9eJbzRupcR/h8B7A7gjE89i43yoA6zkSN
         e6P8DjZJPpwTJ4+rR2aTFFHx01Pq5nzOnIYqa8Vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.4 194/214] usb: host: ohci-exynos: Fix error handling in exynos_ohci_probe()
Date:   Tue,  1 Sep 2020 17:11:14 +0200
Message-Id: <20200901151002.244766167@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
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
@@ -171,9 +171,8 @@ static int exynos_ohci_probe(struct plat
 	hcd->rsrc_len = resource_size(res);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "Failed to get IRQ\n");
-		err = -ENODEV;
+	if (irq < 0) {
+		err = irq;
 		goto fail_io;
 	}
 


