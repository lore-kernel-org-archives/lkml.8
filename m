Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C46C11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFA824676
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOLozh4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBTKAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:00:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39873 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgBTKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:00:16 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so670513pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wCEC2ZRR03FX3LpFaZeS61EwGHy767mriaO/NK8EABE=;
        b=uOLozh4ocYZRgiI3Xgo/dMXSncitbyg/EdtaeRejTPSv+glh5Hj2ZS9fdNOok0fJx7
         BcfVa28+i4aoEuWk+pCRGBU/TsmRzKgJsTm/TQsL4mEMvf7TEPuufb7OzaGyKLn6BoQB
         sP1KpXZx7Zr7xONt6PtGsGyd10ACIu3+WLavCnQAWivASFoiwa60fgztDA7fxUw7DxXy
         Qc526OAaID+EqBHMdev+JUZxIaFKsiVdR3lPcTql5px63SEunVxlxDgYoMLteSgd6Z/2
         3Yx9pLmmPd+Z4C0penqAXS5PccJtMJ6Lxfd+/zOMewD2FEv/kGu4Fy2Jv321BytxvVPJ
         cv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wCEC2ZRR03FX3LpFaZeS61EwGHy767mriaO/NK8EABE=;
        b=iy6M5uQlz2HF6RWivc3RQ3nE9ErZwaUeU1rfX+yRZXPVhr1NV55x1uZNy9UAZ3oSub
         OCtRygR/on7wEydSQJFU9qbLfKTAlbiAQIozaxQ4jxV39VShdhIj5UvCkHzPA0t0ZnpP
         WacOg5Pq+FiYu7+FPIJOZC4MS2vlOi35Xt184H2Fz7HRO2aYuVUVjdYEZ2VdRm666BE9
         y69KNa7DL6vSY4uGHiisbdzB538w/u+biQDP0LmI4B3tIZy+9QDUXkOCjRruTI7N7Q7o
         fbSDGMM8ExmA7j0HQ/bOyYViS33iekAaBeki5hTGYy86GZze7BnPDeqX2XaIwb02jjam
         me6Q==
X-Gm-Message-State: APjAAAVKvZ0pDWZBnjD26TOKjsG/FiMI6Q79e8AtLc3Zsgt0rDb/lF3M
        D3lPZT/lD2kDcVONux8f/QYg
X-Google-Smtp-Source: APXvYqwHpKUKUUfwxWu7wMeFFq8tHCvQXvc3ddc6xuQQDasnQr/PSbvx8lEinNqWdPi8260n7EtWbg==
X-Received: by 2002:a17:90a:fb41:: with SMTP id iq1mr2688737pjb.89.1582192815189;
        Thu, 20 Feb 2020 02:00:15 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:315:9501:edda:4222:88ae:442f])
        by smtp.gmail.com with ESMTPSA id b3sm2678644pjo.30.2020.02.20.02.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:00:14 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 13/16] MAINTAINERS: Add entry for MHI bus
Date:   Thu, 20 Feb 2020 15:28:51 +0530
Message-Id: <20200220095854.4804-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
References: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for MHI bus.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..d01b7e3f6cd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10891,6 +10891,16 @@ M:	Vladimir Vid <vladimir.vid@sartura.hr>
 S:	Maintained
 F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
 
+MHI BUS
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+M:	Hemant Kumar <hemantk@codeaurora.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
+F:	Documentation/mhi/
+F:	drivers/bus/mhi/
+F:	include/linux/mhi.h
+
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 W:	http://www.monstr.eu/fdt/
-- 
2.17.1

