Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C56AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5995206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8BqABZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgFHSaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgFHSay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:30:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761FAC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 11:30:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p21so9095235pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biWB3dPN1k/Nu8Kys1ISfJv9MwFbnl1hMquLBqnmV+Q=;
        b=e8BqABZXrk6xpRby099u4lwdxS2SxOXQh6ZUNSjO3ZwkL7iJ/NZyj2tiOnCLYWGFQT
         xEvw7+Fiy6jtIvmp6ImXKxIIbRVTNbnbRSLeBDZI596gU80xkaqmmdZWasJ+DHUqC0x2
         fbaoqTbGvNN5Y0PnMDZHVvDz6ezZ6fdFdtcN+Ye1agkZMYV/8WyCW3/Be+Moa2ClrEHN
         wkOGIeIsT751YVVzyxCmE6Dtzds50GUI8+V/EwjhwnjM/DPt6w9PA2v8kJOhPgrVleMr
         qylz9q7gTV0gGog4yN5HI8gqZF9V0BjGJZL78K3Bi0gWLovKWQ60Ehxhk/5cEmD5L1rF
         Wq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biWB3dPN1k/Nu8Kys1ISfJv9MwFbnl1hMquLBqnmV+Q=;
        b=k/v8qJwKb4NCVgSkyhP9Qt9liUi2NdlfSNecFTaMZ/B0rswaqfKLy5gdpl9iQhO9Yd
         Hdmciz/q4jE4jY2tK3KrXmHrOq0jBRKE2ogI+EriCn45YHPqnNMBcrPLbg1Bx3qrEP23
         2CXGAvUWyqINZJXy+dWi1aUVvAGrtsYHEbeUFNL2aNV/sGPOnKW0nnofdukidx6N3hbe
         e4ayEesMNZM/ABzNUeHO2Pi1oPmkvv6gAodGBD4kIaGXvT3E0pnuoWS+ixkDbgIZl0Of
         Qya4WFEYQEJfug/hH+2WyRBhgySzkWA0a45o9tKlOO53eEv0N8qwlX0Hg7zFfA/zY08y
         c1Qw==
X-Gm-Message-State: AOAM533oaABtywN9iyvAXzaCUp3Um5Ms9aNr6E5H3aJri66lk/R91ClT
        MZ8ATnzrW9qPF5KFy+lo6aCUAQ==
X-Google-Smtp-Source: ABdhPJwaIWUigIYxZ6eTTcKFtS1vNNDOJBJu1TCx2I1h/KXar1OjiYOAZqiNhzdlf1Af9S35H5aIBQ==
X-Received: by 2002:a65:4c4c:: with SMTP id l12mr21329435pgr.159.1591641052870;
        Mon, 08 Jun 2020 11:30:52 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u14sm8081406pfk.211.2020.06.08.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 11:30:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Clement Leger <cleger@kalray.eu>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Suman Anna <s-anna@ti.com>, Alex Elder <elder@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Tero Kristo <t-kristo@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [GIT PULL] remoteproc updates for v5.8
Date:   Mon,  8 Jun 2020 11:30:05 -0700
Message-Id: <20200608183005.2302840-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.8

for you to fetch changes up to 7dcef3988eedbfb40e7e95a821966a029a5a465b:

  remoteproc: Fix an error code in devm_rproc_alloc() (2020-05-20 12:12:07 -0700)

----------------------------------------------------------------
remoteproc updates for v5.8

This introduces device managed versions of functions used to register
remoteproc devices, add support for remoteproc driver specific resource
control, enables remoteproc drivers to specify ELF class and machine for
coredumps. It integrates pm_runtime in the core for keeping resources
active while the remote is booted and holds a wake source while
recoverying a remote processor after a firmware crash.

It refactors the remoteproc device's allocation path to simplify the
logic, fix a few cleanup bugs and to not clone const strings onto the
heap. Debugfs code is simplifies using the DEFINE_SHOW_ATTRIBUTE and a
zero-length array is replaced with flexible-array.

A new remoteproc driver for the JZ47xx VPU is introduced, the Qualcomm
SM8250 gains support for audio, compute and sensor remoteprocs and the
Qualcomm SC7180 modem support is cleaned up and improved.

The Qualcomm glink subsystem-restart driver is merged into the main
glink driver, the Qualcomm sysmon driver is extended to properly notify
remote processors about all other remote processors' state transitions.

----------------------------------------------------------------
Alex Elder (1):
      remoteproc: Fix IDR initialisation in rproc_alloc()

Bjorn Andersson (6):
      remoteproc: qcom: Pass ssr_name to glink subdevice
      soc: qcom: glink_ssr: Internalize ssr_notifiers
      rpmsg: glink: Integrate glink_ssr in qcom_glink
      dt-bindings: remoteproc: qcom: pas: Add SM8250 remoteprocs
      remoteproc: qcom: pas: Add SM8250 PAS remoteprocs
      remoteproc: wcss: Fix arguments passed to qcom_add_glink_subdev()

Christophe JAILLET (1):
      remoteproc: Add missing '\n' in log messages

Clement Leger (3):
      remoteproc: add rproc_coredump_set_elf_info
      remoteproc: use rproc_coredump_set_elf_info in drivers
      remoteproc: remove rproc_elf32_sanity_check

Dan Carpenter (1):
      remoteproc: Fix an error code in devm_rproc_alloc()

Gustavo A. R. Silva (1):
      remoteproc: Replace zero-length array with flexible-array

Loic Pallardy (1):
      remoteproc: Add prepare and unprepare ops

Mathieu Poirier (6):
      remoteproc: Split firmware name allocation from rproc_alloc()
      remoteproc: Simplify default name allocation
      remoteproc: Use kstrdup_const() rather than kstrdup()
      remoteproc: Restructure firmware name allocation
      remoteproc: Split rproc_ops allocation from rproc_alloc()
      remoteproc: Get rid of tedious error path

Paul Cercueil (5):
      remoteproc: Add device-managed variants of rproc_alloc/rproc_add
      dt-bindings: Document JZ47xx VPU auxiliary processor
      remoteproc: Add support for runtime PM
      remoteproc: ingenic: Added remoteproc driver
      MAINTAINERS: Add myself as reviewer for Ingenic rproc driver

Rishabh Bhatnagar (1):
      remoteproc: core: Prevent system suspend during remoteproc recovery

Sibi Sankar (8):
      dt-bindings: remoteproc: qcom: Add SC7180 MPSS support
      remoteproc: qcom: pas: Add SC7180 Modem support
      dt-bindings: remoteproc: qcom: Use memory-region to reference memory
      remoteproc: qcom_q6v5_mss: Extract mba/mpss from memory-region
      dt-bindings: remoteproc: qcom: Replace halt-nav with spare-regs
      remoteproc: qcom_q6v5_mss: Drop accesses to MPSS PERPH register space
      remoteproc: qcom_q6v5_mss: map/unmap mpss segments before/after use
      remoteproc: qcom_q6v5_mss: Remove unused q6v5_da_to_va function

Siddharth Gupta (3):
      remoteproc: sysmon: Add ability to send type of notification
      remoteproc: sysmon: Add notifications for events
      remoteproc: sysmon: Inform current rproc about all active rprocs

Sivaprakash Murugesan (1):
      remoteproc: wcss: add support for rpmsg communication

Suman Anna (2):
      remoteproc: Use a local copy for the name field
      remoteproc: Fix and restore the parenting hierarchy for vdev

Tero Kristo (1):
      remoteproc: Fall back to using parent memory pool if no dedicated available

Wei Yongjun (1):
      remoteproc/mediatek: fix invalid use of sizeof in scp_ipi_init()

Yangtao Li (1):
      remoteproc: convert to DEFINE_SHOW_ATTRIBUTE

 .../bindings/remoteproc/ingenic,vpu.yaml           |  77 ++++++
 .../devicetree/bindings/remoteproc/qcom,adsp.txt   |  12 +
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  22 +-
 MAINTAINERS                                        |   1 +
 drivers/remoteproc/Kconfig                         |   9 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/ingenic_rproc.c                 | 280 +++++++++++++++++++++
 drivers/remoteproc/mtk_scp.c                       |   4 +-
 drivers/remoteproc/qcom_common.c                   |  17 +-
 drivers/remoteproc/qcom_common.h                   |   5 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                |   3 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 | 173 +++++--------
 drivers/remoteproc/qcom_q6v5_pas.c                 |  68 ++++-
 drivers/remoteproc/qcom_q6v5_wcss.c                |   6 +
 drivers/remoteproc/qcom_sysmon.c                   | 116 +++++++--
 drivers/remoteproc/qcom_wcnss.c                    |   1 +
 drivers/remoteproc/remoteproc_core.c               | 243 ++++++++++++++----
 drivers/remoteproc/remoteproc_debugfs.c            |  28 +--
 drivers/remoteproc/remoteproc_elf_loader.c         |  24 --
 drivers/remoteproc/remoteproc_internal.h           |  17 +-
 drivers/remoteproc/remoteproc_virtio.c             |  15 +-
 drivers/remoteproc/st_remoteproc.c                 |   2 +-
 drivers/remoteproc/st_slim_rproc.c                 |   2 +-
 drivers/remoteproc/stm32_rproc.c                   |   3 +-
 drivers/rpmsg/Kconfig                              |   6 +-
 drivers/rpmsg/Makefile                             |   3 +-
 .../qcom/glink_ssr.c => rpmsg/qcom_glink_ssr.c}    |  28 ++-
 drivers/soc/qcom/Kconfig                           |   9 -
 drivers/soc/qcom/Makefile                          |   1 -
 include/linux/remoteproc.h                         |  19 +-
 include/linux/rpmsg/qcom_glink.h                   |   3 +-
 31 files changed, 921 insertions(+), 277 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
 create mode 100644 drivers/remoteproc/ingenic_rproc.c
 rename drivers/{soc/qcom/glink_ssr.c => rpmsg/qcom_glink_ssr.c} (83%)
