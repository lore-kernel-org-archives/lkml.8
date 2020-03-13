Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C75FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5009E2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l/cF4iKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCMJHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:07:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33544 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCMJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:07:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id r7so7350921wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 02:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlEyFNmy3pyjX2oMkuEavu1zZSuwiAYfnsK65mC/QUA=;
        b=l/cF4iKboaIDC+xHYs6TLSZsMvtHRD1IIKQ729YNj13fHpwpPNa0+wMID3dj4pqXmb
         21tD0UyWk4i0ZyBi0VuvgEwhdCKrXCC70dQoP7Bz+C9m+WrNf+d99KhDTP2H3q3t1I3H
         PwSK9zud1xqzhCczxkFW+h4K9gnTXCTbXTSNvrC/JSU1PvOyDOe0ENzFof+AbAmj6wMW
         tdcOEXLr19NKh5IVqY0M+Yrd+eATVGFKj9JiVq5IDY0l6b4ABwc/CT9cW+pdYgOp5TGO
         iMnZqOOe5ICsfyFmk5dXppdBEBHEaKcYizsJRK+yIrDIj1OWMKoE+4Vhhy3HvsDUXoUK
         knsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlEyFNmy3pyjX2oMkuEavu1zZSuwiAYfnsK65mC/QUA=;
        b=a5ipetun5nrhXe1WQ/2I8kuAgrvZf16NhkPxAY0WQXJlfyC69w4a+796TgD0vWAiB0
         us16OfZ+257AmVj78noZsPmhHbTP2K/7WWXAtjoyHh7H+rEQfCt+apPHuaufFFM0WRPD
         BlqQjb/X8EjFPUOCpcCIGi1ts3FrGI4u+0C2Ojdmz63cNHdmH9bVHI5PMn4chUQBoFG7
         0MqAT1XBqpBuxy4MGhem3nMB/m/DtdOLNk9SbEMI+06t7fFD4YUscBZYTz+HIeKmsnqn
         6cnYjigATAM93GLqBE2BdiX5Z4jNCVm/h7rpeSZtO4CLGD2VFoPbEHOdDEhmmYhsN36m
         cJHA==
X-Gm-Message-State: ANhLgQ3hMHmj7gwiHUySYhzsWBHkJjQu2rJXjxxVNsgaYmbmixhls6IB
        azCPWWWbBk0siqZ8BvPf0rNc4A==
X-Google-Smtp-Source: ADFU+vuPJ8NUok4GeCmE2Jw9WemW5z531KbYxpFMIJ7XQl5ih5AVGvfMpDL/gUM2fHnQl5cuBoUNSw==
X-Received: by 2002:a1c:1f0c:: with SMTP id f12mr9713747wmf.179.1584090436600;
        Fri, 13 Mar 2020 02:07:16 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id i1sm61872399wrs.18.2020.03.13.02.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 02:07:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/4] arm64: meson-g12: enable support for SPIFC
Date:   Fri, 13 Mar 2020 10:07:09 +0100
Message-Id: <20200313090713.15147-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Amlogic G12A and compatible SoCs, the SPI NOR pins are shared with the
eMMC data 4 to 7 pins, thus the DT needs some tweaking to allow setting
on the data 0 to 3 pins for the eMMC controller to enable the eMMC in the
same time as the SPIFC controller.

Since this lowers the performance of the eMMC, the SPIFC is left disabled
and intructions to enable the SPIFC controller as added like done for
the Khadas VIM2 SPIFC support.

This adds SPI NOR support for Khadas VIM3 boards (S922X, A311A and S905D3)
and Odroid-N2 using the same scheme.

Neil Armstrong (4):
  arm64: dts: meson-g12: split emmc pins to select 4 or 8 bus width
  arm64: dts: meson-g12: add the SPIFC nodes
  arm64: dts: khadas-vim3: add SPIFC controller node
  arm64: dts: meson-g12b-odroid-n2: add SPIFC controller node

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 60 +++++++++++++++----
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  2 +-
 .../boot/dts/amlogic/meson-g12a-u200.dts      |  2 +-
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |  2 +-
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 23 ++++++-
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts |  2 +-
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 22 ++++++-
 .../boot/dts/amlogic/meson-sm1-sei610.dts     |  2 +-
 8 files changed, 98 insertions(+), 17 deletions(-)

-- 
2.22.0

