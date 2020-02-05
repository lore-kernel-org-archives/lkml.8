Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE1C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F4022B48
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSxQWHB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBEPzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41638 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgBEPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:54:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id l3so1158201pgi.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OeTbs3cyKvuyu1XTWoXkCtNxO0aHwZN3JCJHavQfBCU=;
        b=tSxQWHB04iYdusKGhVDF8HMwDTDEg0zV1A/JgtCqp2RNswNnWy2lPPeVDgG1U4ciMp
         S1442X0kj37yAgGsopVkcbSas1VGMoRsmtaIhuoIN0r5FkT1k9QwAwbEu8j8MEz0h1ti
         ULJqfBSFIqkaweNLnXs0rnRAsrDQWbLdoJqn0dW7NyirCHjjqvTlwJHgqU3boBikD8Q7
         Ny4WZ5J3PEuHXiDvv76MTiZ9q4OhFLeOywte1WxAnDmNUDlnbNFyAlndQI2/0Y1rGOv/
         NG4arpI04qinlAFilZmbJ5IKdmbTsefBaFkBHarRIT2QqCZMuv4OtFKnqgLX1ciZ+T+7
         vOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=OeTbs3cyKvuyu1XTWoXkCtNxO0aHwZN3JCJHavQfBCU=;
        b=GZ7NHa0M0ToSy9ruIX8NACz38AkVFf9qEUmjH2uJ1vQwQnLlTev2Xhc3XDXaH+ARSx
         1o/NWZzzLEegbO+yOa+Pi6/MO85GOkwB0QNCGM63oHMzUAxbnbxnnBWv0HZLdzQKhSlk
         W5sibBoeIghelXXnB9OEBj43E1DdPbPFxckQnqJrbAvtGvkUMi0k1O66ec5+VfUNNBqI
         6toeMQkfHB1qjFFqlRzNqbKRj7lHUPxQh4WQVTseHmKdauV3Sf5uj5z857Mq1iivepkz
         tur7wwck+81W1Ps4a4QtZPRTQaM2W8KXBYcjNG8+uQ9J/j2VRtzORF9Yr5kETcTruj4F
         cZ7Q==
X-Gm-Message-State: APjAAAW2J019I+X0P8sJxuCKcSI560huaT6qkpuD4/N/yLnb1okXuT2b
        F2L/g56EXQLABRl9pIM5Fuw=
X-Google-Smtp-Source: APXvYqyntnxc3m6CwR6tJ6zUfyr4W1jem2CU87O8i7q51eNcK1sVdFw+GQa0qFTWlHP3qLxXvyIKhw==
X-Received: by 2002:a63:1101:: with SMTP id g1mr35938303pgl.435.1580918097602;
        Wed, 05 Feb 2020 07:54:57 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:54:57 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 03/15] NTB: Enable link up and down event notification
Date:   Wed,  5 Feb 2020 21:24:20 +0530
Message-Id: <1fb68eb0ee7ee636ab92bb0b3b7340c56f4a20c3.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link-Up and Link-Down events can occur irrespective
of whether a data transfer is in progress or not.
So we need to enable the interrupt delivery for
these events early during driver load.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 150e4db11485..111f33ff2bd7 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -994,6 +994,7 @@ static enum ntb_topo amd_get_topo(struct amd_ntb_dev *ndev)
 
 static int amd_init_dev(struct amd_ntb_dev *ndev)
 {
+	void __iomem *mmio = ndev->self_mmio;
 	struct pci_dev *pdev;
 	int rc = 0;
 
@@ -1015,6 +1016,10 @@ static int amd_init_dev(struct amd_ntb_dev *ndev)
 
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
 
+	/* Enable Link-Up and Link-Down event interrupts */
+	ndev->int_mask &= ~(AMD_LINK_UP_EVENT | AMD_LINK_DOWN_EVENT);
+	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
+
 	return 0;
 }
 
-- 
2.17.1

