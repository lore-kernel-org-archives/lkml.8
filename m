Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A876C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A96206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDVDjM1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgDUQjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUQjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:39:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9C0C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h2so4277550wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cpcsJig0GOzBqMohPbuz/pjFci1RE1DIPfHT1dd3q2E=;
        b=VDVDjM1PKxq8hcUmDwxm3pYN3PdcUBrRnAInUPCwYUa1C3uuW4cd0r3m5tjGfLHW2s
         REOsGcsned9GKRUYhoxUjNdl1HiXW8DTo98oRFQorITL1ewTUPqmyTQr+4Vb7K1GrFvf
         ZCkVGbd1tsz31toNZMPSJDaHwXB/IX1qifusC5u+ju+sZ6e1qrwQER7uP6zQD/mQOtWI
         tpD6rPTv4iHd9xdksU6+X+/czTM59nskYYYYLRuyuhJAAN418VnIMdunjQnFVPjJGHlG
         +Mvb9dIIiiki0fbF6clxbRE6TAAzOD/KVgqpYWA8iVOpkLbk8RKUQl23mllUyMQOoMp4
         DS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cpcsJig0GOzBqMohPbuz/pjFci1RE1DIPfHT1dd3q2E=;
        b=PoGrZ+zjz9dQBu3xSbfXdCREedfHC4HQP3ZlND3srRbJP3cFFYdHccD96tk5Yk9HL1
         VZfEKWHP7cUehXJyOt6QZa0pzBz4oy3t6TtfNQOd8HqaATHxaHv6NTXlyx43xRFho2h1
         uY3RBPcJunJcIb/AAL26i/EtzW8Uza3Z7pLjGb1Wz4ex3BfGMykhIAelZ9dBXGYShFuf
         SOC1YHzJHbbX8RJTX1m4TVtQGlY/Eue9Un9uw5kALR3lZZD4kjOUP8DZ9PxK/xfr2UdC
         R52GCsVeU+KzJWPddj3i1zjnxfXpfPUMYUBYiQEipQ52x2l4eRapx3fj9VwhClzVKCTS
         YkUg==
X-Gm-Message-State: AGi0PuYVTh0xgy+qpXt6mHCnm4zoP/eHKgmKw6R/U58ac0RQS07rQRuW
        cRKyc4hFv+Zwhrnpxw/xoSyWw2coIFtRCN6k
X-Google-Smtp-Source: APiQypLw4tm9UR1P5gxmtUBnKckudtQYp7IIUmpMLn5xxiMjaWWZ1WQX1BhGSbGdYMo6UYXnDfs1pw==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr6086580wmf.175.1587487150085;
        Tue, 21 Apr 2020 09:39:10 -0700 (PDT)
Received: from lmecxl0524.lme.st.com (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id q143sm4389055wme.31.2020.04.21.09.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:39:09 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH v2 0/6] firmware: conduit method helpers for SMCCC v1.0 calls
Date:   Tue, 21 Apr 2020 18:38:05 +0200
Message-Id: <20200421163811.22720-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:
 Fix several build issues reported by kbuild test robot:
 - patch 1/6: fix erroneous ';' in inline functions;
 - patch 5/6: fix bad function label used;
 - patch 6/6: fix bad function label used.
 Reported-by: kbuild test robot <lkp@intel.com>
 Fix function stubs to return -ENXIO not -EINVAL when SMCCC is not supported.
 Few rephrasing in commit message for all patches of the series.
 Add an empty line between a trace and a return instruction in patch 1/6.
 Add argument label in arm_smccc_1_0_set_conduit() prototype in patch 1/6.
 Fix typo in inline description comments in patch 1/6.

These changes propose helper functions and macros to consolidate choice of
the conduit method among devices communicating with a secure world that
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
 drivers/firmware/arm_smccc_conduit.c | 148 +++++++++++++++++++++++++++
 drivers/firmware/psci/psci.c         |  60 ++---------
 drivers/firmware/stratix10-svc.c     |  97 ++----------------
 drivers/firmware/xilinx/zynqmp.c     |  87 ++--------------
 drivers/tee/optee/call.c             |  14 +--
 drivers/tee/optee/core.c             |  85 ++++-----------
 drivers/tee/optee/optee_private.h    |   4 +-
 include/linux/arm-smccc.h            | 106 +++++++++++++++++++
 include/linux/psci.h                 |   1 -
 11 files changed, 338 insertions(+), 344 deletions(-)
 create mode 100644 drivers/firmware/arm_smccc_conduit.c

-- 
2.17.1

