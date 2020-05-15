Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48722C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2116620759
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WrDw8Jds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgEOKoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:44:23 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42096 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589539429; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqJlEOVXSKF2UxCy9WOR5kHOjQA8bHXqZJhtSwoMxDs=;
        b=WrDw8JdsEhftb45XlphmyV9bQmtC7Tf6PmcumOlxV2R5z4r0MK92U2AqrqcU8BBBmzL5+E
        lS56EisKEl/nqZe8bkPGjQ/CKcTiWjLSj6wmieBMy6tqnGW0XDu221O5hCUy05qDZxYqIs
        ve/I4pzum9zKDw3M48mbZ0+6fSe6kh0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 5/5] MAINTAINERS: Add myself as reviewer for Ingenic rproc driver
Date:   Fri, 15 May 2020 12:43:40 +0200
Message-Id: <20200515104340.10473-5-paul@crapouillou.net>
In-Reply-To: <20200515104340.10473-1-paul@crapouillou.net>
References: <20200515104340.10473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the reviewer for the Ingenic VPU remoteproc driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v4: New patch
    v5-v7: No change

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 091ec22c1a23..5d864d785574 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8414,6 +8414,7 @@ F:	drivers/mtd/nand/raw/ingenic/
 F:	drivers/pinctrl/pinctrl-ingenic.c
 F:	drivers/power/supply/ingenic-battery.c
 F:	drivers/pwm/pwm-jz4740.c
+F:	drivers/remoteproc/ingenic_rproc.c
 F:	drivers/rtc/rtc-jz4740.c
 F:	drivers/tty/serial/8250/8250_ingenic.c
 F:	drivers/usb/musb/jz4740.c
-- 
2.26.2

