Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A06B207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXj1Cz7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgEURDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgEURDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6968DC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:02:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c75so3461805pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BDvi9M+xkQ8DYDy6nISbQv1xlb2xgpuqiWFCmxXzSnQ=;
        b=IXj1Cz7fg2904ihcRCJj+tpLbjYRMtyoJZxACGsyja88zytdmFRa5HkdXXnn05/MiF
         2z1A9CxSgZSWcDLfrcqdyJeLKugbd0Iw1BoMR7fCkHkMFX+FSbh+P4IWgnXccVIcYDMe
         PVKZLaPdzUSGZlZWKOVK1dbdvLCAfoPadqU5a9s/OcFtLyYqwzEm8NPW1QJcyi7jreTP
         mXkz/tG41cS340rdV6+36En2NpTLDjgu2DvvqFSgC0pggCPqkhNLWa1mSO8RbLap7dOK
         6PzEuKWzJ9cxENEfij+++eh7Wwg9810S4Nes8g2j9YWRGBHE2TKyjoJtnIemwbdwVzWo
         0X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BDvi9M+xkQ8DYDy6nISbQv1xlb2xgpuqiWFCmxXzSnQ=;
        b=LjOcoDBa/8LHkFk4t7EOSm8VFgHj2UB4zrwo2JlVgd6olluSFQGb/HtJIzDE00MfEn
         KB7558j2oNO+/EGWnh5jMxLznjonYrymC9jwve5BQF12mqpGX5eULLyKACWyrWhI2niu
         zAEOyrLNFT97TORDE5lxnpF6rN7dgZbA0poVK+3S0y8EF4DaOXFJdd4u1/sJwmHD6mn/
         X5JlmP87LMjQR7MiEmTr18Qu2c1tUFZFB3yh4Ik2igH+D8/sSBCwBcbJrdSxUxdfsoZL
         kQgCCukROJ+7+xQhacCazvjyy4kwU17KHW+vGbISCi+v5xsG4YBMIro4zsNE9oVM+WCr
         NVCg==
X-Gm-Message-State: AOAM5332YxpAIZP5HMt8h8qLfAniyFzPY7EWaOvjZKA0TAWyefmMUo1T
        jVRok/imcsda2AXELeyt/rhx
X-Google-Smtp-Source: ABdhPJyj0/gL7DlhGRvvKNNZf5mGxvQX6V4tdcFV+EDyVUfbTIpBCURU/CExIKXYSQX5OFX5B22XSA==
X-Received: by 2002:a63:3ec4:: with SMTP id l187mr9765112pga.358.1590080578582;
        Thu, 21 May 2020 10:02:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:02:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 00/14] MHI patches for v5.8
Date:   Thu, 21 May 2020 22:32:35 +0530
Message-Id: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is the set of MHI patches for v5.8. Most of the patches are cleanup and
refactoring ones. All of them are reviewed by myself and Jeff and also
verified on x86 and ARM64 architectures for functionality.

Here is the short summary:
-------------------------------------------------------------

- The firmware download was handled by a worker thread which gets scheduled
when the device powers up. But this thread waits until the device gets into
PBL state (notified using PM state worker). Sometimes, there might be delay for
the device to enter PBL state and due to that the firmware worker thread will
timeout. So in order to handle this situation effectively, the firmware load
is now directly called by PM state worker instead of scheduling the thread.

- Return proper error codes incase of error while loading the AMSS firmware
through BHIE protocol

- The MHI register space of the device accepts only non-zero values for the
sequence identifier. But there is a possibility that the host might write zero
(due to the use of prandom_u32() API). Hence, a macro is introduced which
provides non-zero sequence identifiers and used them in all places.

- Moved all common TRE generation code to mhi_gen_tre() function

- The MHI host reads channel ID from the event ring element of the client
device. This ID can be of any value between 0 to 255 but the host may not
support all those IDs. So reject the event ring elements whose channel IDs
are not within the limits of the controller.

- Limit the transfer length read from the client device. This value should
be within the size of the MHI host buffer but there are chances this can
be larger.

- Remove the system worker thread for processing the SYS_ERR condition and
instead call the function directly from EE worker. This is done to avoid
any possible race while MHI shutting down.

- Handle MHI power off in the state worker thread as like MISSION_MODE. This
helps in preventing a possible race condition where a power off is issued by
the controller while processing mission mode.

- Skip the handling of BHI interrupt when the register access is not allowed
due to the device in wrong PM state.

- The write_lock of 'mhi_chan->lock' should only protect 'db_mode'. Hence, use
it properly in places where it is protecting other unwanted regions.

- Reset the client device if it is in SYS_ERR state during power up.

-------------------------------------------------------------

Please consider merging!

Thanks,
Mani

Bhaumik Bhatt (4):
  bus: mhi: core: Handle firmware load using state worker
  bus: mhi: core: Return appropriate error codes for AMSS load failure
  bus: mhi: core: Improve debug logs for loading firmware
  bus: mhi: core: Ensure non-zero session or sequence ID values are used

Hemant Kumar (9):
  bus: mhi: core: Refactor mhi queue APIs
  bus: mhi: core: Cache intmod from mhi event to mhi channel
  bus: mhi: core: Add range check for channel id received in event ring
  bus: mhi: core: Read transfer length from an event properly
  bus: mhi: core: Remove the system error worker thread
  bus: mhi: core: Handle disable transitions in state worker
  bus: mhi: core: Skip handling BHI irq if MHI reg access is not allowed
  bus: mhi: core: Do not process SYS_ERROR if RDDM is supported
  bus: mhi: core: Handle write lock properly in mhi_pm_m0_transition

Jeffrey Hugo (1):
  bus: mhi: core: Handle syserr during power_up

 drivers/bus/mhi/core/boot.c     |  75 ++++++------
 drivers/bus/mhi/core/init.c     |   8 +-
 drivers/bus/mhi/core/internal.h |   9 +-
 drivers/bus/mhi/core/main.c     | 194 ++++++++++++++++++--------------
 drivers/bus/mhi/core/pm.c       |  86 +++++++++-----
 include/linux/mhi.h             |   4 -
 6 files changed, 217 insertions(+), 159 deletions(-)

-- 
2.17.1

