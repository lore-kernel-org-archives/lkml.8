Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D64C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41A520719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzSoGJdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgHaF6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaF6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 01:58:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D3DC061575
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 22:58:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d19so31840pgl.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 22:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6AsLRpDHwakDmuXrbGWlIm7s+3UR/W0JknRh2YDfh4=;
        b=hzSoGJdVJFRfVadzVGFkdQzGa0rAgCZxrxlqYLE051aqDUx0LJxBy0I2Pdmv8pwHuU
         DwNzkona5VKhZ46ENMuGjoCwsHU1v+yBSm3P24B8YKXx50N9bsqT2VCenkt1U/SDNjeE
         D3yzzwbTd2L0AIUT51McE3J0pNiuKL59rLHRMGYtgBj8rG37ySSCvzlQlriOHSkUn8tp
         waJG/BfzTpgOkzohwxav2k4ItlgCPwbed2qxlSDRkyC6/fKLJxKQ+2523ymDD10YNddZ
         P4SB4dZYGkgjdMCYUlcOAnFURre+mHzZ1WB45GdpsnN7CgBJdXkYMa6ntYlCcJyuRZA5
         TkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6AsLRpDHwakDmuXrbGWlIm7s+3UR/W0JknRh2YDfh4=;
        b=P71vSIou+AVwvpl4cH17Oya7WimSaPunSbH4U9wH3JCaPKK01TDZjfVEdECdyAXqLr
         SqNHdI3kzb8HX0ftG8YJM/mbLrKU1Aym2IqR8yda0awSjgoNulR2jl6p43yDio2IKcDO
         HuU6nCn6ZJ9Y0sHwUxEEjLzhBjPNbw+BzahsNZ87zEcYYGnqIeGpudz/qW4YNcGZrTlZ
         QrtoImkLzoPSO0Zc32NIzZyH/xYS+i4cPQLd0FUWTqY47aeZkFiXSKG2OaRtY4fIuKIJ
         PV+/jSiVPKpBKN4F8MEx7rBk9CqDCfjzd7jikSrh9aSermpe1ymWfCEZnCsmyndFFMOO
         EGdQ==
X-Gm-Message-State: AOAM530h52llVQ3/08CQDgCWiacqoO8fGlS/9MwCD1EtjyxqvuBrwWS6
        0Ov5XHXZkXj40ptSBjnZMZlnpg==
X-Google-Smtp-Source: ABdhPJwGXbHMsM66b23MXrHGO0zax4LzzRWevubMgGap8kSljvyXheQp6cNZ81GCwAXsKxIxJRe9dg==
X-Received: by 2002:a63:5161:: with SMTP id r33mr91670pgl.242.1598853516288;
        Sun, 30 Aug 2020 22:58:36 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id 79sm6549290pfw.97.2020.08.30.22.58.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 22:58:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Prevent memory leak in dev_pm_opp_attach_genpd()
Date:   Mon, 31 Aug 2020 11:28:28 +0530
Message-Id: <1cadaccf3728ce84d5d0af50a48ce8caaa29eb53.1598853505.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dev_pm_opp_attach_genpd() is called multiple times (once for each CPU
sharing the table), then it would result in unwanted behavior like
memory leak, attaching the domain multiple times, etc.

Handle that by checking and returning earlier if the domains are already
attached. Now that dev_pm_opp_detach_genpd() can get called multiple
times as well, we need to protect that too.

Note that the virtual device pointers aren't returned in this case, as
they may become unavailable to some callers during the middle of the
operation.

Reported-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 000d0fcb4680..e65174725a4d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1960,6 +1960,9 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 {
 	int index;
 
+	if (!opp_table->genpd_virt_devs)
+		return;
+
 	for (index = 0; index < opp_table->required_opp_count; index++) {
 		if (!opp_table->genpd_virt_devs[index])
 			continue;
@@ -2006,6 +2009,9 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 	if (IS_ERR(opp_table))
 		return opp_table;
 
+	if (opp_table->genpd_virt_devs)
+		return opp_table;
+
 	/*
 	 * If the genpd's OPP table isn't already initialized, parsing of the
 	 * required-opps fail for dev. We should retry this after genpd's OPP
-- 
2.25.0.rc1.19.g042ed3e048af

