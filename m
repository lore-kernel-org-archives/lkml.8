Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E15C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86DB207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZbX19e3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgEJQzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728849AbgEJQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A01C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s8so7936397wrt.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yH7k9gYgB13VpgYEG3/Nblh9Wnj5tBiFfhJeIl7DDs=;
        b=WZbX19e3hZcwLTtyejO//MC5pLm3CMTwEEijlQoQvY7YPA6Ak7elm34dF6giZQ5LRR
         n4NLp2mH5WdAQhauFMYLXz7vCuXH9z2ONe4zBnkoX2b+3+euVm2FQC5TxzqTTAwXG4GS
         3Z0Sk07D/l76RQCp1wBVCnMYCpML4m6Beab4yAXEFAFjNuDqYR477//SaltCfhgQDAKv
         YZ+lBOpLJRZcQYcTM2Dm4/YITYssgZG2nGt63nQ7aE3zK56h87pYI8mJHFFNVYFtx7LG
         11vyofZFHHTbXvw3e91k8tO7502muM8M3dtZbAqEQT5eVDPnGwqoTLkNBYwpvGAcjV3B
         uy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yH7k9gYgB13VpgYEG3/Nblh9Wnj5tBiFfhJeIl7DDs=;
        b=ACVvDOrhIp601rethjZlq9ekn2GZJdRf4bPOqAB1Ubw4LrLy2s7cab/wbxumHKJwBB
         SXJL8cDV91+CyzFLZUwS0SLwCkNJBgd2XOawHmsInt00ZY7eQWSzkRMVtbd01xFUgJEH
         m7XHVa69bMuRNKPL6Hc6uc7T7vwowvyA+lj8tMfH6Az9q03YYX5uGG1HuBhnNOo6VUR+
         xtIhVNXFjTQigAYhOYh1COPufDhwoo8REaGNEvm7bsfnbpO9ZlRtWOyRyNdsKjPeukxa
         WGajd5rquQJmM2PaMRO8VjdSxup23KckjlfKsoTcNOhl2HZx1W4CAzxVceQSgFhlkdv1
         9FWA==
X-Gm-Message-State: AGi0PuZmOnaBC4TVjdj41glnAhvAuF7T5CEiOvnRAdXXvdW0AI7aSzwC
        TFeym/NcPonZc76LD/kePGA=
X-Google-Smtp-Source: APiQypKO460W1UO0ySq0DC1F1clgOS2zZOWECa6qEnCMEpsIWu09PeM5rrGZWTiQ+sx8PX0ES5vpfw==
X-Received: by 2002:adf:a74b:: with SMTP id e11mr13248517wrd.99.1589129742124;
        Sun, 10 May 2020 09:55:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:41 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 00/15][RFC] Add regulator devfreq support to Panfrost
Date:   Sun, 10 May 2020 18:55:23 +0200
Message-Id: <20200510165538.19720-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This serie cleans and adds regulator support to Panfrost devfreq.
This is mostly based on comment for the freshly introduced lima
devfreq.

We need to add regulator support because on Allwinner the GPU OPP
table defines both frequencies and voltages.

First patches [01-08] should not change the actual behavior
and introduce a proper panfrost_devfreq struct.

Fatches after are WIP and add regulator support.

However I got several issues first we need to avoid getting regulator
if devfreq get by itself the regulator, but as of today the OPP
framework only get and don't enable the regulator...
An HACK for now is to add regulator-always-on in the device-tree.

Then when I enable devfreq I got several faults like.
I'm totally noob on GPU sched/fault and couldn't be helpfull with this.

I got this running glmark2 on T720 (Allwinner H6) with Mesa 20.0.5.
# glmark2-es2-drm
=======================================================
    glmark2 2017.07
=======================================================
    OpenGL Information
    GL_VENDOR:     Panfrost
    GL_RENDERER:   Mali T720 (Panfrost)
    GL_VERSION:    OpenGL ES 2.0 Mesa 20.0.5
=======================================================

[   93.550063] panfrost 1800000.gpu: GPU Fault 0x00000088 (UNKNOWN) at 0x0000000080117100
[   94.045401] panfrost 1800000.gpu: gpu sched timeout, js=0, config=0x3700, status=0x8, head=0x21d6c00, tail=0x21d6c00, sched_job=00000000e3c2132f

[  328.871070] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA 0x0000000000000000
[  328.871070] Reason: TODO
[  328.871070] raw fault status: 0xAA0003C2
[  328.871070] decoded fault status: SLAVE FAULT
[  328.871070] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
[  328.871070] access type 0x3: WRITE
[  328.871070] source id 0xAA00
[  329.373327] panfrost 1800000.gpu: gpu sched timeout, js=1, config=0x3700, status=0x8, head=0xa1a4900, tail=0xa1a4900, sched_job=000000007ac31097
[  329.386527] panfrost 1800000.gpu: js fault, js=0, status=DATA_INVALID_FAULT, head=0xa1a4c00, tail=0xa1a4c00
[  329.396293] panfrost 1800000.gpu: gpu sched timeout, js=0, config=0x3700, status=0x58, head=0xa1a4c00, tail=0xa1a4c00, sched_job=0000000004c90381
[  329.411521] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA 0x0000000000000000
[  329.411521] Reason: TODO
[  329.411521] raw fault status: 0xAA0003C2
[  329.411521] decoded fault status: SLAVE FAULT
[  329.411521] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
[  329.411521] access type 0x3: WRITE
[  329.411521] source id 0xAA00

Thanks for your reviews, help on this serie,
Clement

Clément Péron (15):
  drm/panfrost: avoid static declaration
  drm/panfrost: clean headers in devfreq
  drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
  drm/panfrost: introduce panfrost_devfreq struct
  drm/panfrost: use spinlock instead of atomic
  drm/panfrost: properly handle error in probe
  drm/panfrost: use device_property_present to check for OPP
  drm/panfrost: move devfreq_init()/fini() in device
  drm/panfrost: dynamically alloc regulators
  drm/panfrost: add regulators to devfreq
  drm/panfrost: set devfreq clock name
  arm64: defconfig: Enable devfreq cooling device
  arm64: dts: allwinner: h6: Add cooling map for GPU
  [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
  [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 102 ++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 190 ++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h   |  32 ++-
 drivers/gpu/drm/panfrost/panfrost_device.c    |  56 ++++--
 drivers/gpu/drm/panfrost/panfrost_device.h    |  14 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  15 +-
 drivers/gpu/drm/panfrost/panfrost_job.c       |  10 +-
 9 files changed, 310 insertions(+), 111 deletions(-)

-- 
2.20.1

