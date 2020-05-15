Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5ECC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982A720709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rJjsB9nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEOUrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgEOUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:47:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C00C061A0C;
        Fri, 15 May 2020 13:47:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so4983731wra.7;
        Fri, 15 May 2020 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDplOVA3qSkGjsB6Sd3N1JzIKO5RkayeKsEDfAMl5CQ=;
        b=rJjsB9nhOn9Hxwm+bxXcGYq9CQgEC/ZcMrFgxs3tkMUpq3BlJzZEiqrQ5+uINouauH
         y38NA2yDoZrVi16c0MKXj5pxr0ln5+yyb0Pt7ZgpudG+IxTb2wYg6BVGthn60LbffL8I
         O4U2CQVqSdKeoST9Fv+7UP6btjOqof9llAQa33zqOFYPkWqgp1ldwdhbLA7msBCAxEzX
         ShDQBclglSqUOpCPaePZpkE66AiGUJQQpGtru5KgIk0bVsmRZTY6K/Og1cLohh9AK6sC
         Hs+Fup9AXMJdW7CRo0xcdZcq/5RVsGYPpgZkVy+3q99uP0jE8EufEIG9rHwhhJmsM032
         ie0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDplOVA3qSkGjsB6Sd3N1JzIKO5RkayeKsEDfAMl5CQ=;
        b=kaUYMktmgKjkyPNwD/fUr8n8R7kG070iEj3Ca/lM0fkKoustNMDalmNfrT9WbLOC4E
         zDGSvsN3tJusTG4JufI//dmXcd9NGJ6BL2CfzeX+Y6wRy9P4TwwxcqD6XytOV0rxRg69
         +MK9+TLdqPHRyfQFwFAeqZWUt/H77OLyplhPm5pblovZtAsuqT53fOsKaQKhqm81LqHQ
         JOrS0vS77RWn63m3xrc3GhamHHE0KH2o/BmnngPWcjKO+t0WW9J/i8lVK6bNkjO91D1C
         IFbU6wo62SPYCslLIqC1+H/gSRuBlBqydlBuVQ+zr/O0RvJkTr7li4JYwZ3qHSzzQXj+
         9+mw==
X-Gm-Message-State: AOAM533EvWUZH4nKaRZFV9fq5NfOB4VlxNAU29TRhtBFdnRPtPIjtGyl
        QbWx/TC+KSxUdaQTBFQzWXk=
X-Google-Smtp-Source: ABdhPJxFKXDlog1adLXGbI1UurJEAGEouTAVJ+JR8QmWLAwwKobBc19vqEgGtEo4w5A7H3mtF998+g==
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr6529849wrr.410.1589575662939;
        Fri, 15 May 2020 13:47:42 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r11sm5296211wma.35.2020.05.15.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:47:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, narmstrong@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 0/4] meson-ee-pwrc: support for Meson8/8b/8m2 and GX
Date:   Fri, 15 May 2020 22:47:05 +0200
Message-Id: <20200515204709.1505498-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
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

Kevin, I'm not sure if this can still make it into v5.8. If the
series as a whole can't make it for some reason then I'd appreciate if
patches #1 and #2 could end in v5.8 so I can push the .dts patches for
v5.9.


Changes since v3 at [2]:
- added Rob's Reviewed-by to patches #1 and #2 - thank you!
- add a GX_ prefix to AO_RTI_GEN_PWR_{SLEEP0,ISO} and add new #defines
  for MESON8_AO_RTI_GEN_PWR_{SLEEP0,ISO} based on Neil's suggestion.
- rename meson8_pwrc_mem_eth to meson_pwrc_mem_eth as suggested by
  Neil (thanks!) because it's the same for all platforms
- rename gxbb_pwrc_vpu to gx_pwrc_vpu as suggested by Neil (thanks)
- added Neil's Reviewed-by to patches #3 and #4 

Changes since v2 at [1]:
- don't remove the "reset-names" property from the main description
  (only make it optional and switch from items to minItems) to fix
  a dt_binding_check found by Rob (or his bot) - thanks and sorry!

Changes since v1 at [0]:
- rename PWRC_GXBB_ETH_ID to PWRC_GXBB_ETHERNET_MEM_ID. Spotted by
  Neil, thanks!
- update cover-letter since Neil confirmed (thanks!) that the "dvin"
  reset really belongs to the VPU on GXBB, GXL and GXM
- removed RFC status


[0] https://patchwork.kernel.org/cover/11489163/
[1] https://patchwork.kernel.org/cover/11496013/
[2] https://patchwork.kernel.org/cover/11499791/


Martin Blumenstingl (4):
  dt-bindings: power: meson-ee-pwrc: add support for Meson8/8b/8m2
  dt-bindings: power: meson-ee-pwrc: add support for the Meson GX SoCs
  soc: amlogic: meson-ee-pwrc: add support for Meson8/Meson8b/Meson8m2
  soc: amlogic: meson-ee-pwrc: add support for the Meson GX SoCs

 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 102 +++++++++++++---
 drivers/soc/amlogic/meson-ee-pwrc.c           | 112 ++++++++++++++++--
 include/dt-bindings/power/meson-gxbb-power.h  |  13 ++
 include/dt-bindings/power/meson8-power.h      |  13 ++
 4 files changed, 214 insertions(+), 26 deletions(-)
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h
 create mode 100644 include/dt-bindings/power/meson8-power.h

-- 
2.26.2

