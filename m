Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2295AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79FE206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="GujSemkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFNDPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 23:15:37 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:38050 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgFNDPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 23:15:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49l02q3CBPz9vYfL
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 03:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aji2tq_L6uqu for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 22:15:31 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49l02q1dSsz9vYdM
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:15:31 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49l02q1dSsz9vYdM
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49l02q1dSsz9vYdM
Received: by mail-il1-f197.google.com with SMTP id v14so9506442ilo.19
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXGIj3w1yVBS8cfW/zmC/b0yQf048QtoGJ5/O/lSkls=;
        b=GujSemkDgYkmQ6TzVyyR+dOZ5DTxdroUrcrQu9/15CrlDzCrUDPx55O5GhAzWLOV9d
         hiORMnLrwN3mJB5NpgAvOA/NFfU4Glan2Yxq+FP6n3QI/ud7+N/cemQSnRb7hrvXWUbt
         buuDCeZvwwRmzG0T4DPr3p4zUfpiNgCmVnpSGo2ZdDK+iToqyMFI3gTgIwGuUrruYiI/
         d1ITrnv452S93jEMLHkVfZFm1sUiPBq5I6TKb02p2fj6oz7uP90zg+/ewrXAnGnK85b+
         uKZqJ+bsYAOPCylH/oUi3I9LJ6qs+BVM/3yz+n4xc3T6HLfPRs+IAILZTAx6rg4s1eDT
         gs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXGIj3w1yVBS8cfW/zmC/b0yQf048QtoGJ5/O/lSkls=;
        b=IeQ6W9zWImQeACq4IPmFtM8ovk3xImk322I0ffqNc/LqlJOy27dTDYF/xT6FyuHnZ3
         mn5jCA0y0E+UXKzRJweS+aZaBX5kiGhR2/u1pmJOTGtkh2hfDUv+n7dTKgvkLgirhX6W
         L/Zl77HXJnfUrf71kSaDT5DM83wjrv1bkhbDulOCFcssz/2wbE0jta4knubdLOP/QLBE
         93JBwyA5LRgzyqu2ykq3vRGgzWLNjonBWkplEzGQVLIxqIZeOCJvsVcu1sVu9VeP+6jy
         1+44kIJlGe2iKulmoOJuZx3MZRLdtM2PZbkkCTsTnbUMt7hMiugqprKtUmqINhfjN6xw
         /gMQ==
X-Gm-Message-State: AOAM531eQ0Ab7nZqvahuFZqXrplG7dpfmT9Zn5LKBdvjKM8W8qfaC8GQ
        Ix40o/gD6OO72FYbRgaB6JNmKXDGnXQce9iZRYy3hSpWzI+0BQS1kmYkmBb2lyDeg+SCS/MYTbB
        jKCL7W6oI5M2Ed12gAGHMWVEw56ib
X-Received: by 2002:a02:6605:: with SMTP id k5mr15606039jac.32.1592104530224;
        Sat, 13 Jun 2020 20:15:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2aMBvp3RZakdn77go2evc1SrKFgZNruyEMxHqmY5sbSNA6239KocqzN/goOWJX0cLIiwD/A==
X-Received: by 2002:a02:6605:: with SMTP id k5mr15606026jac.32.1592104530000;
        Sat, 13 Jun 2020 20:15:30 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id d5sm5560197ioe.20.2020.06.13.20.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 20:15:29 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: pci: Fix reference count leak in dwc3_pci_resume_work
Date:   Sat, 13 Jun 2020 22:15:25 -0500
Message-Id: <20200614031525.128556-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwc3_pci_resume_work() calls pm_runtime_get_sync() that increments
the reference counter. In case of failure, decrement the reference
count and return the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index b67372737dc9..96c05b121fac 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -206,8 +206,10 @@ static void dwc3_pci_resume_work(struct work_struct *work)
 	int ret;
 
 	ret = pm_runtime_get_sync(&dwc3->dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync_autosuspend(&dwc3->dev);
 		return;
+	}
 
 	pm_runtime_mark_last_busy(&dwc3->dev);
 	pm_runtime_put_sync_autosuspend(&dwc3->dev);
-- 
2.25.1

