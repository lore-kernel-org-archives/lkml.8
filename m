Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F13C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122D92166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ki2JsUw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgEAQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEAQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:20:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3281C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 09:20:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p25so1758031pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Yd93wm19Lo7i72T5RuGc1UE9Qy6a9u12qh3EanZNDio=;
        b=Ki2JsUw7u3B87uVo1Hhv9ITRcDD/BW6tF24CucfiCHI4w43HbDOPGZItaBOCcMOG5p
         hD91jN7Br2Vo0C8jJEMFTU85Jtx6reaOyYWVS6u5P5VcGtVZ+aAcJO9SV1G4qs91st4V
         iOo72LFGU86TOkilYb5BkxSCxwrD//JDoBJbdJ+p1DIOz2eFUyuxY9p9zSaro9ajwBPe
         Iwr4E1RTTn3ubKSnrVRe9myG3bwgrxHlAZZgi9zMawbw7Rj6QJ6QY+I4Ux/ZX5gEoHnO
         fI0bYGD67w6FBM2FyvO1LeHvWSX8cWIxQL/YOrrrPBLc3NnumdcZPh+hXm0MTttibWPb
         SXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yd93wm19Lo7i72T5RuGc1UE9Qy6a9u12qh3EanZNDio=;
        b=fVho2/fXKLY5R/uwlx6MA8tg1H5rbbEMuHjFaWBgyFs+hJwYG5I9G0JPDvv9SArWAi
         VRI8s+ye7zp6e71C65Ayz3F8pdbJJyMu9yg0HvLO4xzvEKgjgUAt6PwTmbz3ag7gsk24
         eUp6P72Iz/LjuPThlTBO4l/B+sbfCUpVxwDQ3ped+4mWduzsQRJu13Z4+W10Mab27N4E
         j7eeUolL8b63Kk5t8cGl1jZwpGustD93vNm4XNAHFQQD0/4LyMU9FDCp9HVdMCQSFH6w
         8aM/pY2G2RBQopkXeVRUsgXv7XXYKFjmC9HGgYwKJjrjmr2H02vK7QjgylxocGP3eljW
         1JGg==
X-Gm-Message-State: AGi0PuYpYt8MO+hZZDXw1mBdp/wVzx9Qwr8V/wgweBUT26yaf6OXQ+Sk
        roniR/9a4H4/e1FjoPnjOa8fDQ==
X-Google-Smtp-Source: APiQypK4DcqgSSTbtbUe+inFMNtdfWW4US705V2FgiSt5qIWCGPdinVayuyL5IRxeFaQo4Q9yQM9YQ==
X-Received: by 2002:a65:4c41:: with SMTP id l1mr4779951pgr.43.1588350033444;
        Fri, 01 May 2020 09:20:33 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id a200sm2547834pfa.201.2020.05.01.09.20.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 09:20:32 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        ulf.hansson@linaro.org, sebott@linux.ibm.com, efremov@linux.com,
        vidyas@nvidia.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] PCI: endpoint: functions/pci-epf-test: Enable picking DMA channel by name
Date:   Fri,  1 May 2020 09:20:08 -0700
Message-Id: <1588350008-8143-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify pci_epf_test_init_dma_chan() to call dma_request_channel() with a
filter function to pick DMA channel by name, if desired.

Add a new filter function pci_epf_test_pick_dma_chan() which takes a name
string as an optional parameter. If desired name is specified, the filter
function checks the name of each DMA channel candidate against the desired
name. If no match, the filter function rejects the candidate channel.
Otherwise, the candidate channel is accepted. If optional name parameter
is null or an empty string, filter function picks the first DMA channel
candidate, thereby preserving the existing behavior of pci-epf-test.

Currently, pci-epf-test picks the first suitable DMA channel. Adding a
filter function enables a developer to modify the optional parameter
during debugging by providing the name of a desired DMA channel. This is
useful during debugging because it allows different DMA channels to be
exercised.

Adding a filter function also takes one step toward modifying pcitest to
allow the user to choose a DMA channel by providing a name string at the
command line when issuing the -d parameter for DMA transfers.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 60330f3e3751..043916d3ab5f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -149,10 +149,26 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 }
 
 /**
- * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
- * @epf_test: the EPF test device that performs data transfer operation
+ * pci_epf_test_pick_dma_chan() - Filter DMA channel based on desired criteria
+ * @chan: the DMA channel to examine
  *
- * Function to initialize EPF test DMA channel.
+ * Filter DMA channel candidates by matching against an optional desired name.
+ * Pick first candidate channel if desired name is not specified.
+ * Reject candidate channel if its name does not match the desired name.
+ */
+static bool pci_epf_test_pick_dma_chan(struct dma_chan *chan, void *name)
+{
+	if (name && strlen(name) && strcmp(dma_chan_name(chan), name))
+		return false;
+
+	return true;
+}
+
+/**
+ * pci_epf_test_init_dma_chan() - Helper to initialize EPF DMA channel
+ * @epf: the EPF device that has to perform the data transfer operation
+ *
+ * Helper to initialize EPF DMA channel.
  */
 static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 {
@@ -165,7 +181,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
 
-	dma_chan = dma_request_chan_by_mask(&mask);
+	dma_chan = dma_request_channel(mask, pci_epf_test_pick_dma_chan, NULL);
 	if (IS_ERR(dma_chan)) {
 		ret = PTR_ERR(dma_chan);
 		if (ret != -EPROBE_DEFER)
-- 
2.7.4

