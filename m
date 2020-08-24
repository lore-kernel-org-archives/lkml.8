Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1E32072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zb6H8ukR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgHXJaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgHXJaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:30:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF407C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:30:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so3925054plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pK5bVNvEUkGmkHt7h+22p1PRjllmkBfGKoPd86o06Lw=;
        b=zb6H8ukRfhieLWr3DBnUXOTmg55+e5EVKeqsfa2altwwB4K1VmjB+xm8dp0KBc1B0F
         KH/tRUbVH5H9kDw1etY4+d/Urtgr+0Uix5vBzCbL7jtkQ1eORBWByV8kv2G/GTNO34Vt
         mSH6FAZHzaRAefjA6cu7fJfPaD6DxdXrTBmzBKhB6v3cEnUrPrwh8faxFALumEMVOqJA
         CTTMXQeHQ8MSlQBI1kcnwyGWnp1vQ2Y8z7P0NgI/6mlqv0ZgTeOsB4RhP2gBC/WJvl+H
         E/7v/z49lP1blJipG/yCn02u9NiwT7GRfdVRKXa+EBMMQvQmxFyFlkyzbmIzDvLjy4lx
         1+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pK5bVNvEUkGmkHt7h+22p1PRjllmkBfGKoPd86o06Lw=;
        b=Pmq0VVtptpwC9ipMhier8jxEbC1PKVWAR5llIINKwM2bFUgXNk94BPA/nWj0/9uLD6
         IFzJyWLKhqwKSdnYWxXJqd+BIvHTbDRXD5Tv6gjH5VccdpW7UAkGstSrII1+VXzUlfgG
         AhM8yNci2wT/HxIr1Ne2MIPqtCpkflwqYrSVHrGrc1IoMJ6KKcT+M0nPuYkOiIvelBmk
         k0Rwz/fC7OOWrvSIaovz8wskXeDC/PCkVFLfSXVJO8hTFNKzslVyFaQHjRnh4gDQ2BLh
         tVb2UHC9CmxEF4OyQmeljaopywPGi/bvwJxC3+Dm92PTwlTwsoNEe0oa2lNYHdxNsUr2
         e/OA==
X-Gm-Message-State: AOAM530DqHt5tZsM5OFnoq8dgfDHo6027vroeXm+KZumEFJtpsUXQE7p
        WNxEKZZqMILC+p7R9t4ymxhY8w==
X-Google-Smtp-Source: ABdhPJwzqLJz/+aP8JzlsLfMYGqG9zUEjWrPHt0rxu0+/5xAZOVgSxNCJ+v8x4WUX1WjzQRFq4pUgA==
X-Received: by 2002:a17:90a:448e:: with SMTP id t14mr3829392pjg.59.1598261414267;
        Mon, 24 Aug 2020 02:30:14 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id y3sm9647312pjg.8.2020.08.24.02.30.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:30:13 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     stable@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH - for v5.7 stable] opp: Put opp table in dev_pm_opp_set_rate() for empty tables
Date:   Mon, 24 Aug 2020 15:00:03 +0530
Message-Id: <e7e9f887328c06800a79f3b48feb623fd15aa3d5.1598261323.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

commit 8979ef70850eb469e1094279259d1ef393ffe85f upstream.

We get the opp_table pointer at the top of the function and so we should
put the pointer at the end of the function like all other exit paths
from this function do.

Cc: v5.7+ <stable@vger.kernel.org> # v5.7+
Fixes: aca48b61f963 ("opp: Manage empty OPP tables with clk handle")
Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
[ Viresh: Split the patch into two ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[ Viresh: Update the code for v5.7-stable ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bb7060d52eec..c94e725e6522 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -820,7 +820,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		if (opp_table->required_opp_tables) {
 			ret = _set_required_opps(dev, opp_table, NULL);
 		} else if (!_get_opp_count(opp_table)) {
-			return 0;
+			ret = 0;
 		} else {
 			dev_err(dev, "target frequency can't be 0\n");
 			ret = -EINVAL;
-- 
2.25.0.rc1.19.g042ed3e048af

