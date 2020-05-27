Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1FAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5ED207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="epsKr2KQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgE0WgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:36:01 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:53082 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgE0WgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:36:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49XQf73sZYz9vLH8
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 22:35:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 48o0YAEWfKgK for <linux-kernel@vger.kernel.org>;
        Wed, 27 May 2020 17:35:59 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49XQf72CpHz9vLH0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 17:35:59 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49XQf72CpHz9vLH0
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49XQf72CpHz9vLH0
Received: by mail-io1-f72.google.com with SMTP id v16so4741970ios.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CpatvuW2oCiIL+IhriroImU7P7m/r0JsGdlS3UL0xRI=;
        b=epsKr2KQQFASD91Q+FKeGYrbfnjMtu941ofPh58h1X3OFGvYwWvkA8DYxpICLP5JxL
         igEof6dlVtyaEa7orVWfb0MHPf/bxadZ22yUFUi+7ueMlwvZa6uPRuW3DfRCwN3RgH2K
         wi7mABV9A6aAXxxxN1tRUmwCBqxr4JXYffQ4XxwGwYRUXg45eLV5q55+tH0lMb6VVnE/
         DDB3+SRCOfbmNyoWTy5LganvRCPg/iL97DftKHHR4Omxt/KHF4sduSDTBcbEz5TOYAWq
         9JhrmkckVvHLMp72Xz3tBMfPH94dUU5G5TOoEBPvM7sHIHQvjFZlEpU74xwRkwiJ6mXX
         Tmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CpatvuW2oCiIL+IhriroImU7P7m/r0JsGdlS3UL0xRI=;
        b=gFarFUqi12e5kY/VJ2YcsvZbkJ6J4T1YPXO/6cy3B8pCV2qmQMkkGbmLMKGiACK2i+
         XJ4NY7kaex5x+a7f1v9byth8SnW1iKirmhSJ1ZpR8RxlNeCinbyAubFA/uediaV3Xvft
         V8PD+llIxONRolWMlHqBFnHImJWsi7pGe4oXoagMgKE2ITL0diH2DZMJzKWpIae5XULI
         YDF3p1kdcRk8hOycz96MqgIMh61ESohIcvrAtxg7hM+ciEbK3mR77cZNsrDXeWPD+5dl
         SHMLLdRToboRyZIbUpiifb66huKYGKDlJ6wf2Mm9G54lq9vmVb+nt6LsWJB7f8p6G6YV
         s0aA==
X-Gm-Message-State: AOAM532nuGWBVgcgIchhsk+bnQAqGsdE9oE0PRFjUcxX3VfSnsPnq+W4
        2A4W6jymBbbZv1E6LUyqruU/KNB6Q+adaQf61gD+WnyZtUQIXPQks+dc5TgOrX2hvXh48PypmvL
        gJ8g+b+iItM9tdKkec2HV6cgQBwqJ
X-Received: by 2002:a05:6e02:e8c:: with SMTP id t12mr483784ilj.186.1590618958816;
        Wed, 27 May 2020 15:35:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywrYsi6lG1iitaeUz/omV2z7LDZxc73HSoMA4aAWYo8kzkH8F8jJi7zhm/0M8Fqsku4JWGqw==
X-Received: by 2002:a05:6e02:e8c:: with SMTP id t12mr483768ilj.186.1590618958532;
        Wed, 27 May 2020 15:35:58 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id o70sm2368169ild.3.2020.05.27.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:35:57 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        Ashwin Chaugule <ashwin.chaugule@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: CPPC: Fix reference count leak in acpi_cppc_processor_probe.
Date:   Wed, 27 May 2020 17:35:51 -0500
Message-Id: <20200527223551.20156-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/acpi/cppc_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8b2e89c20c11..067067bc03d4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -846,6 +846,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			"acpi_cppc");
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
+		kobject_put(&cpc_ptr->kobj);
 		goto out_free;
 	}
 
-- 
2.17.1

