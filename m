Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F76EC4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610E120838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO2Epfel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBZW44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:56:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45290 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZW4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:56:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so520202pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 14:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3yZOynVtZ9TuFM5blbmeqKauEd+nanPA/x/dYgy4NIw=;
        b=EO2EpfelDxj6yFbd8r60aewPznC0Fq5Ufv3i4qGw0pwwm0k+nYDFr1GL75urBMM4zu
         J0glJhC2Q6cA+mP08iaXFmOVhjCtBgHAWJeXAUA1VIteADNtXsBwcxlgXJ6Y50RnmGy1
         Cv96E4Ml5Smil/1H8gpLYax0smDbD4PCiDMghVSARalpTBGQYTGYI6zkl1BrIuR5NRf0
         rr/hVF0y4Z02yFnx46YZdMQDVpxG9Yo626h46S6yBOfDcIGmg71Zk1W4P8Wz1awOIB+F
         3rngUHAhWU6mhsBugqQofpOFUWUm8dqLNK0nvKHcDHDC7zK1PmEi4ENkrbHtuxoKCIDm
         PLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3yZOynVtZ9TuFM5blbmeqKauEd+nanPA/x/dYgy4NIw=;
        b=G+o4w75nFISqop6/UElZvlnYAt56i2O0bn4xXXDu4bETR/dUP7oKnzbe0vbCfEO324
         FUwTQu4yHPpMuj4DqYw05P4UOpjxt6ZDVRAfSD1jPxvz9hTJwNaK2L3/c1hs8BZN0jBy
         esWE93M1wFYp85RKuXhNzDoyCCg4rg0w7ZV1UpJJcWQrg+vh6o0CUFaAtnOJc7NlcT3C
         vNr27zM63dlmiH/MHPqb3GlgOwdFojfvNo1GiLp/J88HLOkoD6Ge67fawOJnHcHvPF4y
         EcQOXMqY5PxJklWHP6sEW56x9lei6aQ9neWVVxGS3SbGh0zzG8zstfsCVlE1FM6lHDI4
         SFZA==
X-Gm-Message-State: APjAAAWTOjbD2zRbxyWxjDg/dwztaBs1BRVUbIbRni2BekFXm+FRJnog
        21p/9WMlhz8kzHIKI+UfSKwUzirm
X-Google-Smtp-Source: APXvYqwzNIhc6hsdjebEOPJY36PCd53sBWg1xV74dKzmQPjY6Uj4+MZs24N6QMWE1/TPcfml608Otg==
X-Received: by 2002:a63:e74f:: with SMTP id j15mr1077288pgk.20.1582757813368;
        Wed, 26 Feb 2020 14:56:53 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id g13sm3718187pgh.82.2020.02.26.14.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:56:52 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/3] openrisc: Enable the clone3 syscall
Date:   Thu, 27 Feb 2020 07:56:24 +0900
Message-Id: <20200226225625.28935-3-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200226225625.28935-1-shorne@gmail.com>
References: <20200226225625.28935-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the clone3 syscall for OpenRISC.  We use the generic version.

This was tested with the clone3 test from selftests.  Note, for all
tests to pass it required enabling CONFIG_NAMESPACES which is not
enabled in the default kernel config.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index 566f8c4f8047..fae34c60fa88 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -24,6 +24,7 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
-- 
2.21.0

