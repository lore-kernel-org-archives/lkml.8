Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A89C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D972077D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4phUVgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFBSDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgFBSDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:03:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96BCC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:03:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k2so1800081pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l+gmiIhsqHKKeV2kb8RamFGYYWZ6op/LuStlHg2Dznk=;
        b=s4phUVgR+akrp7c/vYhslkZoojsDqIXIGRaVmfYcJ7VHWL8k7vsIvnmfUCezPItguV
         iwugRLWNaBv1F6cYo0op1aLA2J+ZPwuVe8PT1gyBw6L75Lxt9+IbLm2FgPoGroRcD1Tj
         kmpBmnkg+Av5XvHdQldRthLk6gWzwKGhpjLBvRUDpLW9bDO08drc71JgCGyYBk+C7X8A
         4sMmYC2StL7l4l+a8Wi0NWrIHjXALAfbh4jBYI1zogzP5Dk5RIZ66faYX2+eX29+0EhX
         WVraLqHSl+DE4jmYvp32KiwSltqHAEFRQE5YafF465RShCf1i+9IVJGuELRKUAl+cBWp
         1UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l+gmiIhsqHKKeV2kb8RamFGYYWZ6op/LuStlHg2Dznk=;
        b=ClcWTmYahZx3NBOd8MPdEBo3v1cwqPgYnOiOgXrhcoGXIxAVepuygKQfVSXGfEr7nI
         2RHbBd3WqvwFfinzDwAtIqBV6NEEtG6Hf7ZmkC+1X6jOMP2ONDf4eV4WpEa3k1n4UEho
         W4yX2vzZbEr5Hp6ZLaDE/tI9rvbt4CG5tM8Qvt7qMIe0Neoi/L/7XVfXmT3SaFvs9ru9
         6dOgeovIJazGQPjp5EvXdLN4z2MGTAdHzceb0gh86NWr9hJhUh5IrqJUy8G2wL7lE3NM
         c8SnFSoMLwXNTqfA1C3wTe34aXOdF2qZaCQ4I7Nxl/fevMpbkjHjzuPBBBf7CmiHmesG
         KlsQ==
X-Gm-Message-State: AOAM5300buYd7J757r+kz/itx8oIs0D5yOzf5dLMOigOCB1wv943cmyR
        DnNq7gftiW3ZcoaidgfZTxg=
X-Google-Smtp-Source: ABdhPJxfnuS03XcLCUV6KI/FK8sIlZ0kgrEyY9P6ubaAQiCko/R2Xtexh1etML9+59WmTbwZ64/Gaw==
X-Received: by 2002:a17:90b:234c:: with SMTP id ms12mr442497pjb.164.1591120991190;
        Tue, 02 Jun 2020 11:03:11 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id p8sm2740053pgs.29.2020.06.02.11.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:03:10 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 6/6] arm64: enable time namespace support
Date:   Tue,  2 Jun 2020 11:02:59 -0700
Message-Id: <20200602180259.76361-7-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200602180259.76361-1-avagin@gmail.com>
References: <20200602180259.76361-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_TIME_NS is dependes on GENERIC_VDSO_TIME_NS.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d513f461957..27d7e4ed1c93 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -111,6 +111,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_TIME_NS
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
-- 
2.24.1

