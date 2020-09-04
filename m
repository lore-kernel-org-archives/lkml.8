Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6566C2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFBA20665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7W0D/Fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIDSqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDSqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:46:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9886C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:46:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e11so8076798wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=wYjCbBQQF/RZa7DFxW9EFnrYsiHEPgl/aDtOvgFKLs4=;
        b=i7W0D/FiJMtqsEBaVqvZK9BCEkz5MVt7cQWJXek+uf2HY1K0r9qK61RIsVWtpahSnh
         OVcr+8Ukwjgh4XdH8GG+zh4SWMeCjYC53xkBMwolEBq9gw9UvL/ZKO7g+rKkpksyhVRs
         GAIHRGlmmGR0O3g6Wv+XgkkXQoLyiw77dFbXNlKVdYnMLLkG0lg3BUgVKU4uPIkhaU62
         Ojj2wQLUwxK223oNDOp5KIHJ6CpmRPDujAr2knjwG1pQvcJt6QYJHbtTjbT/yZT8rQzg
         QypJVDrkxOHh6Z2sC0jJYOTFnLgXUX+QzitPVzu6UaZPUeIpadWM8werXF6KGcA6HBAu
         jT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=wYjCbBQQF/RZa7DFxW9EFnrYsiHEPgl/aDtOvgFKLs4=;
        b=BWZ3IhCRIMgF/4MlUcIQZvuw83zvAfIbF2omp/WGyMQq49AUpyl5DU8hTNsL6TUOep
         eVTRFqUOIT0H/vP3JNYOjWXzw1yp9ld4neRofj0I3ERNDxNPWtaBRCqex3fKOVv0t8og
         heV6IkNQHpRVM5r3CmvE8QDhsBRKAfFHILvK1fvmPJEot7+AXQttNwQNApLjUjMO6TUn
         ++1ZXQdeQOxKhQDDGP2lM7jg8hQIv49bgIghNHclWUsikGSfY+Q+4J83Krb9vJS9j3Pf
         2/nFwQZxsvRbj2SXQfci5PSRpODMcRxFDG0kuTdoUccV2UTrQPGrOHV7dfmsJKTarXqJ
         vsDw==
X-Gm-Message-State: AOAM530AAzmYpFwX+inppUtpYUKCHShhukE8rsRkbDtRzTikjdBkh0Fa
        9CSdyGAPq3QfcstFr1oHY/zTi214hWQ=
X-Google-Smtp-Source: ABdhPJyie2SGWSW4oLp1uAesrHv4WOO6PpRjKaeacvC+oT+UifUmDjpteq9iev04y5TEB89jH7KXbg==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr8852239wmg.50.1599245190732;
        Fri, 04 Sep 2020 11:46:30 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id q186sm14111670wma.45.2020.09.04.11.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:46:29 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 3/6] habanalabs: remove unused define
Date:   Fri,  4 Sep 2020 21:46:20 +0300
Message-Id: <20200904184623.13478-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904184623.13478-1-oded.gabbay@gmail.com>
References: <20200904184623.13478-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the code.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudiP.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index b86eb98b145c..dd222bc128f9 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -35,8 +35,6 @@
 #error "Number of MSI interrupts must be smaller or equal to GAUDI_MSI_ENTRIES"
 #endif
 
-#define QMAN_FENCE_TIMEOUT_USEC		10000		/* 10 ms */
-
 #define CORESIGHT_TIMEOUT_USEC		100000		/* 100 ms */
 
 #define GAUDI_MAX_CLK_FREQ		2200000000ull	/* 2200 MHz */
-- 
2.17.1

