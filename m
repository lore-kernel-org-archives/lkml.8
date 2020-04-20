Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B540C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A39620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhX0gZE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgDTXQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbgDTXQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:16:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF1EC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:16:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g30so5719564pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xQTgpXJ4QBqY2cydxzcuHbME8SOuNbUR7Rua/VINv0=;
        b=zhX0gZE0wPeOPRlNj2LRe37QBMwZ1DbYDFr1dzAYqUicKa0pAnvSFSKU23Q5UVFJmb
         3M4w8Yc6gDpKgzqaW64gc3WrYNAg+UjsBtSCusY4J6HeCpLxgDE7glF8ClMvu/N3w+x8
         QTiueumg8N/9QAsoF2/5wDte1gN2ktpl6W5FobOC5ng+ihq7sqwkfJQZP30IsMe3Uc/2
         fA071htgTiPv3PQKt5llNmZrqQ2KFg7sT/S9t1bcDbZi2X+HMqi8m+q+WaG/zK6CSs3Z
         1Z1Tiki6UWkWcE5YQjVHDvRrCw3V51Uxb/W8V0VP3NnnHSZMA7tTbZcDwCoqsv4uoqIh
         ukSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xQTgpXJ4QBqY2cydxzcuHbME8SOuNbUR7Rua/VINv0=;
        b=XytOmzmGMXpV6gGjAqbB3kYf5o/ESqEKrQBYdbb44CR9ktg7OnnHlPhfNScuDkhvFS
         CrzPpi3lAvYkJc3m2YVx3GKJCZPVJ6ZrZUtPe7zBIeNyarVXPTkY/HpRXm+MEdb3QFXr
         qTTC6sJ24lZ7KDqQ034r0eEOxQVyRx2PMKuSGmcA18NDeekiMqnZvr0fsuYvQT5dW8wy
         IVXKeArqh6Dmo4bjC3qtZ764NDlyI92/3Wf3f5EGJqDrNv2EFvEyFixMTo4DFT0Scpvo
         Uj63xEbwG4W18TtRnhOX9x0Vl/AN4C/jkYzMPOPZDKQSEMmi59ucXhdGdRBUexrVYHDd
         M62g==
X-Gm-Message-State: AGi0PuYjYD9j9BIUtwJ1RLOV9936AQmIoKeFoFMHl1D8cyMBWxsU9LWy
        GE84MYH0wosxv1rk3OucyHIaJA==
X-Google-Smtp-Source: APiQypL4a7LQVs624sxLsAvBlFJV2UTzLt9usI0l8cClcK7Cj8snnXWciF6PC1oadYbSHDGmdIAQRA==
X-Received: by 2002:a62:7b03:: with SMTP id w3mr12591877pfc.313.1587424563272;
        Mon, 20 Apr 2020 16:16:03 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l15sm435354pgk.59.2020.04.20.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 16:16:02 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     elder@linaro.org, s-anna@ti.com, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] remoteproc: Refactor function rproc_alloc()
Date:   Mon, 20 Apr 2020 17:15:57 -0600
Message-Id: <20200420231601.16781-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the remaining patches from the second version [1] that have
not been applied yet.

Applies cleanly on rproc-next (3898fc99d199)

Thanks,
Mathieu

New for V3:
- Freeing firmware name allocation with kfree_const() in patch 1.
- Get the comment out of the conditional block in patch 2. 
- A cleaner implementation of function rproc_alloc_ops() in patch 3.

New for V2:
- Reworked title for patch 01.
- Added "Fixes" tag to patch 01.
- Using kasprintf() instead of complex memory allocation.
- Using kstrdup_const() instead of kstrdup(). 
- Reworked rproc_alloc_firmware() to use non-negative form. 

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=271809

Mathieu Poirier (4):
  remoteproc: Use kstrdup_const() rather than kstrdup()
  remoteproc: Restructure firmware name allocation
  remoteproc: Split rproc_ops allocation from rproc_alloc()
  remoteproc: Get rid of tedious error path

 drivers/remoteproc/remoteproc_core.c | 70 +++++++++++++++-------------
 include/linux/remoteproc.h           |  2 +-
 2 files changed, 39 insertions(+), 33 deletions(-)

-- 
2.20.1

