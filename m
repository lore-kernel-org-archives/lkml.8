Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5614C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6F620829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQ/3KCYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBGoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIBGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:44:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2DDC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 23:44:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x18so1832597pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 23:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2/PwrHkXfRPQTDfnYkByFyhHKkP+0jKSPgxEEXELOwQ=;
        b=TQ/3KCYqasru32p2OO2IQhCCSo6aHlnixswEpGXVnVJY9KZ9cp7xEOtjds86wKSDTT
         KXys35zg30v70pQ6LiCi/nY+Vd7o+E3KJIiQpnaiVnoEU4ER3yBjJn2U9TpmHbbEG94s
         XMQHQkuBViGZn4I5xowJCyWtDNIDe0NUYeqZN4uZUdkBmEdEsGzCgG/1cwiB/VeJAJkA
         9B9X1dZtaRsO5AenaU5e6WyiMGkeke3Qhupbfv/YQPIbWDtD7w/GIEiqe5DKHb866D6p
         frW0BlCXL+PH5QBJK2NQ58ohO4jEJCaVdBijhEnacUspto7zMjlOz2bAVyNSJ/CCgtRP
         cchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2/PwrHkXfRPQTDfnYkByFyhHKkP+0jKSPgxEEXELOwQ=;
        b=M3afInL+oSQaN6wZYJNAItnhufLIQxHJqMYrDxaSfrQB1XZnwFiqnZVH742r/1D2iW
         crgwFA2yVV0vrhTVpuc3NrDMcyyi2SCQ8uEp829xFcMPS9lL/bgM910eskGL0PVNSN16
         0b8GDOfXJxUD3U18mkt4H0NKVJ/xvrZgeObxT7G3kJHKUNQ1+XGGXnHGOog5bDx4UZhz
         nWPMsxXb2SahxNF8hqzbRf4ZEj9LwbNVTi/X89LE9mVMSXKDDSOXmVOYWgCJ16kab7a/
         7kMKS6at5YoLj9rT5BagkARtl3oabE1jn/oIewxWmjDfSYa0eGnp9AxYtMNB2wLK9pjt
         lHHw==
X-Gm-Message-State: AOAM530bAg3apmMlHjMNnDL/bne/4MI9YAvbNmYvxa91w1aZD7wBmlHK
        ID3ptM6yH7icJyBHOF5WWgpULg31YmJWzQ9tUZk=
X-Google-Smtp-Source: ABdhPJz/SU0piZAdKNsX5HeYwxbkxz1Gg1UHcNE8g8LDx3kbH2bjdelUhi3dSWlcWovFCH6Q5d1lPA==
X-Received: by 2002:a17:90a:a882:: with SMTP id h2mr1015667pjq.180.1599029056297;
        Tue, 01 Sep 2020 23:44:16 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id i23sm4317434pfo.207.2020.09.01.23.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:44:15 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v7 0/2]dd support for Tianma nt36672a video mode panel
Date:   Wed,  2 Sep 2020 12:14:05 +0530
Message-Id: <20200902064407.30712-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Poco F1 phones from Xiaomi have a FHD+ video mode panel based on the
Novatek NT36672A display controller; Add support for the same.

Most of the panel data is taken from downstream panel dts, and is converted to
drm-panel based driver by me.

It has been validated with v5.9-rc1 based drm-misc-next on Poco F1 phone; my tree with other
dependent patches is here [1]

[1]: https://git.linaro.org/people/sumit.semwal/linux-dev.git/log/?h=dev/poco-panel-upstreaming

---
v2: In dt-binding, removed ports node, making port@0 directly under panel@0 node.
     Also updated the panel_on delay to a safer 200ms as needed for latest Android.
v3: Replaced port@0 with just port in panel@0 node.
v4: Since "0425662fdf05: drm: Nuke mode->vrefresh", we have to calculate
     vrefresh on demand. Update for it.
v5: Fixed review comments from Sam:
      - rebased on top of drm-misc-next
           remove return of drm_panel_add()
           remove drm_panel_detach()
      - renamed the panel driver file to reflect that this is a novatek
           nt36672a display driver and not only for tianma panels.
           Adjusted some internal names also to reflect the same.
      - corrected changelog to add info about the generic Novatek DSI IC
      - corrected compatible string accordingly
      - removed pinctrl
      - used drm_panel* API for prepare/unprepare/disable/remove
v6: Fixed few review comments on v5 from Sam:
      - add dev_err_probe() support
      - move DRM_* error printing to dev_err()
      - removed a few unnecessary bits
v7: Fixed review comments on v6 from Bjorn:
      - Reworked the send_mipi_commands functionality
      - removed regulator disable_loads; moved active_load setting to probe
        time
      - made function names and struct less generic
      - updated the reset_gpio working to active_low
      - update MAINTAINERS for file name changes

Sumit Semwal (2):
  dt-bindings: display: panel: Add bindings for Novatek nt36672a
  drm: panel: Add novatek nt36672a panel driver

 .../display/panel/novatek,nt36672a.yaml       |  87 +++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 711 ++++++++++++++++++
 5 files changed, 816 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36672a.c

-- 
2.28.0

