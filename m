Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49A1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 13:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC98323B42
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 13:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj3ImcIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgFTNrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 09:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFTNrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 09:47:09 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B386EC06174E;
        Sat, 20 Jun 2020 06:47:08 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p18so9989775eds.7;
        Sat, 20 Jun 2020 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dMDIomqXv2PTVyT9EN/dRr3Itv33Vi1WIexGpatW+rc=;
        b=Xj3ImcILvx9GAiiJQWsnB45W4oGoeWEalrMVRSj2HHOHHu2oNF3+q2P+c85THB9vgy
         9nZyXZuqSYBle1jgVVyd4Hq84Y6qs1h75lAxpIHTj4dwPolqOdvC6WxGsBXKhrPFwAlu
         0RnPaSkQ4tLReSX8916iPoo55kKQ177hYLg+a3zXu+KfWr2j2QDAtZvMhJZMmTnbk11Y
         PRzCmcSV/E2UJS7tCYr9FFJjDrmCkj+XRVt+1SY9iZMz3jzwyBn4nzRVIh2foS4lANKV
         zYR5lEJB97HMrHy2NYxd98t3oZTGcnAhaV5MuIrogGMk0XdS+p7vriFC8sJU8QY4Y5e3
         BxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dMDIomqXv2PTVyT9EN/dRr3Itv33Vi1WIexGpatW+rc=;
        b=aulTSkOOjWEJvcBvly3mYjvxw+RE5EwLy5PsACIsCTvSzZk1OsXotXG6MMsaHYiBQz
         cZ/q8sYmT8Z0PHtYRg9/i31r/HhFmEIEuwEtsxsNo53rmxNzSHTrKLZYL23PwRkm9Sta
         ME0dmmiYcG+WLpAyyQOxbIJ8ZO84W8YLOoNpYAJTouy+YSjm1hL/dMQ7lODU5h4h+ytl
         wpyvWPjLkYLdBFz5AXThn95LtArhZU8qCaSvJdgEmG4kXsU2S84SRkygMhUeQ7ZWsYDO
         ygLedgejSsPT+mXs2EzwR6HO6t6wVTJIpBodrQza9dWp43C2YKA8eYWsEFSMJjhXAB1e
         bdmw==
X-Gm-Message-State: AOAM531YOi3NLzTvOVEeyxYI99SQUE767Xk7xRb3too8uWpJ0UOdVRo3
        /4rwon9cpCgI3DNgaClHWXo=
X-Google-Smtp-Source: ABdhPJwNeZBiUhVUKw/ctC7vYh4DW+f6zsqCmplGe0ElvUnjdmpMb5JSw6rySy8qGxCaixXyeOr3JQ==
X-Received: by 2002:aa7:c598:: with SMTP id g24mr8380989edq.132.1592660827295;
        Sat, 20 Jun 2020 06:47:07 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s17sm7192368eju.80.2020.06.20.06.47.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2020 06:47:06 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/2] rk3318 A95X Z2 board
Date:   Sat, 20 Jun 2020 15:46:57 +0200
Message-Id: <20200620134659.4592-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status: EXPERIMENTAL
Use on your own risk.

What works:
 uart2
 mmc
 emmc
 sd card
 usb2

What doesn't work:
 vop
 hdmi
 ethernet

Not tested:
 adc key
 av
 bt
 ir
 spdif
 wifi

No support in mainline:
 usb3
 front display

Problems:
 U-boot only starts on emmc, then loads kernel from sd card.
 Need pd_ignore_unused and clk_ignore_unused in command line
 to prevent a crash. Missing power domains?
 Hdmi hotplug detects DVI modes, but marks them all BAD.
 A fixed display mode in the command line also gives no penguins
 on the screen.
 Etc.

Johan Jonker (2):
  dt-bindings: arm: rockchip: add A95X Z2 description
  arm64: dts: rockchip: add rk3318 A95X Z2 board

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts    | 417 +++++++++++++++++++++
 3 files changed, 423 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts

--
2.11.0

