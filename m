Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D868DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A805B20756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vk1Mu5QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgETDsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgETDs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:48:29 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F73CC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:48:29 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id g15so2279650qvx.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rwQUPrlr6GevdIfrDQtgo7Y3ieaJfzc13oUSBH7ZRo8=;
        b=vk1Mu5QKc555oPpMOzBf60MtAFAergUxvIoLl8DUTG0a2fyP+8V5uKWVqY8EuIAkWa
         osfb3RlZmPmLxxtRPIUOBrBWJQYVns47LjuTFrfMqUl/wKb4Z8+fWyvIxxzKYKbDLOA8
         xgA890A6ahu6vJmE92b4QA6Q0m3SsBK1qDUUBU/D2BV/m9TlSBVyS3cHsvGw/DJxr5bG
         r67EvuPncYI+0lsT/rW3fLqc0+1H2Y/j1wfzNVI9Q3z81bGFlRtZDJXuPpKwwLOwBjvh
         2C7lZH6Pi/cTiGZtlhyIwtzi/pO3z+fLFXs54Cot5aQqT+mXy2Fixmr5ClxnFjrse8PJ
         hz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rwQUPrlr6GevdIfrDQtgo7Y3ieaJfzc13oUSBH7ZRo8=;
        b=Lze9XwIaIJ8aHFyuszXZFrOKVDtzilHGn/X1dR5KQm0XFoUCU1u7a9HHm50+VO2iEt
         aNPaAG6PHa4Zc2DeeKkVYQZ2NELo6UaKVVm6BD3k84Jq8SH+yoSJ7lxOSTnbaOixzewe
         VrArzTSOqhvADvglgCUGyu+8g/QyTlKRiOo77Un+XKHGYTO7sQGzREnqpQY+rg5d6KBn
         XbZjkMwW1TRI6GS81T9tU6m83JKxJRJBzntpkHEWEZSASNHlxkuRZr6gBz11Tr4e6rgT
         9hKQ3ygELUaMmzhqDPt2BhqRSTDwvFk8Jt77kqiODU791zz3oZfHhxAroqDn0Y4QuUh2
         RRBQ==
X-Gm-Message-State: AOAM530csNJQkv1mW8M4DF0kau4ItR+Q47v4V5q6NvQc5hB9lrbg0kI8
        BdyURsGKTPlJpsRsLr0OCam5q6OaS6/Stxg=
X-Google-Smtp-Source: ABdhPJwko8r2KTNEW6CL9ZL6/6Q+YoMfzRqnuXoEfhGukkUhMaDw9q3ZDHSnReW57ShHDj/XVh3gBMW+A48hwWU=
X-Received: by 2002:ad4:5843:: with SMTP id de3mr3042792qvb.195.1589946507708;
 Tue, 19 May 2020 20:48:27 -0700 (PDT)
Date:   Tue, 19 May 2020 20:48:20 -0700
Message-Id: <20200520034824.79049-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2 0/4] driver core: Add device link related sysfs files
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With fw_devlink and with sync_state() callback features, there's a lot
of device/device link related information that's not available in sysfs.

Exposing these details to user space can be very useful in understanding
suspend/resume issues, runtime pm issues, probing issues, figuring out
the modules that'd be needed for first stage init, etc. In fact, an
earlier verion of this series was very helpful in debugging and
validating the recent memory leak fix[1].

This series combines combines a bunch of patches I've sent before.

I'm aware that I haven't added documentation for patch 1/2. I'm waiting
on review to make sure the file location, name and values don't change
before I add the documentation.

This series is based on driver-core-next and [1] cherry-picked on top of
it.

[1] - https://lore.kernel.org/lkml/20200519063000.128819-1-saravanak@google.com/

v1->v2:
Patch 1/4
- New patch
Patch 2/4
- Fixed the warnings I saw before that were related to incorrect
  sysfs removal code when a device link is deleted.
- Fixed error handling in device_link_add()
- Split up flags into more meaningful files.
- Added status file.
Patch 3/4
- Fixed error handling that Greg pointed out before.
Patch 4/4
- New patch

Saravana Kannan (4):
  driver core: Remove unnecessary is_fwnode_dev variable in device_add()
  driver core: Expose device link details in sysfs
  driver core: Add state_synced sysfs file for devices that support it
  driver core: Add waiting_for_supplier sysfs file for devices

 .../ABI/testing/sysfs-devices-state_synced    |  24 ++
 .../sysfs-devices-waiting_for_supplier        |  17 ++
 drivers/base/core.c                           | 249 ++++++++++++++++--
 drivers/base/dd.c                             |  22 ++
 include/linux/device.h                        |  58 ++--
 5 files changed, 326 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced
 create mode 100644 Documentation/ABI/testing/sysfs-devices-waiting_for_supplier

-- 
2.26.2.761.g0e0b3e54be-goog

