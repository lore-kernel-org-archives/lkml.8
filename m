Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6D7C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62812071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZpFLqRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgC0Urh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:47:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39097 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgC0Urh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:47:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id e9so2006054wme.4;
        Fri, 27 Mar 2020 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7zjqIGuOMvCRRwPxhvLH6aA1v9QtkQcy+k1LVFwx+gQ=;
        b=hZpFLqRqirh0j+uUf7pKw9RmM1CvhHSFFQxfm7nKNVtd6a8Lih6z9h523TV5Hu7U3p
         kb3OHR+LC2kIax0NVqrNmlPxbhQS/tgmy1rqcPsg8hEpnqv4bkoKUAOagMT4M3xwhAoC
         E6fqW5I/LoOz+XNKPeDON9qL+kaZba+/T1zwYHaN0112EZyj1XyzG4w1M6y+xK60YBJY
         d0xHRpaVTlvz+3V1tg49CmBdnnjULWiuAhshwP65ix1cDHlCVAFegI/Rw80nR7YBTqhK
         dJMh1Q+wE3ekR6IV0z1SIpVpIAMOaT3208ZoApJZHVEjXmSYgXg2uJ6MXZNVgWPcCWSr
         D45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7zjqIGuOMvCRRwPxhvLH6aA1v9QtkQcy+k1LVFwx+gQ=;
        b=Y3JI/Q3m/Yc61jRSTTokHVhbLD9GCCp2F+U6DascXuZLzyLCAVvjT4OJxqFgNTh5C0
         M+qBdBJgMX7C60/J1MTSYCnTr/PfOPbSVXPvOBnpT1FiOrl29bkHkqDfwo6dhglw8WA5
         JX+MmlSfs7QmOrda+pSnIcx1qEz978ZErux8Tcgk0Xk8FGdckCH2zb//5qP62UtjDmCA
         VEyJFmaxu9rRg82yL6c7Xv9IIlERV92lybq574v9uHSOmAP8N37CJ+E5uFdV+JbA59hv
         eH7N0iCNZgkIkIwIbQpR6+fN3YRSMEOwBYbuURfuNZL06fXQZclIn68pS6uMRYebIK8C
         XClA==
X-Gm-Message-State: ANhLgQ1PWf060eSUdlBd1iJ7SJwTcqIKrrTf8isqsEYT/ukj2Jg0MOEC
        HrKdh14u43akHmH9xxujX9ktqL8FM4M=
X-Google-Smtp-Source: ADFU+vv7O3ptwyFeNB+gaALx1qQmJ7yrwmxH0+fEo1SxyAQ+FzNlDD988QZzk9inG198GPusTW3lxw==
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr627122wmb.8.1585342053562;
        Fri, 27 Mar 2020 13:47:33 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z129sm9661450wmb.7.2020.03.27.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 13:47:32 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Fri, 27 Mar 2020 16:47:07 -0400
Message-Id: <20200327204711.10614-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 - Addressed Andy Shevchenko's review comments.
   - Fixed dt_binding_check error pointed out by Rob Herring.
   - Removed pr_info message in ehci_brcm_init as suggested by
     Greg Kroah-Hartman.

This adds support for the XHCI, EHCI and OHCI host controllers found
in Broadcom STB SoC's. These drivers depend on getting access to the
new Broadcom STB USB PHY driver through a device-tree phandle and
will fail if the driver is not available.

Al Cooper (4):
  dt-bindings: Add Broadcom STB USB support
  usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
  usb: ehci: Add new EHCI driver for Broadcom STB SoC's
  usb: host: Add ability to build new Broadcom STB USB drivers

 .../bindings/usb/brcm,bcm7445-ehci.yaml       |  61 ++++
 .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
 MAINTAINERS                                   |   9 +
 drivers/usb/host/Kconfig                      |  20 ++
 drivers/usb/host/Makefile                     |  20 +-
 drivers/usb/host/ehci-brcm.c                  | 290 ++++++++++++++++++
 drivers/usb/host/xhci-brcm.c                  |  16 +
 drivers/usb/host/xhci-brcm.h                  |  16 +
 drivers/usb/host/xhci-plat.c                  |  11 +
 9 files changed, 438 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.h

-- 
2.17.1

