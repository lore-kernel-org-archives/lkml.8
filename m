Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0D3C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149D82073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skTHAeXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCXGLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:11:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46477 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCXGLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:11:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id q3so4236634pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DDkHgjRX92xMsDWF1JcBaoBx76iEMkH2nFLPTXKtP7s=;
        b=skTHAeXIhbUwd2ORJ1F8FBs5Wpu5ah/ctTwjkpQcD+R8XqsF9RRgg0Ejf/bifSI59T
         d8xz2zrKd7pE7BXNqp9Z06gUCf6LLNsZ7QMMbWkXSgGYN0ojOGDIr6ZMlqH/dHNlVfzW
         fi11hUvMeu90VjEt/nQNMdqwC/6C9OjBN59QKlAOBvjAlTJ/tNe8570Pb4kLJHXCumS7
         RFCiNEC8MP/xHeHiWu3OmEOvU0SUhFh5bA2/oTkki/ddVQblK7hOLD3L+wPU5X4I1Suj
         WqJNhFa24BKVt7cMxviK5SPAizVrom58XDTiXNRKFgFTnXn3I8AlqQipQzMYzyJFer/K
         zgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DDkHgjRX92xMsDWF1JcBaoBx76iEMkH2nFLPTXKtP7s=;
        b=a00UpY3KICOIhqWAcinnZrFnE5xPwl1W2FzvDM2gy5B9DxQdVxEImIENmcW8IlvgiI
         apmyEoiTk3ueXqbK7NRv50Cf6ixweEtmPrBukLPmeqtZXlol775wIwZaKKbTnMUduSs8
         +AffWBwnDu0TTIjXUcyVgRR2SSWlL4tZwc87cLCC02+jhb98Xbs8vgfkFjxki9QAG4dW
         lcspbQPV3C3hxhMeJrFQIdH0Hh7j6AYUk11mVo/GTT+Ko9aYrIkjCeaJe3KPnBPjQQY8
         7Z2h9d6FSD6Xk+IquSMSUIjKhDih0yYR3hnhFJhOKnwDPljbbEVYAf2yhvZmJaZhyDd/
         WsLQ==
X-Gm-Message-State: ANhLgQ1PFj1G+0oD1nB+BblshExlt/GieuMCspMVxkyPK5pAmk33XmWu
        4eC5vjBG9qMUU9T7GUXIxIBJ
X-Google-Smtp-Source: ADFU+vtFjU8hCMS0wU/7AfSlBHHkwypFdy8aUWxUycTl6JMb83rMb9R52E24OSd2ncb4timI6+SpgA==
X-Received: by 2002:a62:a119:: with SMTP id b25mr27727359pff.158.1585030261003;
        Mon, 23 Mar 2020 23:11:01 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:59b:91e:2dd6:dffe:3569:b473])
        by smtp.gmail.com with ESMTPSA id d3sm1198230pjc.42.2020.03.23.23.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:10:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/7] Improvements to MHI Bus 
Date:   Tue, 24 Mar 2020 11:40:43 +0530
Message-Id: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is the patchset for improving the MHI bus support. One of the patch
is suggested by you for adding the driver owner field and rest are additional
improvements and some fixes.

I've also included the remaining networking patches from previous patch series
which needs review from Dave. Dave could you please look into those 2 patches
which falls under net subsystem? Greg can take those 2 if an Ack is provided.

Thanks,
Mani

Changes in v3:

* Added Bjorn's Reviewed-by tag
* Fixed commit message for QCA6390
* Added extra comment for MHI revision fields in mhi.h

Changes in v2:

* Fixed some minor comments in mhi.h

Manivannan Sadhasivam (7):
  bus: mhi: core: Pass module owner during client driver registration
  bus: mhi: core: Add support for reading MHI info from device
  bus: mhi: core: Initialize bhie field in mhi_cntrl for RDDM capture
  bus: mhi: core: Drop the references to mhi_dev in mhi_destroy_device()
  bus: mhi: core: Add support for MHI suspend and resume
  net: qrtr: Add MHI transport layer
  net: qrtr: Do not depend on ARCH_QCOM

 drivers/bus/mhi/core/init.c     |  39 +++++-
 drivers/bus/mhi/core/internal.h |  10 ++
 drivers/bus/mhi/core/main.c     |  16 ++-
 drivers/bus/mhi/core/pm.c       | 143 ++++++++++++++++++++++
 include/linux/mhi.h             |  57 ++++++++-
 net/qrtr/Kconfig                |   8 +-
 net/qrtr/Makefile               |   2 +
 net/qrtr/mhi.c                  | 208 ++++++++++++++++++++++++++++++++
 8 files changed, 474 insertions(+), 9 deletions(-)
 create mode 100644 net/qrtr/mhi.c

-- 
2.17.1

