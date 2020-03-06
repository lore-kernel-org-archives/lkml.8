Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CFBC10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6CB20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xfpoa28l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgCFHxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:53:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35413 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgCFHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:53:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id m3so1278431wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=M2N76HSdO2AKrxhSY/D4yXqAwmp+7xWxrk33JmiX+pc=;
        b=xfpoa28lJrSVhMdRpBko/Y5nceCuKhbj5I/+bAxre7oBTCfeMonRyQv6uvUvhbjEP1
         FhPNqoKb8pOCbMYux6/Qmed72a3e/UCzQzyAMz1ucd3fcEhlo0A+d3XiKJmBuYDJqM6U
         hUOJRBs6rchDz5xCdOh5hA6J1i1ThU31flFC/o0vxqXEMJbAxYVQOh6wXfCYROnMbXU7
         tdsmUtgCvfEjQKLiVLGKBkv52u3f6EjtvJ5tvIqpp0vhd7WS4Y2YtihewAgzn9pm9miL
         rojEEcCC5ScIjugqoLc3wAemTYA64NlO4NJzyupetKy4ix6mxXBEiH1eBKr1bSwZsiwB
         3e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M2N76HSdO2AKrxhSY/D4yXqAwmp+7xWxrk33JmiX+pc=;
        b=GV2fZOqsUEMmqTCTas1sYaXFY7Y1wth3OhBZLmWUNPssjxaBwssH/gxG+BB9V7dNIO
         DZvxFMIRhLc9zCq6Z0Co+xz//U6u4aExcUo3XxS8fleKHokz3L1WKejwKXCVkkfybRLe
         rluZ99ULUqlpW0pF7JBy/08L8rHzt9y0pRNJC3mVEKn5yfHbH8gtYCyRlkYoM0Yll7x9
         jc4zGDqiMTyzW1sX/h4fqN8dHEbSvNV9nl+/VF1UnAMFI4JHyUGglyfkridJQduEEZXH
         FfXYFD7HAiVy+5V0ZG1RZ78QzUStgs5yhNFF6cdiZXrL6Bj/XiiU2b8tkIjfp0NZQx9T
         l0JA==
X-Gm-Message-State: ANhLgQ2qV7AfYU480bVMRQEZl/sv6pkazRxGZPHdtf1OU+SIy61vRVtO
        r6j/uangvg/bSHk9oGjXrzG+aA==
X-Google-Smtp-Source: ADFU+vthxeXljgB8Lwz7dXuVcROQRPl46OEPlESn2K/Hne5Kko6Kt92tt8v3fQXREFIZb3sinU+X/w==
X-Received: by 2002:a1c:a908:: with SMTP id s8mr2602908wme.133.1583481188039;
        Thu, 05 Mar 2020 23:53:08 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id f17sm27152245wrm.3.2020.03.05.23.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 23:53:07 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] PNP: constify driver name
Date:   Fri,  6 Mar 2020 07:53:00 +0000
Message-Id: <1583481181-22972-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct pnp_driver has name set as char* instead of const char* like platform_driver, pci_driver, usb_driver, etc...
Let's unify a bit by setting name as const char*.
Furthermore, all users of this structures set name from already const
data.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/pnp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 3b12fd28af78..b18dca67253d 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -379,7 +379,7 @@ struct pnp_id {
 };
 
 struct pnp_driver {
-	char *name;
+	const char *name;
 	const struct pnp_device_id *id_table;
 	unsigned int flags;
 	int (*probe) (struct pnp_dev *dev, const struct pnp_device_id *dev_id);
-- 
2.24.1

