Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E0FC2D0EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5CF20786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uwk1yEjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgC3GBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:01:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45381 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbgC3GBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:01:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so19996487wrw.12;
        Sun, 29 Mar 2020 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nAoWuGTW5ABog8Cj2M3nNOjqgYE3CWQNVmrgj5lQ1DA=;
        b=Uwk1yEjZCOn098fCr015HhA6CtU8DlKpobKl/bvT0dzAwmCcM9JT4aAO6m+2sxMwUy
         vgbkGFs7dQ15gS5dQ3mebfJPdFMPd0/QmCGP0sY1nJRwm03/MNevsr0sUrC1CS2a7vw3
         27TraAA+T0hYkGwcPSaJk4NdpJSfVA3nrzBZu0aRFjCoU++3OxR/pjfZiKnyArrb7Df+
         OgRqtxpry+cEfX46J6Lt5AZwPTlDhfHB0M/hnERd/sJZkDNdanqw7OtaXyOR9at829RP
         Y+ukRPBVxmalsTiQ8AZZIL/6Llrr1mmz1ezJt8IEcVlSFV1YGLtSoQ/e1gDY51+mVp5w
         xuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nAoWuGTW5ABog8Cj2M3nNOjqgYE3CWQNVmrgj5lQ1DA=;
        b=W6bcOYSQEVHUES/fzvvTc0lBvTGlZ9JTHldkvnlwxJk+0APeY24H6Ir3HyaxjimDd3
         ie5bhZ3XDI0AEVPvg2VGKTSpvDLoW68vp2o0lSmy6O6yaeD/iIzYogQPCwBVW8iQch3b
         9PzZjCA0rdaqyRq0tTVo10L2jMPlfl3RoA0eZMYymE/lY+5iZxyf/kcQOzboOjd+a7T8
         zkW5hAJtY87xKWPBI49WPah+u6fBegASHLu47uybI20NSbmTL/mCOso9AWQMSQu0OSqn
         dsAj+APdKZnovBPbpHUfKCGTBZ4l1OCHbOjkznvXUS0P7qy38f/BFnP/z+UKTu4cwHPM
         M8LQ==
X-Gm-Message-State: ANhLgQ1jnoaGZ8QFzbzQRtf6HVxqO34WwRI7PenD1dPHCCHD6wvJsZFi
        CrCR5wHqDWkoD98amue5144=
X-Google-Smtp-Source: ADFU+vtDLAgpvmczvP5q5OPEIH4YCVicaNDFiqQyOqSJLOTiSH3NCUDkUUkIImWvZ3B7ydu8itkhlA==
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr13013492wrn.293.1585548102862;
        Sun, 29 Mar 2020 23:01:42 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2daf:d500:b5da:a664:1d93:3ad3])
        by smtp.gmail.com with ESMTPSA id v7sm18214296wrs.96.2020.03.29.23.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 23:01:42 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs: driver-api: address duplicate label warning
Date:   Mon, 30 Mar 2020 08:01:32 +0200
Message-Id: <20200330060132.7773-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete identically named subsection to fix Documentation warning:

  Documentation/driver-api/w1.rst:11: \
  WARNING: duplicate label driver-api/w1:w1 api internal to the kernel, \
  other instance in Documentation/driver-api/w1.rst

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
One of many doc warnings...
Jonathan, this patch is for you.

 Documentation/driver-api/w1.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/driver-api/w1.rst b/Documentation/driver-api/w1.rst
index 9963cca788a1..bda3ad60f655 100644
--- a/Documentation/driver-api/w1.rst
+++ b/Documentation/driver-api/w1.rst
@@ -7,9 +7,6 @@ W1: Dallas' 1-wire bus
 W1 API internal to the kernel
 =============================
 
-W1 API internal to the kernel
------------------------------
-
 include/linux/w1.h
 ~~~~~~~~~~~~~~~~~~
 
-- 
2.17.1

