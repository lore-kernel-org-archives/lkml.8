Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F287C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C8022B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xj8UXeKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbgGaSwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGaSwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:52:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5D7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:52:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so9320932wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OTd6e/PlNDG/u9+OEO/oweb8OPLzA0xIE8L6spNvI1g=;
        b=Xj8UXeKQ7Faa+XspLRORgj2TiAmYsf2jKCT4tW34XdSZ3VfiPa/LX0PhGUYRv6q1br
         y+G2N0ybWso9byDHPjo8O++MDs0qCu2DDacf1uWwyrh9yRIl1ViiKWf5s5cIWnbtes9p
         lsDjwYxdwpX0QhcE7wy0zHaVJ/kqkI2FfnEfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OTd6e/PlNDG/u9+OEO/oweb8OPLzA0xIE8L6spNvI1g=;
        b=XZX8Wr6ukAFyXtUZ01u/e1V/hc8E4T9diZmyGHi1XCQkr3qw6NSiGs4QyBIh6s6RkB
         /gsSiC30BlMvUT5BW8BWUDS5l7xPxKKyxKobfnsNC2u+PutNLaCq2aC3+m12HDJYe3Bs
         AU8/yuJEiSO8liM6cOgu1w0vK0Nx5mr/NG+tEiz4jR9VI45popYqa82YXPQNcw4CSd/L
         9UFBajtg2wcRZjw7V1H/GwqmeUTuyCTZIAJZy1QNdPECvXzqLoTWMAZr3BZdFPwQ204t
         j0x9UAZFv42OcIRVkZksxxwKSlOFVNXSCbQ98Bjgv52WHhG+VOJLauv6tP/jvl51LL2M
         vrfA==
X-Gm-Message-State: AOAM532D5rUyxjmc7jhBV3YgdgnqSpkryoIinjpb0qCt9zpO9ckG3L9C
        rPnsScfbAp08qZgSNbkiO/1exA==
X-Google-Smtp-Source: ABdhPJysiJHWhlPr18LrYGtyg+tXlvhyJi/PqX7XR1TD0DXM/cNbVsFf6fCz4M6e8buX6/4BHWomfw==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr4830099wml.35.1596221548982;
        Fri, 31 Jul 2020 11:52:28 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k204sm14311710wma.21.2020.07.31.11.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:52:28 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 0/3] Add Broadcom VK driver
Date:   Fri, 31 Jul 2020 11:52:15 -0700
Message-Id: <20200731185218.27543-1-scott.branden@broadcom.com>
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
 drivers/misc/bcm-vk/bcm_vk.h     |  424 +++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 1369 +++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c | 1507 ++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  211 +++++
 drivers/misc/bcm-vk/bcm_vk_sg.c  |  275 ++++++
 drivers/misc/bcm-vk/bcm_vk_sg.h  |   61 ++
 drivers/misc/bcm-vk/bcm_vk_tty.c |  365 ++++++++
 include/uapi/linux/misc/bcm_vk.h |   99 ++
 13 files changed, 4360 insertions(+)
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

