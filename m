Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF93C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5713D20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BePUAKUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgH1Nxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH1Nx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:53:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40BC061264;
        Fri, 28 Aug 2020 06:53:24 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id oz20so1613977ejb.5;
        Fri, 28 Aug 2020 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4lzNkfbdbtgX88qAdnkqoTFXT/HG037Os2PTRBYKfo=;
        b=BePUAKUOc3LbigT963xXcitFAVnrOr0MehLVBNAaj6e09jglBOHlKzzpGDU2t+UGeY
         8Tm5GaAT4VTleqc4Y1tYNg0LbJf5RmWoP8uJScLroWfoH90tgLqB7T6W7kyrIghaOPUC
         PgjcaWVFe+CEa5en382QRkk5LXQWHcBa568KWH0NGPAAxEQojOiostq+/6egiErfJSXW
         XDbb9f2JRg8f2ZkiMrXuZkmJb/T5ZNVJmoecUIE/Ggt/aTBx1kmKtZDJ1+0lb3wTCdNy
         Vndp6TK38wHY42rHCl9eTHtMys6encXyAGlt4yAks0Cox9YfuXrGVkh6b2Js8OGKhV4b
         wH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4lzNkfbdbtgX88qAdnkqoTFXT/HG037Os2PTRBYKfo=;
        b=okPauw12Fnpnbe7TuxkIJAN8LArPiiDjjU/7OSaYvTNeARtje1xGqRHzbhFIADREQE
         488j0qjD9xSMuU2I5egnI8NGKElrzKul9BGCV26bqwNr5Alhftdd121uwuSn8OGa1zMq
         a3At3sYSuJS4Z89MYWOwDZYCiGWHUhC4qplL5dRIcTUaQRHgNwRDVUZyYxNM9BHNwQUX
         x7zepBxWkQ5r7I9rGXJYtz6xQGEOlecJhfaQZKjn9l3zcuncNIlbpFli6aEzpOWRPSbO
         TPhNOqgkzBISRLF81xmD21gkZr89do+lI7P9Qo7WE8f6JScHrX07smm1qpBerwvajt2J
         xMFA==
X-Gm-Message-State: AOAM532RW5VgcVNNix4xGV/n9XyFJpZUC1Xk3lld45edip57FqEGi4je
        /qOw63Clnbpb4EIVXTf+CtU=
X-Google-Smtp-Source: ABdhPJzjXa3uhVQ1vYKA0KVvl7n8ZXPwjp84kKKWg7pTSUsLm2w7BqKchs3veGnxYOK88qxA6i55pA==
X-Received: by 2002:a17:906:5812:: with SMTP id m18mr1961371ejq.66.1598622802967;
        Fri, 28 Aug 2020 06:53:22 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id f20sm981624ejq.60.2020.08.28.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 06:53:22 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH v2 0/4] Add initial support for RoseapplePi SBC
Date:   Fri, 28 Aug 2020 16:53:16 +0300
Message-Id: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables basic support for RoseapplePi, relying exclusively
on the existing infrastructure for the Actions Semi Owl SoCs (thanks to
Andreas and Mani for making this possible).

The SBC is powered by the Actions Semi S500 SoC and comes with 2GB RAM,
uSD slot and optional eMMC storage. For more details, please check:
http://roseapplepi.org/index.php/spec/

The upcoming patches will improve this initial support by adding the
missing bits and pieces to the S500 clock management unit, which is a
prerequisite for providing an S500 pinctrl and gpio driver, in order to
eventually enable access to additional functionality like I2C and MMC.

Thanks and regards,
Cristian Ciocaltea

Changes in v2:
 - Added Reviewed-by and Acked-by tags from Rob
 - Added Reviewed-by tags from Peter
 - Rebased series onto v5.9-rc2

Cristian Ciocaltea (4):
  arm: dts: owl-s500: Fix incorrect PPI interrupt specifiers
  dt-bindings: Add vendor prefix for RoseapplePi.org
  dt-bindings: arm: actions: Document RoseapplePi
  arm: dts: owl-s500: Add RoseapplePi

 .../devicetree/bindings/arm/actions.yaml      |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/owl-s500-roseapplepi.dts    | 47 +++++++++++++++++++
 arch/arm/boot/dts/owl-s500.dtsi               |  6 +--
 5 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/owl-s500-roseapplepi.dts

-- 
2.28.0

