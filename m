Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AE1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7687C20899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+eqmQcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgGCRnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgGCRmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB2FC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so34882393wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kET32cWBEbf+azZpl4b9S5hhud6fCuzb1HVS2JBoyeg=;
        b=E+eqmQcJjcmnr2u4Nr9qPSNrgPa0cqnh4p53vmQ7P1dwDX9UnVYEjQxvClD1uAJ9Et
         uzhmv5h+j90jPdmZ2+ERqI5c22248cZINxdUx6F+2myWrFrXFgqpf6eNpKYa0O/MBx3m
         eev4UTe30wi7JJHgf7OfYcxQTuv4BeTaWmQJIpWM9KzuYepaK8oC+fcYIppNmp23TMX2
         G/yTZk7ZYVnMpw77HcYQ80Pw2EvMp3Q2JJV932kBQn/XCfqsumQIuKyABQHBYFREEhwR
         3HBMjRlr2ascNOBsgGi8i4ez9fFsEC2RFybCAEcAcHKjodJycriwHG1mFqRAFz/TlBla
         o7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kET32cWBEbf+azZpl4b9S5hhud6fCuzb1HVS2JBoyeg=;
        b=soniSC9uUvOjxbcX17IcHfjnhNLhkpuhvPo3IjnJ7eHkVrjn8qhJ+LMU78g5gMdOrb
         koXDZKbi3UWA+cgnEMeBM+eooFR9Nqk3qHMSKBD2rJzLfE9ENJQFjuALxFxEbTZ8iRC3
         hEGBK7Nnz8sX5Vofo9FvBikHqB08TC4wV2bOfkdWzBxRPDyEX43huyFst8SAFDsUVaB7
         RG1vPVuXY8eZftyv6jZOtUoA+KUR80HTA6m99XSLt2/JtMljdM2W6XKfGeO6OGWXyOBx
         I5gHVs3pRVtyWtecE70z7scAaNpj52DZbqwUSCPY0KeW68OP1A13WeyrEn3yorY5CRfR
         GmMA==
X-Gm-Message-State: AOAM5325bpKASfvxWnvLHh1kjqUwBOXmwEBgkcZph1wlcR/53sJSwCki
        3ZrkRf+gZSVMySrHhf3lvzRYgA==
X-Google-Smtp-Source: ABdhPJx+kvzQZ7rH7eOuqZcSpRb7jmBkzPEVOp4RMNOQJpQ/CkWOVZU3h/qUTZDxWMj0S80UE1YZlA==
X-Received: by 2002:a1c:3504:: with SMTP id c4mr4441366wma.177.1593798171685;
        Fri, 03 Jul 2020 10:42:51 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH 23/30] usb: chipidea: usbmisc_imx: Demote obvious misuse of kerneldoc to standard comment block
Date:   Fri,  3 Jul 2020 18:41:41 +0100
Message-Id: <20200703174148.2749969-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document the demoted function here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/chipidea/usbmisc_imx.c:801: warning: Function parameter or member 'data' not described in 'imx7d_charger_detection'

Cc: Peter Chen <Peter.Chen@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Richard Zhao <richard.zhao@freescale.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/chipidea/usbmisc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index f136876cb4a30..8a8e7ad928a61 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -789,7 +789,7 @@ static int imx7d_charger_primary_detection(struct imx_usbmisc_data *data)
 	return 0;
 }
 
-/**
+/*
  * Whole charger detection process:
  * 1. OPMODE override to be non-driving
  * 2. Data contact check
-- 
2.25.1

