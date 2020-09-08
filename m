Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDA0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD308206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zGVSmZ8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbgIHQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732062AbgIHQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:37:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ED9C0612F3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:58:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so17178768wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQtqq8I3b88XI5RYkNp0j+Hhm0cs0BlkIjWpufTUkHo=;
        b=zGVSmZ8TUolLFNV/SsDchqySxOuN18r9lrsOARAJiX8qgn27HVUTobIjs+FYWvWZpK
         QJ9gcWtrP5eg2kUnaDlT/VIsKzYVJy5Tgjs6skknmbDBNfWKHIhhM8k92MWQP9grUzvx
         hO/bdDAA1TCeMktIhuyqFMepQssGn5M6ifZvgjb+ybyIOnK+CeRS5pIKUqZiL2Yvb8c3
         p+OxFlYmMmL/IPbMNHXlwiYsiND/zk/JjY2fKEW6VLjK0jG6FgBW4WFbYSkSyJtCUPCy
         uzKGXeFcqyrWDhyozGOeoo3YF6BqoGxKrANx3KnIVV/KCbwsQmkGjcW4P0RzNP+dYHVk
         PExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQtqq8I3b88XI5RYkNp0j+Hhm0cs0BlkIjWpufTUkHo=;
        b=iFwuqjSXH932LVou+U8cM+1nVqTYxspy/LwP7wwUfQCGiWp59nVQgqGQ3OnZZNM2lY
         RWF/IX5h/lKQ26URfucmhL6SOQn7dTemfrca0ET2OhL6DjeXySevDRp9NB2pVLm1gsQp
         f003W+EwiX4USEHDlVbMcbJmFrwQXSsAdlinKkbJBRA4MSDbqGdB7vo4kc+jvqCMwist
         A139cHSLhVc0EQh77aacFuUIwQnUmzHW37DSb0TwswiOOfmovBIMdT0qQEj8BSULl0eH
         jh1gxwXtTgwDWIg1Jvn+pdbFLcOeXCYcuC2Ee7MIpibpXVJbBQV1GVPDEdoehGddp2G7
         sMhA==
X-Gm-Message-State: AOAM532l/SGpSPAX30YqId1bYh122ofZ77u9MD+uJQywENOygP4jBgBy
        /NKKrhDT2W63Tkab4APJnmlGvQ==
X-Google-Smtp-Source: ABdhPJxQEsA3ZPJXdjC2LTeIeTB/KU9KtEAAN1nSB7wVImXoTAnYJJZmEA23KzFA8RTOBZvJqk+S9Q==
X-Received: by 2002:a7b:c4c4:: with SMTP id g4mr4396170wmk.110.1599569902933;
        Tue, 08 Sep 2020 05:58:22 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y207sm34817875wmc.17.2020.09.08.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:58:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/3] gpiolib: generalize GPIO line names property
Date:   Tue,  8 Sep 2020 14:58:10 +0200
Message-Id: <20200908125813.8809-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I initially sent this as part of the gpio-mockup overhaul but since
these patches are indepentent and the work on gpio-mockup may become
more complicated - I'm sending these separately.

The only change is adding additional property helpers to count strings
in array.

Bartosz Golaszewski (3):
  device: property: add helpers to count items in string arrays
  gpiolib: generalize devprop_gpiochip_set_names() for device properties
  gpiolib: unexport devprop_gpiochip_set_names()

 drivers/gpio/Makefile          |  1 -
 drivers/gpio/gpiolib-acpi.c    |  3 --
 drivers/gpio/gpiolib-devprop.c | 20 ++++++-------
 drivers/gpio/gpiolib-of.c      |  5 ----
 drivers/gpio/gpiolib.c         | 55 +++++++++++++++++++++++++++++++---
 include/linux/gpio/driver.h    |  3 --
 include/linux/property.h       | 13 ++++++++
 7 files changed, 74 insertions(+), 26 deletions(-)

-- 
2.26.1

