Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FCC83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FE2208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="i0G80BZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgD2ODs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgD2ODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB9C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so2174617wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N1h32tUQUjUvbbVh9Sx0ldWuhfL7NViXIQbgOtPfHU=;
        b=i0G80BZPAm1av9kXUevS62676qW5KOO6kLiBwdV+1UWaQThQ90GQpKI0ph1mvO4BVu
         jiNxY/PNluCXb1YA19LsvSwYN4H84/FQa/FgQOHxB/zk/grBc4TOo+ct2ThdUv4lGOYC
         XYDvpJr4oy31138O+l6/L25Rw19V8HgwqzH/mruMC3gSnvsk/qJF2LRZGKYvw0oG3PCN
         jegxRxSVqRk6QlL117n9HGP86LqIyW5IpjmyrJaY7TFy74U8k8TWAmS4RaPSnNnVSX83
         +NTOdHFd1z9NEnkFMlOsPHjiXruY2OiiTaPurfWtDhy2E9NArtqZ6j3tCXsBfk/bQkE2
         v/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N1h32tUQUjUvbbVh9Sx0ldWuhfL7NViXIQbgOtPfHU=;
        b=DyRdk8nfQ3ATvEusZn3xkxSc5V4bMwGhk9z8CmKKK1OPu6XcmtDx6LvtkZZjCxKnxh
         sCe39n8WfezWp+g7oBPOk0wgcsFxL2YuXraFvMBa0qkcUmVzAOm/u6lHoNDX1SzXTLzw
         tWCaCPdtgrE6dtKNzveg8DMTF0Fhz/Umz4S/6UoCGmXSvVB39OzWtxivEm5gC7nQ7ZNL
         ku8tyeBaGql0695WTahsWQgkS/YmFkepjkk1LuiK8d22g0vwIXfy/0soyE1PLj1ouCdd
         idDvmCthHhATT5UNPWYzLEdz4rydQ80XvYJGJGGB8IkA+uEWoENPhwJW/U2vKWSMeJ5I
         SgZA==
X-Gm-Message-State: AGi0PuYsoN8swHsYUd2ZJ44A3pKRrtggfr/9XotNzG99Kc96nk/fbmtd
        Z3VNTO3V37zMnTrKcxC9HpyS9g==
X-Google-Smtp-Source: APiQypKhVVvWGVwyHnc7ndDVd3MQfcksp1Ah1aPBYv179+YC7X76d3YUcZsmi83MJ3DjOOhWMmkMhg==
X-Received: by 2002:a1c:8084:: with SMTP id b126mr3345914wmd.135.1588169025309;
        Wed, 29 Apr 2020 07:03:45 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:44 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 00/10] Add a new LOOP_CONFIGURE ioctl
Date:   Wed, 29 Apr 2020 16:03:31 +0200
Message-Id: <20200429140341.13294-1-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a new ioctl that makes it possible to atomically
configure a loop device. Previously, if you wanted to set parameters
such as the offset on a loop device, this required calling LOOP_SET_FD
to set the backing file, and then LOOP_SET_STATUS to set the offset.
However, in between these two calls, the loop device is available and
would accept requests, which is generally not desirable. Similar issues
exist around setting the block size (LOOP_SET_BLOCK_SIZE) and requesting
direct I/O mode (LOOP_SET_DIRECT_IO).

There are also performance benefits with combining these ioctls into
one, which are described in more detail in the last change in the
series.

Note that this series depends on
"loop: Call loop_config_discard() only after new config is applied."
[0], which I sent as a separate patch as it fixes an unrelated bug.

[0]: https://lkml.org/lkml/2020/3/31/755

---
v4:
  - Addressed review comments from Christoph Hellwig:
    -- Minor code cleanups
    -- Clarified what lo_flags LOOP_SET_STATUS can set and clear, and
       made that more explicit in the code (see [9/10])
    -- LOOP_CONFIGURE can now also be used to configure the block size
       and to explicitly request Direct I/O and read-only mode.
    -- Explicitly reject lo_flags we don't know about in LOOP_CONFIGURE
    -- Renamed LOOP_SET_FD_AND_STATUS to LOOP_CONFIGURE, since the ioctl
       can now do things LOOP_SET_STATUS couldn't do.
v3:
  - Addressed review comments from Christoph Hellwig:
    -- Factored out loop_validate_size()
    -- Split up the largish first patch in a few smaller ones
    -- Use set_capacity_revalidate_and_notify()
  - Fixed a variable wrongly using size_t instead of loff_t
v2:
  - Addressed review comments from Bart van Assche:
    -- Use SECTOR_SHIFT constant
    -- Renamed loop_set_from_status() to loop_set_status_from_info()
    -- Added kerneldoc for loop_set_status_from_info()
    -- Removed dots in patch subject lines
  - Addressed review comments from Christoph Hellwig:
    -- Added missing padding in struct loop_fd_and_status
    -- Cleaned up some __user pointer handling in lo_ioctl
    -- Pass in a stack-initialized loop_info64 for the legacy
       LOOP_SET_FD case

Martijn Coenen (10):
  loop: Factor out loop size validation
  loop: Factor out setting loop device size
  loop: Switch to set_capacity_revalidate_and_notify()
  loop: Refactor loop_set_status() size calculation
  loop: Remove figure_loop_size()
  loop: Factor out configuring loop from status
  loop: Move loop_set_status_from_info() and friends up
  loop: Rework lo_ioctl() __user argument casting
  loop: Clean up LOOP_SET_STATUS lo_flags handling.
  loop: Add LOOP_CONFIGURE ioctl

 drivers/block/loop.c      | 407 +++++++++++++++++++++++---------------
 include/uapi/linux/loop.h |  31 ++-
 2 files changed, 281 insertions(+), 157 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

