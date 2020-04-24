Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459ABC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211C720728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAOWm2YD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgDXKY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgDXKY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:24:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8241DC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 03:24:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so1283535wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HF5bWdV7dRmYzWvaTSHJDPKeizw87uk8L9aTpHSkzdU=;
        b=cAOWm2YDDlUvPd7+hciQsQxaOEjENKMN5qagTRQj+nkqpmxr3W9Z3F5q6H+iFVCRXP
         nQr+h88MQY8/M46HGbO7zK19mrcVI7ho+kSRKDmZKtPOIZSg5Suvsex/q7NL/XUfhRlk
         bd1EeFVT0sUEr2+pOaxi2U8eSG2rr80vOX53T3nRnpdFGawh+kLFQRaqouz+JXjK4HYh
         XJkbUVXaebv3qlvhzLTYQjpkKaSytKxKuV7zicwi7Zx78vFv92IKOKyVp1q3fub/5XCU
         7BEmkF94ky9YMlupM2cz6e1PkjGkf7rkzeiFNtuhVKLMghaDxNWpS7oVjbzM5Wdbd8wF
         vjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HF5bWdV7dRmYzWvaTSHJDPKeizw87uk8L9aTpHSkzdU=;
        b=hh4QYacOtcZKfexapyFk8KVfxL5EoWfCHxlVaSrGR8ttQRGHhSThNhYIV2sYTr4/Ya
         ja12ZLIkZeagub9jFKk9s8BhY3gUQq8jJwSrD5cazrgK1qk5EZ8G+J/W3dELegJqh1nS
         WnRiatUW5JMrrql+mwxwSTKrgJM3SaLsWMzHFHKiw6UTzZo+ll1BOfGo3PfzGt9GCtaX
         Q+Z28KyQqdmf1477LERZzbeDJBACqXDat838WlIvLnLXCcdAvxf34V9R2KMdOs25l3hX
         k5IaPShAD/I0BErlqmwngJXxvtjK4ln/0l7G6k99C8J5SJWNrQm1xsHI4lkHhk3XKNZo
         2ZlQ==
X-Gm-Message-State: AGi0PubIwJMx+/DNjMCa0AdXr92Fp6F/gIsZdb7yQvdcNqYQjqD2HMMa
        LHZSEnu75h+Xy8g+4bzykHxXAw==
X-Google-Smtp-Source: APiQypItjRrOqF5wnb5bFyjobG8q9GT/8au3pnUULil08i6PL32UrroBQlQT5ZUiJ/qm+7GegD0TVw==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr9422112wma.32.1587723895088;
        Fri, 24 Apr 2020 03:24:55 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id l15sm2151819wmi.48.2020.04.24.03.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 03:24:54 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:24:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, X86, USB and Watchdog due
 for the v5.7 merge window
Message-ID: <20200424102452.GB8414@dell>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-x86-usb-watchdog-v5.7

for you to fetch changes up to 2f72d35ea75ee8bf8c9e63fb43d43d5bfb4ac8fd:

  MAINTAINERS: Update entry for Intel Broxton PMC driver (2020-04-24 11:18:51 +0100)

----------------------------------------------------------------
Immutable branch between MFD, X86, USB and Watchdog due for the v5.7 merge window

----------------------------------------------------------------
Heikki Krogerus (1):
      usb: typec: mux: Convert the Intel PMC Mux driver to use new SCU IPC API

Mika Westerberg (19):
      platform/x86: intel_scu_ipc: Split out SCU IPC functionality from the SCU driver
      platform/x86: intel_scu_ipc: Log more information if SCU IPC command fails
      platform/x86: intel_scu_ipc: Move legacy SCU IPC API to a separate header
      platform/x86: intel_scu_ipc: Introduce new SCU IPC API
      platform/x86: intel_mid_powerbtn: Convert to use new SCU IPC API
      watchdog: intel-mid_wdt: Convert to use new SCU IPC API
      platform/x86: intel_scu_ipcutil: Convert to use new SCU IPC API
      platform/x86: intel_scu_ipc: Add managed function to register SCU IPC
      platform/x86: intel_pmc_ipc: Start using SCU IPC
      mfd: intel_soc_pmic: Add SCU IPC member to struct intel_soc_pmic
      mfd: intel_soc_pmic_bxtwc: Convert to use new SCU IPC API
      mfd: intel_soc_pmic_mrfld: Convert to use new SCU IPC API
      platform/x86: intel_telemetry: Convert to use new SCU IPC API
      platform/x86: intel_pmc_ipc: Drop intel_pmc_ipc_command()
      x86/platform/intel-mid: Add empty stubs for intel_scu_devices_[create|destroy]()
      platform/x86: intel_pmc_ipc: Move PCI IDs to intel_scu_pcidrv.c
      platform/x86: intel_telemetry: Add telemetry_get_pltdata()
      platform/x86: intel_pmc_ipc: Convert to MFD
      MAINTAINERS: Update entry for Intel Broxton PMC driver

 .../ABI/obsolete/sysfs-driver-intel_pmc_bxt        |  22 +
 MAINTAINERS                                        |  23 +-
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/include/asm/intel-mid.h                   |   9 +-
 arch/x86/include/asm/intel_pmc_ipc.h               |  59 --
 arch/x86/include/asm/intel_scu_ipc.h               | 114 +--
 arch/x86/include/asm/intel_scu_ipc_legacy.h        |  91 ++
 arch/x86/include/asm/intel_telemetry.h             |   6 +-
 drivers/mfd/Kconfig                                |  20 +-
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/intel_pmc_bxt.c                        | 468 ++++++++++
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |  34 +-
 drivers/mfd/intel_soc_pmic_mrfld.c                 |  10 +-
 drivers/platform/x86/Kconfig                       |  46 +-
 drivers/platform/x86/Makefile                      |   2 +-
 drivers/platform/x86/intel_mid_powerbtn.c          |  15 +-
 drivers/platform/x86/intel_pmc_ipc.c               | 949 ---------------------
 drivers/platform/x86/intel_scu_ipc.c               | 447 +++++++---
 drivers/platform/x86/intel_scu_ipcutil.c           |  43 +-
 drivers/platform/x86/intel_scu_pcidrv.c            |  68 ++
 drivers/platform/x86/intel_telemetry_core.c        |  17 +-
 drivers/platform/x86/intel_telemetry_debugfs.c     |  15 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c      |  97 ++-
 drivers/usb/typec/mux/Kconfig                      |   2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |  12 +-
 drivers/usb/typec/tcpm/Kconfig                     |   2 +-
 drivers/watchdog/iTCO_wdt.c                        |  25 +-
 drivers/watchdog/intel-mid_wdt.c                   |  53 +-
 include/linux/mfd/intel_pmc_bxt.h                  |  53 ++
 include/linux/mfd/intel_soc_pmic.h                 |  15 +
 include/linux/platform_data/itco_wdt.h             |  11 +-
 31 files changed, 1411 insertions(+), 1320 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
 delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
 create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
 create mode 100644 drivers/mfd/intel_pmc_bxt.c
 delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
 create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c
 create mode 100644 include/linux/mfd/intel_pmc_bxt.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
