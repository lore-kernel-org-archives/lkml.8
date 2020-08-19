Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBCAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7774A207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddg2juEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHSS7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHSS67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:58:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBFBC061757;
        Wed, 19 Aug 2020 11:58:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q93so166510pjq.0;
        Wed, 19 Aug 2020 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=teSA+VF9m0g0fiG8uR8fbDhA8YjsqGp+oSZrp5d7n9U=;
        b=Ddg2juEOoCmHUuQArhnsFSay6iY0S9DecklI+21FdyRNq5jSHiDoGK2hZWZBN6dXxf
         uSJdgdBW2SbPPdcGEqOMILtPKUxDod5d+CniKZp2b9MMNxkLNIZ9CK9XHrf9XlMwFH9O
         BeXKAXjBjqp0U9QnBE5dElE/lfDh3muuiVY6RpzO/DhO6iUxwXPd5OAYGwEccOmKeUok
         AvH+PzbcQtdlJZ5v7PYUomw2GhVLghruNZsxqBFTdfvF4HpNxBpH79FXQtn/7ZQ+Sj7r
         hymuwHpjetoojCk3aJJ83r3Okn2hZlhsU7kOFsAeMPrODkHd/n01iMWK8C4/fxGbXpjO
         +Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=teSA+VF9m0g0fiG8uR8fbDhA8YjsqGp+oSZrp5d7n9U=;
        b=GUQF0HCOYaP+HoWoNwTmU2LkEgW/MswrM5dd4/KY6SYWE4IoG4CAhWZG/MYQkQpyFt
         bxFjym0qBJo/DIVgpSq2wUqZvxP66cG81eJo1wO0oz26vkHntWZdg/VlCYhySGFbyfui
         pd1e6oOspJqOEuDTjsnCLE/iVeeChqEVoQzbILgt7slHU8DqvhT+NUD8HitVLtNP2g9/
         tgU+DaK/fOXb3hDBEUidsUd2mPS3RRcy7H6IyUBfMB2rup2fh0lRk7BKObdlKLhdeiM4
         g70xiT/Jh5eM3xiyHR2bqTxoHzWeujS8Bf52IuwryBCLop8tCfQYsiJN8SC/+hqy2Tqf
         +E5A==
X-Gm-Message-State: AOAM532PcQO5jF0H4BeHfp3rVIumRJO5keKOlVIv1zeN40bPnvrqKTw4
        sR+dBRqPcum/Ana2jSuEX8w=
X-Google-Smtp-Source: ABdhPJwNFdqnCDQRO/tySZxGOWZIe3t9mcFk7yheydz6bXCndpt/TagKm0lrSk7e+WHEmyBWkUYYHQ==
X-Received: by 2002:a17:90b:4c0c:: with SMTP id na12mr4980552pjb.24.1597863538514;
        Wed, 19 Aug 2020 11:58:58 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o134sm29149305pfg.200.2020.08.19.11.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:58:58 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 00/12] video: fbdev: use generic power management
Date:   Thu, 20 Aug 2020 00:26:42 +0530
Message-Id: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to upgrade power management in video fbdev
drivers. This has been done by upgrading .suspend() and .resume() callbacks.

The upgrade makes sure that the involvement of PCI Core does not change the
order of operations executed in a driver. Thus, does not change its behavior.

In general, drivers with legacy PM, .suspend() and .resume() make use of PCI
helper functions like pci_enable/disable_device_mem(), pci_set_power_state(),
pci_save/restore_state(), pci_enable/disable_device(), etc. to complete
their job.

The conversion requires the removal of those function calls, change the
callbacks' definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

Test tools:
    - Compiler: gcc (GCC) 10.1.0
    - allmodconfig build: make -j$(nproc) W=1 all

Vaibhav Gupta (12):
  fbdev: gxfb: use generic power management
  fbdev: lxfb: use generic power management
  fbdev: via-core: use generic power management
  fbdev: aty: use generic power management
  fbdev: aty128fb: use generic power management
  fbdev: nvidia: use generic power management
  fbdev: savagefb: use generic power management
  fbdev: cyber2000fb: use generic power management
  fbdev: i740fb: use generic power management
  fbdev: vt8623fb: use generic power management
  fbdev: s3fb: use generic power management
  fbdev: arkfb: use generic power management

 drivers/video/fbdev/arkfb.c                  | 41 ++++++-------
 drivers/video/fbdev/aty/aty128fb.c           | 51 ++++++++++------
 drivers/video/fbdev/aty/atyfb_base.c         | 50 ++++++++++-----
 drivers/video/fbdev/cyber2000fb.c            | 13 ++--
 drivers/video/fbdev/geode/gxfb.h             |  5 --
 drivers/video/fbdev/geode/gxfb_core.c        | 36 ++++++-----
 drivers/video/fbdev/geode/lxfb.h             |  5 --
 drivers/video/fbdev/geode/lxfb_core.c        | 37 +++++------
 drivers/video/fbdev/geode/lxfb_ops.c         |  4 --
 drivers/video/fbdev/geode/suspend_gx.c       |  4 --
 drivers/video/fbdev/i740fb.c                 | 40 +++++-------
 drivers/video/fbdev/nvidia/nvidia.c          | 64 +++++++++++---------
 drivers/video/fbdev/s3fb.c                   | 39 +++++-------
 drivers/video/fbdev/savage/savagefb_driver.c | 52 ++++++++++------
 drivers/video/fbdev/via/via-core.c           | 39 +++++-------
 drivers/video/fbdev/vt8623fb.c               | 41 ++++++-------
 include/linux/via-core.h                     |  2 -
 17 files changed, 267 insertions(+), 256 deletions(-)

-- 
2.28.0

