Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98CFC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE57206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTORhAfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgEKThF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731200AbgEKThF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:37:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A274FC061A0C;
        Mon, 11 May 2020 12:37:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so19259061wmj.3;
        Mon, 11 May 2020 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/Svia73gmi6e2JWwfEm7X8hb8hyr5H6YmceiUPfyA6I=;
        b=tTORhAfCtorEyS148Eup4I/5GRpiD+ruhh3jUBz8PxJCMMUH7lxjdlD8rbU1u8ITVe
         xWXD5n0eT1KqSdO1aSGhllNNpmlwqX836vayWicSHRRLd7E1Gxm22BktYQV3PwvPBDJl
         S/2j4M7XXP3zsg2kipThtSxH08QVisvOk+cZ4k4UqW2mgh+p2Zddu3xt0ATLuHSZHJc6
         p9ieuF01Siqo5W7vofJRYAOMBaBnwELy65ep5/ghkARq2dqtt52Rxcp/2ttTE8um4BQq
         z6JtmT7ud2mecRosEMxeojhGcWtyGLLxcuBAhjgSENEndscTN7SqCu5gifiFbE6CbpBR
         5BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Svia73gmi6e2JWwfEm7X8hb8hyr5H6YmceiUPfyA6I=;
        b=IuMvpGhf0eIqC01gyqhwX6NYA8elMMKAh0uI3c8MVxUwqcFk4e0TVY3Yg3N8dICyfr
         DWR27d3r2xuFj5JX4k+m2wEtg9Y5Zt624lp8s401fy/I4nS5QANPZ/0Z6/oESvz6Bre7
         12wnds5Lf1aiw3ETXMzzFpLrcgsi4Xh+FSmvbwl3ctgXdzj/03fMwHcvBctdreJoaJ0R
         EdZ6m6JSjn4XCYCpp9iWA57AuvtVHkaeQ5+3qy5DkyN0uqZvgiYW3WIw5Vi114i4YtZJ
         lnnOtROeZ8H2gD80ZECurSu7gmjUnqMwsjsDidj951ggD2YnirQOiSvV7xyhJdf6nUJO
         A7Jg==
X-Gm-Message-State: AGi0PuYUg/jd6GPAlPprtkzhgOEeUZrczgUn4U2O7KTKc78oIu9N4sML
        3UxGYtc6PPZ6o355op1n62DtD145DRY=
X-Google-Smtp-Source: APiQypJNX+VamUukWc02F8iKZd+/ttbAU2KK/UYkpjejT9Mk1/8TEqj8dnETqvg/4oPRRKYxf33x5Q==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr7269379wme.133.1589225822015;
        Mon, 11 May 2020 12:37:02 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o203sm11529030wme.12.2020.05.11.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:37:01 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v9 0/5] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Mon, 11 May 2020 15:36:38 -0400
Message-Id: <20200511193643.30926-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9 - Fix minor typos in patch description for ehci driver.
   - In ehci-brcm.c, use ehci_err() instead of dev_err().
   - In ehci-brcm.c, handle zero returned from platform_get_irq()
     by returning -EINVAL for 0 or actual return value for < 0.

v8 - The previous v7 had the wrong version of ehci-brcm.c. This time
     really, really add the changes Greg requested.

v7 - Cleanup ehci-brcm.c as requested by Greg Kroah-Hartman.
   - Split out Makefile re-order change into a separate commit.

v6 - Remove "contains:" from compatible section of
     brcm,bcm7445-ehci.yaml as requested by Rob Herring.

v5 - Use devm_platform_get_and_ioremap_resource() in ehci-brcm.c
     as requested by Andy Shevchenko.
   - Add pm_runtime_set_active() to ehci_resume() in ehci-brcm.c
     as requested by Alan Stern.

v4 - A few more fixes to the brcm,bcm7445-ehci.yaml dt-bindings
     document requested by Rob Herring.
   - Fixed ordering issue in MAINTAINERS as requested by
     Andy Shevchenko.

v3 - Addressed all of Andy Shevchenko's review comments for
     ehci-brcm.c.
   - Fixed the brcm,bcm7445-ehci.yaml dt-bindings document,
     dt_binding_check now passes.
   - Added the XHCI functionality to xhci-plat.c instead of creating
     new brcmstb files, as suggested by Mathias Nyman.

v2 - Addressed Andy Shevchenko's review comments.
   - Fixed dt_binding_check error pointed out by Rob Herring.
   - Removed pr_info message in ehci_brcm_init as suggested by
     Greg Kroah-Hartman.

This adds support for the XHCI, EHCI and OHCI host controllers found
in Broadcom STB SoC's. These drivers depend on getting access to the
new Broadcom STB USB PHY driver through a device-tree phandle and
will fail if the driver is not available.


Al Cooper (5):
  usb: xhci: Change the XHCI link order in the Makefile
  dt-bindings: Add Broadcom STB USB support
  usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
  usb: ehci: Add new EHCI driver for Broadcom STB SoC's
  usb: host: Add ability to build new Broadcom STB USB drivers

 .../bindings/usb/brcm,bcm7445-ehci.yaml       |  59 ++++
 .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
 MAINTAINERS                                   |   8 +
 drivers/usb/host/Kconfig                      |  20 ++
 drivers/usb/host/Makefile                     |  17 +-
 drivers/usb/host/ehci-brcm.c                  | 280 ++++++++++++++++++
 drivers/usb/host/xhci-plat.c                  |  10 +
 7 files changed, 389 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-brcm.c

-- 
2.17.1

