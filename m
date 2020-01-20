Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DAFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB95217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrOLIgKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgATOoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:44:03 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50612 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgATOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:44:03 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so6864919pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 06:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Gk+XnTJkS82tNYdQHdvBk1UC3MkIoHkULCXBVdOn/98=;
        b=YrOLIgKH7aFn8lDGP/EY6YnW9V6SUULS/WGIwhS6gE5Vm10r/q5IYDt7OUbHG4888U
         Vq5zvJu9FXgvS5fGIVM7odYfzTgipSU5BifQa25quydewc2OYs3VeRgGN2n7yF6F/is+
         gsRc0gntvpZBZifQgjyJwcXyZrc72HxJdRxlPZgdya4gNXMlbeMKBC2fAbZ73FOo1fe4
         I08tUix64bedwljZfRHayujDeBM3J7R4ZgfCqaKPiu9byjvfcUbHVqBCJnqY8MSeBzps
         FkpNCqZ5ozXb9Mnw+zhMX7FfUfCjHhi9bDkvEGr36aUKm3SkZRxIPFFMLsVGBr8egD15
         1L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gk+XnTJkS82tNYdQHdvBk1UC3MkIoHkULCXBVdOn/98=;
        b=ncMYq041YylHOGaYKyVNzQ0dtWcg2DWzKUhrous+P3o8LhngwOUtj9Oe8sF8rTq9nr
         0l3HIZnKDTTD7MRsx6GveGMmM0xz+hyTydxOugDhU3Xvi98VmCKwxkDNN8+rkEvX4RVb
         Evfxr0asxa+t1ZXBoAVhTNS4GPZPLJHBRwoQGrl+kLnw1M8YCmMbrOTWMvW3g4xBMSDz
         YPvCOtCMbOmPQRk8I2B18uTzmxOKaFDeVItOPTvy7FQTVAtQ+EMMvhdR+Ly/1n7iXoqC
         JzkkU9GPwAZzQ9kuzD3FI9B8f8Z11mNcNJqim6RqyzLnVo7CXyqUkZr7Vis7edr8gZad
         1bdA==
X-Gm-Message-State: APjAAAUUnz5M5FYaEizYfkXbG/IccYIDYWMx2cOAlLcz4Hnx+Du77M2o
        pGz1VPaqJlm1bE12MW8bDw8=
X-Google-Smtp-Source: APXvYqwn9xPQBXqWtFBVQ2U19m5cD4nwj01Adw9EZj+vufMWeamCIUNCFxC5MCJn2KVbzC7axX/YjA==
X-Received: by 2002:a17:902:fe17:: with SMTP id g23mr5567plj.42.1579531442917;
        Mon, 20 Jan 2020 06:44:02 -0800 (PST)
Received: from ubuntu.localdomain ([218.189.25.100])
        by smtp.gmail.com with ESMTPSA id c18sm39517820pfr.40.2020.01.20.06.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:44:02 -0800 (PST)
From:   wangwenhu <wenhu.pku@gmail.com>
To:     Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, wenhu.wang@vivo.com
Subject: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM configurable
Date:   Mon, 20 Jan 2020 06:43:27 -0800
Message-Id: <20200120144327.20800-1-wenhu.pku@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangwenhu <wenhu.wang@vivo.com>

When generating .config file with menuconfig on Freescale BOOKE
SOC, FSL_85XX_CACHE_SRAM is not configurable for the lack of
description in the Kconfig field, which makes it impossible
to support L2Cache-Sram driver. Add a description to make it
configurable.

Signed-off-by: wangwenhu <wenhu.wang@vivo.com>
---
 arch/powerpc/platforms/85xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index fa3d29dcb57e..ee5ba10b98cb 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -17,7 +17,7 @@ if FSL_SOC_BOOKE
 if PPC32

 config FSL_85XX_CACHE_SRAM
-   bool
+   bool "Freescale Cache-Sram"
    select PPC_LIB_RHEAP
    help
      When selected, this option enables cache-sram support
--
2.23.0

