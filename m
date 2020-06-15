Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B49C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923572068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh8ZUSh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgFOJJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbgFOJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:09:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B752CC061A0E;
        Mon, 15 Jun 2020 02:09:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y20so14006325wmi.2;
        Mon, 15 Jun 2020 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnGbf5grf0IkRGVHz6T6Je/lqrthZMXPB4yMEA/nohU=;
        b=Eh8ZUSh5wrn9ZW4a7Ao9x1tY3fRR/5c0ilkslt79XE8NFFHpQm8QvWeU5rFr2aYp1E
         tEej/CjmTV83cI49kr5d7hr7EJwG36KsyEOmftDFG0dpSZvO5oOsMv1V2Am6ZeoqB7V6
         eCDXv9BIroOC6si3ck1daFL8VW3igDakwwbQcmVXT/HqHDmnwm9DpurEjBg/y4kBsBO+
         GSnypJEESzOJvEnezdhlKZ3Uh7EQgRMKILVv2xGSmWO7+9LvRvpVViVTPgmZu396fXPk
         TJAjAdTqdzpllqpuLyhP0E3a/0EPvmXjY5cC4wslASEZIvhmB3wRWvdVhWpvPeez7id2
         5vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnGbf5grf0IkRGVHz6T6Je/lqrthZMXPB4yMEA/nohU=;
        b=R9WlpTbClRsuQTxEkuMaZanOXVwtWHEpIQBL8yuhzhm2+V7U8iLk5omO4OikInL2Tg
         8SqoZKZ/rudPM8tzwVfQ4+sBRBB03ARTg6B8EN2aw3G5ynbZj5tqy1w5f66c4YakqQuR
         5lbPU+Tv+txe4Ef3jkXtWTtyhH6wjUVFcjOstY3dDW96K0BkGsQ+37syENvNr3EQJGx6
         4vC5y6vo4hMrz+cI8ykACd5GuW7jEeI6fu2mCLnjlvfpAF0jGzXHNQlsj14Td2CtDMY7
         CwdqjATXWcZES7F+SeYnqZ7RtrAoYKXczEmxn7KoBFFYhtCTP7WAj7MJYwsH1+aP6Ckw
         v2Eg==
X-Gm-Message-State: AOAM530JC+SHQJs6lAczdnxio8LJLmf+RuFNvalWIHwW9ABkgk6Dn9Jr
        f1ovn79ctGePxziPC17iI3Y=
X-Google-Smtp-Source: ABdhPJzfERI69ORfwOl4kiXFJAzXSSL2kMnLwByHcC0R8ycGyZA/K2B7Xgr6QOiZjOxn4jcAjIoU8w==
X-Received: by 2002:a7b:c393:: with SMTP id s19mr12026304wmj.92.1592212189426;
        Mon, 15 Jun 2020 02:09:49 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id z7sm23109370wrt.6.2020.06.15.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:09:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 4/4] spi: bcm63xx-hsspi: allow building for BMIPS
Date:   Mon, 15 Jun 2020 11:09:43 +0200
Message-Id: <20200615090943.2936839-5-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615090943.2936839-1-noltari@gmail.com>
References: <20200615080309.2897694-1-noltari@gmail.com>
 <20200615090943.2936839-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcm63xx-hsspi controller is present on several BMIPS SoCs (BCM6318, BCM6328,
BCM6362 and BCM63268).

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: no changes

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a9896e388355..500774fe1351 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -155,7 +155,7 @@ config SPI_BCM63XX
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
-	depends on BCM63XX || ARCH_BCM_63XX || COMPILE_TEST
+	depends on BCM63XX || BMIPS_GENERIC || ARCH_BCM_63XX || COMPILE_TEST
 	help
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCM63XX SoCs.
-- 
2.27.0

