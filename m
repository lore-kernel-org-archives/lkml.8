Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F021FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C855A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="je8FKIC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHZQDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgHZQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:03:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D965C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:03:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i10so1268519pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MaekrRirwKyLzs9+Fv4keJH6CPIXWhtw9U0PCRkCag=;
        b=je8FKIC9TGkUAFpMpoOz6n/MZ2qY+MYbDAsxEvFByHYwAys46YPtfyvinT5Tc5VoLm
         VfkjkpM0XzmxkSRNqoO9LHL6c+xnl99zoU8PzEayCX+rnKFVJjS1sNMeZlXdPasbmsSk
         asoFQHgi0de+x4c1buK756hG3y3ggRi50Iq0QQmTizbxaLpb7POgmp/WdQK7HHERY5Ha
         AqW78nNYRwAMtRXUrGe4zBbA4Tjaj8x8EO2FtzIq0gcqZLkTIM1SFym6ke4Aly7Pmat/
         SNHnLNOMjlNdyBA0LsE0m3nB0cl/BiNF09/fY31IomJ77dFQVxqN60hnWdxEHdp5KUXZ
         WyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MaekrRirwKyLzs9+Fv4keJH6CPIXWhtw9U0PCRkCag=;
        b=UZO/aknZm2u1TEpYpMoQO46TcDW8Erxt6sodyeJfjVaEeil4Xa+kjqmX59IgbNvOOS
         oAHhYHVN4IUwFI7+gIobTUBsOWZirbt/KvmzlR5oK/bY41QR7l52fnawLTH5eSVBG80p
         3/uwNLtZXfv58gE+DutuQkMGto9GEFoAOpcBsa918Z/V5ungPgl8kiGFNzc7dvy2FKMo
         vJYOLe87RxtP6z4RKvW6LEGX2JTHe3O8HFYRzAcm7ipSk0WwLp9tUH5BojYX/g0b7cpE
         BgPX2dxmRZ1Ews9lHvS56VQsudZJqZmqww8042/uQhHVNqnu3P+2I6JMd9GAoKCGPCnh
         Tamg==
X-Gm-Message-State: AOAM5309l8Z2OUVMmudgWdUzO4raQVzrGjskP3+93BOvm2nEYjHhtvKY
        IQX9m4+Vj938lBMN3FNSL79J/A==
X-Google-Smtp-Source: ABdhPJwUwvdLJh8d8dcPiKqwY4ilUtCue79cXTiTu10Mk7sjBJ9ZeCIllA/nQ9aqa41q8vlo1XzY9w==
X-Received: by 2002:a63:471b:: with SMTP id u27mr11023159pga.139.1598457800565;
        Wed, 26 Aug 2020 09:03:20 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id u3sm2487555pjn.29.2020.08.26.09.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:03:19 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v5 0/2] Add support for Tianma nt36672a video mode panel
Date:   Wed, 26 Aug 2020 21:33:06 +0530
Message-Id: <20200826160308.18911-1-sumit.semwal@linaro.org>
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

Sumit Semwal (2):
  dt-bindings: display: panel: Add bindings for Novatek nt36672a
  drm: panel: Add novatek nt36672a panel driver

 .../display/panel/novatek,nt36672a.yaml       |  81 ++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 767 ++++++++++++++++++
 5 files changed, 866 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36672a.c

-- 
2.28.0

