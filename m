Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CBBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334AB2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owUjuKkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgGPPj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgGPPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:39:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F08C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:39:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q17so3856756pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyr3SbI1oCdH1r4F7MJGMzPIMQ8npf5yNx4WEH8ce+g=;
        b=owUjuKkkWuKV1LRfGIfOWWmzhKUI7qHe1gaoiNt0XcQEqZ6xMq8wW8NI0mfS1m1HYU
         4R4fGBNPKLx+IUkJ0Ysifp3YPvbhy7ORdKhMaXKX3Vxb95xbGV/17d1XEq3meifzV55S
         yjJiB6lRGcft7eQWmKK3wn2TFUTibh9yrv1F5X236i+2wS4PRJPCccp/sCEARqlBhtQn
         rk8DlwnQ0QHHSCCYCHzK87PQoBF0yXlkbb0uPlQLhkIyfNDnkr4xW0i2p1iTfzUQ8fKe
         mVBmJrYpgkGbFYXtg1wOKSayJFf3ijPSsQTo208/1fvJgBjiCpmgUHmM9n5inbdHkTBi
         LYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyr3SbI1oCdH1r4F7MJGMzPIMQ8npf5yNx4WEH8ce+g=;
        b=cWvOEwkLMakVQvhuexZFZlxd/l5L0mKQGPOV5i+ATLm1szFOf5K+AjUoTML3/6ZyvE
         jjXj9tWYUXrz8TyTYbehQgHSMGfjH5U00wye2JAYq4rzpT/TbtkmgD1iTFw7AUqZSPNj
         QyVEvQ6oYbA4p69+iBKixbl4s3ZxLs9hvrShPGac97HotDEJ69cyE3TdegQw6g84hmel
         rVw5HHUC9K0f7oWnafpYz5saWSELZyv7f1l0mxwZRvh7zQWErRYaQ89aAsdDEche4h+Z
         cGwQg1yXYq8++1IjY3P102miQAMjMSwzg4mCcJ/qWAQ5zP9tJr/6tKAp4ajlkcaU/Xca
         oxEQ==
X-Gm-Message-State: AOAM531RB9JDLKhRhQrNwf4pT32IwrlunU4T2/xkPpx90e3cln1KrbGO
        Im7AiKXXDPHFwxEs5lSPQn0MOgYRMoCkxpi/3Vo=
X-Google-Smtp-Source: ABdhPJyH762SfP1/MeevRjOltGL0CLXQaQ3GApf3PLejmWvDLXcok6iAh0HwkKFpK57hxEPywYJUvw==
X-Received: by 2002:a63:d605:: with SMTP id q5mr5009426pgg.344.1594913955686;
        Thu, 16 Jul 2020 08:39:15 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id f14sm417056pjq.36.2020.07.16.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:39:15 -0700 (PDT)
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
Subject: [PATCH 0/2] Add support for Tianma nt36672a video mode panel
Date:   Thu, 16 Jul 2020 21:08:56 +0530
Message-Id: <20200716153858.526-1-sumit.semwal@linaro.org>
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

[1]: https://git.linaro.org/people/sumit.semwal/linux-dev.git/log/?h=dev/poco-panel-upstreaming

Sumit Semwal (2):
  dt-bindings: display: panel: Add bindings for Tianma nt36672a panel
  drm: panel: Add tianma nt36672a panel driver

 .../display/panel/tianma,nt36672a.yaml        | 110 +++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-tianma-nt36672a.c | 859 ++++++++++++++++++
 5 files changed, 988 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-tianma-nt36672a.c

-- 
2.27.0

