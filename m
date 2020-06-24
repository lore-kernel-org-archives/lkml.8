Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0657C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8E720823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwO+qzEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbgFXIdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390359AbgFXIdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:33:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B077C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p11so836702pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K6FaA8bFNUPkcRq6W3DV/IXdAKXv7nzg8Ufaeu178aM=;
        b=fwO+qzEyFZBMfHQ0gi2/vrxvXbXGY7tvAd7D/mKV64lasUBfBzBgTbVz/Vg0cA8oio
         fb9o48qdd10gTTEnlTheJx7cIA7iuM8Jgru4wR3WyLpDwocyd/1kx8cmpaSOF/HBSMhL
         cFB8H/ZzbakDCKBaiiAnvBurn9xHXuZUWffT5zVFRhEMOWQdgB3enMNdEZZNGePPjIbZ
         ddp0Ri4+r3S51K7Fz1ngVtVotiIaSO+46blkS7i5McpZXyhd7Q5IsNhQmUfZp9+qz3Be
         ovFmV+3up4jCJYxmI4kK/zB/XQDwtgs/FD5+S//+ONzR1VQQRmlWdMrkgqyaDyH1Jnor
         Rw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K6FaA8bFNUPkcRq6W3DV/IXdAKXv7nzg8Ufaeu178aM=;
        b=a16gbdBmw2ezwwKMoNVUWZpNNtrLoyRpCuMPGzVHj8Bwh2cuvP87LrOCrUEtOARdfz
         dP3PAfu3xoyOqjvn5iXRb0z8TGrDurSL0tSE2QiF91t01dN+7vq1cxi2fOUGkg2avBig
         rCBB97S9JIYHPImpgorJjNrCakAnlSeQNKsAW5GkCOa+sLwP25cIRS0IBdRRflYamR8q
         udgkA69q+TYLIq34K3OiQ2isMnio+aEQww3kx1H5KYCdkGOITqw/MDpjqF9vt3G3lkAC
         kaawacwv+FLIjHnNyY9OOJJHxzL63PScrvnTJufl/VmvaWgGXFHIINBdcu3lE63fUx3T
         rOKQ==
X-Gm-Message-State: AOAM532GO8yWDOOl/RGTDKD8PUY+ivNewRgZI14M2nNgC4tPrJ4xbD9T
        pF/wi5HgRquk2xfW5Nl9Prw=
X-Google-Smtp-Source: ABdhPJzLr88wWvbvRLXk7bWaQyyZvrof38iC5EuX3OHuXEHnZeiwpHbKEMtKRe7iWf5xgZOiAPSrvA==
X-Received: by 2002:a63:a119:: with SMTP id b25mr20280014pgf.10.1592987609797;
        Wed, 24 Jun 2020 01:33:29 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id g17sm4558614pju.11.2020.06.24.01.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:33:29 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 6/6] arm64: enable time namespace support
Date:   Wed, 24 Jun 2020 01:33:21 -0700
Message-Id: <20200624083321.144975-7-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200624083321.144975-1-avagin@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_TIME_NS is dependes on GENERIC_VDSO_TIME_NS.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4a094bedcb2..38d3180adf78 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -118,6 +118,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_TIME_NS
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
-- 
2.24.1

