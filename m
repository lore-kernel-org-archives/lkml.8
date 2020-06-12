Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E3CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C598B206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViukwVvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgFLKSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFLKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:18:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71EC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:18:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so4090298pfx.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrqb7rFrPm71zufQQQJM2Qw+hcWl7jQI7PiyTPO3UHw=;
        b=ViukwVvkgr00MbjToEOcrPK4Woyhmram6FnQaogQzeqmiRUQnsvSwjkQRER59XdQe/
         sZFvgy0xWtF795/qKsCne3X6r8cGBk3KMvVwtpflZ4+r8zCBUmF4JQqhyMFJl8wruKBN
         8WZaJq/f+CBFIH4wWLIuBMc5TUZ14cDxear1YqCHwL4vzl4ZYBfExmzNZQ+WpHpbyh3Q
         knQgqzzBlo7JQICJpkbJyQkGz6kVulHYq8TfVbRcaVKd07gvUqetQddUc0SVo0mfk3kt
         t7r1hQLAZMVbeKDNOiZyVbmG0ovJnLuxYY4PVA/DamoL5LrvBVE0tijvhdVeNFiDBN/1
         Q+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrqb7rFrPm71zufQQQJM2Qw+hcWl7jQI7PiyTPO3UHw=;
        b=ZHjVh3JJ1ueifUTld0NghSVHe6qlqDucSlJXb4lPA6wNJLNkM7fCfaD4Do66HhpGdW
         zXIF9lKM7n5WFvdOVPiRIX/bpoXT9P4I9rQsOQpoUFuLBY1ysIRfIp0RhfeahtbyeOc7
         QQ9OX3G8YISKyRWensuxtzoDDbLBqUcJ16LZa8fu8elGKmV6wMhDXSQTEssX0/ZXZjwu
         sThGHyteYa1+mbBumyscQvwrkNh9DGOw8/L6AsUff1ZL8dPfv9EqPcEpMvEOliBH2BaF
         fkvrHv5Fl3tvUSBxxwlH/c0XUvbpZduD4z0ccqnV6RErVwILZm4iYNNeN9i+BfefAaAw
         kTMQ==
X-Gm-Message-State: AOAM533DGKOE/C3BEzfzIL8uO4yWmmm00eVhsLhMz84D3VGAMngv8ccX
        pHLUUaTMaTZdWlJr+sM/FDE=
X-Google-Smtp-Source: ABdhPJwVWZa81QyZtpAyosO7H+mBqn21lO1GU02lU/SfiVDeiGLvuMOQXAEavq3IzBRp17NqlqMJAg==
X-Received: by 2002:a05:6a00:15c7:: with SMTP id o7mr10779006pfu.51.1591957126712;
        Fri, 12 Jun 2020 03:18:46 -0700 (PDT)
Received: from localhost ([49.205.222.116])
        by smtp.gmail.com with ESMTPSA id n2sm6039429pfd.125.2020.06.12.03.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 03:18:45 -0700 (PDT)
Date:   Fri, 12 Jun 2020 15:48:44 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 3/3] ARM: provide CONFIG_VMSPLIT_4G_DEV for development
Message-ID: <333fdfb5080726988b1223a5fbe8ebcc4d6ec3e0.1591885760.git.afzal.mohd.ma@gmail.com>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select UACCESS_GUP_KMAP_MEMCPY initially.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c77c93c485a08..ae2687679d7c8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1326,6 +1326,15 @@ config PAGE_OFFSET
 	default 0xB0000000 if VMSPLIT_3G_OPT
 	default 0xC0000000
 
+config VMSPLIT_4G_DEV
+	bool "Experimental changes for 4G/4G user/kernel split"
+	depends on ARM_LPAE
+	select UACCESS_GUP_KMAP_MEMCPY
+	help
+	  Experimental changes during 4G/4G user/kernel split development.
+	  Existing vmsplit config option is used, once development is done,
+	  this would be put as a new choice & _DEV suffix removed.
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
-- 
2.26.2

