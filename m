Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4657DC35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA0021744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx4GbuvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgBYHhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:37:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44435 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbgBYHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:37:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id a14so6065835pgb.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uVjpVCpfuu6u9amKnD4CalKwNS7GepUbqRwEuTYWuWo=;
        b=lx4GbuvYcRQjywh8EGZg3jQu30Cb/EuoaBgo5dSiBHWhUH8B6aEpiGP0b3oAoPAvf7
         2nT8fUJvf9KyOMiaVcYdBiLulqtfsog2SPe0Yv6nRWLqwpjhmINC3dzTxBc4c82OdFgg
         M5t6Yc3RdK3h3B1QIXBHTml5dG+5pIz8M8ysMLJMVIzfU9LaTwqbDtfu1IfYz93sFqNA
         Ds4lhE3GPdLBoii7W65iNEqxYFzs6tLAgdKYeTfm1k2p/T/ljtliKzAwzcSNgqFMYKMu
         6QT+LPZxcbYtrdbyLpg39NooaXEDDzKcOqv0qG+hmftmZPyw0cWIpu0P5CBK0Du5lrrC
         ykxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uVjpVCpfuu6u9amKnD4CalKwNS7GepUbqRwEuTYWuWo=;
        b=k4ImkOtYDpPVXUEOnS31b9w5AQ9KO+BbflzRaHsxWr9K9z4T6YnwGpSsoblzSBQ1PS
         flkp5mG4tP5qfVZRT3pl4ClJtyhV1C9qrqG5tBEVVg3TNN3eiqujIMD8pPfo2l2S7H6h
         LIC542EMvtlHv9KPTUJpWQwIHI+YTKX/2s/gHBr61oNEm0ms2Ur2bFYFmzSJYW4XyWzL
         JvLz/tTS/2moDXyYQq3522nkHBjgosyiLK4VukDMef+Q48nFg3Y4crbn1eOKzOYmnwt3
         kpEj7xFN85IRtwNqqFLNESZy+JMAsqGWodgueDQU6VwJkrw2aArqmV8oWGi81bMfii7R
         uu4A==
X-Gm-Message-State: APjAAAWxAIFTcX9TU2GSEo480pI1u6MSLMhlsDywYDe+4piCPM0y5ZIX
        KP5mFctN/EDTQoyyPkrqrDVWjw4L
X-Google-Smtp-Source: APXvYqzyhGlNtKBclYq/XwC7fr72ijj3ORk/duS7q2SyU+JRS6ZWSmS2Cg4WORnlDUArTv1T7imXhA==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr28708916pgi.33.1582616266674;
        Mon, 24 Feb 2020 23:37:46 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id m128sm15979390pfm.183.2020.02.24.23.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:37:46 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH v2 6/6] arm64: enable time namespace support
Date:   Mon, 24 Feb 2020 23:37:31 -0800
Message-Id: <20200225073731.465270-7-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200225073731.465270-1-avagin@gmail.com>
References: <20200225073731.465270-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_TIME_NS is dependes on GENERIC_VDSO_TIME_NS.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c6c32fb7f546..660ad0b0e6bb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,6 +110,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_TIME_NS
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
-- 
2.24.1

