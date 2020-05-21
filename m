Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21E3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55BB20738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOjdqkXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgEUTSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbgEUTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:18:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85195C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:18:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d7so6498587ybp.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nvAJ73uOva6L67ScKM3nQf7DLT+6Xp7iUQAv2S4wZr0=;
        b=XOjdqkXVdlfc+buczRZyVO5UqBw+OKSF1qBoNSX1Hn/h1nfCxlFHhGlhMfN2Yg162t
         6XXR5MpetLwXTax4xL27XgKVFLkVFcw5g4c3/Y+H1zr3YsLa87kUDBslil9K9i/UzcXO
         IL88XHFVyfvlkBOXI6hX5nrKtmvJTeqf1Rv+cX+X/mIU4aiOeVKiidJdo2Egxo26QqSq
         3TSNyw2D+G3F8aTo0vZ8bW4mQ0rbZY/ItbD8rHzBjPeOFw+PUQTlno1wh5yoCqUEkIDz
         eCyxPEMAlGsMJqKqCMo2aW9TETwK3wuWy2lZ8WWFi/ZYSfIr1UwWfsp+tGeivj9Hw0wl
         tOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nvAJ73uOva6L67ScKM3nQf7DLT+6Xp7iUQAv2S4wZr0=;
        b=pCqEbkkSVBrV8ojFNHdQoxXq0Ju2XmHkBLq4P3t1zGpK7txJqoGa9fu4qwgVIL7EMf
         4gp7HuE8sgyxh+eA+MhlnUASBaaGFxUhkfXnZfLYUb1KxjlIZUOAkp9a6DjDULM1+RvH
         Vo9dGwyuku0VA0QrWU25WycAvi5o19s2MpYZEuNDCCWeJYeWiOSXMNHsjpui0iVdLwh6
         RlYPAGNhzIvlpLuiJlpCRHB+7Ij8BAJJB4m0qlAiPe/kVhlkZHL3KBJZggYBG8jDJGpE
         CFk1l/3pA9fECcpE76MihAeXu2q3hAvbroqeCH37e3X8lNOV4hHvu/TRpFcwYd5n00nf
         rlPQ==
X-Gm-Message-State: AOAM530RaB6XPfiW1BB6kVWZDVbxw2pmMDqjBwe/bYIPxRTyCq1gh9aQ
        4t7kiP62Hv62wQ1l7jbEftCFZeox74+Cp0s=
X-Google-Smtp-Source: ABdhPJx3jJ3162uuOjFj1uglwt+ADyLgm8XwN2OMVHeB0HY2RMnQgcRY684jRDHwncr6xbKcLSeOLtnh5vL9hDc=
X-Received: by 2002:a05:6902:728:: with SMTP id l8mr19177361ybt.127.1590088688764;
 Thu, 21 May 2020 12:18:08 -0700 (PDT)
Date:   Thu, 21 May 2020 12:17:57 -0700
Message-Id: <20200521191800.136035-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v3 0/3] driver core: Add device link related sysfs files
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

v2->v3:
- Dropped patch 1/4 from v2 since it was already picked up. So numbering
  has shifted.
Patch 1/3
- Added documentation

Saravana Kannan (3):
  driver core: Expose device link details in sysfs
  driver core: Add state_synced sysfs file for devices that support it
  driver core: Add waiting_for_supplier sysfs file for devices

 Documentation/ABI/testing/sysfs-class-devlink | 126 ++++++++++
 .../ABI/testing/sysfs-devices-consumer        |   8 +
 .../ABI/testing/sysfs-devices-state_synced    |  24 ++
 .../ABI/testing/sysfs-devices-supplier        |   8 +
 .../sysfs-devices-waiting_for_supplier        |  17 ++
 drivers/base/core.c                           | 237 +++++++++++++++++-
 drivers/base/dd.c                             |  22 ++
 include/linux/device.h                        |  58 ++---
 8 files changed, 464 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-devlink
 create mode 100644 Documentation/ABI/testing/sysfs-devices-consumer
 create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced
 create mode 100644 Documentation/ABI/testing/sysfs-devices-supplier
 create mode 100644 Documentation/ABI/testing/sysfs-devices-waiting_for_supplier

-- 
2.27.0.rc0.183.gde8f92d652-goog

