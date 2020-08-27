Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBEAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CEF2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zO5xaZyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgH0KFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgH0KFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:05:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B2C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 03:05:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so3104106pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY9vWqi8io8Q/KjFZpL5UnBPSsLhfZfobXaFG+SgOqk=;
        b=zO5xaZyH5NBB+g4FkyMZLdJPv05aiY5r0BLK9s2kZG019uiBNqS4nZLXOUc3mRpPI2
         5FrqdwuJl2R/C8CN2uQD3HjvsFD5uHOwL/StxxRfaPssdEomiavjQqsuqN6uv1uxrHC4
         wr3MU2wmm+AUJupiwa4JH4lkULPVfIDAN28ujoeEMVPBQ5T+5Px6ffPlLZjrwbSQfLQb
         lT+8MrZAHcHmkH8EDl51eBhkxPLl/ZOhyZIQ0dygBVEWKmOBkUFMTg250ikuM6GVsqm1
         nrGVdfiQM0NN+XA27rxEbfTXhJ/WY8fYlI9irkBP7FR0KwmMwPjsAgigSZp3xv/2GV3+
         1z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY9vWqi8io8Q/KjFZpL5UnBPSsLhfZfobXaFG+SgOqk=;
        b=rVEwhxqhf8S09EEO1exOP1N2Yi46Udpn9Un5hc+1OJvGxDp0zBHqg6R/IJ9nGBDsF5
         0alsQEVGFsvOI9dwUzo3dNc9jT+pufIe5DS4+HDW50e4aapMTBmBUpoubToZkHj+Tipx
         hBPOe3wXBvxcFXQZ+y3pizlm1LKWp+N/WZgT65xJYyDyAG5A7SEnRDprK9X/b23NAfdK
         NDu8TFFmKz5drln6Ij5SNKY1gMhCnijpcb/Vphezv4NsV9gg1fP7dFKWnF+4sgH0OKmo
         Sl8dJm2fYfBcrurpR7zmwlCy9xvginNHZECkvowE6ywaHZv+Dln1roGwttvg0PFvEd3K
         Tiyw==
X-Gm-Message-State: AOAM532pfloN6IPycPA1/u1EttWT8H/sKLwCYmrUC0LxdrgRFg60dc1D
        SwM2/X+s/8uUDm4BcuIZOOKIRQ==
X-Google-Smtp-Source: ABdhPJxc3HNQBhVYTuNOywoWV07oFElapsdKQi1sNWkbDWdd6btWY5ytriyBJr0/a4vXEGR1/V7ZXA==
X-Received: by 2002:a65:4847:: with SMTP id i7mr13871837pgs.385.1598522719424;
        Thu, 27 Aug 2020 03:05:19 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id lt23sm1751841pjb.52.2020.08.27.03.05.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:05:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Drop unnecessary check frmo dev_pm_opp_attach_genpd()
Date:   Thu, 27 Aug 2020 15:35:15 +0530
Message-Id: <88c8522b556d15bd44b8388d47cf25ac6f06b057.1598522635.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c0ab9e0812da ("opp: Allocate genpd_virt_devs from
dev_pm_opp_attach_genpd()"), the allocation of the virtual devices is
moved to dev_pm_opp_attach_genpd() and this check isn't required anymore
as it will always fail. Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 8b3c3986f589..000d0fcb4680 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2031,12 +2031,6 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 			goto err;
 		}
 
-		if (opp_table->genpd_virt_devs[index]) {
-			dev_err(dev, "Genpd virtual device already set %s\n",
-				*name);
-			goto err;
-		}
-
 		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
 		if (IS_ERR(virt_dev)) {
 			ret = PTR_ERR(virt_dev);
-- 
2.25.0.rc1.19.g042ed3e048af

