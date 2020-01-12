Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72819C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390BC2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaPlFfdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbgALR2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:28:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38245 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgALR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:28:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so3718278pfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 09:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mWAcq9bb+JndPzUhrr5Pb2HRZwmhGDpzE1gJ4Awh0iE=;
        b=VaPlFfdOq+DlRixUbvY7uOaKV8x9tGYxMk/mMIztPXQ90iS7bPhb2v8tDfQ1G8ONNE
         EVCuFCVVFxt3Ic6pf6M+20qRjGABhGbYQDOSNKApv4NWmyc9Beb6njFrMqb0Bvv8fN1E
         lSYrIMWksLS9w8Bqb0JECSgxyuE8nL+DujYGRZ3pWPR77ZdTBFmAI1+yNKg960Ad6E7P
         +WZzexY1l34yY7/VuU1OUXaxh01vY15l+N5P1J+shALFh/kjVsOSzkUYffhAjnWPIBX1
         V6XdTGoL87JnCf+haztWChVF9/PwNVgEXSJGU6cp3q+XE5O+GY177IHscpCGy7E5+/LP
         gy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mWAcq9bb+JndPzUhrr5Pb2HRZwmhGDpzE1gJ4Awh0iE=;
        b=S6ryfBbSzFMKF+FUMB40j6khzDdNHdltiFpEueuoSPur3BKYn6gtHWkPZH8Az4Dp3l
         b7Lv8Yd4XcD9yBVoPseAcGlQf3phzSjLIVY4F0ACj+5Qu/NHxETca8aK27fFgOl/cPpy
         CMdNxrAUx6Cz+2DsMW2ZhfKOxgQjvB1xi2ZJgRhYlXWVnvXMh5AgkCXseNuIKE6s94v2
         qBqodXgYtnu8qlmPw1nmxIvn4pppZdpnR3n55KrYwC15iC76/IkR+OuaoKqc+bfTgnRh
         lGBZ2wyrLV6rTGpk8nvsKcBhZfeBi2wnQWRbe15cgn+5aAXuydOw81TbYAJY1lquUGz2
         1GwQ==
X-Gm-Message-State: APjAAAXSgYehqrSllvx7YcH561yI7mTekW4VALNFRZZjXHRbejOhPflt
        NvSc4rc9k1h3lxl0+TplpkE=
X-Google-Smtp-Source: APXvYqzqWp3rd2E4Gh5ieMTKf/wQ6uq1DjhlX73ZEhRTeq9FbLjUfguGvxj3jMgwUU37ZVdRyuGCUg==
X-Received: by 2002:a63:a555:: with SMTP id r21mr16539281pgu.158.1578850111207;
        Sun, 12 Jan 2020 09:28:31 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id w187sm11114777pfw.62.2020.01.12.09.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jan 2020 09:28:30 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     kishon@ti.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        p.zabel@pengutronix.de, yamada.masahiro@socionext.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] phy: stm32: fix using plain integer as NULL pointer in stm32_usbphyc_probe
Date:   Sun, 12 Jan 2020 17:28:28 +0000
Message-Id: <20200112172828.23252-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter of devm_reset_control_get should be a pointer, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 56bdea4b0bd9..8cf24c330f5e 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -340,7 +340,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	usbphyc->rst = devm_reset_control_get(dev, 0);
+	usbphyc->rst = devm_reset_control_get(dev, NULL);
 	if (!IS_ERR(usbphyc->rst)) {
 		reset_control_assert(usbphyc->rst);
 		udelay(2);
-- 
2.17.1

