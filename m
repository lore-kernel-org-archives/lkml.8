Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D3DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A209207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="D1mB/+jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgFZQz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgFZQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:55:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD26C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:55:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so9435974wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwEfQvmcAp1OzhHgbrf29ByeeRHA8D4QLJumMWlGdMY=;
        b=D1mB/+jjoHrmpzacMbrIPZbzyNR9c53DNmMqrnXYRh1ji4kj8KMh1BFxfXv+E3S3l/
         zE1ygnczed681pTpSj45J9PmD8Kljg4O1mxIskO0RbUq66weejJ7ltMYmR61WwiazY08
         wFM9S5AJtQmmX3cgoyCS5mk01HGvXtAlSB1At87hGWdmWEBT/FGfSwiAD5yEEqZswC+5
         5A3mqUXdDvGnF2J/fsdf28xc5qrA5VgQO3vidHdEI87VseGQOSxVGI0Yo9FQ7noYzqag
         OYyLeTHsfWbZhsnSVUbaXbBJRC/ConjEmK2/ZLLVgVu+YQFgALAkXSk/OkbYgWJu3Ovn
         UBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwEfQvmcAp1OzhHgbrf29ByeeRHA8D4QLJumMWlGdMY=;
        b=tA8YDloEW9+VhkHaWlmlo5uUvPbxTR2p4Q3bJqRCg6EdB3ntGgxvavAEfjVkJcDxxb
         5tcptWr3wAq77U09St+ROWbLJ9ZRoi9sHnGLJOc0IqBFRL9JuWmvEpxHle8rhthnXjAr
         4UzsaAf2+I76+1mYVQAkP34wLZZcvn/V/umbrYu3UwPWDfPc6T2IRmv6WDnD+a+Emv1s
         s+8lg8inaTJFM4mvjZpBiDPC8yI/vFPMZ7MnDB0yFzroaHg7TFal5HnlONehfS+F2sfw
         7pEfghTCFcY20syaTwo9qfXDy57HzgamF06HCZ4MO6dVPTdgkygHwbq3R7jITHBBPkkl
         GQ7A==
X-Gm-Message-State: AOAM530GiZNlKBcznhlBIA+v6N+hm1vrzFpEm0yW0YaxbsIb8EujKQu0
        I46UV3ywW+eQJaNb4c6T1paulQ==
X-Google-Smtp-Source: ABdhPJy08XREFDSmhdAEr3SYzJ2t9HnXgtq5h0IAaCZA65lnqgXMhF90VUJGb0CaBUmmjn+39KSZWg==
X-Received: by 2002:a7b:c18f:: with SMTP id y15mr4457933wmi.85.1593190552393;
        Fri, 26 Jun 2020 09:55:52 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id x5sm18654706wmg.2.2020.06.26.09.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:55:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/5] devres: provide and use devm_krealloc()
Date:   Fri, 26 Jun 2020 18:55:30 +0200
Message-Id: <20200626165535.7662-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Regular krealloc() obviously can't work with managed memory. This series
implements devm_krealloc() and adds the first user with hope that this
helper will be adopted by other drivers currently using non-managed
krealloc().

Some cosmetic changes to the code modified by main patches are included.

Bartosz Golaszewski (5):
  devres: remove stray space from devm_kmalloc() definition
  devres: move the size check from alloc_dr() into a separate function
  device: remove 'extern' attribute from function prototypes in device.h
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers

 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/base/devres.c                         |  58 ++++-
 drivers/hwmon/pmbus/pmbus_core.c              |  27 +--
 include/linux/device.h                        | 225 +++++++++---------
 4 files changed, 173 insertions(+), 138 deletions(-)

-- 
2.26.1

