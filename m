Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2D120760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGT6P/GM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGCRFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGCRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:05:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F4DC061794;
        Fri,  3 Jul 2020 10:05:19 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f12so8767086eja.9;
        Fri, 03 Jul 2020 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzXO2/YQtP7mmUtJI2Phdpl7tGijDa11G8t5gttXFS4=;
        b=mGT6P/GMOidgiOrtYqyDw3Sl4cBH+iyMLzd9CQOMR3JWDJrDNh5bPf9Ogwz53kfUMn
         XpodOhKWaVI8SKFxCd0Nb0sRaAaQ2bjAoPUWNnbXOiCCl1Ru5d9RsO6q00P9oMk9/eLS
         gOzdal0yRhOZ+AJD8ti6Y5VRbs8q0PWlaYEIyeX1qCWcbfeFfELLJduDLQPlqzGDAU8T
         wWD4WqzYX5bLHfK6+N0m/dMwtKNPNYWJJSTcczffbGtyaJbIL6WhcQjzT5MWA37y5Gzt
         drRqxRs6dWEkZJrq4zc4P3Atf/tgkGgOX9ljCZpxq4msmT/55ZvpNpGZEbgs3RjXabLX
         JrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzXO2/YQtP7mmUtJI2Phdpl7tGijDa11G8t5gttXFS4=;
        b=F2fdhdBpcR+RPXy1MiC3lKrrJuuhTZBzUxJaQn7gXLQ6dxRx2EVS0wRGGsxhIUwYUE
         yV9+8LKVGa3L2xkdcBtNN5C/Vng8v7Pl3mpyXVKORN9wAFj1rnhHLDk1dBuDV6ooFwmi
         6YcCUKisq1Z46U1MVUw6z/xtS9UIVMt8Qz8r+DSHE+Rvgv5SJRmmVJCWw5zl34nIufPh
         UI4tbwru/3BwOJACXfDRwDhDVlI9vJG+vDQnbyxbR9ejUHsfHCiVD8Z26QjPhRsd3eFV
         sKNicV6RziX7WU/QG0znzXj6FoBFLLgxHosRjJ/2GtsC9pWSmytF8Ga1SkpLIkR2ULfk
         qrxQ==
X-Gm-Message-State: AOAM530GPsoobjFedujg8UVk4TNmNtJ4UkWDoPk9GKJtIfsiVRwSqLyX
        wjuMyKXQLRtUZ0BCRqAMCE4=
X-Google-Smtp-Source: ABdhPJx9uruR98eAolW4ynaII6t8dVZ1X1yNn3bW7ER9Gxn0hlnG465NOusilRAR8UnIwjfZOWL+FQ==
X-Received: by 2002:a17:906:364a:: with SMTP id r10mr32650789ejb.122.1593795917982;
        Fri, 03 Jul 2020 10:05:17 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id dg8sm14342272edb.56.2020.07.03.10.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:05:17 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v3 2/6] dt-bindings: clock: Add APB, DMAC, GPIO bindings for Actions S500 SoC
Date:   Fri,  3 Jul 2020 20:05:08 +0300
Message-Id: <67112af4f5bc0cc5e70ce8410feb369cc72972b8.1593788312.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing APB, DMAC and GPIO clock bindings constants for
Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v3:
 - Preserved the original values of the existing bindings and moved
   the newly added constants bellow, as indicated by Stephen

Changes in v2:
 - None

 include/dt-bindings/clock/actions,s500-cmu.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/actions,s500-cmu.h b/include/dt-bindings/clock/actions,s500-cmu.h
index 030981cd2d56..a250a52a6192 100644
--- a/include/dt-bindings/clock/actions,s500-cmu.h
+++ b/include/dt-bindings/clock/actions,s500-cmu.h
@@ -72,7 +72,12 @@
 #define CLK_NAND		52
 #define CLK_ECC			53
 #define CLK_RMII_REF		54
+#define CLK_GPIO		55
 
-#define CLK_NR_CLKS	       (CLK_RMII_REF + 1)
+/* system clock (part 2) */
+#define CLK_APB			56
+#define CLK_DMAC		57
+
+#define CLK_NR_CLKS		(CLK_DMAC + 1)
 
 #endif /* __DT_BINDINGS_CLOCK_S500_CMU_H */
-- 
2.27.0

