Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB5BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A8C20678
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OH7iWFoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHKFcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgHKFcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:32:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63240C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:32:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so1264180pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDW8GZfBUCMf0R5RQS+TdRNbfrugle98/9+/xg/t7LA=;
        b=OH7iWFoQpbu6NmweyZfdS27s0Vntsrcjoz+PaGa1fW60EAV87oThHj88yOe+Z/ryBU
         9RLhq8Z69GLyBEx+jxLss9Vxq5nM0xoMmUqwv+Q5emej65DCgxLbJM4FqltxIU6j2778
         WdFTAB/bjQg2fxVJDrEOiq2tiZ/xgMa+BKItTx6VU9u3IkAttgxqPjjrFweq+JhVWebO
         BFHguhjRu8/qXQjc9Ta64Ds1gvtEyMbuTroYj1rFnwSl04frpFD9wKUA8PKJwduoE7fF
         BzOP1pV0XR2t8GUOcnM+Er/TU+qlai2DO44pM/7xsErh0/wI1K+ieH4Ytr+VGhweaWEY
         Mp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDW8GZfBUCMf0R5RQS+TdRNbfrugle98/9+/xg/t7LA=;
        b=TokY9zi2UCsDV6IbFxPUWHQLv87XEpcid71zdqcfgGY0uc+2vQlQX+asPeiIKMm5ur
         tGQmPwvLSoaRCf2Vl2RYKINy97KKOKhMH/sIGifQzfLcYVmMV9HTjH7loi2/8zWDoT31
         BjmdqFoiwwqsOQdLT7qQVbaldVCW0JmttfLH6uwvjZk3ixz/6DF0z7LTHG1kC11AKVJJ
         md1Dp4cq0rHyq7wqqHUE9LQehA3tDDXrUqYrGrWbjQ+1gkyEZXMJaWGI9ifyiELgOcNz
         HEpmnLzitC5kmJkcVnlFDknbV9ihoYXRGhuomxWz1dQPwF/S3KmeLiocOSD5y8U1YoAX
         X5rw==
X-Gm-Message-State: AOAM533wiEelKK8+dSLAUfFaCK3iMUeDjlF3mgfRGUKTDppHYcEdkf/u
        Nx93N7NoWGPCRwSca3Z3oO8FJw==
X-Google-Smtp-Source: ABdhPJwQeizbKdB05qhy5JyqYL8+85N/Npg2ikA79bowRXyqq7ncpibyfJDQxN6WOUsvu06x38oHRA==
X-Received: by 2002:a17:90b:20d1:: with SMTP id ju17mr2807885pjb.219.1597123922861;
        Mon, 10 Aug 2020 22:32:02 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q7sm24048818pfl.156.2020.08.10.22.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 22:32:02 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>, Suman Anna <s-anna@ti.com>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Alex Elder <elder@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [GIT PULL] remoteproc updates for v5.9
Date:   Mon, 10 Aug 2020 22:28:32 -0700
Message-Id: <20200811052832.404425-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.9

for you to fetch changes up to 62b8f9e99329c92286534d05dac9dc0a6e0ba0cf:

  remoteproc: core: Register the character device interface (2020-08-04 20:17:08 -0700)

----------------------------------------------------------------
remoteproc updates for v5.9

This introduces a new "detached" state for remote processors that are
deemed to be running at the time Linux boots and the infrastructure for
"attaching" to these. It then introduces the support for performing this
operation for the STM32 platform.

The coredump functionality is moved out from the core file and gains
support for an optional mode where the recovery phase awaits the
notification from devcoredump that the dump should be released. This
allows userspace to grab the coredump in scenarios where vmalloc space
is too low for creating a complete copy of the coredump before handing
this to devcoredump.

A new character device based interface is introduced to allow tying the
stoppage of a remote processor to the termination of a user space
process. This is useful in situations when such process provides crucial
resources/operations for the firmware running on the remote processor.

The Texas Instrument K3 driver gains support for the C66x and C71x DSPs.

Qualcomm remoteprocs gains support for stashing relocation information
in IMEM, to aid post mortem debugging and the crash notification
mechanism is generalized to be reusable in cases where loosely coupled
drivers needs to know about the status of a remote processor. One such
example is the IPA hardware block, which is jointly owned with the
modem and migrated to this improved interface.

It also introduces a number of bug fixes and debug improvements for the
Qualcomm modem remoteproc driver.

And it cleans up the inconsistent interface for remoteproc drivers to
implement power management.

----------------------------------------------------------------
Alex Elder (2):
      net: ipa: new notification infrastructure
      remoteproc: kill IPA notify code

Bjorn Andersson (4):
      dt-bindings: remoteproc: Add Qualcomm PIL info binding
      remoteproc: qcom: Introduce helper to store pil info in IMEM
      remoteproc: qcom: Update PIL relocation info on load
      remoteproc: qcom: pil-info: Fix shift overflow

Guennadi Liakhovetski (1):
      rpmsg: update documentation

Kefeng Wang (1):
      remoteproc: qcom: Add missing slab.h

Lee Jones (2):
      remoteproc: remoteproc_core: Use 'gnu_printf' format notation
      remoteproc: qcom_sysmon: Solve function header bitrot issues

Mathieu Poirier (22):
      remoteproc: ingenic: Move clock handling to prepare/unprepare callbacks
      Revert "remoteproc: Add support for runtime PM"
      remoteproc: Add new RPROC_DETACHED state
      remoteproc: Add new attach() remoteproc operation
      remoteproc: Introducing function rproc_attach()
      remoteproc: Introducing function rproc_actuate()
      remoteproc: Introducing function rproc_validate()
      remoteproc: Refactor function rproc_boot()
      remoteproc: Refactor function rproc_trigger_auto_boot()
      remoteproc: Refactor function rproc_free_vring()
      remoteproc: Properly handle firmware name when attaching
      remoteproc: stm32: Decouple rproc from memory translation
      remoteproc: stm32: Request IRQ with platform device
      remoteproc: stm32: Decouple rproc from DT parsing
      remoteproc: stm32: Remove memory translation from DT parsing
      remoteproc: stm32: Parse syscon that will manage M4 synchronisation
      remoteproc: stm32: Properly set co-processor state when attaching
      remoteproc: Make function rproc_resource_cleanup() public
      remoteproc: stm32: Parse memory regions when attaching to M4
      remoteproc: stm32: Properly handle the resource table when attaching
      remoteproc: stm32: Introduce new attach() operation
      remoteproc: stm32: Update M4 state in stm32_rproc_stop()

Rishabh Bhatnagar (6):
      remoteproc: qcom: Add per subsystem SSR notification
      remoteproc: qcom: Add notification types to SSR
      remoteproc: Move coredump functionality to a new file
      remoteproc: Pass size and offset as arguments to segment dump function
      remoteproc: Add inline coredump functionality
      remoteproc: Add coredump debugfs entry

Sibi Sankar (8):
      remoteproc: qcom_q6v5_mss: Monitor MSS_STATUS for boot completion
      remoteproc: qcom_q6v5_mss: Replace mask based tracking with size
      remoteproc: qcom_q6v5_mss: Add MBA log extraction support
      remoteproc: qcom_q6v5_mss: Validate MBA firmware size before load
      remoteproc: qcom_q6v5_mss: Validate modem blob firmware size before load
      remoteproc: qcom_q6v5_mss: Add modem debug policy support
      remoteproc: qcom: q6v5: Update running state before requesting stop
      remoteproc: qcom_q6v5_mss: Remove redundant running state

Siddharth Gupta (2):
      remoteproc: Add remoteproc character device interface
      remoteproc: core: Register the character device interface

Suman Anna (8):
      dt-bindings: arm: keystone: Add common TI SCI bindings
      remoteproc: Introduce rproc_of_parse_firmware() helper
      remoteproc: k3: Add TI-SCI processor control helper functions
      dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
      remoteproc: k3-dsp: Add a remoteproc driver of K3 C66x DSPs
      remoteproc: k3-dsp: Add support for L2RAM loading on C66x DSPs
      dt-bindings: remoteproc: k3-dsp: Update bindings for C71x DSPs
      remoteproc: k3-dsp: Add support for C71x DSPs

 .../bindings/arm/keystone/ti,k3-sci-common.yaml    |  44 ++
 .../bindings/remoteproc/qcom,pil-info.yaml         |  44 ++
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml       | 184 +++++
 Documentation/rpmsg.txt                            |   6 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 MAINTAINERS                                        |   1 +
 drivers/net/ipa/ipa.h                              |   3 +
 drivers/net/ipa/ipa_modem.c                        |  56 +-
 drivers/remoteproc/Kconfig                         |  34 +-
 drivers/remoteproc/Makefile                        |   5 +-
 drivers/remoteproc/ingenic_rproc.c                 |  84 +--
 drivers/remoteproc/qcom_common.c                   | 133 +++-
 drivers/remoteproc/qcom_common.h                   |   5 +-
 drivers/remoteproc/qcom_pil_info.c                 | 129 ++++
 drivers/remoteproc/qcom_pil_info.h                 |   9 +
 drivers/remoteproc/qcom_q6v5.c                     |   2 +
 drivers/remoteproc/qcom_q6v5_adsp.c                |  16 +-
 drivers/remoteproc/qcom_q6v5_ipa_notify.c          |  85 ---
 drivers/remoteproc/qcom_q6v5_mss.c                 | 157 ++--
 drivers/remoteproc/qcom_q6v5_pas.c                 |  15 +-
 drivers/remoteproc/qcom_q6v5_wcss.c                |  14 +-
 drivers/remoteproc/qcom_sysmon.c                   |   4 +-
 drivers/remoteproc/qcom_wcnss.c                    |  14 +-
 drivers/remoteproc/remoteproc_cdev.c               | 124 ++++
 drivers/remoteproc/remoteproc_core.c               | 457 ++++++------
 drivers/remoteproc/remoteproc_coredump.c           | 325 +++++++++
 drivers/remoteproc/remoteproc_debugfs.c            |  90 +++
 drivers/remoteproc/remoteproc_internal.h           |  42 ++
 drivers/remoteproc/remoteproc_sysfs.c              |  17 +-
 drivers/remoteproc/stm32_rproc.c                   | 214 +++++-
 drivers/remoteproc/ti_k3_dsp_remoteproc.c          | 787 +++++++++++++++++++++
 drivers/remoteproc/ti_sci_proc.h                   | 104 +++
 include/linux/remoteproc.h                         |  36 +-
 include/linux/remoteproc/qcom_q6v5_ipa_notify.h    |  82 ---
 include/linux/remoteproc/qcom_rproc.h              |  36 +-
 include/uapi/linux/remoteproc_cdev.h               |  37 +
 36 files changed, 2795 insertions(+), 601 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
 create mode 100644 drivers/remoteproc/qcom_pil_info.c
 create mode 100644 drivers/remoteproc/qcom_pil_info.h
 delete mode 100644 drivers/remoteproc/qcom_q6v5_ipa_notify.c
 create mode 100644 drivers/remoteproc/remoteproc_cdev.c
 create mode 100644 drivers/remoteproc/remoteproc_coredump.c
 create mode 100644 drivers/remoteproc/ti_k3_dsp_remoteproc.c
 create mode 100644 drivers/remoteproc/ti_sci_proc.h
 delete mode 100644 include/linux/remoteproc/qcom_q6v5_ipa_notify.h
 create mode 100644 include/uapi/linux/remoteproc_cdev.h
