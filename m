Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A711C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37F120CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="lR9gZIX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEGTpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgEGTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:45:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D41C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:45:53 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g185so766643qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/jYBC0J9QkfRK9H/zHRlhsgtFYHxAEt3SeV/+q0yv0=;
        b=lR9gZIX45a7NOAUW7gO/TUP7kgP15l9Dy3x8IQB53ToCGkuWWhC/nVW8iIAWjhQGy2
         trEj0TP/YH7S0QjEmfAc8//2v8Lq1FHMuGFqQW5oM8vhL+vJpTDLGDN9Hx3WTW00Tjos
         0NaBw34V6BbrJleA2/aGtmFn19XfbRNwTbku7fDsp0U2/DJIkym1SrKuvCLk/cQlPhSx
         ViHbvTuJBkqStOAQl9Uhw4+PDLdRhOrgDGKYkLk9vy8BrP++iZ/j/2RYIn0ao72LabQ3
         kjmElQA6DOgPzgCwEK09hUHIbKcZW5BqKq64JAs8KBD7bzqVsY9F0mgHypwKgBq0PwLi
         Nd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/jYBC0J9QkfRK9H/zHRlhsgtFYHxAEt3SeV/+q0yv0=;
        b=qjZw84+DBYlhqGuATUWTZ8nKIkPV7Hmk6e9N5//87/Di0Vu89pEwQ4dJws6rppZL0U
         zovEHMHx7Tkbr3251Rr/C75OWWY1LC+BOLBprhorB7uzsyIu7RdmXhSRMQ3ovHq2UovR
         0RSZSsQNnrBTIjS9jSIT1hCNxtKCED0AhJkagQQ79SSB4fjX4n99KpF35ffHX5ZhRBtV
         w7Plael97csIE9TNfUf3Jd1SLW2aao45htQDPGfzYZWsPf5YNrAVblWCWzUmsu7I0X2F
         NFFlDm/gGo3BjMyFXDLalS9Mu36+SLnxiU0DyYGA6vRV3TJbYa77Rn2PUSz/OUhL0fLD
         MkDw==
X-Gm-Message-State: AGi0PuaX0VBOQwCdObxo8K/HyRTWXGiv91bXKcGkmkKmJQ4VC5ANGu1n
        oSBWc8Rr69IwSLJ+2MwA9IG65qJuYFFuPw==
X-Google-Smtp-Source: APiQypL81TqxJs3IwyAikpGDMDxU+8lrSpnUTCQS4TfC8xfRR1Quc3xQtFqQjuI5gWDq3vMEf1CZhg==
X-Received: by 2002:a37:6690:: with SMTP id a138mr16599091qkc.152.1588880752001;
        Thu, 07 May 2020 12:45:52 -0700 (PDT)
Received: from dfj.bfc.timesys.com (host142-13-dynamic.2-87-r.retail.telecomitalia.it. [87.2.13.142])
        by smtp.gmail.com with ESMTPSA id s125sm2085616qkh.51.2020.05.07.12.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:45:51 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        zbr@ioremap.net
Cc:     Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH] w1: ds2430: fix eeprom size in driver description
Date:   Thu,  7 May 2020 21:50:50 +0200
Message-Id: <20200507195050.472483-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non functional fix, set Kb to b, to avoid any misundertanding.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/w1/slaves/w1_ds2430.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2430.c b/drivers/w1/slaves/w1_ds2430.c
index 6fb0563fb2ae..75bb8a88620b 100644
--- a/drivers/w1/slaves/w1_ds2430.c
+++ b/drivers/w1/slaves/w1_ds2430.c
@@ -290,6 +290,6 @@ static struct w1_family w1_family_14 = {
 module_w1_family(w1_family_14);
 
 MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com>");
-MODULE_DESCRIPTION("w1 family 14 driver for DS2430, 256kb EEPROM");
+MODULE_DESCRIPTION("w1 family 14 driver for DS2430, 256b EEPROM");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("w1-family-" __stringify(W1_EEPROM_DS2430));
-- 
2.26.2

