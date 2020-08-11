Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C83C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D842A2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awMoBXKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgHKSV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHKSVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:21:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF295C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:21:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x25so4701533pff.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DmcHWuf2v+3wV2AD0mGNYgT+VY5ydtvubi2qH/7HZXw=;
        b=awMoBXKow61xwOaSEK8foUmARLBgX2Gjc5NemuqQ+u+zr/6iL8Wlsjmt57+TU5sw3T
         7NVhcphc0qo/jF38mnBxS3Ox4C2E5WjVu9pDoWHl77+hseWYj0leqw+QDmOQxgihBiut
         oML0ZtWsJ/clSU5Qiv5dviSFCcgouDXNxFVlfe8kaYX9XRtVRWXHmVd8x/3uA7PejlKh
         xlyJ8OXubECBeXln5+g8YZTmPKeiTJtHKWPnKn6OEud8YkpsmWSROyPvDEDdaXpxJpD+
         3QdyEi8Zu0NgdAfbEPmejz47s6bpMRKcLC6QFNFBP8ZHMnsecIkQ13ujRfP8h7AyAN7F
         +Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DmcHWuf2v+3wV2AD0mGNYgT+VY5ydtvubi2qH/7HZXw=;
        b=SoSB6JiBijoA7XISEEg/7hSZ0LYJcj1EQJrKqSgyWRuxMz0sd4iNG0BBcRg+8M+D7E
         U88JYbUw7kHFd0UfSh09v3ZBeY+oejOykxJnS0hL2c0mVGf0COWRHO9QN4R9HtLB4e3e
         73APNdCWx5fKkijOQT3TT/FzbaHtzo4MLivxKYIqF92GjdTshZ2fpZW0/JgteZBXLrH9
         uwXcrGVnH7zU+4q4F05LE5CI3nRjNDXWnpqXz8K0pAD/L3OgkbbMrI+R2pzqNIQxlxmk
         hsAtP74rg6S7Lhz/6yF7WYYOtPx+DlY5dXmVQvxhAh1TO9nZBdbrbwEPMMtyV+XINhLQ
         eL9A==
X-Gm-Message-State: AOAM530pOFzBY8MmrbyB83JO4lvZlpLEE3bYtHWVidWKQSLMm3R7PlmV
        zfD1ovlLWU+09ouQ27fJ30rsEQ==
X-Google-Smtp-Source: ABdhPJxz0PuC4YfxRjlx/Cs0nOrfxWcypnJDNU7R3auDZe+MNSwJPMHKt+8nmemmZO+slEKvzzM6Yg==
X-Received: by 2002:a62:1803:: with SMTP id 3mr7912192pfy.198.1597170077136;
        Tue, 11 Aug 2020 11:21:17 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id x7sm26595162pfc.209.2020.08.11.11.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:21:16 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add support for Tianma nt36672a video mode panel
Date:   Tue, 11 Aug 2020 23:51:05 +0530
Message-Id: <20200811182107.6515-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
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

[1]: https://git.linaro.org/people/sumit.semwal/linux-dev.git/log/?h=dev/poco-panel-upstreaming

---
v2: In dt-binding, removed ports node, making port@0 directly under panel@0 node.
    Also updated the panel_on delay to a safer 200ms as needed for latest Android.
v3: Replaced port@0 with just port in panel@0 node.
v4: Since "0425662fdf05: drm: Nuke mode->vrefresh", we have to calculate
    vrefresh on demand. Update for it.

Sumit Semwal (2):
  dt-bindings: display: panel: Add bindings for Tianma nt36672a panel
  drm: panel: Add tianma nt36672a panel driver

 .../display/panel/tianma,nt36672a.yaml        |  95 ++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-tianma-nt36672a.c | 858 ++++++++++++++++++
 5 files changed, 972 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-tianma-nt36672a.c

-- 
2.28.0

