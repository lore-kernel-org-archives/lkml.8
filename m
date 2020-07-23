Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55602C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A63720792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8C+nOYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgGWRLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgGWRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:11:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7053C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:11:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so5648933wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRu4Sfc0eKZYW4NAF5JKMWkFO9pZEFzvYAjt+8O4OdM=;
        b=s8C+nOYWU7I7nGZXx8Z/dZlzwyT+jhO+JX+BdOh8tg2SYZHrjqRFKGNNKMPw/IblAt
         NCLYh9WJOZXBhZLylMt0p24mCocEx61ApvBc9W5kvy7HhRrEAw5Ch22hh388axo86RVU
         pfNffctSMRPYJAF14211y7byWuQME9kiloyPxnnaMbSk+lGGl+9S8GSw27udAW6Hj/3M
         7Pd/pXSdHF6hT+3PGBUs9vVmOXN+9evl6NC3wc+HQ81Xlb3jiwwa309BwrX2FipyAdyU
         1s/tEunpyYFK1mcaCmxmoboDDYDt91yfcyNbVMDH+FJSd01CYI7ycraIBrMCsSHMQbNr
         sx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRu4Sfc0eKZYW4NAF5JKMWkFO9pZEFzvYAjt+8O4OdM=;
        b=slEVyqI9KM3BzYK3CHqyO90RcPrwwwFDCR6Dz/N+W52pM97xKwJwYpv6u9lminxqmO
         DctaP+bvFijxR8kxbH91K+LZ+JAGBOQX/Zdj0QeBCPAf9bPjz2ltkeYLeFtgtrsOFff+
         Ssl9Is6glsIbY16wlk9QsWJa4yWMKGQXkOY/PCEvwHKy9qPJbmjQqiOq3vcECy2jSynW
         DdPgCv88x3IsLVhqduLDr09v0X7aEn7swzJSkGsJAJ4g1wYcob5HIvUcq83wfc1lACHV
         KxX8tbsblsuMNfaLzWDJ3qSwCGQdUbBDHelk1OS0L0kKZUZZbUvJWdYfRD47ZWj/d9ZY
         7YtA==
X-Gm-Message-State: AOAM530oXJdK5X5TZkH4lRLExoOeezBAXjgaDZD0NSjCacTspMO3GL/g
        UF9i4Ebvqql/O3lZBQ8uqQk=
X-Google-Smtp-Source: ABdhPJznVykFzHvMrcs+vyZnf696+XUa8DaMAE6Roh4+S72hPgE9Uw5si8wh0cEApyTJ0JqmIVERNQ==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr5372662wml.155.1595524289453;
        Thu, 23 Jul 2020 10:11:29 -0700 (PDT)
Received: from localhost.localdomain ([46.114.110.108])
        by smtp.gmail.com with ESMTPSA id w12sm4705502wrm.79.2020.07.23.10.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:11:28 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2] x86/configs: Remove CONFIG_CRYPTO_AES_586 from i386_defconfig
Date:   Thu, 23 Jul 2020 19:11:14 +0200
Message-Id: <20200723171119.9881-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.28.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially CONFIG_CRYPTO_AES_586=y was added to i386_defconfig file
with commit c1b362e3b4d3 ("x86: update defconfigs").

The code and Kconfig for CONFIG_CRYPTO_AES_586 was removed in:

commit 1d2c3279311e4f03fcf164e1366f2fda9f4bfccf
("crypto: x86/aes - drop scalar assembler implementations")

Remove the Kconfig relict from i386_defconfig file.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
Changes v1 -> v2:
- Add CC to Ard and Herbert (see commit 1d2c3279311e)

 arch/x86/configs/i386_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 550904591e94..3a2a89882350 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -290,7 +290,6 @@ CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
-CONFIG_CRYPTO_AES_586=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_EFI_STUB=y
 CONFIG_ACPI_BGRT=y
-- 
2.28.0.rc2

