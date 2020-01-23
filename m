Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D16C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09484206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNMapbpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgAWLTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:19:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42776 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgAWLTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:19:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so1217756plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OOn03P2j4+kr/DXG8NPT0x1Kk1bZl2DSDVVAcxfmW/Y=;
        b=oNMapbpk822BP7CdcxtHz54BSReHACxR+26qB0HWnkZ4gytrswDazDLuWvp8kWTHyY
         X0EM7F/EpABqwyGi14/41RPld6Tb6ZigyF+qHq4HZIw95eLkKTsU0Aznzq9Xa/n5lfXZ
         3SwmcfunHdLLigUEHiATW5hTYmuxhxau5Iwo4I+pOo2p0IbEkPipHROpk8tMxqph6A41
         VGtD5AHIb3ZXNfM6ZTBVwoKZoh6Upe+hBcr93VLXovkzRuS6xVRc9IuQPKm0zG+M+zfx
         XVC2NomZ1VqNLZn5dOMb8A40GP2OrtIFiH+K/i3qD9orFKnIMYsp0xmOqOaotAQu7cKf
         3guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OOn03P2j4+kr/DXG8NPT0x1Kk1bZl2DSDVVAcxfmW/Y=;
        b=czXiEO07BUAj7TOwzGeUxeqcQwuxn6i4Qnn5mino+EkUCsqte+BfVsj0NiSN4KcqTT
         bRJu6i/Up2quhIEcDns5RzX9fWQstUGjirTLijd2n/aV8Zd6bVa8+z5tNARpSRwsrh26
         sD72lP29Dq8dk/MkUkBgYUEtYnG5bd8f7NY6IdypsxTvT9qBjuXIiaKvd+Atg0+c7Dam
         t8XItMnRlT171Lz0jPRL0+qfJL/BIzQGPRIwyczpp4PJif+Axtl+/cyfLki3zzStsOL7
         1sZ7RqYFYKOR68wdz+yoHX/UH3d+59QicAuYU1sF8+vKNE84z59cgSU2J05irHA5/0nC
         h9mg==
X-Gm-Message-State: APjAAAVtZoFHR4rgStm8JsdqEp2TJkq8nvDDRoN3TcJUOqQfgCBEwKTO
        z972WbdVXIgekEavuR0DRauG
X-Google-Smtp-Source: APXvYqzf7o8s8NL4+/h7QX2QyDG6Q2e+Dp159PX+H007Fn8qM0bcUDWCeLXu7wTK/APwY8aw2bW4zw==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr15626148plt.221.1579778370707;
        Thu, 23 Jan 2020 03:19:30 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id y6sm2627559pgc.10.2020.01.23.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 03:19:30 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/16] MAINTAINERS: Add entry for MHI bus
Date:   Thu, 23 Jan 2020 16:48:33 +0530
Message-Id: <20200123111836.7414-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for MHI bus.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf6ccca6e61c..927cdd907f1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10777,6 +10777,15 @@ M:	Vladimir Vid <vladimir.vid@sartura.hr>
 S:	Maintained
 F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
 
+MHI BUS
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
+S:	Maintained
+F:	drivers/bus/mhi/
+F:	include/linux/mhi.h
+F:	Documentation/mhi/
+
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 W:	http://www.monstr.eu/fdt/
-- 
2.17.1

