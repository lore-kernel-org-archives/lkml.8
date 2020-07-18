Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE650C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A2220717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcf8cdLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGRUDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgGRUDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:03:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C75C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:03:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so14252517wrp.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CDz0040ocUHxpFUIIP4fawvgLepMYbIMzDH3U+AwhDE=;
        b=Rcf8cdLP2PLdCB7DxKkuMt6EV43l9QwZu9aYwkGNp5s/GN3zpxXluUytmA9Rdu5M8U
         99lHO8D6M1RPJOsPbGOfw7m6Ep+/BoBFpwwLTN0X7pwmv739vngR4oqT3jVvmmhVMQI1
         AVm3Sc6Sjg0+5PYNYI2B25tyLtGnwzcgFKvumrFNqXEezJcmKAgRWkJo+a5XsOtOItLD
         AQMIwczK42lKqChvbtm6pjA+fT7dZs+wfo0CB83XoapwO/y66/QwsM8Yl7zRZAEahTX8
         Bqza7z8bRgof0sv6QtvtxtViukOaviSYpfRialEf5yVK2o7tFYzR7d/FnjEV1SYSYQCG
         B8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CDz0040ocUHxpFUIIP4fawvgLepMYbIMzDH3U+AwhDE=;
        b=YrdsuH+k1QZKz+qJiuWFV2QM6pTdPG19CuBApoB4HkG18x87qWGqbhDTZsufI5NKNY
         YGYojyrHIJeH7tKn5OshmPXYMAmKSRQqh179V3zlNXEDWsvhUYJAPwF270GgUWSepjB9
         WLqVWaHxdVCKB54Dq3Rg3gpHV+UF8gT5trDmzTd8TVQHhrHjVYFrtY21Y+atXx5HgR0e
         uXFrWCRnocgHMoDhHAixBPC1Y1dfPg5cTURcsGjoee+rLESY8aIQe26XbZrMwHTxssfS
         X0DbvCsqzp/VYk5g9QTIX1Hfmops5wcBdHIg3IMs1flC/eH9VRrrn1oRq8q4lmb0/2ab
         k6bQ==
X-Gm-Message-State: AOAM532wgtpsMWKOSse0Rbb8L1kSbTlJXpLea7bCA7DuLBEqhJclnAj2
        6z5WWv9wPLNFHz6ME/mmUA==
X-Google-Smtp-Source: ABdhPJx5Fp0CxCd6qslOfU0OK/JewpJD0l6KtPf8y69FELkCFoJGm9+D7k5ACzyusZZ9JM/JA4VQQw==
X-Received: by 2002:adf:d842:: with SMTP id k2mr16092208wrl.239.1595102616515;
        Sat, 18 Jul 2020 13:03:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id l15sm21073826wro.33.2020.07.18.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 13:03:35 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm: rockchip: various ports for older VOPs
Date:   Sat, 18 Jul 2020 22:03:18 +0200
Message-Id: <20200718200323.3559-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly ports existining functionality to older SoCs - most
importantly enables alpha blending for RK3036, RK3066, RK3126 and
RK3188.
Besides that, it also changes the window type from DRM_PLANE_TYPE_CURSOR
to DRM_PLANE_TYPE_OVERLAY for VOPs that have only one overlay window.

Alex Bee (5):
  drm: rockchip: add scaling for RK3036 win1
  drm: rockchip: add missing registers for RK3188
  drm: rockchip: add alpha support for RK3036, RK3066, RK3126 and RK3188
  drm: rockchip: set alpha_en to 0 if it is not used
  drm: rockchip: use overlay windows as such

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 43 ++++++++++++++++++---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  1 +
 3 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.17.1

