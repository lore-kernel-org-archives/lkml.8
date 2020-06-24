Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41BBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F722078E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+H6PpNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405694AbgFXRsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405546AbgFXRsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:48:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D71C061573;
        Wed, 24 Jun 2020 10:48:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so3328316ejc.3;
        Wed, 24 Jun 2020 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eopJXMOiBM4uNCSpUziq8KbuR5DEUMui+dpvP7Q2/5U=;
        b=T+H6PpNIklJjcSSldaz48SjChF+gUaSl1gUlXDjWs7kfYEHeeLWiyKNmdltgu3PQP1
         Gl31B77wgh/YLGK6v85qlgUyFRiQ/DYnMXbbxu5sosB4F4pV/AJnLzRDOa6OK7umNk7x
         o926s1TstOFlKfmjwYPrsiy/pmv2oYUzMhorJe4YS72OWNf3pf1bfneYWQb5j8Fq/PzG
         H88V3/ouLdM4yK6+hq10iilXPAkspkyRZ9trNalO+POoTk4EmCdACTMm9fSX4sOa1uUS
         X5WbyxFrvsGil2xu1KuOA5WKRXqDE0EEoxeuFkMawcz6mp21fgMgJZtyhW6pD2bYgGMl
         xH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eopJXMOiBM4uNCSpUziq8KbuR5DEUMui+dpvP7Q2/5U=;
        b=JTyeir1XPsV04KLyHdOdbGjgfzPlAUwcG2AXZU4uttuZOczT7+4CDnI4ZYhCFGzJ1q
         +C7x47oiezxCEMSr4sn0q9fsM7cAq0zcVDLcR7w+YVYlpz1/O1PAlYDTgXEWUoFGWg8h
         IAAFg6pEK5ExPSn/J2jRURSH6Ub/Te6lkR+bmZuJpzQRRzq0rk7aXoji8+N9ADnUN5TC
         YSBwzsF0RUcFXt5JQQ012xaneY/OJnCy7McYxFZ+NvbaglEkTwn5Wx4S0rTPorc+aGJF
         5pXBCLIrppR3fSMQ81+3Xc6YdJ80o9gyN7AT4kwawwOE6ppNQVrofPow/JzUjFfJy/Da
         q/Kw==
X-Gm-Message-State: AOAM532FAlc0opJeyL6QShIwjuxndisWrBb8LkvxFVXsPgzbAUS0P7F5
        3B2fP1XzXFO5xRiWT8p4yYo=
X-Google-Smtp-Source: ABdhPJyycI4VI3Jn5WxPZIcHDCmNYlNFbUBkNYbFZf32o5yzfQkcZzSBWqm65y70VWV3kRJBTqYndw==
X-Received: by 2002:a17:906:3483:: with SMTP id g3mr25568317ejb.373.1593020880243;
        Wed, 24 Jun 2020 10:48:00 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id s14sm8044146edq.36.2020.06.24.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:47:59 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 0/6] Add RMU and DMAC/GPIO clock support for Actions Semi S500 SoCs
Date:   Wed, 24 Jun 2020 20:47:51 +0300
Message-Id: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a stripped-down revision of the initial series
"[PATCH 00/11] Add CMU/RMU/DMA support for Actions Semi S500 SoCs":
https://lore.kernel.org/lkml/cover.1592407030.git.cristian.ciocaltea@gmail.com/

At Stephen's request, I detached all DTS related work to keep the focus
exclusively on the Actions S500 SoC clock driver changes:

 - Add support for some missing clocks: APB, DMAC, GPIO
 - Add support for Reset Management Unit

The removed patches are subject to resubmission via a separate series:

 - arm: dts: owl-s500: Add Clock Management Unit
 - arm: dts: owl-s500: Set UART clock refs from CMU
 - arm: dts: owl-s500-roseapplepi: Use UART clock from CMU
 - arm: dts: owl-s500: Add DMA controller
 - arm: dts: owl-s500: Add Reset Controller support

Regards,
Cristi

Changes in v1:
 - Incorporate Stephen's review comments
 - Remove DTS related patches
 - Rebase remaining patches on v5.8-rc2
 - Update cover letter, both subject and content, to reflect the new
   scope

Cristian Ciocaltea (6):
  clk: actions: Fix h_clk for Actions S500 SoC
  dt-bindings: clock: Add APB, DMAC, GPIO bindings for Actions S500 SoC
  clk: actions: Add APB, DMAC, GPIO clock support for Actions S500 SoC
  dt-bindings: reset: Add binding constants for Actions S500 RMU
  clk: actions: Add Actions S500 SoC Reset Management Unit support
  MAINTAINERS: Add reset binding entry for Actions Semi Owl SoCs

 MAINTAINERS                                   |  1 +
 drivers/clk/actions/owl-s500.c                | 89 ++++++++++++++++++-
 include/dt-bindings/clock/actions,s500-cmu.h  | 77 ++++++++--------
 .../dt-bindings/reset/actions,s500-reset.h    | 67 ++++++++++++++
 4 files changed, 196 insertions(+), 38 deletions(-)
 create mode 100644 include/dt-bindings/reset/actions,s500-reset.h

-- 
2.27.0

