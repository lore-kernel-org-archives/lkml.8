Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52604C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269C52076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm8dATNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgFAXG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFAXGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:06:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573C7C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 16:06:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f21so4160163pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksDb9WvMZ1M3ofOtFLzn4jr3f4hC59VYfNza1WsvRoE=;
        b=qm8dATNKOPlcESfgAAvsnKiWz1RNC4W36kcNYRoFZ8otgjEc1n/cXcgKNrZSx0Pcs2
         4WtDXyP3Ktbsa90g0PYgnVk4nRHJqGbejcat0TQsz96DMfWLm+eyucyC5uu8TPQcRGH/
         PsaXKpz/+4Hduu39mQ12jTewPa/9p+y07kkfSdSa6swz0OWHSWYMb0Xyt7kMDu7+Unrn
         bZbnKgQ5zUkUSH3uD/9BxLZsU2Ycbv4IUal/HKogIYYN3UMWvt3XhZNmrRPY2fDnjf2K
         z+MVt6Y7ktSwKoF/A8XkeOBFyor6GWGvHNdBYeT8Z+CaL2BwxocnCDnaZPN6NHIEJ1Jx
         rVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksDb9WvMZ1M3ofOtFLzn4jr3f4hC59VYfNza1WsvRoE=;
        b=VF2yA432Hesx+ulqPXU5NjZNenBglcCwb8b9+VkkCYaa5DoWGpdwmZ6JCHskcl9sY+
         g+lWWBIre/kgJr8dl95WodvVCxY9395m9Xn6y4tNP+O/29sjlEjljqq1mC473xB2C/HI
         VBKodDbdcxC2J7pWG7VWOljgJy6H2jY7nuLqSugdPgcNNLGJvmGIiBWe8dzNYi1PWedo
         Zm/mN70MHTsLcS6YdP/+/P6E/wNM5GjOXB3mmmA37150C+PbdwhwJfFgs7i/SUcPAWj7
         4L1P7NSUl9GDOs4c24MDjkhzWhGRWFcC2Vxl+eQ5rIgngr1YJrNZoo3G9Am4vRRq8NUX
         nARw==
X-Gm-Message-State: AOAM532u+SiTHeS3B1ddIxZ+0XLTHyTp/PRWFeAsYrAaNOIfPNbec9xq
        xc4Nak4rVUbop1Ech8XxZ8g=
X-Google-Smtp-Source: ABdhPJyzSSRl8CDEGtel/I/WxxiOtih3epDRjNMht9hndzr/8CLd28xq2DFFdyzMcc1KPkG74ihiLg==
X-Received: by 2002:a63:1323:: with SMTP id i35mr21649156pgl.311.1591052784607;
        Mon, 01 Jun 2020 16:06:24 -0700 (PDT)
Received: from squirtle.lan (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id q201sm394891pfq.40.2020.06.01.16.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 16:06:23 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH] clk: imx: vf610: add CAAM clock
Date:   Mon,  1 Jun 2020 16:06:07 -0700
Message-Id: <20200601230607.31740-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Vybrid Security RM, CCM_CCGR11[CG176] can be used to gate
CAAM ipg clock.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-imx@nxp.com
---
 drivers/clk/imx/clk-vf610.c             | 1 +
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index cd04e7dc1878..5129ef8e1d6e 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -438,6 +438,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_SNVS] = imx_clk_gate2("snvs-rtc", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(7));
 	clk[VF610_CLK_DAP] = imx_clk_gate("dap", "platform_bus", CCM_CCSR, 24);
 	clk[VF610_CLK_OCOTP] = imx_clk_gate("ocotp", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(5));
+	clk[VF610_CLK_CAAM] = imx_clk_gate2("caam", "ipg_bus", CCM_CCGR11, CCM_CCGRx_CGn(0));

 	imx_check_clocks(clk, ARRAY_SIZE(clk));

diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 95394f35a74a..0f2d60e884dc 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -195,6 +195,7 @@
 #define VF610_CLK_WKPU			186
 #define VF610_CLK_TCON0			187
 #define VF610_CLK_TCON1			188
-#define VF610_CLK_END			189
+#define VF610_CLK_CAAM			189
+#define VF610_CLK_END			190

 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
--
2.21.3
