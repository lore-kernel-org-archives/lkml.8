Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE6CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB9F20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTlq/KdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgGVSNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:13:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F3BC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:13:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ga4so3220431ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4+5ISOyb7tM5s6mEPwXPVcwm6EctmoSKPA8kmLF4uKI=;
        b=dTlq/KdGP1L+HQ163BMoFKaZzkW1o0bImAoZppaIGDaNTzP3zxFSz6uSq5wXoAFpwF
         EL0Q+NQ9IHYNsDuGOQU6kz02Iy+WrcfFlwWdP5BSCyaOzRrjDOxX73DFE+B7Z1ehZ2C/
         V2zKXSX2fgIBxImbV1zVW0Cqz76fHwI7Zwl5WhJyse0E8FlGQIzGt7peaXuI2GFqokEP
         yn9Qjppak9nXO26xpLmyFUyK7F5BxZ2/A9HMGqWoMIjRCMJn0JTVMdPz88rLb79Hjh/+
         jesWVlweehg+eyT0M73fJOId8f8npsd4estpoZgPSIugIGFreFAuOVlw/kcYtjw6j4Av
         nYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4+5ISOyb7tM5s6mEPwXPVcwm6EctmoSKPA8kmLF4uKI=;
        b=Oodvmv+gD4ha5UzsKT3bLGcORZ+Gng8dcryu+zAOszFm0+EibbFmQNcMK/v/RadgLz
         lue5pqmWbtk4QxEnLd9vP9s+oaZXZYbQ5DJJ0KnSS/SF8acaulHvUfi4+vE1AJTPZ+jz
         nPrOI/ZyGiK5QX299FY6ph5q30F3Yt6JYo4MVitR7ORFIG+r+2IQMdqDUrtqwmL0JeVh
         IPPYytpShUeBVNUYyp21ReD9W0baVJDRwr61ijtfUsXGTwK7Fyjorx8AkOj+3cyS/IqT
         +RBhL8FcQSa3eIdkQSNklSuLJT06IQ/0aXXF+N4bdLoLDEhLEescAfAVbo869hFkqs9I
         QTFg==
X-Gm-Message-State: AOAM532syT14co4q9QOq4D6a02OZozsdreOmz6THSWtK9WcL3ttDP2lB
        vJgvnulHu8nsCHl+xa5BCg==
X-Google-Smtp-Source: ABdhPJxH3ykklNW90CXxFH3WCY8jAJvtLfyYFceNbp5BHs4YaXxdf5D02pAOLtVlNj7b+JXICAZrbA==
X-Received: by 2002:a17:906:eb93:: with SMTP id mh19mr767276ejb.552.1595441625318;
        Wed, 22 Jul 2020 11:13:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id x64sm372954edc.95.2020.07.22.11.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:13:44 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] drm: rockchip: various ports for older VOPs
Date:   Wed, 22 Jul 2020 20:13:27 +0200
Message-Id: <20200722181332.26995-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series mainly ports existining functionality to older SoCs - most
importantly enables alpha blending for RK3036, RK3066, RK3126 and
RK3188.
Besides that, it also changes the window type from DRM_PLANE_TYPE_CURSOR
to DRM_PLANE_TYPE_OVERLAY for VOPs that have only one (1) overlay window.

Regards,
Alex

Changes in v2:
- drop not yet upstreamed dsp_data_swap from RK3188 regs
- rephrase most commit messages

Alex Bee (5):
  drm: rockchip: add scaling for RK3036 win1
  drm: rockchip: add missing registers for RK3188
  drm: rockchip: add alpha support for RK3036, RK3066, RK3126 and RK3188
  drm: rockchip: set alpha_en to 0 if it is not used
  drm: rockchip: use overlay windows as such

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 42 ++++++++++++++++++---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  1 +
 3 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.17.1

