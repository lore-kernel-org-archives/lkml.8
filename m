Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0938C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF31F2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XH0hSXeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgDBFgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:36:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44744 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgDBFgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:36:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so908196plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 22:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HyrxYPPKtExm1NfMHVW1Pd1VfNh6VOJr0yFtpDNvGk8=;
        b=XH0hSXeUWPJPrlWZMRtC5FNOQI/7YR4vE24emThPzV5vJI3GTtnIExpmt1kg2no4IT
         WByEes1UHudWitsY7ZlyIKkEPvop9YQN0mPx2/ms88yRpqTLgyFH2JpUAHEf+SKudQRB
         mS7NDcoiLFcQg7A7npN/3joYgRU2qNvvp7uvekK2w+87wRFSgyd3jDrk+fIjvZL96Occ
         bBZy0pkZjNEhGMsltrrlVMNgV/6FwLdb47OTA4ga9Low/cZQqcoPVH1QLHJmysEGsyDv
         PuUratjr4a5AwSvhP8EL3hG67K0F4KdbiyLDHShkmSmcOVJ/7+JMaC3SZZxQtkPvUV49
         snvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HyrxYPPKtExm1NfMHVW1Pd1VfNh6VOJr0yFtpDNvGk8=;
        b=jhx5MzuSuNpSHgy/vdunM83LYO476OtaHHwW3ev67/B10CWDdwTYL0scyptek9QzJ4
         CS052IovErs0Z/qq2sUrl7a9IAlQzawHgcxPERfi/ktzD0IXYMGtHcRi6Fy2GLj7DIam
         7TmVI9EdivKn6eiM8xrOZ5XzKZ/jAZ0lfCX1mgdWMJ0mHn/fF3+fcKi/CHvV5mdnqvQb
         ESMFmucLsOC2FErHSTY5LCgDAVBXjHrvTUpdb0axEFPPxxgJaYii7ffgz5ARA3QjEYJ/
         LXfYEJS4swE5qjqQYp7kCfEtrzsrdUc3Mcp+rR85tQwMKcs2EwKpbJoTFjYNwWRz1p73
         6iwA==
X-Gm-Message-State: AGi0Puag75jKHRxgw7X9EfffXpElrjUKWMysjqMJWbbd30NMqYcqgsfa
        ltjSR7F03nY4M0vqFDVpEXuR
X-Google-Smtp-Source: APiQypJrVmmFTASNA3/Kl8d+BLrNiNdYmcxa75r+p43PyWSfwbnSKIvKCBbOpdgiRqeEZJSq8invcw==
X-Received: by 2002:a17:90a:db54:: with SMTP id u20mr1878643pjx.140.1585805781347;
        Wed, 01 Apr 2020 22:36:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:29a:a216:d9f7:e98f:311a:69f6])
        by smtp.gmail.com with ESMTPSA id s14sm2684824pgl.4.2020.04.01.22.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 22:36:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clew@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] MHI bus improvements - Part 2
Date:   Thu,  2 Apr 2020 11:06:07 +0530
Message-Id: <20200402053610.9345-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are the remaining patches left from the pervious series. The QRTR MHI
client driver has gone a bit of refactoring after incorporating comments from
Bjorn and Chris while the MHI suspend/resume patch is unmodified.

Dave, can you please look into the QRTR MHI driver and provide some review?

Thanks,
Mani

Changes in v2:

* Moved sock_put() before consume_skb() in QRTR MHI client driver

Manivannan Sadhasivam (3):
  bus: mhi: core: Add support for MHI suspend and resume
  net: qrtr: Add MHI transport layer
  net: qrtr: Do not depend on ARCH_QCOM

 drivers/bus/mhi/core/main.c |   3 +-
 drivers/bus/mhi/core/pm.c   | 143 ++++++++++++++++++++++++++++++++++++
 include/linux/mhi.h         |  19 +++++
 net/qrtr/Kconfig            |   8 +-
 net/qrtr/Makefile           |   2 +
 net/qrtr/mhi.c              | 126 +++++++++++++++++++++++++++++++
 6 files changed, 299 insertions(+), 2 deletions(-)
 create mode 100644 net/qrtr/mhi.c

-- 
2.17.1

