Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C70C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E56920707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGvZgbNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgEDTj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:39:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2AAC061A0E;
        Mon,  4 May 2020 12:39:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so785473wmj.3;
        Mon, 04 May 2020 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NW8oQWWMjyDuVRlAJpFreByMFafi4QpaqckDeeBZAK4=;
        b=BGvZgbNEWZJtJB/rLL03NY9rGi/ehlH0jg4N4WKhGixHvbUP/tquGIF4e4ki56rWne
         Tz+uVwFhd/70t7HHez2Wfo7FBUinRRAwV0VJriMwat8q2EEUNSlL64jdTT5bA10iKRyx
         IIowCe8n3GYDpxPnBrITwbAUvLNRl0fWAdB735ya0JBTSIRaMoUqvamsrQXPyr+8zaiF
         XF453YXLy1G6JebbBAtF6Qkh80Zh3npwl8uGSw1KXyMRg7rXYI3UU96M4TJ5/6WKwNoT
         yN6EOUFOZvFiEU0gO+PL9RHUPFEThCSX/0Tb5IUPAPUIyDtMAemXAQhDOqu87hAVH/Ds
         G6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NW8oQWWMjyDuVRlAJpFreByMFafi4QpaqckDeeBZAK4=;
        b=bUvh7JlgT/76oHBko8cULCEj1qGQtbnyZGviye34723Z6d66T9/xatn9iY3LHFhabX
         yHLnkfifJ8Qubw28IPvnp7hCeqfT7kZyTaCd8/0sRPX7mhHLFymErfnXE9THGhdezqV/
         oKW5ia8P6ZTLNhBoqqqN9yLVZhBTus/XO8DpgbFyuAC5qW+neR/cr9NzfdDLTLtb17pG
         l5wRGGcm+TFPZdxLxx4HQPixUODX3UYQVhMO2MOEGHgryhNWIGBUhxp5b9xmCszNs7EU
         G6VDX+EVNq3OpmxwlcgAurmZiTS137BlKio+FI1EzrcbKXQnmufZtubIcBU6HPuyAduC
         v9/Q==
X-Gm-Message-State: AGi0PuayherJlnaNDGKp+ZZ+QdsDjkJ7kBpayxTD8jHdsGVjevbbJodp
        +o95Ah3ZhEx0T/EGjOfgDFg=
X-Google-Smtp-Source: APiQypKgVNA1FOuWyq3/1fPwRoS94xnMG7wOri4uYVEUV4/OF7DNlSDZCeZjGj/SyAfRTNf6GeY4FA==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr16729738wmg.117.1588621195459;
        Mon, 04 May 2020 12:39:55 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id p7sm20631312wrf.31.2020.05.04.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:39:55 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 0/2] Add support for ASUS Z00T TM5P5 NT35596 panel
Date:   Mon,  4 May 2020 21:38:12 +0200
Message-Id: <20200504193816.126299-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v1:
- make `backlight_properties props` constant
- a couple of line breaks
- change name and compatible to reflect ASUS being the vendor
- remove a redundant TODO

Konrad Dybcio (2):
  drivers: drm: panel: Add ASUS TM5P5 NT35596 panel driver
  dt-bindings: display: Document ASUS Z00T TM5P5 NT35596 panel
    compatible

 .../display/panel/asus,z00t-tm5p5-n35596.yaml |  56 +++
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 367 ++++++++++++++++++
 4 files changed, 434 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-n35596.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c

-- 
2.26.1

