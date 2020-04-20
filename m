Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81113C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F05D20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aum878dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgDTQkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbgDTQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:40:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E9C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:28:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k11so12980471wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y6BXvIfk0R/gZ0twMeBQX3iT31MGytnoVIMSO2j5UM0=;
        b=aum878dLf5/Y73XSxFsTat47TJHjOeeg6LINMRbsCZDiJlT48QPf0++SYSxzUx6CvN
         bP3h04KO1U856CbHH3qzKQxtE2Stix58x5qHJ4KxpWNlK7l9DFAVmhwM9jnbliYXnJmb
         VzRvCxVX2K9PVqBCJYdvPhCKFzQBjxMWyUR+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y6BXvIfk0R/gZ0twMeBQX3iT31MGytnoVIMSO2j5UM0=;
        b=ufs3qhBcjpFJda8VCSpLO/WsgoBY7UmAxEZwkoh44Acl03T2/N9Ru4s+8cwzsk+nJ1
         hx2kM91fklUZHJ6bBCl1Lwg0xBRmjbtpEIA6YPxBL7a/xd87jutoCoQ/BEnuV+u7g9wE
         YQdbQXf6MyqX8ZS6O43lFAtYLKK5GBdkKyZV4nwLcOhcL1jJclwrhcsXgl+lZt8qspuw
         XpupTHyro7c73yUVgRLItsV1C9ForQhzwekpyu9In3im1gz7rJOa6nJhniWT7YBGVszQ
         b1r7GvwtWjiCBfuow7L5zrUZ04rAQA1np4LQcESA7DSL6vsi7H5roqHx+0UhxQZ4XoTf
         7J7A==
X-Gm-Message-State: AGi0PuZq7adqmdD1xV9tfQ2YUg21uT2RMfpoPzfhoZahpfQoiIS1Vz13
        sAvlXP+YX4VuJd5imruguqSQmA==
X-Google-Smtp-Source: APiQypK0GeQ9aWgjyRkEgInVfvj7aKu6g0F7ig6yHsVbodIn5FHUwC9TJ6Lfy8OKLglWlXCBO27LYw==
X-Received: by 2002:a05:6000:110a:: with SMTP id z10mr19362693wrw.389.1587400108867;
        Mon, 20 Apr 2020 09:28:28 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 36sm14882wrc.35.2020.04.20.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:28:27 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3 0/7] firmware: add partial read support in request_firmware_into_buf
Date:   Mon, 20 Apr 2020 09:28:02 -0700
Message-Id: <20200420162809.17529-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds partial read support in request_firmware_into_buf.
In order to accept the enhanced API it has been requested that kernel
selftests and upstreamed driver utilize the API enhancement and so
are included in this patch series.

Also in this patch series is the addition of a new Broadcom VK driver
utilizing the new request_firmware_into_buf enhanced API.

Changes from v2:
 - remove unnecessary code and mutex locks in lib/test_firmware.c
 - remove VK_IOCTL_ACCESS_BAR support from driver and use pci sysfs instead
 - remove bitfields
 - remove Kconfig default m
 - adjust formatting and some naming based on feedback
 - fix error handling conditions
 - use appropriate return codes
 - use memcpy_toio instead of direct access to PCIE bar
 - 

Scott Branden (7):
  fs: introduce kernel_pread_file* support
  firmware: add offset to request_firmware_into_buf
  test_firmware: add partial read support for request_firmware_into_buf
  firmware: test partial file reads of request_firmware_into_buf
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver

 MAINTAINERS                                   |    7 +
 drivers/base/firmware_loader/firmware.h       |    5 +
 drivers/base/firmware_loader/main.c           |   52 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   41 +
 drivers/misc/bcm-vk/Makefile                  |   12 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  406 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1179 ++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_legacy.c           |   89 ++
 drivers/misc/bcm-vk/bcm_vk_msg.c              | 1420 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  215 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  271 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  323 ++++
 drivers/soc/qcom/mdt_loader.c                 |    7 +-
 fs/exec.c                                     |   96 +-
 include/linux/firmware.h                      |    8 +-
 include/linux/fs.h                            |   20 +
 include/uapi/linux/misc/bcm_vk.h              |   99 ++
 lib/test_firmware.c                           |  144 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 22 files changed, 4487 insertions(+), 49 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_legacy.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

