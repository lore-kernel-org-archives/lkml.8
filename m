Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5549BC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9DB20578
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vhhy8hS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgB1JAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:00:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38433 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgB1JAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:00:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so1393449pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N1F/bpv1kOPGzHOo/dvtOAcabQfC9mTkgd+qNe4q6u0=;
        b=Vhhy8hS0v7tKFYFnjFK9GFpPGvPzWfpQOyOBCijvVDU5Mq6Ozt3ctaJ1iX9IJfcqWR
         Q1FiRbA29Y5bNRjmS7ogDl3GUd7kkVfo+kGKnFYKdGKVZmHoFWWC3ZGGBLnlceKlvQMs
         8tYTYqvMd7JD96hqSV7VILCCjpzc6XrbQkNfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N1F/bpv1kOPGzHOo/dvtOAcabQfC9mTkgd+qNe4q6u0=;
        b=KoFnde43LTYUBKAzgU3UpwaH4Gz9wHSXF2XJ/4sYKMH+xvoZQJOyTB4UoPmaeO8OTD
         eUaMdS/iCs0O1aqb4LUxVjtnZtqBXc7NA+x3Zz4Tb/ZoquCWDZZhoIAGrsNO1E3MrHf3
         6VFQOS13ZS+R9KJICS533UqgHgPukjJlt+RWJgLrhhOpSmk63VMVv+VqMvjC5w0aq8bj
         /xA2V8S7E3FuIumNOe/Y0w4rCQPdQnyg1QHzfPwro5iVRi/eCr29CxLLhp5uORcYLZme
         KgFrrhVKBDfq8Zi3sTvYFmyWnYrd84GHj5f+UYMwPUc+9FCFoaOBbl+Gwhxpjj5kOhJ7
         U+mQ==
X-Gm-Message-State: APjAAAXMaPmhtes14MdPzoI4X0zddHBpb3Mj/d36g3cjQXAMTDR0SRDh
        hKaYOVTVxrGWFsD6QyNYBvZnQkKLcIk=
X-Google-Smtp-Source: APXvYqzu+TNq51ZyH/yM6O1Cgur6Ni67ucIAGI7MfIy5AsohygPh7PQ4iWwtKBYNwiphZZ42ldk0zA==
X-Received: by 2002:a63:7013:: with SMTP id l19mr3532509pgc.58.1582880438402;
        Fri, 28 Feb 2020 01:00:38 -0800 (PST)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id h132sm5841419pfe.118.2020.02.28.01.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 01:00:37 -0800 (PST)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] mailbox: bcm-pdc: Remove unused struct member "size"
Date:   Fri, 28 Feb 2020 14:30:27 +0530
Message-Id: <20200228090027.25685-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused struct member 'size' in pdc_ring_init() function.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/mailbox/bcm-pdc-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index fcb3b18a0678..3eac338c8f7d 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -253,7 +253,6 @@ struct pdc_regs {
 struct pdc_ring_alloc {
 	dma_addr_t  dmabase; /* DMA address of start of ring */
 	void	   *vbase;   /* base kernel virtual address of ring */
-	u32	    size;    /* ring allocation size in bytes */
 };
 
 /*
-- 
2.17.1

