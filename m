Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3B0C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EC224670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iRWHPF4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBTAsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:48:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37175 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBTAsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:48:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so1002349pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MCnc7lIWYjCyOM/3eUwsK77pJjRdrQHPG+GhI2DPtOU=;
        b=iRWHPF4ZxnvlZs+BPBJTKw5+kW68aECGGTAzv+JtpeB/RwX8M734IfDoYVGoNPk9F4
         VmtB9RXFMaXFNiYpqLN8V3xETnXZBktVcU7NO+/YUMNsmOPqCOXxw9UHsWVgXYgsziFx
         UKfQ//Feovjz4wGRg9goWtbJLBqZfrJ3YZQ6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MCnc7lIWYjCyOM/3eUwsK77pJjRdrQHPG+GhI2DPtOU=;
        b=BXNi6IpDrTQron6O0M9OgS00x9o4Kyhe+7H/wzCB2bdw/1bbVOQgU5iZbtNE+T6L31
         VtkOVBmqFjJ9IJM/QOTV70vjUjxHP177uaETIzhrqHHmsGUfisnsV/Fz3UYKMbr5Wb5M
         tnLgUYyil9A44LbcxUEIUDqbJ8BpRe/rZwpMA830sL9rXL/u98LlfFyDZoVq59Sz9AI6
         y6znvZqoIkZsDMGiEour4wYdauVEC7211pvz7wdGspowrUOgzKYuCbrgn+NcVCWlgtxH
         d+FQJEY/K131R4oPA2uLVZfxclYaQ4NLwMQYYYnR3aL+ZiWJ+NkFTXbRAfYNgp/xP9bQ
         D7Ow==
X-Gm-Message-State: APjAAAUMFBG+n8XCbr/CFMQ/25KVW77c6Pd39BXCWd3eqx3NJtpf0JHG
        4JljaAmIhH7zKMqkg9Jv1oolyg==
X-Google-Smtp-Source: APXvYqyPmPeQJdr9Oa52QoVxIdceLP7MLylnFV/IINfia5v++zGBusoLcQHbou1xSZoghCPOQ3Iu3w==
X-Received: by 2002:a63:ae0a:: with SMTP id q10mr30424929pgf.178.1582159719593;
        Wed, 19 Feb 2020 16:48:39 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 64sm816323pfd.48.2020.02.19.16.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:48:38 -0800 (PST)
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
Subject: [PATCH v2 0/7] firmware: add partial read support in request_firmware_into_buf
Date:   Wed, 19 Feb 2020 16:48:18 -0800
Message-Id: <20200220004825.23372-1-scott.branden@broadcom.com>
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
 drivers/base/firmware_loader/main.c           |   49 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   42 +
 drivers/misc/bcm-vk/Makefile                  |   11 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  357 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1197 +++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c              | 1359 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  210 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  273 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  327 ++++
 drivers/soc/qcom/mdt_loader.c                 |    7 +-
 fs/exec.c                                     |   77 +-
 include/linux/firmware.h                      |    8 +-
 include/linux/fs.h                            |   15 +
 include/uapi/linux/misc/bcm_vk.h              |  117 ++
 lib/test_firmware.c                           |  139 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 21 files changed, 4305 insertions(+), 37 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

