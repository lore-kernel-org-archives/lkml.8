Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4102067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxMpXkgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgGBOtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgGBOqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF2BC08C5E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so28794003wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K724gNBq1+8gJuUosuyXSMvH+REcJBS2sGMOEUVIfWc=;
        b=bxMpXkgMVaIQhUosfclwMUUcexKCyxfNvmHDbmWxGE6fnfTamN5u0EjbZj6xscXTJO
         KIqwSDdDoUdpSQjaH5gfR2j3bPAjelzx07KQNxL5h1MuR11ckg4jcR5+LCNbnF7m0LyX
         uc+hTJBCiFR8J/aHBmIrhWw+iCM8BO8LXIO9UZm+GQk+ettGaEC+svC5PHWO9knyxcxq
         Eyx45/1OtfW7w8v3xhWVQYzHpRGQvw0Iu6TXfXbdmUcCnnO7yuLErpt3TcRveMRqx4t5
         9j6tlz681kwT2hbuts1GpJis58KKUpqBVck9dSa7i7jQ4OzcB3v+7hlHUu2FUQP7ik3B
         tWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K724gNBq1+8gJuUosuyXSMvH+REcJBS2sGMOEUVIfWc=;
        b=soda8/k2KA6USTPNuHxBiOpu9i6AmYYt9dRrE3wT38gMNiFrpqj9Mu0xKtTVaQd8V/
         1+TLkD3dLYgzFrcCdFtyDVYWxMF30MCElnUX5+CscczXh2dAhRx7WshyXWvbwEM3ZGky
         aOdkRhAL3SSKndTwfmF/veJtlHyn3sE1NEgpn5jB2BM8jp15oaOTJiqBGJ1qsvS2z58p
         kwys5/z6KyQWjpIlV/4wX0z90ztDmWFykEnqRVpJyG9w1TG0azoDHAGYbczCwliNf6Sb
         Cm8s1mz+Xs7VMX1Ef6f+vtGkq8j6Lo6bxIbmqNC3lFnfTQ2yRCgcTcVE9uiVEtZ484HR
         ridg==
X-Gm-Message-State: AOAM53033bw9khkS5UquKVNERjD3KlApSwBzuOHSAT69MmVtP4VICzKb
        lRvx4aO3vCVFq5vh9gpXudNU8w==
X-Google-Smtp-Source: ABdhPJy4S926IqfqG9+GjXBGJlktkqEcFIY2+P6+GBBzSak8NQL0ghDJYlnEAQjhrd4dBc3MisUR1Q==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr30549831wrp.183.1593701203410;
        Thu, 02 Jul 2020 07:46:43 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Ben Dooks <ben@simtec.co.uk>
Subject: [PATCH 09/30] usb: dwc2: gadget: Do not read GINTMSK2
Date:   Thu,  2 Jul 2020 15:46:04 +0100
Message-Id: <20200702144625.2533530-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of GINTMSK2 hasn't been checked since the inception of
dwc2_gadget_wkup_alert_handler() in 2018.

Fixes the following W=1 warning:

 drivers/usb/dwc2/gadget.c: In function ‘dwc2_gadget_wkup_alert_handler’:
 drivers/usb/dwc2/gadget.c:259:6: warning: variable ‘gintmsk2’ set but not used [-Wunused-but-set-variable]
 259 | u32 gintmsk2;
 | ^~~~~~~~

Cc: Minas Harutyunyan <hminas@synopsys.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc2/gadget.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 12b98b4662872..14c422ee6a069 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -256,10 +256,8 @@ int dwc2_hsotg_tx_fifo_total_depth(struct dwc2_hsotg *hsotg)
 static void dwc2_gadget_wkup_alert_handler(struct dwc2_hsotg *hsotg)
 {
 	u32 gintsts2;
-	u32 gintmsk2;
 
 	gintsts2 = dwc2_readl(hsotg, GINTSTS2);
-	gintmsk2 = dwc2_readl(hsotg, GINTMSK2);
 
 	if (gintsts2 & GINTSTS2_WKUP_ALERT_INT) {
 		dev_dbg(hsotg->dev, "%s: Wkup_Alert_Int\n", __func__);
-- 
2.25.1

