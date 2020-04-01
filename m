Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7F9C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C903206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpVU1R96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbgDAGpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:45:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38859 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgDAGpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:45:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so10993567pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 23:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=csVYTYfjTqbGWMeGQR9zKoMblf3SbVsagJxZkrL+InA=;
        b=hpVU1R962Piv0K4jnO+Nr/AyCJsL8pX+aUH0/uLvf4naOP4yDk1SgEF8dtifL2TAaV
         XoO+3j2sy8c0oETI4zi/3jNj8EUNWpO2LdssXmUC7IRFuV5hWlBXG5rN382pnIQL0lw9
         hS8wN0zoAGAOG4AEP2nswH0qpG61io4jKa3tAx1IRvzJca22F2O8FE3p/jW3tRU66pFC
         4kb/WLXY9v+WNRoi4SPjMDGZWmS3LQP6OfnB8oPqTMsWeAGB+GYa7/TyvaCBdf5ouAWX
         CsQx2Dyav84QOSNvJiUiOvc0A89+28m2ZGHf9xcLdaW88VDrCD+DuCo/zyt0OdgvRsWC
         Md+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=csVYTYfjTqbGWMeGQR9zKoMblf3SbVsagJxZkrL+InA=;
        b=Y7R/jYlmKlcNA9QYlaSjLkp0oE0uHVKBQdlF6uoogzkS6evSzY3Gr/52JSsyDHTBLH
         rXoxUN8xSAucFS3D7ZPX3tSjQlyq+vCOOgHT+XtKTlAWMwBpVe9u/rj+gMIUY7F2yVB/
         grdT87Nbef2u0/SJdAPCZ8EdzjfGW08rUSCRqHqXj4Nr3ZtIohC64Wnjrtoxt3Fm6rEn
         JZVlNW3IH7PmY5Hn3s3xrKgH2GTR2u13w9Estzy6QMAR5H/56EAq7sW5iuZu+w5/M4Bu
         18QmdUADI+BScqj5rewQTLy8Mrf7wscrKAd96tu5l+GoqTIZ3W04tB5/aDaPL7RP6B/I
         QgAA==
X-Gm-Message-State: ANhLgQ0WuAsAWHA1rUGP3+7myCsAYGCMnITeADmGfCSlZyTc2Njl/3AH
        YlgBfVyPnKqNR9cd82A8BIo2
X-Google-Smtp-Source: ADFU+vvgzMtlpPO2xjjNC3QCrYxppVjHEzjMoYTmj9+Uw43brLLRXBvEMJHpSB+LOOogC10+wWjAVg==
X-Received: by 2002:a63:f95c:: with SMTP id q28mr20973084pgk.321.1585723505866;
        Tue, 31 Mar 2020 23:45:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:648c:592d:60f5:6f58:e46:db78])
        by smtp.gmail.com with ESMTPSA id w24sm831962pjn.14.2020.03.31.23.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 23:45:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] MHI bus improvements - Part 2
Date:   Wed,  1 Apr 2020 12:14:32 +0530
Message-Id: <20200401064435.12676-1-manivannan.sadhasivam@linaro.org>
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

