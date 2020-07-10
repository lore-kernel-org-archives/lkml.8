Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE70C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9ED2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnIxyl30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGJHm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGJHlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:41:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D1EC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:41:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so4795282wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRzp0fkgzEo5tA9tK65ADA4d9spnntHWN3TuXkgZmws=;
        b=hnIxyl30UtrFXLZ6C2gE3jejOPSzk9VK2aMARHzcMFEZg7PxhTfGSvsUkq38Jmb3FF
         aL8YYBIb0MucB5wIMw9j7LnIxVIrZc1Nu+AEDxD/nYZaGcHZeVzLaUbqtjr+LUW0Uor0
         fG8uwhLNVZGW9T+v+d7kRCQSRP0tSwjELvSuV6bOHOrwuQ1f/VQs3tZ1im5omyHPK/Sk
         0yu+kQt9yJu6/BmfmqFOM8DW/ccPh8khhnvRtGxOkL4hGZLDGSJ0mp4YAzQ8J/59E6a7
         xh2rMZbBe96Iazd9dCQjjsH+M1/M3pKbuiN2GIPPz4qO5QS8bd/B9OKym0BcH/3vt4OZ
         OAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRzp0fkgzEo5tA9tK65ADA4d9spnntHWN3TuXkgZmws=;
        b=HyFn3QpYcZm8XdZJxS2KK787IRVVv1l9ZsEXUyEjvIIhV09C/AlrlbMXa0fRU5O8uL
         B6Yl2b8lVQ2Z00lF4jOFE2ah7/GTaTTL7ve4fECQ1//JOQwBhaZzufIbklYPcA/1l1kf
         YGJv4mBH9SCLuQ/5h0wHZ+pb4RooD1UKB/LvIsxxAvNaQKX2LUEBwY0bj72I7UnzjJa1
         zo2p7M+R+roo3DJrywM+dCSc0xUO2bZm8APWnmjfZoNVbmbHH/iOztuWODew22FTo7Eh
         rCRSZ8m+YjGgdmWtXBwshlXZmcye6gTCyKGgKEDd2yZMeAJgXwWreudWRzrhSyBCv5lQ
         4NYQ==
X-Gm-Message-State: AOAM531IINMro38l1pOQVY6vzJkhpVhL8zna/lw7UDPygJL5i+6/fdKb
        K7z+MPFsZRjsriE1YYWN6eB9Sv/Yqh0=
X-Google-Smtp-Source: ABdhPJxjmu1t81pwJYQvJu6PXnZ1rTlbee7s/kcWW+nojDUMarVkTZhwOJtURe+jV8IEXIJSndJrqA==
X-Received: by 2002:a1c:48d7:: with SMTP id v206mr2150751wma.145.1594366907543;
        Fri, 10 Jul 2020 00:41:47 -0700 (PDT)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p17sm7951375wma.47.2020.07.10.00.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 00:41:46 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/4] Add support for GPU load values
Date:   Fri, 10 Jul 2020 09:41:23 +0200
Message-Id: <20200710074143.306787-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for loadavg values for GPU
sub-components. I am adding a SMA algorithm as I was not
really sure if EWMA would be a good fit for this use case.

Christian Gmeiner (4):
  drm/etnaviv: add simple moving average (SMA)
  drm/etnaviv: add loadavg accounting
  drm/etnaviv: show loadavg in debugfs
  drm/etnaviv: export loadavg via perfmon

 drivers/gpu/drm/etnaviv/etnaviv_drv.c     | 14 ++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c     | 44 ++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h     | 29 +++++++++
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 79 +++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_sma.h     | 53 +++++++++++++++
 5 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_sma.h

-- 
2.26.2

