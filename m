Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D632EC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA472464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="psv0JUyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgBRTer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:34:47 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40703 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgBRTdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:17 -0500
Received: by mail-wm1-f48.google.com with SMTP id t14so4203136wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+jgqRKML7Yrf3AYnGUIzG8hS1esv3rcPRRHV79fbvHM=;
        b=psv0JUyk005qlyxlj1y9J8rTdUdyhCDFJ8a52kSkwHTJ/UUnAdgPuS8uo/RvUQeufE
         IdR+1lIruwhhBdDjahf5NsTruJo6m5wRtMuj10lr44QAxMyTu2yeXbwg0oLq5l9XDJ19
         gF/npJQeVP389phPJ1HuNhkxGV5DEpcgDeU2V6F0XFFvsAHMVBJtB2+ZilGPEnwjGZu+
         JHbNfoxTnrwiWgzqfroaexHBf6AOBs7iETrD6WKuri0WQ8YJPpTONO1jHaEK5CLeJuBf
         f8ty/A9+CxIxsy3Ns/70PDj+VGvOcqe1ioJPrgHgkPDevJyMAt3la2sYCqXZGfniokvD
         ofwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+jgqRKML7Yrf3AYnGUIzG8hS1esv3rcPRRHV79fbvHM=;
        b=L4ieBnWQnUdjhHuha3UgwStWoMMN+cdervV7oo/WNBvbM4ldRLoCaeMKLeRJpm43u3
         FaAKA3KZsdNj/WpbI+ZGw1rqbMv1TG1p6WSJkhBqY2m2pl8Txit+oIJqqGohXDfjReqc
         mCSvgrsGqPWgVClUE3myk++IEY4fYftih4WbktUaCJVD2X47lYdmxE7qU948Pxj0Io5J
         povPF0eLPwtrWr3ScQujWgkRTswCC6yS5ltSYDyc2nsWod89w3UneIw+xS64T/7iaudW
         ug8ZV+322EOGw5eRX95YH3RXaq6QSgPZcOV71DSL2+O06zzVJgkCUN5f3X2JVVFzkhJY
         hzCA==
X-Gm-Message-State: APjAAAVpwqpPCN0++4SJOd/tNgY5TaAjxWRwLJIdbScoEG1wrHyXT7vC
        MUarayqcymOQ+emfpn1tWqHxgQ==
X-Google-Smtp-Source: APXvYqwCxodnbtZlxvUkeYI5t16CdUAuDYPYCyMJxqeG3RsIVjlqMSYNSQQ1wHqDOq1LeY0/99WinA==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr4919167wmd.163.1582054394962;
        Tue, 18 Feb 2020 11:33:14 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:13 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 00/20] usb: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:43 +0000
Message-Id: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie remove a useless (char*) cast for some xxx_driver.name.
pci_driver, device_driver, usb_composite_driver structures have a "name"
member which is const char * and all the driver patched assigned to it a
const char[] name, so the cast was bad and unnecessary.

Corentin Labbe (20):
  usb: gadget: legacy: gmidi: remove useless cast for driver.name
  usb: gadget: legacy: inode: remove useless cast for driver.name
  usb: gadget: udc: amd5536udc_pci: remove useless cast for driver.name
  usb: gadget: at91_udc: remove useless cast for driver.name
  usb: gadget: dummy_hcd: remove useless cast for driver.name
  usb: gadget: fotg210-udc: remove useless cast for driver.name
  usb: gadget: fusb300_udc: remove useless cast for driver.name
  usb: gadget: goku_udc: remove useless cast for driver.name
  usb: gadget: lpc32xx_udc: remove useless cast for driver.name
  usb: gadget: m66592-udc: remove useless cast for driver.name
  usb: gadget: net2280: remove useless cast for driver.name
  usb: gadget: omap_udc: remove useless cast for driver.name
  usb: gadget: r8a66597-udc: remove useless cast for driver.name
  usb: gadget: renesas_usb3: remove useless cast for driver.name
  usb: host: ehci-pci: remove useless cast for driver.name
  usb: host: ohci-pci: remove useless cast for driver.name
  usb: host: sl811-hcd: remove useless cast for driver.name
  usb: host: uhci-pci: remove useless cast for driver.name
  usb: host: xhci-pci: remove useless cast for driver.name
  usb: musb: core: remove useless cast for driver.name

 drivers/usb/gadget/legacy/gmidi.c       | 2 +-
 drivers/usb/gadget/legacy/inode.c       | 2 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c | 2 +-
 drivers/usb/gadget/udc/at91_udc.c       | 2 +-
 drivers/usb/gadget/udc/dummy_hcd.c      | 4 ++--
 drivers/usb/gadget/udc/fotg210-udc.c    | 2 +-
 drivers/usb/gadget/udc/fusb300_udc.c    | 2 +-
 drivers/usb/gadget/udc/goku_udc.c       | 2 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c    | 2 +-
 drivers/usb/gadget/udc/m66592-udc.c     | 2 +-
 drivers/usb/gadget/udc/net2280.c        | 2 +-
 drivers/usb/gadget/udc/omap_udc.c       | 2 +-
 drivers/usb/gadget/udc/r8a66597-udc.c   | 2 +-
 drivers/usb/gadget/udc/renesas_usb3.c   | 2 +-
 drivers/usb/host/ehci-pci.c             | 2 +-
 drivers/usb/host/ohci-pci.c             | 2 +-
 drivers/usb/host/sl811-hcd.c            | 2 +-
 drivers/usb/host/uhci-pci.c             | 2 +-
 drivers/usb/host/xhci-pci.c             | 2 +-
 drivers/usb/musb/musb_core.c            | 2 +-
 20 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.24.1

