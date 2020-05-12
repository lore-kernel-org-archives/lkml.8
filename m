Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2CDC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA9C20733
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uzxHI4cI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgELJjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725889AbgELJjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:39:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AE2C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:39:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m12so16067143wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zgpqu0nvlNXje4P44wgJ/fTYplh7IoX+pXP6R2kTyUM=;
        b=uzxHI4cI4r7ueJkfpnBdL3JzpvoW11LDPGiW6NfK1U9s8c2/BhOFPdFJjMwZ6ryp+U
         1tU+DHdfOsMJQle6OpB0KoaUQHeyVEdbxV0BUVeHnfQVrsbYAS/6IzYrgTESjFYX4pqQ
         5/Dsf8ikXsKJcV491ahTN25F6sw2KPdozOs6+pO2ITbRI9Mm52K3zL744WjWTdvJG0hV
         YejSR9syq8/27XceTE9AdEzoCBtZW5B5g3cHdVmxzu8Rc0QoC/j25fJBFHt0A6NhSWOP
         IgHs7vrjfl1oPq0ouyWYrdBtpp+skiLEC3zJlbzZj0/f59jQ7iWsW5pKVjNBuR8ZmxVA
         UrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zgpqu0nvlNXje4P44wgJ/fTYplh7IoX+pXP6R2kTyUM=;
        b=p/zfELfHh6UxG+k0+KZCb9nmiJHlbzpIm+EgeIu4x8SdjWu9lrZdPAKYinQXOBJUMo
         NqEjEU0f4/fX4gzjR3o1nDGdp4k+qn7GD/Fh583Z2tlPYTZD3mqiqCErX0bpMnJp79kc
         yzmT4bNStNCfO7tSsZtNfJkKeeM+UseXXwb6DHmXVqDuogFcOZJaNVspDBPegU2dhgUo
         dgoAgzGe7Gi6qnTOcxJsbmQi+PRbnbh1Wt+egOqiurRBHyPLYFm3etL1cana0luWQPG7
         7kcQu5+uuNJVFgGszA6vXoOqQSceMGhaLOO9v8mzDNkTf66LnZMS9z2xGUUC66VBUtYP
         dBiA==
X-Gm-Message-State: AGi0PuZoDEbt9EVuLU1+5ulQnruw/Fa/CgMiV2h8WgMNCbA9KJytHk+C
        IP8D2POyFbPfxcihWAFgOmHnwQ==
X-Google-Smtp-Source: APiQypKf2iz/NXq0roCfN6pjhAVz0wejgec/5x0siuuEH16JGsJRfDvKR1I8FJOnJ4nNNidj130K1Q==
X-Received: by 2002:a1c:1c6:: with SMTP id 189mr5058963wmb.47.1589276361349;
        Tue, 12 May 2020 02:39:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id 81sm14037092wme.16.2020.05.12.02.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:39:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] arm64: dts: meson-sm1: add thermal nodes
Date:   Tue, 12 May 2020 11:39:14 +0200
Message-Id: <20200512093916.19676-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM1 Thermal is missing and broken since the G12A/G12B thermal enablement,
fix this here by moving the g12b thermal nodes to meson-g12b.dtsi
and adding the proper sm1 thermal nodes.

Neil Armstrong (2):
  arm64: dts: meson-g12b: move G12B thermal nodes to meson-g12b.dtsi
  arm64: dts: meson-sm1: add cpu thermal nodes

 arch/arm64/boot/dts/amlogic/meson-g12.dtsi  | 23 --------------------
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 22 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi  | 24 +++++++++++++++++++++
 3 files changed, 46 insertions(+), 23 deletions(-)

-- 
2.22.0

