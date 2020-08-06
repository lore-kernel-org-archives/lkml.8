Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41376C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0492065C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UIitZfc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgHFAqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgHFAqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:46:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06DFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:46:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f1so41793974wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AvthtXx6kNmBbpW2Loz0kXBTU3ty0PjFeNcZDHCZDYE=;
        b=UIitZfc8XfgaMR8z/QIrNVR4gMcLmGYSsG0b3nne78h3fCARuLXu/nflHFi7aYCS+n
         eOsl4quX1lPwhTdQbkXmRla+EpksFR2G1Hj6QGwxVnJT89q/DfDlR65S4bOLddww9K2O
         /gwKgjLn3/wxQXlq1khXJezYpmPThk8jk35to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AvthtXx6kNmBbpW2Loz0kXBTU3ty0PjFeNcZDHCZDYE=;
        b=SNnJ9as9dwL+FtcoOIUg17gzvc1qCnFOC661uOQBlr33Bz391QjhAlZ7rXXEVj8sR0
         /RRNWsoNriIoMT7g2qFzp3B7Pj6VynRBAqa/CB4wb/O1LBOyyEl4XpbUdeA65Gsm82Ts
         zCEXeZmB17SmNngYweUAmYrm0ecPqj5j/j+/btISjiVpdraMuVhydzv9Mbo/uuUOi5OS
         4bbr7xSE4AOzerI/y0yI5zPzTo210VmAqjmjFlS7SBGA2Q17c6av5T2G3AqzWrFJGL4q
         y2LDUDknmbTvyRnxQIJjjNekOZafZnxFOlRGL3OzVZztzjd34M/hFsXYwrJnpq8sEpZz
         MohA==
X-Gm-Message-State: AOAM5313IAUMzJNKTH4dRYIAQzRLAMdGabMKUT5TJcN5oc+qrz4ZLFIF
        14Q+aeJOG+chzLlAdOaLmahOeQ==
X-Google-Smtp-Source: ABdhPJw46siNu+N+Rs6Uqg8CH2ckpMHqpnmzu5GpcKZalxogdzJgpXJ8tSxpZR+LIX6hsPP2vvgv/Q==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr4536729wrj.380.1596674802446;
        Wed, 05 Aug 2020 17:46:42 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c17sm4665745wrc.42.2020.08.05.17.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 17:46:41 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 0/3] Add Broadcom VK driver
Date:   Wed,  5 Aug 2020 17:46:28 -0700
Message-Id: <20200806004631.8102-1-scott.branden@broadcom.com>
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
 drivers/misc/bcm-vk/bcm_vk_msg.c | 1514 ++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  211 +++++
 drivers/misc/bcm-vk/bcm_vk_sg.c  |  275 ++++++
 drivers/misc/bcm-vk/bcm_vk_sg.h  |   61 ++
 drivers/misc/bcm-vk/bcm_vk_tty.c |  365 +++++++
 include/uapi/linux/misc/bcm_vk.h |   99 ++
 13 files changed, 4367 insertions(+)
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

