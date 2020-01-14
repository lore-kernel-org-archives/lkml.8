Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AFCC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C7924682
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PKw0i+zD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgANPC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:02:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40025 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:02:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so14100090wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9IO2t4EUB8vq/le/UQYX/kJysQD2wGi9iIq5cBrOC0=;
        b=PKw0i+zDZ9peTZ+YPK3rzVwcJw2YI19Fu5RkLsnSIGglohdAEmd2+q1mOlWc6xDcbD
         hrX5XYNHgw6POEEwue1wdI1Y+o5NkIRl5/C7huezZHsYdDqZGldsMYV3kph7jay+zr3i
         ZXVDysZeRx4rW5Mfch2YiM9ktc0WnjDPfhSSd5pYelYCg9k1xqteO86HTAfvaw5I+smv
         XvRIbCrwqZ9+75MlZloV4jLC8ZrxIo2+kpNKQdLH754C4TPyoxBOCPXN77iLTvCf/vUL
         1iWWsdduMu4X01Ty13Uqznesv3dYhDroxdbQWlv+/DcwBPCo+pMsi/7/k/9YleQ0Tx+N
         lAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9IO2t4EUB8vq/le/UQYX/kJysQD2wGi9iIq5cBrOC0=;
        b=gQz+9jcxFOXmv/NWt7AJArsWInXr1jlW3DCenC/RgUOR4vzKen/wwjWg81hN+1r84z
         KJClbvDUM8ZDP5egsO6w5kE3hGp/lz/9O4jJH7unt2SZWMMAUPZpqwnAxeFkv+E/Yfxo
         dOOai38BAvtFX7kCqjTqSAfsKoFoHejBlYjIt9Es4xsNkizsj2kNSH1H6IGQmKJktQWw
         679HcNCnUhlBtrxRnLG91IR4lUI4uMA7zCPIGZbLOc3A6QF9MQPeerCvbyYkjY8MtRtS
         KJ1CmArkfan7DYhtuR3VldUOBabaPL3dDzv+csk/II294vqkT0hKK4Jw2NYVZsLTZCia
         pJNw==
X-Gm-Message-State: APjAAAXYkibVhH1kNIK0Q/IxxWv8ABykSb9/uLim91tGHqO76gYCQNeH
        bMBlt98ZVLwm1dx4SDn2RFxjUA==
X-Google-Smtp-Source: APXvYqwJFreF5WnZJIR7uF51w0nmbr6VtAN/xFBUNukeio9dENX6u6Q8TN4Yual8CujM+F3w6B5rlA==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr27444098wml.3.1579014176616;
        Tue, 14 Jan 2020 07:02:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i10sm20311539wru.16.2020.01.14.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:02:55 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] gpio: mockup: minor maintenance
Date:   Tue, 14 Jan 2020 16:02:51 +0100
Message-Id: <20200114150253.28716-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Just two tweaks to the testing driver: update the license tag to conform
with the current SPDX list and sort the headers alphabetically for easier
maintenance.

Bartosz Golaszewski (2):
  gpio: mockup: update the license tag
  gpio: mockup: sort headers alphabetically

 drivers/gpio/gpio-mockup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.23.0

