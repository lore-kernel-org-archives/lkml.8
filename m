Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1999CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E553920656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="hvQ1oySd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgFVRcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgFVRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:32:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E400C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:32:07 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so18821668ejn.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCAmII4vqMO96t6X95dj63747CKVWHh9SpN0EDHNpes=;
        b=hvQ1oySdzoTVBNsN+Qt+HaAMEdhMG3L+Uc9QrdJ1obT/L6trCvyS1+6ZzzR9xjtI4v
         7yQvnyViWU9NsYvAjZgHiUdsopYgkr4JULFpKxs9uzNeyp517EDsw/7+xgWfVuGlTNzK
         /Jezmi5Dac3fa+kZE2kq+Ms3CoNWr1xKVUtjIKQpg76kyAXtjDXDT0x4XIQc7JupEyL+
         p5/kDdJ1aWQ9X5JHEIbollPYf7vUoyO2EG7td/nOPrp1C8+hWPBjIrqVsYjxvgKDcxX1
         kS9KFRBFen4rc9+Y+nQEKwP73AxeOeldYP/JKjhAUgOpyyCMEHGtRT2Btw2yYP/3B/YC
         ST6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCAmII4vqMO96t6X95dj63747CKVWHh9SpN0EDHNpes=;
        b=enx3dl/dUUUkAm+2996SbepyO/Vn9i3Jz43TYoCD3ENhBjgwdBE793fztH/livhM92
         FagnQtjULElrMJA7BE/5hU+2fwhyumyfhdjsUaRE7eHbwamAz7hOcJFKt3ikVUVJvJV6
         6wjBK6WJXsEGEX6ouBcOTPOq/xbG/Wpk1wRooczf8y+zx6V/wxed2U/SI2616W1Gy7w+
         HYZcgAki7AfQ/smiwc3VT+HoG61rdrUDqJShZ4Yh54s8DwD/6beh1avKXbRqkDkqi+Gl
         UsPxeTJlIzIn5Pxvp6KGzAtSgMTOkU1udufFgOl8jOx0AWQCZ8IEm24VRij6gEw4SQHa
         JwSw==
X-Gm-Message-State: AOAM532gr88C3sFB4CnY3/OgTKDCw+WA8y+tP6fHG0iyUEp9Ge5iadbl
        yTLry1eltsc3BbLgO5cCWPcOXGdsmW+gwGy/
X-Google-Smtp-Source: ABdhPJznEQZukuasHS/Zg0q2uZdeIDXrMqMHqbzNqvR2pj+yiY1x7DPMl+RtmNMaot0hcEZtE374dg==
X-Received: by 2002:a17:906:7208:: with SMTP id m8mr17339905ejk.544.1592847126281;
        Mon, 22 Jun 2020 10:32:06 -0700 (PDT)
Received: from localhost.localdomain (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id z1sm4747386ejb.41.2020.06.22.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 10:32:05 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        devicetree@vger.kernel.org, bcousson@baylibre.com,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v3 0/3] pinctrl: single: support #pinctrl-cells = 2
Date:   Mon, 22 Jun 2020 19:29:48 +0200
Message-Id: <20200622172951.524306-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, pinctrl-single only allows #pinctrl-cells = 1.

This series will allow pinctrl-single to also support #pinctrl-cells = 2

If "pinctrl-single,pins" has 3 arguments (offset, conf, mux) then
pcs_parse_one_pinctrl_entry() does an OR operation on to get the
value to store in the register.
    
To take advantage of #pinctrl-cells = 2, the AM33XX_PADCONF macro in
omap.h is modified to keep pin conf and pin mux values separate.

change log:
- v3: change order of patches to make sure the pinctrl-single.c patch
  does not break anything without the dts patches

- v2: remove outer parentheses from AM33XX_PADCONF macro as it causes a
  compile error in dtc.  I had added it per suggestion from checkpatch
  about having parentheses around complex values.

Drew Fustini (3):
  pinctrl: single: parse #pinctrl-cells = 2
  ARM: dts: change AM33XX_PADCONF macro separate conf and mux
  ARM: dts: am33xx-l4: change #pinctrl-cells from 1 to 2

 arch/arm/boot/dts/am33xx-l4.dtsi   |  2 +-
 drivers/pinctrl/pinctrl-single.c   | 11 +++++++++--
 include/dt-bindings/pinctrl/omap.h |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.25.1

