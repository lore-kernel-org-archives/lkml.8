Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61274C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA1F2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW1UGJHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgB1QzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:55:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37088 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgB1QzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:55:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so3743472wrx.4;
        Fri, 28 Feb 2020 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Xxx3Qqb0dtnL6NDUmFvuivQTJNpJqeohkC3WvUa0gU=;
        b=OW1UGJHXN3wEyt0gFoFs1F0xM5wtl4/sNFB8A0if1rM06Go/3Vel70CebFwzbshV12
         e1FjcCrm630adccf9UdRmL58R//T3U46Qqkj5gGWuE7y8+1+RkjarS6sy9M4FvrAXjy0
         TtQgfIV9eVNdRz541PzHENVU3DyVMCjW2eQnckHVxH+NFsWtuJC+CCf/3i0XDbKol4+p
         h5DS/PG03qOCuQYCSDE8p5KuFTr8Kmxpjfo/ct5Sc/LMccd4A8JW4DGeFyHIWoI4NqAh
         xb0fRFQipa6mlBSaXh5nfPrLgjkAG5QB46+tKXBJyxQ65LQsIVzgxre6pygdQ0Nxw5vO
         4gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Xxx3Qqb0dtnL6NDUmFvuivQTJNpJqeohkC3WvUa0gU=;
        b=UWikZT2yL20erhl/uZTMVAzjRP7hfFR7NpAifSxAES+9DdyrfDBwGQ9aRD+oRmSi9y
         Q0f/UpOGuq7u5HJ35512rgE3nFcQoXvZVxaFzEnGbKT+O3gGec0w90VHGWCCPhXr3WJa
         XUd//pVQoLranUH2ndw1odub2V8sPsuj4k5HaHkf9RuSROoMAIukwPbWb4Nnfv114up8
         LnHehmh51dyj3Rnzqu6Cjc7uYVjsY26IR2IkFt8t+tJ29ys3c/rfjG5/0jzMG8kgQMNN
         ock1AxqCdjtTJoMb7vbHGpcX339oKD1P9Gdk1si920J+ykH1+05gM+ISOhK72sHZnpdJ
         1uTg==
X-Gm-Message-State: APjAAAXXylkuSPjLNogT1pGsYIt8ZYNTp6bnzXKErjmLpTxu7/+bPKpq
        cK9GCAOV/mxOCxMYIpkrYXo=
X-Google-Smtp-Source: APXvYqz5+s2KcoOfysGF++FSqbAnNfBGGG/8rRM0bPYVnipfHUtyC4iaUsAdG9Om2tO0TAEyYnsGYQ==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr5885593wrv.358.1582908906472;
        Fri, 28 Feb 2020 08:55:06 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:3855:fd13:6b76:a11b])
        by smtp.gmail.com with ESMTPSA id s1sm13300071wro.66.2020.02.28.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:55:05 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] media: i2c: imx219: Feature enhancements
Date:   Fri, 28 Feb 2020 16:55:00 +0000
Message-Id: <20200228165503.18054-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the following:
1: Makes sure the sensor is LP11 state on power up
2: Adds support for RAW8
3: Adds support for 640x480 resolution

Lad Prabhakar (3):
  media: i2c: imx219: Fix power sequence
  media: i2c: imx219: Add support for SRGGB8_1X8 format
  media: i2c: imx219: Add support 640x480

 drivers/media/i2c/imx219.c | 225 ++++++++++++++++++++++++++++++++-----
 1 file changed, 199 insertions(+), 26 deletions(-)

-- 
2.20.1

