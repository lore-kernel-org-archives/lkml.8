Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8961C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF0420732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpL3UtMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442142AbgDOUtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438348AbgDOUtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:49:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A94C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y25so568279pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+vFGqxc5dPMJeeeZ5Cnx0EVWnNSJOtmLF10sG/N2cg=;
        b=XpL3UtMAZ15JobghNWqXKOX8dms54fCKgtwZ5ggE9fNzMVpPAQ3uPRv7Eks9RFEWrW
         UQTfVeabUc53q07V7ZidluUIlTkE7a0NUBffTUeTNmQVy7xHLWysJLQMZ/MbaZuklZv0
         HVcLNA42aLEfXshpus9WM2FD3hk29w9gmuwY+0FX6dFMDaE/a/Dpd6ypBYCE74yRtTob
         XYIouV+eNCiCT32Og/Ev6ijlwLebqF0m0el1kVSEWZkT7enXvSboXSnKuOiuxHvupfAi
         8sKxFsPExMM3jpOYQbzGHu7in+wV/G9QH7qdK14ppUK+IOWHitgXXIU0cSo9dDVJ4kkA
         NdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+vFGqxc5dPMJeeeZ5Cnx0EVWnNSJOtmLF10sG/N2cg=;
        b=trol+JjMHmY+HXnX5hn/eMUvYOfWOAaQXNzZnsd0NsRZ6ZqF27dbIZFp6g4rmxK9h8
         OEPcW3zgAucCMx2pIkICis3jPdXULtt3GV8pxIFbQ0vWwZ8/bFBaQKUdnF4TzT8f4RR/
         3STJWQTXWwtgXVKNc1pO2ZHAFqU3ydrOX7l0QxURUqHN0rdAK9fVkpLAIg9OGwGkQkIG
         48INsN50j+kjp2Qd6Mu2diVe9p05HnUh+o7oNvvlb5TjWGeq/vZfFzyPj/k5nM4zNQ0W
         uyRrpkuYW49cSX5B5Dh+b1AbdzF/VekhgGHUabjgQm5MtPzx/JERt63hQKsBDZ8cmvnh
         xvYg==
X-Gm-Message-State: AGi0PuaTw1RDm5CIPiZ6yDCMXpYoDg2YInQmB9UmuMT/ZOCi55DH8MF5
        9u9mgxKsSGgD9QnGnde5q3gpBg==
X-Google-Smtp-Source: APiQypKe2P93/Xi7Xk5IDgAVAIbp0ygmih9rQoW9IY4TRBaifF/Bc6a7ZirWAVWS9fZqp4BC6L9oIQ==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr12625559pgc.241.1586983740413;
        Wed, 15 Apr 2020 13:49:00 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i13sm14461861pfa.113.2020.04.15.13.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:48:59 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, elder@linaro.org, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] remoteproc: Refactor function rproc_alloc() 
Date:   Wed, 15 Apr 2020 14:48:51 -0600
Message-Id: <20200415204858.2448-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon,

This is the second installment in this series, the first one can be
found here[1].  The goal of the work is to consolidate modifications to
function rproc_alloc() that were made over the last weeks[2][3][4] to
provide a common foundation to work from and avoid merge conflicts.

Applies cleanly on v5.7-rc1

Thanks,
Mathieu

New for V2:
- Reworked title for patch 01.
- Added "Fixes" tag to patch 01.
- Using kasprintf() instead of complex memory allocation.
- Using kstrdup_const() instead of kstrdup(). 
- Reworked rproc_alloc_firmware() to use non-negative form. 

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=270239
[2]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=261069
[3]. https://patchwork.kernel.org/patch/11456385/
[4]. https://patchwork.kernel.org/patch/11473241/

Alex Elder (1):
  remoteproc: Fix IDR initialisation in rproc_alloc()

Mathieu Poirier (6):
  remoteproc: Split firmware name allocation from rproc_alloc()
  remoteproc: Simplify default name allocation
  remoteproc: Use kstrdup_const() rather than kstrup()
  remoteproc: Restructure firmware name allocation
  remoteproc: Split rproc_ops allocation from rproc_alloc()
  remoteproc: Get rid of tedious error path

 drivers/remoteproc/remoteproc_core.c | 96 +++++++++++++++-------------
 include/linux/remoteproc.h           |  2 +-
 2 files changed, 54 insertions(+), 44 deletions(-)

-- 
2.20.1

