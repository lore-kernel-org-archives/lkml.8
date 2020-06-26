Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEB5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F7220775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKp3jqiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgFZG56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgFZG5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:57:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14CC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so8353149wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vqpawo5MJsJOmOd5oGBoADQ9AShkAYfWIevIqG7XtBk=;
        b=SKp3jqiWYrIXN0jB0OY408JIuyw4za4+UhL8h4rqgsIDHOoRrIpyJa6mqRtdVOps/0
         mgEnzvPXKOyVwiok9xc3e/aGae/TCe+lyKlYblCgxaVLB7fMbQtnu11Fo+LZk4h2UfVY
         8P1sCwqocGnNgb/S8jhEd6RpJSjY68unkDdCp+pHLc9YZnYIj1UgvuxvRk19OyaAut+a
         LmXMXl6hD2/rB7lZdVRXsKPxUxXp+btTwbd/amNtSAhDR5xvBKGtFOiZlDYFOrCx0d27
         8kN6CjSFPWag25rf6VgKqLU1xAHYvr3vl9ay5I0DYXrHesL43//ThifVueOcz0HuZEjY
         gVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vqpawo5MJsJOmOd5oGBoADQ9AShkAYfWIevIqG7XtBk=;
        b=hgT/vW1+K15pz6M+H645M0Inokhh+rYxdJGFdzVZfC6j3fh+ydzC5DpvqaxvK8C6wM
         DJR94Qhaz9viyWwve6/52GMVJg69j6d9rpcloYej5SnzoE7fpe09yY1Br6qaNYyXICyl
         m7+Ywhxx9Uuo5Pi2qHQbtW3gfdef5xeGHh45w/Uzjp99xzM04CWTZ6S+W3V+BwkYcD6u
         zZYMUOMEjszza+7T+9UsXavZszTxClIuDq1jxPqbSvMFlnjHLyIfzqbFFcF8viIsNKLs
         t+KfZFvEYfFhC0u+7NYOH/p6zRhCFUtGVilve0v7kGys4QcuMFfuWi/BMt7Dzw+s4xav
         HMbg==
X-Gm-Message-State: AOAM531dFbjkZqXZP4vU2Jkt44oRi916vA8N251tnynqDSonjgX66gDN
        Y7Nmf8ERExfrZ8A97zntRKn/zg==
X-Google-Smtp-Source: ABdhPJzUZcx9JMvk0I42jptf4iOIhyswi9h4IvKidFSgFgUMg8zyNP/ZGhoR0T7CSf8Q1Xinyvy5Tw==
X-Received: by 2002:adf:9307:: with SMTP id 7mr2062805wro.414.1593154668628;
        Thu, 25 Jun 2020 23:57:48 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm15355269wmi.35.2020.06.25.23.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:57:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Russ Dill <Russ.Dill@ti.com>,
        Keerthy <j-keerthy@ti.com>, AnilKumar Ch <anilkumar@ti.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 6/9] regulator: tps65217-regulator: Use the returned value of tps65217_reg_read()
Date:   Fri, 26 Jun 2020 07:57:35 +0100
Message-Id: <20200626065738.93412-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626065738.93412-1-lee.jones@linaro.org>
References: <20200626065738.93412-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now the aforementioned return value has been ignored.
Previous and current calls to tps65217_reg_read() return
instantly when the value is not 0, so let's do that.

Fixes the following W=1 warning:

 drivers/regulator/tps65217-regulator.c: In function ‘tps65217_regulator_probe’:
 drivers/regulator/tps65217-regulator.c:227:9: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 227 | int i, ret;
 | ^~~

Cc: Russ Dill <Russ.Dill@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: AnilKumar Ch <anilkumar@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/tps65217-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index f2d3a4a9f3e77..3f5ea029e2e3f 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -254,6 +254,9 @@ static int tps65217_regulator_probe(struct platform_device *pdev)
 
 		/* Store default strobe info */
 		ret = tps65217_reg_read(tps, regulators[i].bypass_reg, &val);
+		if (ret)
+			return ret;
+
 		tps->strobes[i] = val & regulators[i].bypass_mask;
 	}
 
-- 
2.25.1

