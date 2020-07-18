Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9834BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D7B20724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5lAQfKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGRKx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 06:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgGRKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 06:53:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E26C0619D2;
        Sat, 18 Jul 2020 03:53:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ga4so13459566ejb.11;
        Sat, 18 Jul 2020 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zIs8U1AFp5oU7Cmugoi3AB4+ops3mMT+enEcajDUhwg=;
        b=N5lAQfKS8Gbe8mgHP7atg2F/Fd0vQHeKM6ISEhazP33rstplU5A5hGe5QYDH+n8ZF9
         QOn/rxmKkhnvWXEzBKq4mV9aoh2NeuOWc7NuaMDOy7TaC5ahcAw2JFc6KGby2b8+crRK
         oRKz422Ut4VstmKSCmncObD+MR+xn1+k86QmLIqISs3k6s5jKhsEtfYiNJAZFmjG8gtt
         O5IPLXJ8HRQpT5NQUvHvfWO52hFDnPHwveHCcEazAp1nPF2OYWfLpbhO87onOlHfUtkk
         Kh31VOP+nh4kDl3hlhnImZ/gVIgpO3TU/AL1FnjKgJNXjGKqNIVCb7oLraMGMfrV7aS/
         IJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zIs8U1AFp5oU7Cmugoi3AB4+ops3mMT+enEcajDUhwg=;
        b=sO8hinRq+z7aLDrHdmjw3HBHyFu/cl7OewTxFuwU37ORh8DvEAH+86ReKDTCLd4vb+
         bjQIRPrIjv88h2RdIE9ZGo74DNSxOxMs8Kg9cjNpz80QmzoMLgqXfokp29RGBPJHdOQ3
         TkVXTlJmkgiqRfvFxcznaPRbv3VgAbw96DyYOTbSEjdDaQFZ1KT2OALpreiu0Q7uintW
         p38TegfyhJ0B0PPRqWHaSrbnHzZyAu41uXjDymvy9cDgIobmoUyaNR3ybebOogeabX04
         5rlI/l0QS69RoBA8k9Hrm4LrocV/5pdPDLWz6oLBQkuW11bXLUmhbuDAXS2GwRkHVjSz
         omOw==
X-Gm-Message-State: AOAM533WsLBYyVyBdNoY1kbw3DLyRizLK+01aMgpSNMQbYShAhMQiAms
        PpZ7/zChFOwovzMqN3P5CmA=
X-Google-Smtp-Source: ABdhPJyfxdy8JnK3/GBka8Msg1fQrDtZ/be2IA9Dfboj9fwWCufUWM5B0aLmW2SVGzT+dZUHfmrwcg==
X-Received: by 2002:a17:906:33c5:: with SMTP id w5mr12120922eja.275.1595069631178;
        Sat, 18 Jul 2020 03:53:51 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r19sm10776381edp.79.2020.07.18.03.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 03:53:50 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] rk3318 A95X Z2 board
Date:   Sat, 18 Jul 2020 12:53:40 +0200
Message-Id: <20200718105343.5152-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rk3318 A95X Z2 board.

What works:
 adc key
 emmc
 ethernet
 hdmi
 gpu
 ir
 mmc
 sd card
 vop
 usb2
 uart2

Not tested:
 av
 uart0 / bt
 spdif
 wifi

No support in mainline:
 usb3 (works with manufacturer driver)
 front display (works with custom gpio driver AD1628/HT1628)

Problems:
 U-boot only starts on emmc, then loads kernel from sd card or emmc.

 Hdmi hotplug detects DVI modes, but marks them all BAD.
 The dw-hdmi driver needs more pre_pll_cfg_table entries.
 Slow boot behavior. Screen available way after boot. (no penguins)

 GPU support for Debian is not up to date. (old version)
 Use Github version instead.
 Test with glmark2-es2-drm gives glmark2 Score: 29
 Kernel log:
  lima ff300000.gpu: pp pp0 reset time out
  lima ff300000.gpu: pp pp1 reset time out
 No mainline support for GPU thermal and voltage to frequency.
 PWM1 supply connected to DMC, GPU and vcodec.

 The box only has a model name. Vendor prefix not verified.

 Etc.

Changed V2:
  add vendor prefix
  changed compatible string
  restyle
  removed usb3 regulator node
  changed led active high to active low

Johan Jonker (3):
  dt-bindings: Add vendor prefix for Shenzhen Zkmagic Technology Co.,
    Ltd.
  dt-bindings: arm: rockchip: add Zkmagic A95X Z2 description
  arm64: dts: rockchip: add rk3318 A95X Z2 board

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts    | 393 +++++++++++++++++++++
 4 files changed, 401 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts

--
2.11.0

