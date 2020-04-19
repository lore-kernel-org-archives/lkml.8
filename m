Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8857EC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B5C214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB3Fbtbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDSPFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgDSPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:05:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7082AC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:05:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so8815559wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=f5P85hmUMhEq+eY3Fw9ehsoGgopm9PSDgtwYxrXj4Rw=;
        b=UB3FbtblWCqsJJwAEUxsm67LpYnI51ri/oflUT3gRwEcpE3oOtro/2Pyno9yFIkw7R
         SWvlGrvRGjUv6hsKiFXYvrTKl4JGNDkMsdXIg5aoa/LCGRqKKJtH/C0nGEgnlxH2TyU6
         QxfF9kRqpei3BqZ2GmTVbISesOABpKjO8KEuZlfP3iJif4sfBx+8N2qjQ4YTvcKyWnH2
         Zogz4jOcxDAwf15GHC0DgEeCZd0JKr4YabErRuvw3z6PRqHSn5l03f/RDIvj5CI7uCJH
         iq8OCZhWD6c1voXRpao0tSEkJ+4FEWso57f7QnzvzOkZ0QpZPtIlNzghKlZRI2XmaPFC
         YgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f5P85hmUMhEq+eY3Fw9ehsoGgopm9PSDgtwYxrXj4Rw=;
        b=GaoRdUf17C+SgRvR+3s2of/ZMfHNAlbCUhz0LdUNg4xvAkXQPCppri3uTTyTuGFkq1
         i1UUV8Efp28l9DjaLeNKMSmeD09+1ehACZSic3GWxN62eSAHy04Of/CQstAmUKldeqRH
         32bFjBP1kC7rDoWss4FFxLYEIo7qsqp7vlQIYJQBokBZU6l8l+CC7oBz3Yvu4x6uOGT4
         AlgFDFjIljX3hzjmUXvs++FnXhFi67/4nV+KwNbCvRzpFWzUmr3DX0VdWihn/0UhCniy
         SdiTr5hNcHhtclfzxOdSkXPScvt0kkEja1knU3HMv7A2kg68/nGMdXFR8MDrIggEuDDv
         gm3w==
X-Gm-Message-State: AGi0Pub+spQp7xBG/Sqap6mTZarVVaFouavX/A3zk03RY5QsiQzlAE0n
        7rLzjFKISNEVlf59pAZiluIf6x+OawAaKFgeAWg=
X-Google-Smtp-Source: APiQypKJVViZSl1iZBIeUYfV13AGcmfiqHfkciGRh6iFjmSPINU2ia6Mo5Hmv29OfSfWyivJZNe+7A==
X-Received: by 2002:a5d:4306:: with SMTP id h6mr13371145wrq.234.1587308733878;
        Sun, 19 Apr 2020 08:05:33 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id w12sm25948635wrk.56.2020.04.19.08.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 08:05:33 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH 0/6] firmware: conduit method helpers for SMCCC v1.0 calls
Date:   Sun, 19 Apr 2020 17:05:24 +0200
Message-Id: <20200419150530.20508-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes propose helper functions and macros to consolidate choice of
the conduit method among devices communicating with an secure world that
complies with SMCCC v1.0 but not SMCCC v1.1 or later. The new helper
functions mimic arm_smccc_1_1_*() function but for SMCCC v1.0 compliant
firmwares.

This series of changes updates several firmware drivers that each define a
conduit method whereas kernel drivers are expected to use the very same
conduit. This series obviously does not enforce these drivers to apply the
proposed changes but the interest of the first patch is this series is that
at least the PSCI driver upgrades as it will allow new drivers to benefit
from the early initialized PSCI conduit method.

Etienne Carriere (6):
  firmware: helper functions for SMCCC v1.0 invocation conduit
  firmware: psci: set SMCCC v1.0 conduit and use helpers functions
  tee: optee: use SMCCC v1.0 helper functions
  firmware: arm_sdei: use SMCCC v1.0 helper functions
  firmware: stratix10: use SMCCC v1.0 helper functions
  firmware: zynqmp: use SMCCC v1.0 helper functions

 drivers/firmware/Makefile            |   1 +
 drivers/firmware/arm_sdei.c          |  79 +++++---------
 drivers/firmware/arm_smccc_conduit.c | 147 +++++++++++++++++++++++++++
 drivers/firmware/psci/psci.c         |  60 ++---------
 drivers/firmware/stratix10-svc.c     |  97 ++----------------
 drivers/firmware/xilinx/zynqmp.c     |  87 ++--------------
 drivers/tee/optee/call.c             |  14 +--
 drivers/tee/optee/core.c             |  85 ++++------------
 drivers/tee/optee/optee_private.h    |   4 +-
 include/linux/arm-smccc.h            | 106 +++++++++++++++++++
 include/linux/psci.h                 |   1 -
 11 files changed, 337 insertions(+), 344 deletions(-)
 create mode 100644 drivers/firmware/arm_smccc_conduit.c

-- 
2.17.1

