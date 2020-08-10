Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B8BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7704020774
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZsnFz6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgHJS7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgHJS7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:59:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882C6C061756;
        Mon, 10 Aug 2020 11:59:18 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so5439039pgl.10;
        Mon, 10 Aug 2020 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x87wiamKK8IpHrYWyQZkX28BwuSCR2wXWSfYCvqc6Rg=;
        b=ZZsnFz6L+wbM1Zgg5QA7lgADPT6oEH8/ADKOklgw32TAKsJT37pzlRTS8P3PEYEU21
         0a5tolSF9/i6pWJzA1Ezl7Lmuroho8D9xIgHerRNXT5z2bFEzWjqeFDUNBNJ5j0CozVE
         WVZCtUqwr5eChlEX3rtzkrtXYQRS+F/KAJJOwggs2PcBOip781/p8XMRT8WEr+s1rII0
         nAmGLbJwKfTsy/ySJlzup63SsbjrJ727FRySv3UAg5IWXReYUSy76ylEygkQ1VnZMFE+
         cIxdPQafbXsER2xhNcurt51yWutvFr8nD+sGheu+NIer6bZs1UbfeEq8GTYPsucTFlNl
         cjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x87wiamKK8IpHrYWyQZkX28BwuSCR2wXWSfYCvqc6Rg=;
        b=mWQFrMTxEJld5NsEeqEeLnaXd0UpJpFqFbAguRkfadGwgc282GIH71Ypr7ItCEW9nU
         xgIF9hnqN12oTBz8jcmmMoX+Eu9u6uAqeZMlrNKEVSKkcTC0Oq1ey6NxoahBsIq8UnQI
         vC+nhNzK7RFIZQOboCYKEgbFiiSzm6Ji79c7TnJRZuu4gLrlfkFaDpt4OEOT245aXboi
         yMjIFdc8LqhoIek5TWSWA/wXG3bJSBwnr+fgVghw9nWg4f168E/hYSYUh6PPzl4GGJ9G
         5khE6W8JbyhWzHRrRZVjPqWNn5cEpAXxOyKGtZJraEDkt6ZNn1BU6YTtyqP5+I16/xeA
         YT6g==
X-Gm-Message-State: AOAM530pN/T6+hG7fNriAVl8xfU+aMdOvxz0WQhCtrAjbLS4cQdk2DRS
        Bx4VO/XQdDwmt39oC6oGooo=
X-Google-Smtp-Source: ABdhPJyPqIiE4/6f56BZE0TAQHYbCJrcQ8/BTUQoQnH8DzVTNJrbgDzgOiV0zuWvmdXily+zD39Uqw==
X-Received: by 2002:a62:cfc1:: with SMTP id b184mr2255523pfg.262.1597085957970;
        Mon, 10 Aug 2020 11:59:17 -0700 (PDT)
Received: from varodek.localdomain ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id f27sm22683547pfk.217.2020.08.10.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 11:59:17 -0700 (PDT)
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
Subject: [PATCH v2 00/12] video: fbdev: use generic power management
Date:   Tue, 11 Aug 2020 00:27:11 +0530
Message-Id: <20200810185723.15540-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200810165458.GA292825@ravnborg.org>
References: <20200810165458.GA292825@ravnborg.org>
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
2.27.0

