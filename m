Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47536C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2723A207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeSWVtCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEHBqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHBqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:46:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5635BC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 18:46:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 18so94579pfx.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 18:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=alS8Kr7RIS62zN20gJA22RVwlZfBznZKCMd7Fh+rxNs=;
        b=GeSWVtCymiM2pRkZiRajPWrIg9Phe4A4Dum5/RXbulyy2pTFx37DkoJ3vgJQPbq9MW
         mf3uvUdLVFUtj9TWWhRT4xsy8nPUrV4+kNmUbV+M7J5x3KDLwvZrEpcORIanmdZcqaot
         xVrXu8dWMeOmcaGLN/uQNUT78TTuflDHZl2mgS0hD4Fv30ARH5wq6EYUkk7d2cVLE3o1
         VVGDDhKvyXHaYrqSX8RUuNe7an0f+NXBxeHDBAvAekTxjoSMyhjFrFuWV5ms0PxgUn++
         DCWmhcZ0pwc2yf9xKUCbHIMTNVAujIBZ8dFVTgSZ+bE6FWjuSyjf9XidcD1luwSLW9Z4
         hiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=alS8Kr7RIS62zN20gJA22RVwlZfBznZKCMd7Fh+rxNs=;
        b=Qd9E5SBrXd9oArEDpiCTS7fsGhE51TK+f8Tqe1IDnNb/+TFWV7VVRdqx22kZ1lfL8x
         3arUeBLGq/VkpyRKX3YyPs9FD76eW0K208sXKYuGwNM7v8Afw35EJmkepbUrhEx6D41K
         mSCe+qrFmqNfNUuG99oJQjKXWv6fDLEtoiTBk3A6SsMJczoyHfd7JAX/I8VhUJFO9GKM
         iRT100Dd51SFi0hZBuv8mDacOXMzGRJJ1VRDAVBs+DVna1hCKnCgVRIosupThrRMuFRc
         uW8qTnnOp4A7QtJklhlF/n163d78K2im1xBcdFl32dDL0yyit/gTuQyk65vJXA0yjNU6
         JM+A==
X-Gm-Message-State: AGi0PuZ5kVGs7QeLfQCULmCqGQj7fkDkeBRrwWaxigW+PkLb/LM4q6Lz
        b5Jqe2kx0SD4QCDaZniQzxQ=
X-Google-Smtp-Source: APiQypJnSQcMaolrg+UI+/NNrYXp5sdhjMIzzc+8xWsfA0ZYycN3cwtOCSb4v/IJVPkWRFUHNgwBkg==
X-Received: by 2002:a05:6a00:c8:: with SMTP id e8mr275081pfj.206.1588902393523;
        Thu, 07 May 2020 18:46:33 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id f74sm9270816pje.3.2020.05.07.18.46.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 18:46:33 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 0/4] Enable stmpe811 touch screen on stm32f429-disco board
Date:   Fri,  8 May 2020 09:46:24 +0800
Message-Id: <1588902388-4596-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset is intend to enable stmpe811 touch screen on stm32f429-disco
board with three dts and one i2c driver changes.

has been validated by ts_print tool

Changes log:

V3: just add change log in [PATCH V3 3/4] below ---

V2: remove id, blocks, irq-trigger from stmpe811 dts

V1:
    ARM: dts: stm32: add I2C3 support on STM32F429 SoC
    ARM: dts: stm32: Add pin map for I2C3 controller on stm32f4
    ARM: dts: stm32: enable stmpe811 on stm32429-disco board
    i2c: stm32f4: Fix stmpe811 get xyz data timeout issue

dillon min (4):
  ARM: dts: stm32: add I2C3 support on STM32F429 SoC
  ARM: dts: stm32: Add pin map for I2C3 controller on stm32f4
  ARM: dts: stm32: enable stmpe811 on stm32429-disco board
  i2c: stm32f4: Fix stmpe811 get xyz data timeout issue

 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 12 +++++++++
 arch/arm/boot/dts/stm32f429-disco.dts  | 47 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f429.dtsi       | 12 +++++++++
 drivers/i2c/busses/i2c-stm32f4.c       |  6 ++---
 4 files changed, 74 insertions(+), 3 deletions(-)

-- 
2.7.4

