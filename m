Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232D1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7EA20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhKIvkc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgGAIc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbgGAIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442BC03E97A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so21486358wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wk9/DzLGRf8KDCzfvt/GOgByrJsxT/fIOxcZPlWq/CY=;
        b=ZhKIvkc9EZNAisfx8yW7B1c6fqYpuwL3KFpCpXgXTlBejrPWOHUTy/KIbvJ9WTaGSq
         HCVTlW3EkIOPThRGyJmtXhzx5lgQEAt22ieLy2QrgdDrpOKl6QLl/glgAvVxNIYE+24R
         uC/llDdROdmalYWGpdmiRBx/vGW9AQY9bGXLKX5zDmqWKPZtj2vdMQwg3FmBEXwXc4Ia
         pvYwS7uGIQm9C2o+ULEoT5ldL7fuDqN67T6cSSwnOfDOnzM8RuG2kANRVCdN/fAZ6XJH
         Dc2pcCMJPPdC0nlL0uSX/qWPUtInLKyBrEkuNFmPneGAwCc/L9cpOtE7e9D4iRDlIaGS
         7WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk9/DzLGRf8KDCzfvt/GOgByrJsxT/fIOxcZPlWq/CY=;
        b=AGRe9eUJfxbA/tv2YlQINLSsa+//6vU0I+0oLWkiupK8PW+kQ+MbhRcg8/WEo46Dz6
         IRDoAtL9F46eNdD6vPQBYUqLQ2KGDWsghOy/VL4SrFCvpinwmuRn1OInZVfKuIjobif2
         tWzoIZlq0wAW69crHrxV/le/iJK7+sIxHw/q0UTS/zpNb6EAcMdX5ndy40zL5rUZmiOF
         YjdjhDNf9TPS/lesHLikLlSW6MzGACle0sAFyPBBgl1UfExeOTnwHwaySRgkSQsoPSRX
         /SwjUsICYbDnhGJD5VLsUFOj7H1IdSxdeoLQKGoD8O4rNrL/R97NmfwrYewS/Oj1ftB6
         1PLw==
X-Gm-Message-State: AOAM531NhcFeYbtY0e8YEL3p0NDPewsSYOuZk2nBI5lDVc9lJ2cqyyvy
        RSYAb7q/9YrIzC0EyyZ7bYKGZg==
X-Google-Smtp-Source: ABdhPJwQr98gAL8MHnu1nzgyNiK9BU8UKpLx8ucmr2e2ABYci7yRuFN4SSOONAe5wonNWDXKGVxnLQ==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr27652986wmj.117.1593592302632;
        Wed, 01 Jul 2020 01:31:42 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 16/30] misc: mic: scif: scif_ports: Fix copy 'n' paste error
Date:   Wed,  1 Jul 2020 09:31:04 +0100
Message-Id: <20200701083118.45744-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__scif_get_port() has never taken 'port' as an argument since
its inception back in 2015.  Probably document the proper arguments
expected 'start' and 'end'.

Fixes the following W=1 kernel build warnings:

 drivers/misc/mic/scif/scif_ports.c:36: warning: Function parameter or member 'start' not described in '__scif_get_port
 drivers/misc/mic/scif/scif_ports.c:36: warning: Function parameter or member 'end' not described in '__scif_get_port'
 drivers/misc/mic/scif/scif_ports.c:36: warning: Excess function parameter 'port' description in '__scif_get_port'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_ports.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_ports.c b/drivers/misc/mic/scif/scif_ports.c
index 547a71285069a..4bdb5ef9a1399 100644
--- a/drivers/misc/mic/scif/scif_ports.c
+++ b/drivers/misc/mic/scif/scif_ports.c
@@ -14,11 +14,11 @@
 
 struct idr scif_ports;
 
-/*
+/**
  * struct scif_port - SCIF port information
  *
- * @ref_cnt - Reference count since there can be multiple endpoints
- *		created via scif_accept(..) simultaneously using a port.
+ * @ref_cnt:  Reference count since there can be multiple endpoints
+ *	      created via scif_accept(..) simultaneously using a port.
  */
 struct scif_port {
 	int ref_cnt;
@@ -27,7 +27,8 @@ struct scif_port {
 /**
  * __scif_get_port - Reserve a specified port # for SCIF and add it
  * to the global list.
- * @port : port # to be reserved.
+ * @start: lowest port # to be reserved (inclusive).
+ * @end:   highest port # to be reserved (exclusive).
  *
  * @return : Allocated SCIF port #, or -ENOSPC if port unavailable.
  *		On memory allocation failure, returns -ENOMEM.
-- 
2.25.1

