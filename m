Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB6BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44713206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LADWMtJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgGPEU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgGPEU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:20:57 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:20:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a205so2934686qkc.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E5IYfaz3Q/wt93scHSn9NYWEZmA+rvPF7ero22jc2/I=;
        b=LADWMtJLbNPlv8QbEFjqfU/8Pzs25O8AVXPZS6xQnoQjwt16vTFIIjCMdwOtESnVvB
         RQLK7NzEX6ezXY9SEQI974nD2vNsJb4mUssswme49exFvxaW64vQX48MeljBKiugb54y
         loQOb+KMso2lmgTTW5SpoJ4x+eZYLID07nZPtIi8uIIgv/afKbISW8s5A8OYJKE0JdDD
         1m45gzCU2uzuNvextRyBNi5OMbOuQY/aWXUQXvAZXVpVnPjX2667RHrVJ95KNRrM6QLN
         Croh5U4D1/U6BjIxEFkdUTlM7g9ms2f1+dbRNbu6I+S4pYokrqZfZnogwK1q5HeKKjqe
         TDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E5IYfaz3Q/wt93scHSn9NYWEZmA+rvPF7ero22jc2/I=;
        b=i4cbo54ViCkaNFrERNmu7v0WlCOEe3or2jfn5k072tPqKdU6l3M9QWXkp/JZ6RLfEl
         LvuV8BB+sQXxtdqDghjtrOtOP4NbiZr3JZZk9eoECpfQKhOltQtowdyN9HcZXUeiqK00
         XdY2Cf7ob84QB/woKQ/AHRAtAEyQwAjWrNxowmu8y/sVdjX4ID71/fuM2/38YJn2YGci
         o6Z8ruSELMU6K47Y7Y927e0fSV2W4u01WwXQwAWLiLOZYSCOZ1E1kd8YGVKxDqHbhHgY
         mCq7nN7/U6Qa+9LDVmbiD/DD2FxaECUy+lkY/VyngCoCPpE/RZjGAxEkB2MRcEDlpx9n
         VZkg==
X-Gm-Message-State: AOAM530jSbetsqEjP/Ly6pQunsm+aVv6bDlLi3qn+iJGUlWQb22pGpkh
        gB2TRdV+WDj3qZWxpT+9qm2pXNFxOgM7ZnA=
X-Google-Smtp-Source: ABdhPJyWLkBS3ule+mtfJOFmH6JEPfmTEveLacZvT2o8vs3Nk6U8cOarvp8+1Djo9qbCvuMlLOkeGWgHeNmpEQU=
X-Received: by 2002:a0c:aa15:: with SMTP id d21mr2364715qvb.155.1594873256266;
 Wed, 15 Jul 2020 21:20:56 -0700 (PDT)
Date:   Wed, 15 Jul 2020 21:20:49 -0700
Message-Id: <20200716042053.1927676-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 0/4] regulator_sync_state() support
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following example:
- regulator-X is provided by device-X.
- regulator-X is a supplier to device-A, device-B and device-C.
- device-A is off/inactive from boot.
- device-B and device-C are left on/active by the bootloader
- regulator-X is left on boot by the bootloader at 2000 mV to supply
  device-B and device-C.

Example boot sequence 1:
1. device-X is probed successfully.
2. device-A is probed by driver-A
   a. driver-A gets regulator-X
   b. driver-A votes on regulator-X
   c. driver-A initializes device-A
   d. driver-A votes off regulator-X
   e. regulator-X is turned off.
3. System crashes or device-B and device-C become unreliable because
   regulator-X was turned off without following the proper quiescing
   steps for device-B and device-C.

Example boot sequence 2:
1. device-X is probed successfully.
2. device-B is probed by driver-B
   a. driver-B gets regulator-X
   b. driver-B votes on regulator-X
   c. driver-B lowers device-B performance point.
   d. driver-B lowers voltage vote to 1000 mV.
   e. regulator-X voltage is lowered to 1000 mV.
3. System crashes or device-C becomes unreliable because regulator-X
   voltage was lowered to 1000 mV when device-C still needed it at 2000 mV

This patch series makes sure these examples are handled correctly and
system crash or device instability is avoided and the system remains
usable.

More details provided in the commit texts.

v2->v3:
Patch 2/4 - No functional change. Simple refactor.
Patch 3/4
- Was Patch 2/2 in v2.
- Rewrote commit text to hopefully address all previous points.
- Renamed variable/functions. Hope it's clearer.
- Added more comments.
- Added logging
- Fixed timeout functionality.
- Handle exclusive consumers properly
- Handle coupled regulators properly
Patch 4/4 - Prevents voltage from going too low during boot.

v1->v2:
Patch 1/2
- New patch
Patch 2/2
- This was the only patch in v1
- Made the late_initcall_sync timeout a commandline param
- If timeout is set, we also give up waiting for all consumers after
  the timeout expires.
- Made every regulator driver add sync_state() support

Saravana Kannan (4):
  driver core: Add dev_set_drv_sync_state()
  regulator: core: Add destroy_regulator()
  regulator: core: Add basic enable/disable support for sync_state()
    callbacks
  regulator: core: Add voltage support for sync_state() callbacks

 drivers/regulator/core.c         | 200 ++++++++++++++++++++++++++++---
 include/linux/device.h           |  12 ++
 include/linux/regulator/driver.h |   2 +
 3 files changed, 198 insertions(+), 16 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

