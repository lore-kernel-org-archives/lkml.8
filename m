Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209BBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC707206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snlOuFkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHQI5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHQI5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:57:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26DC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i92so7669760pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0b4hDbgubBeeHXRlursdhBMl3jFnpB2aLYnsOHqVEyc=;
        b=snlOuFktVD1cP5N09r0AccPqkRSPMz+cvjfUmySoCBbHAg5IqrIz//oiUEskZWFBpr
         WvYMGv0nxUz2prgAdW1W2WCUBYbwjEuXFvOXqQvQDemb2bOQVRke86WivzHQrMQZRB1f
         n7zXV4FZMYRZ3YylXm4t6JHV6yeOVf8lytGEkjdQNn+nRI+VzqOpkEC06NO0isZclWUl
         TlfDxFLlZW1kkEteoruH6rrJ0NqOreFPKS9Q2aSyxdg3xzCMqIJh7JyBHfTBR3mrN1ZA
         NFiQzrS0OC19GCaekoNy7ZIqNpa3wLP3s3orkMWFKreQcAQ5fYdVgB6u8Rrf8bajgR/q
         ndag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0b4hDbgubBeeHXRlursdhBMl3jFnpB2aLYnsOHqVEyc=;
        b=QRb2xhCt9pj0Cs+XqXY+BgKEXnpnt/SxTb4F+e8K9j0tA2/c4ckgLLOLepYRbBfH6T
         eHgQhgED2ciqP0jmN8lEBI0fxZmQYK0RcyQSzNDeEKnHqLZeMwF8UauRnenrP9/BkPRt
         30eFRmjdiRdE4ZCvxv+EljXfnWAkZo6BAIrKh4HWeu3QZeeg71Ybvt/WybgfQqcWXrcQ
         vZkYAK1k4FhFm9SC7eKIbcs5rP1Q6Sufh2jdsFsNPCSKpagKdl6bjD2fJvPvpKJs8Rim
         6L5aPyA7E0jgwftHZZI2+NdfppXqon+hg1xOmBp/tydFMAQ/L/P2oVemHz22de0hsoKS
         wnig==
X-Gm-Message-State: AOAM532qvf5IDu6Ka7PGhrfhDOMYbX4U+VTdvdDWdQPf8QiMShZEtFUo
        EVRRw4h7VNnc4JNBmXe7pTw=
X-Google-Smtp-Source: ABdhPJw7HRAC6poe+UqqVsK7dgB/sMPd8DjS9fktdGxdcAkuA1yd4TGrqN3B3HxZjnefmHY9/tBTCQ==
X-Received: by 2002:a17:90a:c28d:: with SMTP id f13mr8355288pjt.124.1597654637867;
        Mon, 17 Aug 2020 01:57:17 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:57:17 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
Date:   Mon, 17 Aug 2020 14:26:53 +0530
Message-Id: <20200817085703.25732-1-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts 
all the sound drivers to use the new tasklet_setup() API

Allen Pais (10):
  sound: core: convert tasklets to use new tasklet_setup() API
  sound: firewire: convert tasklets to use new tasklet_setup() API
  sound: asihpi: convert tasklets to use new tasklet_setup() API
  sound: riptide: convert tasklets to use new tasklet_setup() API
  sound: rm9652: convert tasklets to use new tasklet_setup() API
  sound/soc: fsl_esai: convert tasklets to use new tasklet_setup() API
  sound/soc: sh: convert tasklets to use new tasklet_setup() API
  sound/soc: txx9: convert tasklets to use new tasklet_setup() API
  sound: midi: convert tasklets to use new tasklet_setup() API
  sound: ua101: convert tasklets to use new tasklet_setup() API

 sound/core/timer.c            |  7 +++----
 sound/firewire/amdtp-stream.c |  8 ++++----
 sound/pci/asihpi/asihpi.c     |  9 ++++-----
 sound/pci/riptide/riptide.c   |  6 +++---
 sound/pci/rme9652/hdsp.c      |  6 +++---
 sound/pci/rme9652/hdspm.c     |  7 +++----
 sound/soc/fsl/fsl_esai.c      |  7 +++----
 sound/soc/sh/siu_pcm.c        | 10 ++++------
 sound/soc/txx9/txx9aclc.c     |  7 +++----
 sound/usb/midi.c              |  7 +++----
 sound/usb/misc/ua101.c        |  7 +++----
 11 files changed, 36 insertions(+), 45 deletions(-)

-- 
2.17.1

