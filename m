Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485A9C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222CE21473
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AU7yxeOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgHaNDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgHaNDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:03:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7849DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:03:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so3008909plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+IiUboT2JLDJY0XsSVzEObSUqQ+wJYQmQ9IQlrmfRQE=;
        b=AU7yxeODVSir9VRjdBY8vrW2CXURGru6jWd9wyEjXM4CcofAOpb2CtmWHknrxH+loJ
         AbqRTohLYEli5/hYHYRPDitwwHEs0IOEWpFE298hoUlMgE14e+nfgqeYft3sr2/FiDVX
         IxliwDpqNj9sEMfQ50HSyMEv6RnFicAPELAe0y5526i31VmuEQ7fAVI4FlYV4xNt98ke
         6lFjeg2hU3z9nPxSDJwZIZh9cPYoRZW6qLsoztODDCY/PcX+EJq0Cu4sFutLqKfYv/Wr
         gZBcH8gJi9eZ2vvSxbFc/o/gbyIqUhLbXhL+UOIvHiOdiNYLHSSf3/WkD54/eHcNV33b
         U7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+IiUboT2JLDJY0XsSVzEObSUqQ+wJYQmQ9IQlrmfRQE=;
        b=MDLNn6l2SGnPU+LklyeKai+j84+y0rMukrStx8+Xm1cx5hVnCQm4kCeAs/YuGQQq64
         C+udWOepmZ5tFWsEucd7hbgNqE0vxdrCWauNfCcEm/ANl3RkBryUD9DxYrRl5s7gg2gF
         09mEttHuGlPCymQeGSiV9aFNb2GSPvMN8BwY6yEV8F3yf0rTVXqb92OE8qtN/GODW+Jg
         /KgoR2jjCD1jC8TEMd1RoM1zoSeyjOvBFue+wnoVsVkuoXMsGbT8lX9SFOOwKWnvuNhm
         hANHWfPpaxMIQbWBgwxnetM2k5+8/DdYJw8uDzBiT42y4CvbGZe8WsByXJPDXrp0DsYm
         ZmfA==
X-Gm-Message-State: AOAM5311LfSL+F37mUFUxlmX/+1Uq2lngu3LuJJX60Sr4HLxOIYBhzfH
        sILrw85Yz54r1Ful+mOvzgmAgA==
X-Google-Smtp-Source: ABdhPJxMUeWG8U9zaI/FC6OP08+JhDmE4fNYmOk9ttc38HQyfr05FpxaMoj5JbHP7FA3wP0uCaHjlQ==
X-Received: by 2002:a17:902:b681:: with SMTP id c1mr956980pls.214.1598878983503;
        Mon, 31 Aug 2020 06:03:03 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id l21sm7400580pgb.35.2020.08.31.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 06:03:01 -0700 (PDT)
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
Subject: [PATCH v6 0/2] Add support for Tianma nt36672a video mode panel
Date:   Mon, 31 Aug 2020 18:32:49 +0530
Message-Id: <20200831130251.19769-1-sumit.semwal@linaro.org>
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

Sumit Semwal (2):
  dt-bindings: display: panel: Add bindings for Novatek nt36672a
  drm: panel: Add novatek nt36672a panel driver

 .../display/panel/novatek,nt36672a.yaml       |  87 ++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 740 ++++++++++++++++++
 5 files changed, 845 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36672a.c

-- 
2.28.0

