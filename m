Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75704C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A1D20753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bInhT/9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCTQxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:53:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39405 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbgCTQxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:53:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so3539102pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmL7WKSSlzn7AwVehX98pnv4QVn1Y4dArQ8fGVMuiPE=;
        b=bInhT/9Z3tPBsPg8EMknvbA1Oby31u6fG3pylyWnoBarM6PXmlq/Y5wfBMZA9La5jP
         qtUS13AbDSDZrrVHk/ueAL3/npdlJ+KZG2xdCovFO7Iya6iKsMT5OjzR0awoLv0K7rzk
         CFc8pNt5Ke/SdCwVY8vYHTrGIQ8wFQHwNkI3AJ6tJC5xC2MPfhUPyHYaTpDHE54leFi/
         F6kvMiE0cQEHY1lrIcpgPql3ZHxiuai6bUaoVMAI09UVdu+uwPpwgrDmNcQV6raVmANP
         aYdduPr/uY0a+L2CH5ewqvF74DMBnuQFgjef2kl32C7wuYC5ZndIFwH86d+GnerwWoa6
         zfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmL7WKSSlzn7AwVehX98pnv4QVn1Y4dArQ8fGVMuiPE=;
        b=PlMPjw6TvCca+A6W9fPCAeN5wknTbd0bHJa+mQcd4b5Owgj12rKUNR08jjEEq4xzZT
         IzWNssSg+vdJ/hhIFZpywMDf5VGcRyS6p58MChFwCuYrXpD0T0JXoFQTUhEwvg7bnd4z
         /UQyc3TxZVR0j3kKpYmpTHJmTsxfGNHy3/w8YjO0k+IybW1xa57j+7YXuBFKk+ur9Lq+
         odJzdZmgY+jlCbweEAJaFCOIw4atT3RK6lp6mQ+bvu/q2WWgbPtaP5c1KmIGFJ3FX55g
         NkPWZz3wFL+Rdk3PAeE0qbh+KmsSKZVBCv3EhfzYJdpxS87QWTXhW5i+RxuU6ayxRBrP
         bSrw==
X-Gm-Message-State: ANhLgQ1NAjZcBlRCnPL2g5N02AgEI5GvVJvLv/BKZb7ms5WqF43kd445
        vRbCbi7It1H0BlpWIcwL+0QMYw==
X-Google-Smtp-Source: ADFU+vvCqMNOoII+Tvgh346RZZiWuiCEk9FlFiP3qpQ2Ts4pUCVtqJ0wR9NBNFuAaG5yilFA5SrOdA==
X-Received: by 2002:a63:a361:: with SMTP id v33mr9344642pgn.324.1584723199217;
        Fri, 20 Mar 2020 09:53:19 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x17sm6064216pfn.16.2020.03.20.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:53:18 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     mike.leach@linaro.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 12/12] Update MAINTAINERS to add reviewer for CoreSight
Date:   Fri, 20 Mar 2020 10:53:03 -0600
Message-Id: <20200320165303.13681-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320165303.13681-1-mathieu.poirier@linaro.org>
References: <20200320165303.13681-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Added myself as a designated reviewer for the CoreSight infrastructure
at the request of Mathieu Poirier.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 847d1da852f9..b6f4eb83ac99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1676,6 +1676,7 @@ F:	arch/arm/mach-ep93xx/micro9.c
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 R:	Suzuki K Poulose <suzuki.poulose@arm.com>
+R:	Mike Leach <mike.leach@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/hwtracing/coresight/*
-- 
2.20.1

