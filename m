Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBFDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522042084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPyrB8Pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGCRmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGCRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F253C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so32760597wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GH9kLkzHctUtpjzMG5uKy/EUP0KmLjkarK3Zyi+F734=;
        b=oPyrB8PidDxQT0BDJL8ttUMskiiCjdZZjs3FWjc7sJiQ3GTGABuuowxYHEb4PXYO9R
         oUuXo2ZFCkIhfpc5FiL95BvY5X6H8sYdqjL+mtb7hHzsc5+VWC3YCMEvMqjGFbMZZtaG
         c0W+rgRjDKk9CsLqqPh94NHRplYLc6no40CMSS2sqVsosXrilmdr4P4sTUGhyv3MvAFi
         vSXEuHkzSkqfzBV05NAGb4G7gjUg4oLd7gld3YYCk6nJ6wyrZcO8NIGoeATjlSR43iDM
         sW57euHO4YC6uPitM6vEsxyXp4WxMo/dVFUtPPoeuuSx3jG9FAR8gNR65w2CAGjEPmjw
         QVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GH9kLkzHctUtpjzMG5uKy/EUP0KmLjkarK3Zyi+F734=;
        b=o2LpcGKxGO/+fWwo8hgPAf0w6Wgq0h6c5Yk/N3oMdpbmAJL5kmWOEJBmvh0i+cu7DM
         cNOkTgz3IhhWM9OWU16Ynu/ClFxB1s9rP/DD3+MlX7ZWoOWWquwmW597t431H2dVFvxw
         dj3lbnQElNH4VoVgJ9sJGK5hBmaM1U73pnD029wl95XYTO4LLl+nUNibnSWK2cu+nv3X
         wQNFnN5UCtBLqT08WiP+znOLTCuhx8LtO2b8w+GZUIRNWp+K28lDVlgQscnqUOsc4mx2
         UlahbVaccK3xHxUO4edQxNVVzI7PBa3W7EU/HAFjWRGmFPXSPgr7ZttSC+uroUT2Qjte
         SGhA==
X-Gm-Message-State: AOAM531V9myupPNOFzRj0nS3DRcSjYI+zrbhSiOs6BKEb7v7bbJB2wGP
        jZoJdfbR+b1bLr3rr6YiBQsorw==
X-Google-Smtp-Source: ABdhPJyR175xQdUE3YbXopU3B0c7WCXx8R0l/TMeTSCdkdTrAkW/AeSsiuMDCeOhzYob4uQ7e/uQvw==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr38510987wmm.48.1593798119975;
        Fri, 03 Jul 2020 10:41:59 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:41:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Roman Weissgaerber <weissg@vienna.at>,
        David Brownell <dbrownell@users.sourceforge.net>,
        Christopher Hoover <ch@hpl.hp.com>,
        Ben Dooks <ben@simtec.co.uk>, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 02/30] usb: host: ohci-s3c2410: Demote obvious misuse of kerneldoc to standard comment block
Date:   Fri,  3 Jul 2020 18:41:20 +0100
Message-Id: <20200703174148.2749969-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document the function here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/ohci-s3c2410.c:356: warning: Function parameter or member 'dev' not described in 'ohci_hcd_s3c2410_probe'

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Roman Weissgaerber <weissg@vienna.at>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Christopher Hoover <ch@hpl.hp.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/ohci-s3c2410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index d961097c90f0e..de5e570c58bae 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -343,7 +343,7 @@ ohci_hcd_s3c2410_remove(struct platform_device *dev)
 	return 0;
 }
 
-/**
+/*
  * ohci_hcd_s3c2410_probe - initialize S3C2410-based HCDs
  * Context: !in_interrupt()
  *
-- 
2.25.1

