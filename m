Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC042C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E455208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmgHUg7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgICSmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgICSmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:42:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C559C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 11:42:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so4993767ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ojv6Zk70N0pbknpw71ulfKg+oLfuRBwxeCEgVk52nEg=;
        b=PmgHUg7YwZYRfk8fy/b0qtwKor1VLNxaFACT9pq1qIzXr2izp251+LS8lUqZSW7KL4
         5nwmyMNkpkK3MOGxCBuG5EOMPLbBC6i06CLYfIFGAUxlxB7PA6LhjSIhAxeIQj5HcP1L
         TQVChQztEpkR+z9iYfObgEE2kwzmqBt6IbYh/nrWhls/JIl0a1LTZ3Squ09s4yCSDmCs
         H9++MGcmnALDUa7TrAXiPOHq/rwYV1dylFsbvi3MxWg1umXtYNUXKBj32uWGeenwVs/+
         TS8h4wSP606ZJLXugzKPGigTVTQdOBCu+R0Y1eNP6XzyZLo9dDFFZ4w9/eyQnpSDvnJg
         mWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ojv6Zk70N0pbknpw71ulfKg+oLfuRBwxeCEgVk52nEg=;
        b=jTBF2KVvXgcFSsnd0R4tVYKV2bYK8ce75ZPZSoUOP8EPL6pDo4ZRUwmiLSZ+64E3SX
         LpPRTWiYxjuIKbq0aZD0iQPeMxQzc2H666UgEbc7dWbzDVYE/D7dGHMroxoCor4aw8y7
         GavI0p3aUuqkuoqukN0XDvtFoq5P/l889v8BUtuh32WxGPBG1TXGJLtGrWWXXPWMcvIw
         yBrYFZ4hMaDcAhOhu1WkAToOkzarDyGxvnRx34ieBs+++gppd2eSqnFpDiny745zkmbu
         9XEzGlrZLY9PkKe30+qjglMfUvJgPtEmS2Gf11Mg+vgmghiQoAkGFDIWck8sbjP5udWu
         VAJw==
X-Gm-Message-State: AOAM532CggzB68q0D/dhM/SlAa+6f0i+pp5Fam5J/Rmk/X1C9p2MzTEv
        2VpIuT+jBUqGNWRGfKmGWNfqTg==
X-Google-Smtp-Source: ABdhPJwFpQwo6BynYN2iRFXq6SxYV8l/szsBtAdT1FFMfbaNsMBXqPNhU6TRTeGGcR9y91+b/9OimQ==
X-Received: by 2002:a2e:9602:: with SMTP id v2mr1857532ljh.455.1599158519552;
        Thu, 03 Sep 2020 11:41:59 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id r8sm754854lfm.42.2020.09.03.11.41.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 11:41:58 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ssantosh@kernel.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, santosh.shilimkar@oracle.com,
        robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        praneeth@ti.com, tony@atomide.com
Subject: [PATCH 0/2] Extend TI PRUSS platform driver
Date:   Thu,  3 Sep 2020 20:41:39 +0200
Message-Id: <1599158501-8302-1-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch-set extends TI PRUSS platform driver about CORECLK_MUX and
IEPCLK_MUX support. The corresponding dt-binding is updated accordingly.

This patch series depends on TI PRUSS platform driver patchset [1].

[1] https://patchwork.kernel.org/cover/11729645/

Grzegorz Jaszczyk (2):
  dt-bindings: soc: ti: Update TI PRUSS bindings regarding clock-muxes
  soc: ti: pruss: support CORECLK_MUX and IEPCLK_MUX

 .../devicetree/bindings/soc/ti/ti,pruss.yaml       | 121 +++++++++++++-
 drivers/soc/ti/pruss.c                             | 184 ++++++++++++++++++++-
 include/linux/pruss_driver.h                       |   6 +
 3 files changed, 303 insertions(+), 8 deletions(-)

-- 
2.7.4

