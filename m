Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460C0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 03:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FAF20727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 03:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VA99b1HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbgEWDFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 23:05:08 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:36090 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387492AbgEWDFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 23:05:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49TSry19y3z9vfW1
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 03:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hOHNpOh96zuW for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 22:05:06 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49TSrx6jNTz9vfWD
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 22:05:05 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49TSrx6jNTz9vfWD
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49TSrx6jNTz9vfWD
Received: by mail-il1-f200.google.com with SMTP id d8so10313963ilo.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4APjft/5VvetHiIznyWdv2vIr+e1uIVsN6rb4yHlPI=;
        b=VA99b1HY2OCME05zDpyX6XVw4kEAgvxKrRRUhYAOhFIiAu9+SLhhd/tLM2GxxOpNpR
         OIQq93cVOn6cqM838gyozL2a8kyd1x2LmwqNEdBdXNYPJcrumXQzlNy8kgvg89XW55iH
         N/F80sFaONQsq+a8J+vO2YWCiqg1hohgaZLoZ9vYfnouwXZWWxdzOKxbJOjP3K6QXqpy
         pPFjeJ3/IU8AnBJQCVIkOEHgM1ihLkN403Di/x4NR1BgYh1h5a07VQQj4kT/ymhcFi2A
         SAtUggp2julTWCrxn3J6H6Mn2LcR3y1mWWCCTP2uNIjIBoRPcKhdgKRS+bBcRNT6tM45
         /HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4APjft/5VvetHiIznyWdv2vIr+e1uIVsN6rb4yHlPI=;
        b=uiA6WDjXPBAo0QWmXZmVf1lnVbbfz8Pc6mdweeVmi21uBZY2CpXszKUWA3Blw5sy9e
         59X/PLe/LlvwrcW9UEZMD7bqWtMiF5lI3WumCDPfhjVEmkMT/RcezyWq0JTvm/pj4cLi
         D07LE9/guVOa0Y/lidJjR7Z4gXujgAw2LPb3t22SM71LkBZsEZ3i/OgtfuunUw5/qlW3
         h8ownmm1ZXqTfaEM8l8swGRbJp1H3regue6NA69SdbLG1gdZKJ2phY4mXdbskYUbPAUy
         xFjDuBxKQUHXTDBz4sU4dfRQAfQ7WxQ+mf/g1WFPwe3qdV/2Z6v+Pl9jrS+xuklbSZtR
         FJBA==
X-Gm-Message-State: AOAM533dEhAlfFCEz4wPY7g+fD+Uo9K1eA1pl4lpxEjitN3YlkexQesE
        PbDTv8J2hbqpJO4wca0GBIEXTdKz1eZxDxUohTG0CHvZwaSN/Uol06iHRaCVDGF5H/JazhIDfox
        nVSZ9tR1jZljG0DR1N1bje4AF3MMC
X-Received: by 2002:a92:a199:: with SMTP id b25mr16770649ill.77.1590203105491;
        Fri, 22 May 2020 20:05:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysOKS8U5syUfh/x1v52pLjo8By1qmPmyAxMt2dObO1CEXzbBkpWlS4XnWTRgSZkVNwW2OCLg==
X-Received: by 2002:a92:a199:: with SMTP id b25mr16770629ill.77.1590203105129;
        Fri, 22 May 2020 20:05:05 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id q78sm5634989ilb.25.2020.05.22.20.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 20:05:04 -0700 (PDT)
From:   wu000273@umn.edu
To:     aditr@vmware.com
Cc:     pv-drivers@vmware.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] RDMA: fix missing pci disable in pvrdma_pci_probe()
Date:   Fri, 22 May 2020 22:04:57 -0500
Message-Id: <20200523030457.16160-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function pvrdma_pci_probe(), pdev was not disabled in one error
path. Thus replace the jump target “err_free_device” by
"err_disable_pdev".

Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index e580ae9cc55a..780fd2dfc07e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -829,7 +829,7 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
 	    !(pci_resource_flags(pdev, 1) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "PCI BAR region not MMIO\n");
 		ret = -ENOMEM;
-		goto err_free_device;
+		goto err_disable_pdev;
 	}
 
 	ret = pci_request_regions(pdev, DRV_NAME);
-- 
2.17.1

