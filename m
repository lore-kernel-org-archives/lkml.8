Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7122074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em1o/scn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgG3LVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgG3LVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:21:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BE1C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:21:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so14556335wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2fKN5lB5E97AFklcPW2OKcQHBfR9S0UWEJIP7OKzhUE=;
        b=em1o/scndKx9OX1hjOQ2bjLKuLEESvFRi3QROdaMkGSL38XPZxX4JYmjw/I5GG+rWh
         XmXIiscO0vX/2qCv3Gw8MogsNP7dVzSpFwdJ/dqoQbPTa+SRDZTmvd7d1Hc1yKhMkdoR
         m49jb7exEkobJh1x9C0BHTUOXMNCPhFfcuqOFC5UeZDiiylcahnYsi58c3xJ9Hlw8VM5
         RKDuYfCOBfZBmA0aELpjKrEw9drc09Xd+lj4f04J5MlQvtSB5aHfJhzJwMZRZMwHmdNH
         yN+wKj31YKsrTSvTY2HerM53TmmxNE9gI8auJSfnz4zCSsH4dsmex6BzKJHo4R8AmDS1
         e9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2fKN5lB5E97AFklcPW2OKcQHBfR9S0UWEJIP7OKzhUE=;
        b=eECMej3rlv7Ous89zxIbH5TEiNsX0n2W8zZdxBHYNQOakaSYRDL8wZnH8jYzuYDLrX
         fR5W6lynpn80NZx2bnvnNpUmQIAomDyEPK+x0mfE40q7Gu9rtBui+iLB+6WO4/96MHkh
         zPE7wuxQTf+2IiJGc+dqmH/SFeRXf/6243hvFwv0y0u+WulWihdMECi0aowuQzOpSRep
         tF3sFQNMdpnXXaMIUC+pfX3R2WAP1Oc4Kb7yJNSPTc49lcnUQnbIMH1yCPcnFAy4Vz4p
         hu/QUu3S6X/6soC0TpBbShZ/v63+zltLjAml7w+7fypC+JaNMz6gjd7VlJHZabkEBySa
         2Zyw==
X-Gm-Message-State: AOAM532w1z3FcIDOb8akIVS4snTsIqges0oGC7sseLl4PVc/eXOqXaTP
        fIwdJC2ubVEcV4N6FZmbsItzGC0D
X-Google-Smtp-Source: ABdhPJzMYJt3iPkYVzBzU9J2bIbwqErmt0KcNR895BK67GVv9jja+wMzPbg2478W0X1FTmolttq7bg==
X-Received: by 2002:adf:e712:: with SMTP id c18mr2467810wrm.92.1596108098998;
        Thu, 30 Jul 2020 04:21:38 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id k184sm9212591wme.1.2020.07.30.04.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 04:21:37 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: unmap PCI bars upon iATU failure
Date:   Thu, 30 Jul 2020 14:21:34 +0300
Message-Id: <20200730112134.17448-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In case the driver fails to configure the PCI controller iATU, it needs to
unmap the PCI bars before exiting so if the driver is removed, the bars
won't be left mapped.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
index 7bd3737571f3..b8184cb49034 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci.c
@@ -369,15 +369,17 @@ int hl_pci_init(struct hl_device *hdev)
 	rc = hdev->asic_funcs->init_iatu(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to initialize iATU\n");
-		goto disable_device;
+		goto unmap_pci_bars;
 	}
 
 	rc = hl_pci_set_dma_mask(hdev);
 	if (rc)
-		goto disable_device;
+		goto unmap_pci_bars;
 
 	return 0;
 
+unmap_pci_bars:
+	hl_pci_bars_unmap(hdev);
 disable_device:
 	pci_clear_master(pdev);
 	pci_disable_device(pdev);
-- 
2.17.1

