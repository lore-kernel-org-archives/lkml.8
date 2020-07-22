Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7393C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0B220771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8ZTcKkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgGVF61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVF60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:58:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7B2C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:58:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a23so589727pfk.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iv7QKTOnsxus+CuHI4vvy3vYG7WJhwMve42jwP65b5A=;
        b=Q8ZTcKkPG2FtXDevUXUXT12Cpg5/QNeaH242BUf0y4hS76xUFB35tplhoVeBGSKbS4
         nxJjcK2bjH2Ng8pExvUvJglYqCEh2TV/OysI2eX6f3Ji0ukDLKJ94gBLHct284DHZUU7
         toCbiRUHv2GuqSy7+56Y+0vMFa/fd87OE07bWJ15ufJYS9VQkOXaxTIeb9SHk5J1Ykpi
         uvX7Lzdf1g9+d5sRziXlGX9eGp922bso9G+WGwTe0fw5wtKFdsa5GHTVx5dexv25xvqO
         wFO7hzq1D/GCtGeckSZ25talOW5mcJ/PrNdI7oQiGF/d1gaVIFDPt1szOx3Vzuwv6Ut4
         3wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iv7QKTOnsxus+CuHI4vvy3vYG7WJhwMve42jwP65b5A=;
        b=bumn/DFqXwhFjkeT4eUEGufcq+/taK7ENggXnJc2L0HY5OymlQtdIMyLQr+mWs0ec5
         nXj29pVABMtPOrPMdd7N+joV3EDmg7ec4U0jF9wc8YSLJhXxnho7TOHv99cBKcInnTbb
         OiE2qYGtlQDPMMgkIljUZghUHf1OIagaBNICL3oHiWBquCo3K81QqCkPw3wssRthjk8+
         YTpQsF4kDrJ9t4ztZBvzPXFlYC2JWsaAPkeKMmP+2gmPZcoJabJB3krYXKHPLTgYHBLm
         n9zc464TLWscO/nwly3cACncgDcSei+tyB56GiJ4CROrLlZMV1L1qy3SSloEZF9S67jj
         ch3w==
X-Gm-Message-State: AOAM532WhnemTrYGAKfTxtaYmcWHH7eM7RbfpJztnFFHGzGj514wavuy
        fbraX8Jiq3o1swNtp6Zbg817/g==
X-Google-Smtp-Source: ABdhPJwCCobUwQ+e2qBFBRCdirZxriYS+99wEqbUE93tZXMYMdKpU/YWU6y9v2U/frBlQbsxu1858Q==
X-Received: by 2002:a62:33c5:: with SMTP id z188mr27044385pfz.180.1595397506096;
        Tue, 21 Jul 2020 22:58:26 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id e191sm22144010pfh.42.2020.07.21.22.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 22:58:25 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v2 0/2] Add support for Tianma nt36672a video mode panel
Date:   Wed, 22 Jul 2020 11:28:14 +0530
Message-Id: <20200722055816.20768-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Poco F1 phones from Xiaomi have an nt36672a video mode panel; add support
for the same.
Most of the panel data is taken from downstream panel dts, and is converted to
drm-panel based driver by me.
It has been validated with v5.8-rc5 on Poco F1 phone; my tree with other
dependent patches is here [1]

---
v2: In dt-binding, removed ports node, making port@0 directly under panel@0 node.
    Also updated the panel_on delay to a safer 200ms as needed for latest Android.


Sumit Semwal (2):
  dt-bindings: display: panel: Add bindings for Tianma nt36672a panel
  drm: panel: Add tianma nt36672a panel driver

 .../display/panel/tianma,nt36672a.yaml        | 104 +++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-tianma-nt36672a.c | 859 ++++++++++++++++++
 5 files changed, 982 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-tianma-nt36672a.c

-- 
2.27.0

