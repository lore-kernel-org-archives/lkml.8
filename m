Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A9BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE9420720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO+aAPgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHUSQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUSQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510FBC061573;
        Fri, 21 Aug 2020 11:16:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so1167352pjd.1;
        Fri, 21 Aug 2020 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxwCDfHWPjzIrSTbHnr9CZMv03RGjdZqzd0L3MLHXYg=;
        b=nO+aAPgw5Lyom/aRnFm3BN7MTJhDMaXWBr4uaGu52Dq975S8DSH2fCCw1B89aX+ZPW
         s+z/lX3lWh4hQoEtYhWrsPiSkK6pxiiqKKkOlmm7sg7sG8rbosAWih5bxKH0OfDQEYSb
         qzi2uaRzM9B0F1WXm0vD7KhMs92zKKvUT9UH0l/ptOvWJK0ZYPIGHX5ZRk0HDJnygOmm
         W1KGGZ1P/dKlldpZN1M2btMyLcNWXq7kmiPn7nA6VKG9VWkPvuXJVPX20bNGAvyGSUkn
         5Pr6FjB1rMB+ylas6/Y4F7XYkKKiS38zadWgbsgkkebviQr8GZqBQYBAlFeOI4t3wGRR
         8HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxwCDfHWPjzIrSTbHnr9CZMv03RGjdZqzd0L3MLHXYg=;
        b=qwccnKA4WxejXiVCGDLChiaSibq0HSQeulMjGx4ykvb0QxK+cJEaNP6653UCqH2zJK
         utetuejFFOWIfB0+Tc0yDHqlWFjPp5mMhzfIDETIa5gIoDA8G7EmXbMIme9k2m1HI4JT
         YKz88Vtq4aANI3aqYyXzcnd1GTpob4+ty3otLLUJTdUsy4fVjXPz/l9gCkN6LUTA2bMv
         HYRL1Jf9GyNvEBE0LVF/sF4qMkittV8YKB3HNrScUjSiTaAJwhCsS3Wnn1iqK8LNa82+
         sz9dzDa7vI9itnNxlZtOpwtL3WhZc9rLZDfMlZ1xdhYU96akRT/ShZc7HXGgRIswx3Hp
         3heA==
X-Gm-Message-State: AOAM533pYc4VwCBpQKZl/zq1YERgUiwa3Ba8/VafjZlqoYQ/gYBkZVDJ
        301pVBZ9+LUqdpzsB+pSfR2eGNZTNgNzDA==
X-Google-Smtp-Source: ABdhPJxO7XfPu4e6UwXIZv6vPtEbcsm+fwxO3Pn5QjPdn8w3VZpd9WPCKAI6cm1mnMtWBV7v7OOwzg==
X-Received: by 2002:a17:90a:6481:: with SMTP id h1mr3661390pjj.18.1598033761198;
        Fri, 21 Aug 2020 11:16:01 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:00 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 0/9] platform/x86: panasonic-laptop: add optical drive, brightness and battery charging threshold
Date:   Sat, 22 Aug 2020 02:14:24 +0800
Message-Id: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series is to follow up https://lkml.org/lkml/2020/8/19/186

Martin Lucina <mato@kotelna.sk> added a platform device to power on/off the
optical drive. The patch somehow never made its way to upstream.
This patch merges his work.

The Panasonic Let's Note series have firmware registers that store the
state of mute, AC/DC brightness, current brightness and battery charging
threshold (ECO mode). This patch series also add support to them. 


Kenneth Chan (9):
  add support for optical driver power in Y and W series
  replace ACPI prints with pr_*() macros
  split MODULE_AUTHOR() by one author per macro call
  fix naming of platform files for consistency with other modules
  fix sticky key init bug
  add write support to mute
  resolve hotkey double trigger bug
  add support for battery charging threshold (eco mode)
  add platform devices for firmware brightness registers

 drivers/platform/x86/panasonic-laptop.c | 509 +++++++++++++++++++++---
 1 file changed, 454 insertions(+), 55 deletions(-)


base-commit: 06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
-- 
2.17.5

