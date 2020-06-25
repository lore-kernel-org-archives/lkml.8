Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A06FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1C4207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glb++HtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbgFYGqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390207AbgFYGqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:46:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611F6C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so4611620wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bh7BIJEoFgjXHqYRkwppX22NHiJGTlWMxnnDJ2K7EXk=;
        b=glb++HtS7oZWTpXDAzu7GckwXl1mrcYHW8RG3vTiRLcrJP0l7bKna80fqlxmkNdFuI
         WtsEu8LgvypecW54tymX3u8xbDuWXwH15K8LxtUmwAnB5XGefq2pMyX5ndzdlS78CuO6
         X8YwtelBuFGRwp5DX/Lg1xCuSkc+Gue1l6Ue7pWro9xfXnmYiRXceFTqupqzt+vGtjDT
         +jbyK+D9fFbDRc+8XfgTfi+DfbyNx+U0gVeA3dnVYIMm4bPGVm/BWPyspiJbOZd5LODD
         3QuaAbe8tuiikxunA1ERhVLZ1r718Dkld9We079Otb5DKfuJKCICePZjxmw2lQLBaD1m
         DHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bh7BIJEoFgjXHqYRkwppX22NHiJGTlWMxnnDJ2K7EXk=;
        b=q0qNb6ctCAw2MQPmDVwk3qs0FT/oygzM8RgwpFDjKUJMJ3zCLXlTT8KBFLF1BivmQ6
         CX0yeQVmqsR2UA9d7DTLIbZTXZO2VR01nfimz/oOSFlay6TnfwOk58QlHt+wE44jtvKG
         JGQXzHgglYN8vB84fTiLtTXXUlZQSyuJ4JpKBpOR+7GCGYAHPZST4sZspS3kdphH+JAX
         6pTCnS4PwwDLC57zfQ7bUI+/VS8d5JGqxYietRqwQyXOjPKsjYqifNHI5C949bWc2bEA
         shju1SPnE0RKruyTI9kdUJNWyHPnfzlB7mftjZQJUahpeqN5bu2O5UapEaMC351dYwjD
         XZlQ==
X-Gm-Message-State: AOAM533kRtN/pN2GZ1TerF6YfbRbconLmDAbcycA5IL11j6ykTtwyYTD
        59Scc6l7cQwEpgRydY8cTCqJIaeUgUs=
X-Google-Smtp-Source: ABdhPJz7hX/Z2JM0lOGHssb5FyeBBY2iFs7Z9tsdVrKKfbPW5vOlTRxleyhOq9BreaGxFEv4RwYsQA==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr8325231wru.88.1593067597162;
        Wed, 24 Jun 2020 23:46:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c20sm27235363wrb.65.2020.06.24.23.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:46:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 10/10] mfd: altera-sysmgr: Supply descriptions for 'np' and 'property' function args
Date:   Thu, 25 Jun 2020 07:46:19 +0100
Message-Id: <20200625064619.2775707-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625064619.2775707-1-lee.jones@linaro.org>
References: <20200625064619.2775707-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.  Arg descriptions are required.

Fixes the following W=1 build warnings:

 drivers/mfd/altera-sysmgr.c:95: warning: Function parameter or member 'np' not described in 'altr_sysmgr_regmap_lookup_by_phandle'
 drivers/mfd/altera-sysmgr.c:95: warning: Function parameter or member 'property' not described in 'altr_sysmgr_regmap_lookup_by_phandle'

Cc: <stable@vger.kernel.org>
Cc: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/altera-sysmgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 83f0765f819b0..41076d121dd54 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -89,6 +89,9 @@ static struct regmap_config altr_sysmgr_regmap_cfg = {
  * altr_sysmgr_regmap_lookup_by_phandle
  * Find the sysmgr previous configured in probe() and return regmap property.
  * Return: regmap if found or error if not found.
+ *
+ * @np: Pointer to device's Device Tree node
+ * @property: Device Tree property name which references the sysmgr
  */
 struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 						    const char *property)
-- 
2.25.1

