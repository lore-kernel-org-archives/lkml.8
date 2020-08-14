Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A2DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E07207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIpSp0Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgHNJFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgHNJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:05:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BAC061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so7662535wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iO7mw694Q/zibSe98wvgSj4vZ6umHd/bC+tFMWsB/Lk=;
        b=QIpSp0ZdPhCXFTpBbXE3c0uql6bwGWCp4VWj1PX6a6Jcw76pc+DGkH5co02Kj8WWbn
         h/wXjVHnmebPwcobENg+xj4vlFEJxu4HpvojoBNj4Ib2nWehIzKzSdarN2XxcAFE9I9k
         nRJwH9HEwbgUKi1Ek4JmIk3Nl7EMpvRzoaltRWuYdQmTesmiUqcZnn+W+99xh5rYEwl9
         weTT6Gj09mgQTc9ApG9RMWs/MkbxAvtq1JbKLGHkcN6nEpFJfsZLiBA4ESy/KdmJWB7X
         RnnzosPC67X5suag8e72XwwpKUuDuQan/DUtRIfPloqNmmlij8IKN1L0PS2t/xY52oH5
         IHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iO7mw694Q/zibSe98wvgSj4vZ6umHd/bC+tFMWsB/Lk=;
        b=df9JBl5hU0N4KOluk5wZZ5oNPsa/XMi5oOpZP83IhdRTLXNr6wg1a8wm2/zQNaHX1N
         1cSDTgz6IpdQPo1R8Qk3eS8PvVwDtUogyNYstqeqwqhpaoWSbRHl0iQojcn4Pkoacsd9
         lGVAldUB85dtNBtGjv9M/PxodWCvU93n30aajPHjKach11zikaQQeOdbNUBW/spNlexa
         tdMNrQu6lREIHpNg6z4ILaA3dvz2k9q9/t/gDjKWgKsU4Xr7zYKZZFy+LiMdiR4GyG5M
         394BvA8Nv3hpp58OsRFQX6I9zGqtvhQ5mkPJ0S4o8TAK+eJSGXY6YY2z5gQInA4HJeCF
         TKlQ==
X-Gm-Message-State: AOAM530Yh6t2dG7koZwelJA6AwPAGFktswCp+SOOzydiySCLE13qpWMT
        YLoQJm1hkSbVbat9GajAx4r3xIYs6abeeQ==
X-Google-Smtp-Source: ABdhPJymLYH3K8QMt1MSVRkr+LgMJBwbmUJ/Pd0NyaLN5j3DPjxXJLZ9XYjVxTj8u+VpWCUmq5yr8Q==
X-Received: by 2002:adf:e712:: with SMTP id c18mr1907130wrm.92.1597395918946;
        Fri, 14 Aug 2020 02:05:18 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id m14sm14046745wrx.76.2020.08.14.02.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 02:05:16 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/4] drm/etnaviv: add total hi bandwidth perf counters
Date:   Fri, 14 Aug 2020 11:05:00 +0200
Message-Id: <20200814090512.151416-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This little patch set adds support for the total bandwidth used by HI. The
basic hi bandwidth read-out is quite simple but I needed to add some little
clean-ups to make it nice looking.

Christian Gmeiner (4):
  drm/etnaviv: rename pipe_reg_read(..)
  drm/etnaviv: call perf_reg_read(..)
  drm/etnaviv: add total hi bandwidth perfcounter
  drm/etnaviv: add pipe_select(..) helper

 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 78 ++++++++++++++++-------
 1 file changed, 55 insertions(+), 23 deletions(-)

-- 
2.26.2

