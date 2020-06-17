Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDD0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE2520C09
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXmEltU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgFQIck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFQIci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:32:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66464C06174E;
        Wed, 17 Jun 2020 01:32:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so1361136wru.6;
        Wed, 17 Jun 2020 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AS853kMz2fYyTa2uBOf+cRLpX9fTWk/d4IPoxmHBIJE=;
        b=EXmEltU/uQPntxMqBH7DmDFhTjSV/D9Diyn3jB5mmkka2v/P/dRM5rUIJoVIBGMMVP
         SD0g9CT/3mkS3ac8l03Uyt4emgCFxHhiRxmLRh2GjHHkJaF+CDPScEtpC3xl5O3JUP9I
         0+WZmsuj/XIo4i3JQ74IKNPVGG+2h7hIC1QfenVsLuvaXh1bOg4VmbFJbpdkhI/oDyP2
         eZmTStDzI681VFWEig2+njHWPoFcQmkiHwwFQ1lln0PeqKdSR9xIwUIGk5RZUSSTkqS9
         cvKCrJm7Rcfvaz8R1tqpgnqwYE0J6WOt0EWXRaqKVn7cBzYig2xMy5CbOVE0854ZC2eL
         SX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AS853kMz2fYyTa2uBOf+cRLpX9fTWk/d4IPoxmHBIJE=;
        b=ZK9l8cPhiURPNIGgvykOoekoNrJcgUAB9FbM4pkN6d7/SqHuDfYj2mRhsVa9pwfmZJ
         qB4iO8IMkgS8auTJuWYawuPQmyyQkV/tky/ibWl+dLEUhu7oHmT6BYongWEpOjS4Kytw
         ClnuBUbBlxrmnReA4CBcmMLrr+DVnPZeyqgfUKFKYwr4of1zkfZ6e3DdbluCLAsjlopY
         70LommhzmodERvkV0fAkXlgsYki+ZsyWYdNUITfmTLxd0r/IAqbRsZgUrWMQ4rorDQ9U
         xBhAMdFEKGdRrhPxsWCeU4F3Ln1p84XZ6vkyUX7Goqwr8UPyFsBsj3toi1ZqIMZE1qZg
         z+3Q==
X-Gm-Message-State: AOAM532nCpjW7uDQWeaUewIWOLGH2oSSoGEvLg/KaGmo3xTiy7TSpThL
        lR1Uatunwa2ZL0eNGlqFyI8=
X-Google-Smtp-Source: ABdhPJy0NnJreLQlU1ZL8Bxqgbdf7TsF6G/FIMNxmgC6mc0xYbKd66+BcIYamswZ8WQeSZUwz+ZlJA==
X-Received: by 2002:adf:f507:: with SMTP id q7mr7139549wro.353.1592382757101;
        Wed, 17 Jun 2020 01:32:37 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id a16sm32596863wrx.8.2020.06.17.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 01:32:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v6 1/9] mips: bmips: select ARCH_HAS_RESET_CONTROLLER
Date:   Wed, 17 Jun 2020 10:32:23 +0200
Message-Id: <20200617083231.3699090-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617083231.3699090-1-noltari@gmail.com>
References: <20200617083231.3699090-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to add reset controllers support.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v6: no changes
 v5: no changes
 v4: no changes
 v3: no changes
 v2: no changes

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6fee1a133e9d..b1840119cb64 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -227,6 +227,7 @@ config ATH79
 
 config BMIPS_GENERIC
 	bool "Broadcom Generic BMIPS kernel"
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 	select ARCH_HAS_PHYS_TO_DMA
 	select BOOT_RAW
-- 
2.27.0

