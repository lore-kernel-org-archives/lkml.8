Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703ADC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5343A2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VFWrd83n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgDQTIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDQTIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:08:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA004C061A0C;
        Fri, 17 Apr 2020 12:08:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t63so2988055wmt.3;
        Fri, 17 Apr 2020 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMuvuyOtFyoLpiY9akzKJAflY+hfg2VBUUL0F5qxAe8=;
        b=VFWrd83nihPAd9jGqMjJj7mOg7uSRRuJRre/cQRjri0xNaNlduifUNSMb23hB8pK61
         aR0V7qTDd6xAXXytHpIulp6uwcM/jyxG5myWZIHq5cclm2JD2XW6jhwpsBzV6ieOc3RH
         Ywo1LCk5SLOhNLgszZVxqedyiHcB/mP0DzLD6vo6gK2Igw37afpghTZBfKlEieCq6hbs
         mxqwCuoYI0GnFfbKROnT93/1tdM245mHGpZhrcHzEQ721DuhYbQI7MkWF6u/ayUp3iav
         iLI1ZPkio2N+5P6lIoFtRrBDxmQqG7i8AftYmJwLRMAD/gCn0cNvWQthBICnbuEbgv5z
         wJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMuvuyOtFyoLpiY9akzKJAflY+hfg2VBUUL0F5qxAe8=;
        b=IboTxiVhSkhWGe6KX9K41AieB2lK2nPF7vlV+L8vSdSPEwJKwJveRNsMx+QF4o7pEx
         KN5djUQXU2+pW0oYgkaU3RsHhVXlR3xePP8c6jqH5KG5lMyQ2v4C3HQURwfnFXIwYiNJ
         8Ou/LxdPYkaGQRv74BDR8moYAtKP7BIOp8xqDYeBlTCU5mHrh5e2QM5FW+TJSh8m3Uz1
         fgA8B/pHYtWVMqItAi6Yq0305lur/e96UuqjHmDEMBepJNLNRsB0V7XgFrqZKEkiTBVR
         SKUwAZZrlr3oBoCMuya1GpNkwxdGBoswvkEBO9QtxEvobIDsdLAHXU5G53S67p1t+03a
         fU2w==
X-Gm-Message-State: AGi0PuaFZjGsekN+vjUtum72F9clWHzY9JYda4NzZlgjSG2MjU41rjVe
        vwvutq0vAenRTPSxaTfRDWI=
X-Google-Smtp-Source: APiQypKLFPW0P7ews0g26VQ1VAHJSlCWTLKsKwNJUPZQRwT1ZhWrWrDunAJ+rJ+hoeml4OFa5XGZlw==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr4589135wmh.47.1587150521550;
        Fri, 17 Apr 2020 12:08:41 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id q17sm8722220wmj.45.2020.04.17.12.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 12:08:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/4] meson-ee-pwrc: support for Meson8/8b/8m2 and GX
Date:   Fri, 17 Apr 2020 21:08:21 +0200
Message-Id: <20200417190825.1363345-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for all "older" SoCs to the meson-ee-pwrc 
driver. I wanted to compare as much as I could between my Meson8b EC-100
(Endless Mini) and the Le Potato board so I added support for GXBB, GXL
and GXM as well as for the SoCs that I'm actually working on. I will
send the ARM64 dts patches once all of this is reviewed and merged.

I successfully tested the Meson8b part on EC-100 where u-boot does not
initialize the VPU controller. So this the board where I have been
struggling most.


Changes since v1 at [0]:
- rename PWRC_GXBB_ETH_ID to PWRC_GXBB_ETHERNET_MEM_ID. Spotted by
  Neil, thanks!
- update cover-letter since Neil confirmed (thanks!) that the "dvin"
  reset really belongs to the VPU on GXBB, GXL and GXM
- removed RFC status


[0] https://patchwork.kernel.org/cover/11489163/


Martin Blumenstingl (4):
  dt-bindings: power: meson-ee-pwrc: add support for Meson8/8b/8m2
  dt-bindings: power: meson-ee-pwrc: add support for the Meson GX SoCs
  soc: amlogic: meson-ee-pwrc: add support for Meson8/Meson8b/Meson8m2
  soc: amlogic: meson-ee-pwrc: add support for the Meson GX SoCs

 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 102 +++++++++++++++---
 drivers/soc/amlogic/meson-ee-pwrc.c           |  98 ++++++++++++++++-
 include/dt-bindings/power/meson-gxbb-power.h  |  13 +++
 include/dt-bindings/power/meson8-power.h      |  13 +++
 4 files changed, 204 insertions(+), 22 deletions(-)
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h
 create mode 100644 include/dt-bindings/power/meson8-power.h

-- 
2.26.1

