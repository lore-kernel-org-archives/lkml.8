Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EB7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855552074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWvkYGGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgFONTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbgFONTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:19:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:19:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so19163762ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0+fVB8z8jdw1gSMk70thxDB2hpCm5vov8BerGkPNs4=;
        b=zWvkYGGBLqm+uDBKq1QN8h5GKQ/ETBo/7AxNpXaC4Nb//BtPtgw+DB/QEHBtjD/h9M
         pututTgMvRNXv+Kh3DhcDdxnAonmbMkx6RbS8G7Wkp9PTcVQYQHxhFJ9+uTByfw2DoXr
         MmPAJL9Qfd8irfMqzJi55c0evcYyNIyzxVqoPBi8np315K7e4ZivkDb4NpqUCjytDw5D
         aMg0dehJ2f1o4p7oD/g9AbPALMOj7p943ZMFR7I61I7j4rFyulhKQwm4m5UlAwOovlsD
         +/6tmDLFBy2t45WZ5ukXjxUjiyuFlm1SpagSIP1u5vgu9+dyl4ZRRBaPSUbpusGhChQq
         vHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0+fVB8z8jdw1gSMk70thxDB2hpCm5vov8BerGkPNs4=;
        b=EhrRcA4YWVB+zN2Eu/CWi/oPHLMMuyJag5yExkd1+0k8gCvi2hzcaLoU+ozlG4C6Nt
         gTSeeHndzDwdIaoPCWRSFtAiutGfNfcjHuwfc+vn56fgby/NlhpV65jpywSrOsYpk1r2
         REc5XIZewfelh1nZlNLrhbHb4Kvwg7Bksw4WvRRM5b9+l3osdZJYhN6VEaRUozULoyuX
         kTvxD9r8lTsUmT5JFjNMtPASdtvJJOt4LeAd1iAPT0igKaCgi9jzmLUkD2QMAbMlD2C8
         afpvSRAjPPrw4+YcTsL/GEg9hrlHnEY8vDS5ua6Q2X3HGKFCTbISUJelKd4CEnEU9GA3
         2Wyw==
X-Gm-Message-State: AOAM533821l663hw/oSJEcOh5wyQ9foDST3trQi9iFxIhA3ag7VO2VQj
        lsiCwVDU/wbVMtHnU8ODThWrlg==
X-Google-Smtp-Source: ABdhPJzWFCWxAYzx+/wH9hK3PCY6B9IEdhgTdt/1LyTbYR0kQnQJ0LwMDx+enY0AQppT3qo+WTZE6A==
X-Received: by 2002:a2e:98d7:: with SMTP id s23mr13427255ljj.2.1592227155000;
        Mon, 15 Jun 2020 06:19:15 -0700 (PDT)
Received: from jade.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id y12sm3823532ljh.79.2020.06.15.06.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 06:19:14 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] MAINTAINERS: change tee mailing list
Date:   Mon, 15 Jun 2020 15:19:10 +0200
Message-Id: <20200615131910.2276515-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old TEE mailing list tee-dev@lists.linaro.org is about to be
retired. From now on please use op-tee@lists.trustedfirmware.org
instead.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..772448e36203 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12691,13 +12691,13 @@ F:	arch/mips/boot/dts/ralink/omega2p.dts
 
 OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
-L:	tee-dev@lists.linaro.org
+L:	op-tee@lists.trustedfirmware.org
 S:	Maintained
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Sumit Garg <sumit.garg@linaro.org>
-L:	tee-dev@lists.linaro.org
+L:	op-tee@lists.trustedfirmware.org
 S:	Maintained
 F:	drivers/char/hw_random/optee-rng.c
 
@@ -16759,7 +16759,7 @@ F:	include/media/i2c/tw9910.h
 
 TEE SUBSYSTEM
 M:	Jens Wiklander <jens.wiklander@linaro.org>
-L:	tee-dev@lists.linaro.org
+L:	op-tee@lists.trustedfirmware.org
 S:	Maintained
 F:	Documentation/tee.txt
 F:	drivers/tee/
-- 
2.25.1

