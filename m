Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC948C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16842074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvnIEHlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgFPH4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgFPH4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:56:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBF4C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:56:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d8so8019384plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nMU0QpWstwt4mPNSQHpH9spCG7iWFS4Lj2/e7Jbs4Y8=;
        b=kvnIEHlYsYhqIQvEykdlOvGT5aFbVPQ0I5NSmr0OO2ZOpjGbjlD36ksZRVkRxfowl9
         vgkH+aovCyNbmpHJcp3be1kpq9U1Nv3Bad7lLecV29/XunIvflIvYslGhmKAjiJOCBRm
         C3bDW7XceDDovvrB/IiUWpKSzdzSpXuxP+unqJWwgQqkxjfKzJn330cfoAWgdMf4OaiJ
         458bRdJeljnBWXvbodsbPhT2j1R8ZcUzFhv09FLb6JMqfIzAjlzgWoHZOmZiFdyJCiG/
         8qT6PuT7ruWMKRCrJ74s9thXxHq2OxvN48cQKvrXqkOUypNbwRPGRbIMOsQrESEK2fGJ
         ZIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nMU0QpWstwt4mPNSQHpH9spCG7iWFS4Lj2/e7Jbs4Y8=;
        b=iQ5lIy+ltl6wjIyFkMQqo7mBurqAS9MuGZMZtmcRZro8mXfundMZ0hpv2yJYZcRfZC
         Qfkd77AJqYWylHt7Ctx3cih145oifB+B/4sAYqUpU2lzuGVvrnf5J6nn2l1FP43MY9Y+
         8rGG64Z9TVFyseLzN/qrwY/HCogPB2NGIFeh4+fwD5OVpMupb8Xe9EQPV9GiraJHpUAH
         C3vvW9ghulxTc7Sz0CowPQlbWewMoF4cnRwiCUCn1G6b+jG3t5PrE7/gUM5VJWUZckwi
         I8crHfHDFvvXy3/cFlIbaT7wTxbEAGy48GfGwCnLkCJliq3iK61/dBorbPtHOtULAkyC
         1LoA==
X-Gm-Message-State: AOAM532XGQLNTAwmT+SJCsK5OFYediSrUGryM2LDwW8mMpzDy+uf2TnW
        EfhK39KzDqMwkVxhdNzZ8cE=
X-Google-Smtp-Source: ABdhPJx9ESgFJYgJixb9EpAL0K0/DKoBFxAGTlq4+BbivpEmofTqN4UTPSDg8vPFiadrqeTQricL4g==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr1108812plr.154.1592294162652;
        Tue, 16 Jun 2020 00:56:02 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id g6sm16168984pfb.164.2020.06.16.00.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:56:02 -0700 (PDT)
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
Date:   Tue, 16 Jun 2020 00:55:45 -0700
Message-Id: <20200616075545.312684-7-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200616075545.312684-1-avagin@gmail.com>
References: <20200616075545.312684-1-avagin@gmail.com>
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
index 31380da53689..e3956cbfd8a9 100644
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

