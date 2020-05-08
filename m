Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF283C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E8120A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn7GIjVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgEHVUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEHVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:20:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0540C05BD09;
        Fri,  8 May 2020 14:20:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so11661599wmb.4;
        Fri, 08 May 2020 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1btuJlFJxyKxOm8nyjE+wqJZo7pVEMFPvRsdfbxA2FU=;
        b=Zn7GIjVLdWCwL/jXvAMa3GwSXGqrFFL9JoYYX4tVdEI5JOkf6JzheIJTG25sdDZszO
         Sy2itywQnMQ4PxWTTOe+sXLHNP1eDAbcNBOQrW5py3pLoudTivzQ9/1oQI3V+XG+hO8H
         Nzzf8HZ+4Nz9Yw6y9q0BT5mQzWDOvhzzNs4CLDmJtSCiNKVTexAe6JWAqN3apybkYGW4
         WUBosHkhZYwNEziaHuIQpsXYhv4cLOSvqrNYlca77BQsqVMMJnhw1MRQfXeetjDRNiy+
         3ROGq8lp93Zj5L/Y3mCEyalMZvxXW05Y3sHpP/KzbXcQlY4q6VKUAQlXMf0y7vvwMPhe
         Bzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1btuJlFJxyKxOm8nyjE+wqJZo7pVEMFPvRsdfbxA2FU=;
        b=My+d6MVuDf3Woog1TU4M3V3f4gzAV+xzJq5ce+8q6cYrvJwU3Xtaa6BdlVbCuIGPBu
         7gevWB8coFml7z6as8tkePpU451Bz5DneqmUtEd8/mF9I4AiT7RRAUo0gfEPCxYSakDj
         spDfyHjjGNmLO9i1GmL4kKAE4SQ8iiE7831ToALc1TEAyKuW9b3eQJd72yvonqZng5ko
         JV1fYRTW/JdFwzUtrmmDjQT/rkJpXxwux7moIz35u06Mh8dF8t++jtLpsM8CdUETZjCj
         JNvLMWManHkgVdpu8HN7vJTEvooxxtKDYT5T4pTvmdKyo/Hh7LTkUAYnkRAcIjNW5Xv5
         IsVQ==
X-Gm-Message-State: AGi0PuYREM3LFiBZi99K85R+0tJySHRRvkpU4m8tx3Lyr2+/+ztB7W43
        JiaZwRAaX9HdEU5PDwYumhk7P2LYGoA=
X-Google-Smtp-Source: APiQypLZbSNIunJ1uK/bvkg5d94s+VdgVmnvtMEE2sDtJ37Elm2ZYojQ1kuOSk7qkyxxZJSKtPf6HA==
X-Received: by 2002:a1c:3581:: with SMTP id c123mr6985480wma.150.1588972796890;
        Fri, 08 May 2020 14:19:56 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n9sm4669705wrv.43.2020.05.08.14.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:19:56 -0700 (PDT)
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
Subject: [PATCH v8 0/5] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Fri,  8 May 2020 17:19:24 -0400
Message-Id: <20200508211929.39020-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/usb/host/ehci-brcm.c                  | 281 ++++++++++++++++++
 drivers/usb/host/xhci-plat.c                  |  10 +
 7 files changed, 390 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-brcm.c

-- 
2.17.1

