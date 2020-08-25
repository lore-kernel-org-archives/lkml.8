Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4ED2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CzFzK4bN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHYToN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgHYToM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:44:12 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1200EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:44:12 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nv17so24292pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T5IVeQZed1/ZAiunFGgrbQcoqmk5Du9WN/sYpAieJCE=;
        b=CzFzK4bNXTBS3Z6DobUHrOBJ9CwStPKYTfGH1JMYvFvXzuRg3puB5N/2pR/f5BvWZe
         eYE0LVjrWSvlpOnDHXHcaFZmMoqDwAQn/xKFeR5B9ddn8+AHlWmgw1y/KzfY5PXn/0wH
         Err+seuenQuOtbLhc+CYhQqTNgY7v3PfYoUT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T5IVeQZed1/ZAiunFGgrbQcoqmk5Du9WN/sYpAieJCE=;
        b=NpFFNfZwPg+15bGCygm16y7dkVuP0L15fcxaByqgQmMsdMalDm/4SdCdCidlKXsuKI
         81/BmooXG5jK69LRnlWxUi8Mv0yrmW5/221xtzM6DPgg6YChUaSyAMnCmGeMqv5KwK9K
         2dcF1wtSm49lY44BxEDD5Y83LOdQXq0uFbSLniI+xEv+y4ZMC7igeQ4BFV7OYhW1dBrH
         86/M6BtXVpjm3LSiN4kibEO0bK7GBEA8HV9Gaesrx5kouNA2Cb3Jl/x0AjTlI/cKJ19n
         oEW0jdwetwhZeuBXISYc+HPgR3URPPyNHtCvkNiX6I8taRabtO9YBl+ZF47uIiYX+Sjm
         lawA==
X-Gm-Message-State: AOAM533EVOEB80ZT8qSJowIXRfi+G1HfbwDn6qD9qpEIRSY91327MLdP
        emVDO5J4nCeX9I8yNT/JU3s0WA==
X-Google-Smtp-Source: ABdhPJy4RpgW6YH6obomlzYspJie2cYY2qw7wLvxP5wRAtjU7xvbGXesr2vq+f5XUZviBHIXnxSa7g==
X-Received: by 2002:a17:90a:b296:: with SMTP id c22mr3018357pjr.170.1598384651320;
        Tue, 25 Aug 2020 12:44:11 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x5sm45297pfj.1.2020.08.25.12.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 12:44:10 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v3 0/3] Add Broadcom VK driver
Date:   Tue, 25 Aug 2020 12:43:57 -0700
Message-Id: <20200825194400.28960-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series drops previous patches in [1]
that were incorporated by Kees Cook into patch series
"Introduce partial kernel_read_file() support" [2].

Remaining patches are contained in this series to add Broadcom VK driver.
(which depends on request_firmware_into_buf API addition in
other patch series [2] being applied first).

Please note this patch series will not compile without [2].

[1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
[2] https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/

Changes from v2:
 - open code BIT macro in uapi header
 - A0/B0 boot improvements
Changes from v1:
 - declare bcm_vk_intf_ver_chk as static

Scott Branden (3):
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver

 MAINTAINERS                      |    7 +
 drivers/misc/Kconfig             |    1 +
 drivers/misc/Makefile            |    1 +
 drivers/misc/bcm-vk/Kconfig      |   29 +
 drivers/misc/bcm-vk/Makefile     |   11 +
 drivers/misc/bcm-vk/bcm_vk.h     |  430 +++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 1475 +++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c | 1523 ++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  211 +++++
 drivers/misc/bcm-vk/bcm_vk_sg.c  |  275 ++++++
 drivers/misc/bcm-vk/bcm_vk_sg.h  |   61 ++
 drivers/misc/bcm-vk/bcm_vk_tty.c |  365 +++++++
 include/uapi/linux/misc/bcm_vk.h |   99 ++
 13 files changed, 4488 insertions(+)
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

