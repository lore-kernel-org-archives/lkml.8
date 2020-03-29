Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BB9206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si8HYkNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgC2I3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 04:29:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37926 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgC2I3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 04:29:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so17159403wrv.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FRwX/aFxZlvWnvMFZBMtRNHnacz7wGK1fEqFa9dnLg=;
        b=si8HYkNCdieXsKQPaAV4yZfcSmVkWLAqOTdGyv/5qirMRewfJQg7GDzO8Hc6Cpj7ha
         uOjC+uvNq7OeIgq/F3gP7Nz3tDJ7CZKFl1nj7FnGbDzcsXpoHS1UCPs1+Tao38Fep9fs
         WtfSI99Q2CiPKCH5nWISvotQRKuavtu6g+H3Kg7usZokS0SX3EAxY/eQeUqdjObm7PEb
         ldsi8rYYAnOx2qzebyiPscH2LmCEbg+6LHBw99PnctIx74ZiXoJGI3gr2ApNe+lyZjiV
         SmPHNmK+akbMR1HYeywf3U/d7VCzR+sfm5+2Kn8X2t7MnfYm7xgd3uJSeoMSvAeVn+QB
         k2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FRwX/aFxZlvWnvMFZBMtRNHnacz7wGK1fEqFa9dnLg=;
        b=rOlvoUrAaXY2F5y4QEVG0BT/digrn9wWEDCtJ5oOLuiyPdeIoBcE8Xskq/34mPUsYf
         70X8PaMt7kRkjdqCq6B8BwshpgqnJCzr7bBSPVj4FBkaE7TMI2XbFXdLEqrwBUakUynX
         BIwWVS0p9MlAvxT33X+lwZ1oDMfkpNQuZcGsvdflXZXb6jnKB4nXdxF5n1IdateoeiML
         Qa2INinBVzS3G4BO1QHDNuGq5J2b43QLaRnJGVcug3/veVAwsdq9CxNI+oMMLsdPRzEm
         cccoPvipREy5ascY0tFALiR59BWirliF+bD5ymljoXG/Fo5PufvQaoQkhcJ0HITjamW7
         AP5g==
X-Gm-Message-State: ANhLgQ1cZzDFB5xtQEH5JOYm9d/x9C8CxveG9Yb+fGXsMA59XVUkgHTy
        Opnl1lhEQTDcIs/wpIVUR9o=
X-Google-Smtp-Source: ADFU+vvGeH+ECebYBa/AcTF+iEbEb/xzr54Oy8IvgSIxjXwlKqA7hX5puAv8Ob0E6zzLSIYS3ygtqw==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr9195579wrs.182.1585470578255;
        Sun, 29 Mar 2020 01:29:38 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.39.37])
        by smtp.gmail.com with ESMTPSA id y80sm16551368wmc.45.2020.03.29.01.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 01:29:37 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] random: Drop ARCH limitations for CONFIG_RANDOM_TRUST_CPU
Date:   Sun, 29 Mar 2020 10:29:09 +0200
Message-Id: <20200329082909.193910-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option itself looks attractive for the embedded devices which often
have HWRNG but less entropy from user-input. And these devices are often
ARM/ARM64 or MIPS. The reason to limit it to X86/S390/PPC is not obvious.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/char/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 26956c006987..abc874722251 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -539,7 +539,6 @@ endmenu
 
 config RANDOM_TRUST_CPU
 	bool "Trust the CPU manufacturer to initialize Linux's CRNG"
-	depends on X86 || S390 || PPC
 	default n
 	help
 	Assume that CPU manufacturer (e.g., Intel or AMD for RDSEED or
-- 
2.25.1

