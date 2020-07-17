Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1163FC4345B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53392074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oom2uQQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgGQS5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgGQS5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16828C0619D2;
        Fri, 17 Jul 2020 11:57:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 80so9707992qko.7;
        Fri, 17 Jul 2020 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4zn4BK44vZc7f0S/HNU/DnwDAwm1t28dPBFAJHotrE=;
        b=Oom2uQQI7KUCuoWcWA7nWB3HfReS/D9H1JRxaiFh0ZXMlSDFP/OSyZeSiketeJdPru
         TDdL9QS17IY/Q+NSOe/amqnXiAHvyeAza/PIN6dUAaM3+3U91eHjHZsdR2npYjddQYLF
         xXUiYeitsZqpYrt/PoZru38euYd3oS4xJSZRJ6y+FVTSeog/+sR1iwUy7Oo5U8Ngk2wD
         LPITEzGmzxvU2E0vr1iVaaoFN3eGXNYrODrZg6rnexz2qlB7e+O6faiP4r/z/xU2YXg3
         EWsrs5pkgoWS1GjZ35ejS5DfnC0T/BcZ0zHkW28NvTEe6mzDPHKUzO4glemKnZOgrtdo
         FAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4zn4BK44vZc7f0S/HNU/DnwDAwm1t28dPBFAJHotrE=;
        b=SRrWpwTEFq8u8poM+3mNmOucWoRgsao2OoXLJmz0m5BPgDyZQlCFugrDDeyVi4yCSk
         AWXVU987iVMI+++cbdQbXM2ZfXGo7xnRHwITfBSRLjSkJJb59PTLJU4FJSyV//CGhv/9
         FYazcdoS6ToBDp7gsCEQC7hNZorHYw7Y1j2Lrcw0szQNfBdZDuHdPKvTsEE3vkYZQ7uM
         Lj0CVBwL5bNRpkM3azDMN35bXtKElqmnGRGeVMKv345zW7A3C7c8cKKN000HgwaEpLgy
         ciI6YdCFHny5tYhBy9tQtS7zW8+tMa5SxF7s6ZV7zNjGIfZBVDfE4SxcagXEuP1a2xcu
         /zrw==
X-Gm-Message-State: AOAM532JGXPbmxUafD45WAoQ83zZaNnMazY07V5b6ovDrSs+nyrz5WNY
        3evH4hZF+dMITO3GHS91gzs=
X-Google-Smtp-Source: ABdhPJyW3SJZO6eoLZ/8YCXW4+NL7d6BnnWVSr1HDaT+yL+nmss9fLfQ5BSG331f6zTrqq21kTy9Rg==
X-Received: by 2002:a05:620a:994:: with SMTP id x20mr10704606qkx.367.1595012264274;
        Fri, 17 Jul 2020 11:57:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:43 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/25] Documentation: staging/tee.rst: fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:14 -0300
Message-Id: <20200717185624.2009393-15-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

tee.rst:65: WARNING: Unexpected indentation.

tee.rst:69: WARNING: Block quote ends without a
blank line; unexpected unindent.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/staging/tee.rst | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 62e8ba64d04f9..4d4b5f8896032 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -61,13 +61,17 @@ represented as a device identified via Universally Unique Identifier (UUID) and
 client drivers register a table of supported device UUIDs.
 
 TEE bus infrastructure registers following APIs:
--  match(): iterates over the client driver UUID table to find a corresponding
-   match for device UUID. If a match is found, then this particular device is
-   probed via corresponding probe API registered by the client driver. This
-   process happens whenever a device or a client driver is registered with TEE
-   bus.
--  uevent(): notifies user-space (udev) whenever a new device is registered on
-   TEE bus for auto-loading of modularized client drivers.
+
+match():
+  iterates over the client driver UUID table to find a corresponding
+  match for device UUID. If a match is found, then this particular device is
+  probed via corresponding probe API registered by the client driver. This
+  process happens whenever a device or a client driver is registered with TEE
+  bus.
+
+uevent():
+  notifies user-space (udev) whenever a new device is registered on
+  TEE bus for auto-loading of modularized client drivers.
 
 TEE bus device enumeration is specific to underlying TEE implementation, so it
 is left open for TEE drivers to provide corresponding implementation.
-- 
2.27.0

