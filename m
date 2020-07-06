Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959E0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8EE206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXZDJoc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgGFNdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgGFNdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E58BC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so40628208wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+nQXwDHguiGp87OCYbVTGWXLc1URK1vaJ9PiL1A1B0=;
        b=zXZDJoc1A2V93xSJfuu/TvVJ84aP59eMQDUgoyirbYWo4kmGGDGVsgnFlpMV72H7Kv
         l35LUn4EwJYdguw7NEQHz6DLWrIExD0ExqbUDEGpAZy9e9pGZBDETz1yBge+sv3khapI
         M0ioU8SaK8W2lhGfcB3rIpJEV4Btyrl8lcyKT3r32OxKWFMsm7RGDeSHAko7i/lu/Ewh
         12XKdSbvBCxYku0W5DjfCOZLkLnC9k4WJjmr/LhPrs0a2ptcyQ+xgr0OJZ/BggQLjyEu
         gIBtLMLKniqGYaNIbOzISbj+bIwldL0IUVb5Y+vrbIPWkwXewy9gfXXmWXXDj3zEFBiz
         HEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+nQXwDHguiGp87OCYbVTGWXLc1URK1vaJ9PiL1A1B0=;
        b=VVW1Bj5sZH3SvyPZMcDnDXsiH8p+axb9vqrgejXa8qoruy6yPBzNl3apscUy/pSBrI
         IPEX75J4X5IUT2Hf39uv4jAthkzWiYzUS6cOlYs88WiWr5FKrJZAXqoZPsrSgPPSiVXm
         oJmbNHJRb9XHPFC34llPBrzAo3cBTUrdXcPcccJ0FGgz0dz1QYRit3A90tUgBGs4H9qW
         C6tbInoZorIsI2HBLaQHJ5D7TorQZxXyJhJh2yFdD7eQtnXSxwrWN1s+3eVX+hBXkB8E
         Zzd8h/WayLQVbSB0BML/Eg/Kzkp+wpcNp6JeR1NAIjGoX1GukIc7xs1G1UpyvxUEY291
         EGtg==
X-Gm-Message-State: AOAM531U8mg6JA3lBJTE71Un4V1jZSu8MyNWTgnn3pph0DKruMQ9l5D+
        xw/U+DdWUSaXX5ED/TtERQowRlr2LA4=
X-Google-Smtp-Source: ABdhPJxhgoSOPnxJP1T3cZgmiZCQBoAnzrvdc/7TMtQXC1SFusnQ/dznihoXfm6sJBScETueoIwi5w==
X-Received: by 2002:a1c:2157:: with SMTP id h84mr48333657wmh.35.1594042424602;
        Mon, 06 Jul 2020 06:33:44 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/32] Fix the final bunch of W=1 issues in USB
Date:   Mon,  6 Jul 2020 14:33:09 +0100
Message-Id: <20200706133341.476881-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

After these patches are applied, the build system no longer
complains about any W=0 nor W=1 level warnings in drivers/usb.

Hurrah!

Lee Jones (32):
  usb: misc: legousbtower: Demote obvious misuse of kerneldoc to
    standard comment blocks
  usb: chipidea: ci_hdrc_pci: Fix improper use of kerneldoc format
  usb: gadget: legacy: printer: Remove unused variable 'driver_desc'
  usb: gadget: udc: amd5536udc_pci: Remove unused variable 'mod_desc'
  usb: gadget: function: u_ether:  Downgrade kerneldoc headers which to
    not make the mark
  usb: gadget: udc: pxa27x_udc: Fix a bunch of kerneldoc issues
  usb: misc: legousbtower: Demote function header which is clearly not
    kerneldoc
  usb: typec: tcpm: tcpm: Remove dangling unused 'struct
    tcpm_altmode_ops'
  usb: gadget: udc: atmel_usba_udc: Remove set but unused variable 'pp'
  usb: gadget: legacy: nokia: Remove unused static variable
    'product_nokia'
  usb: gadget: function: f_fs: Demote function header which is clearly
    not kerneldoc
  usb: gadget: udc: lpc32xx_udc: Staticify 2 local functions
  usb: host: r8a66597-hcd: Remove set, then over-written, but never used
    variable 'tmp'
  usb: gadget: udc: mv_udc_core: Remove unused static const variable
    'driver_desc'
  usb: gadget: udc: pch_udc: Fix a plethora of function documentation
    related issues
  usb: host: imx21-hcd: Demote function header which is clearly not
    kerneldoc
  usb: host: ehci-fsl: Fix incorrectly named function argument
  usb: host: fotg210-hcd: Remove unused variable 'hcc_params'
  usb: gadget: function: u_uac1_legacy: Demote obvious misuse of
    kerneldoc to standard comment blocks
  usb: host: bcma-hcd: Demote obvious misuse of kerneldoc to standard
    comment blocks
  usb: host: fotg210-hcd: Demote obvious misuse of kerneldoc to standard
    comment blocks
  usb: gadget: udc: mv_u3d_core: Remove unused static const
    'driver_desc'
  usb: gadget: udc: max3420_udc: Remove set, but never checked variable
    'addr'
  usb: typec: ucsi: ucsi: Staticify and stop export of ucsi_init()
  usb: early: ehci-dbgp: Remove set but never checked variable 'ret'
  usb: early: xhci-dbc: Supply missing 'xhci-dbgp.h' headerfile
  usb: early: xhci-dbc: File headers are not good candidates for
    kerneldoc
  usb: host: ehci-platform: Do not define 'struct acpi_device_id' when
    !CONFIG_ACPI
  usb: dwc3: dwc3-qcom: Do not define 'struct acpi_device_id' when
    !CONFIG_ACPI
  usb: host: fhci-tds: Remove unused variables 'buf' and 'extra_data'
  usb: host: fhci-sched: Remove unused variable 'td'
  usb: host: xhci-plat: Do not define 'struct acpi_device_id' when
    !CONFIG_ACPI

 drivers/usb/chipidea/ci_hdrc_pci.c          |  2 +-
 drivers/usb/dwc3/dwc3-qcom.c                | 22 +++++----
 drivers/usb/early/ehci-dbgp.c               |  6 +--
 drivers/usb/early/xhci-dbc.c                |  3 +-
 drivers/usb/gadget/function/f_fs.c          |  2 +-
 drivers/usb/gadget/function/u_ether.c       |  4 +-
 drivers/usb/gadget/function/u_uac1_legacy.c | 14 +++---
 drivers/usb/gadget/legacy/nokia.c           |  1 -
 drivers/usb/gadget/legacy/printer.c         |  1 -
 drivers/usb/gadget/udc/amd5536udc_pci.c     |  1 -
 drivers/usb/gadget/udc/atmel_usba_udc.c     |  3 --
 drivers/usb/gadget/udc/lpc32xx_udc.c        |  4 +-
 drivers/usb/gadget/udc/max3420_udc.c        |  3 +-
 drivers/usb/gadget/udc/mv_u3d_core.c        |  1 -
 drivers/usb/gadget/udc/mv_udc_core.c        |  1 -
 drivers/usb/gadget/udc/pch_udc.c            | 36 +++++++--------
 drivers/usb/gadget/udc/pxa27x_udc.c         | 15 +++---
 drivers/usb/host/bcma-hcd.c                 |  4 +-
 drivers/usb/host/ehci-fsl.c                 |  2 +-
 drivers/usb/host/ehci-platform.c            |  2 +
 drivers/usb/host/fhci-sched.c               | 19 ++++----
 drivers/usb/host/fhci-tds.c                 | 11 ++---
 drivers/usb/host/fotg210-hcd.c              |  7 ++-
 drivers/usb/host/imx21-hcd.c                |  2 +-
 drivers/usb/host/r8a66597-hcd.c             |  8 ++--
 drivers/usb/host/xhci-plat.c                |  2 +
 drivers/usb/misc/legousbtower.c             | 26 +++++------
 drivers/usb/typec/tcpm/tcpm.c               | 51 ---------------------
 drivers/usb/typec/ucsi/ucsi.c               |  3 +-
 29 files changed, 96 insertions(+), 160 deletions(-)

-- 
2.25.1

