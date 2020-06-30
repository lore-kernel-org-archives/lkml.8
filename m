Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901DA20780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofjxhuaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgF3AJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgF3AJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:09:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5164C061755;
        Mon, 29 Jun 2020 17:09:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so9048301pge.12;
        Mon, 29 Jun 2020 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kx8J891apkIa/g8IE/ArV1cGSLaJdXykQLAbT7gapEo=;
        b=OfjxhuawS11Tyw27qrDv6z78jdyLU+y90/sALz95jSn5ElzsTBhObyaJPWIUD06A8Q
         Rq9XbItl+rW0T4wkm3urohy2MEtJxfCb8Zxdtc2EvR4//sFm4GNqIQ5CJdw2kcr/h3Kk
         SniFgSMVoyHJMiixcZZjfmshzJRypFvUzhO1JSqygFQSDGN3lgJ9cn7Bf8TfA87dnXPF
         7KLoCYmjfVzAxwkcHXac+9fkRa9st4bULqoFc1xWKDAv2tGSeiC7B097UFowCgbfi1AE
         ySFdSzcfGj6S0Z4ATo4HcLrBUQ70+lNBm5vHCZ6KSVPBr18nMWacb2eK++3xPAE1PdJB
         4WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kx8J891apkIa/g8IE/ArV1cGSLaJdXykQLAbT7gapEo=;
        b=NNWjXCuEC8jtdgL77HyJ6i2m2sEiLpuho/dj22Sj5DOLn/aXKtCJQAARy1FYufX2h+
         t+iTe40dUqKCombWhNqlKMf3Vg1LC9DHl7dpNz4yM8hJ2Yr1s2tUmXZbqOcgdBqA+Imu
         2fUxVhb3gZUlAnOcDi6hCEttn5CBJnijMnlLBLjdy5DS/B0wscekCTOgSwAWe/qxEZ6+
         1PBp95DzNN9RaNp0pArvb6EzHhgzaiT9IEbdSRyOUpdt6CLZUk2nyPb+YFgHiLL1qGhG
         JTnfU16qVlGCx9vpVpokLpxlmSNbWWaZKG+I+ZDEw7bWyPHYzuUfFp8Oz34/oQCYnaeK
         rl3g==
X-Gm-Message-State: AOAM532MYstZz/NNf5ryNaoEwqkDB9BlM1j/RG3cIJTIKBQweeTHf2Ty
        tGNpo0jOhZlCapx/lK8BJnw9mFjD+KJqWA==
X-Google-Smtp-Source: ABdhPJy27ifQA45ma6XMOnXykokl5ViL5QxEvsVBhYpeBWZBo8l1JoEZW17Z+4iSRG19EFlNaLhJHQ==
X-Received: by 2002:a63:125f:: with SMTP id 31mr13062566pgs.239.1593475742116;
        Mon, 29 Jun 2020 17:09:02 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id m9sm754600pgq.61.2020.06.29.17.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 17:09:01 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/3] ARM: dts: aspeed: fixup wedge40 device tree
Date:   Mon, 29 Jun 2020 17:08:48 -0700
Message-Id: <20200630000851.26879-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series update several devices' settings in Facebook Wedge40
device tree.

Patch #1 disables a few i2c controllers as they are not being used at
present.

Patch #2 enables adc device for voltage monitoring.

Patch #3 enables pwm_tacho device for fan control and monitoring.

Tao Ren (3):
  ARM: dts: aspeed: wedge40: disable a few i2c controllers
  ARM: dts: aspeed: wedge40: enable adc device
  ARM: dts: aspeed: wedge40: enable pwm_tacho device

 .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 42 +++++++++++++++----
 1 file changed, 34 insertions(+), 8 deletions(-)

-- 
2.17.1

