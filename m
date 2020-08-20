Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064DEC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA6920724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vU9PtiBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbgHTKps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731913AbgHTKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:44:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD4C061343
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:44:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k18so824436pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=haHH6xEEDXJD3ODlka0BS0C5wOsHmEx6Ewo0XdB15Uc=;
        b=vU9PtiBP/HMww5OYiXpQ2L/p3G067TEgmGB7o6dGutqO8yILjlrEn53ex/u3faTp52
         ThF1jzECs2i+5ZuE8HPnXkwi1aAQCfu6hJ3ejTDZJCHMwWvI24LXzKm7M6x0ciFr72wP
         OeCydEUBElA1g0WqGWGlncp53UuL1I87DeVH1eZFO72pv0o51t5tbD5Q6MeBqYVUD+H7
         Jd5mg7xLagn5+maXyf+J/zdNvyHv4YKZBrHEpAQcZq2SVRJ1twUFTsCOBkh1s5BEXekM
         oMqeaBRysQ0+4BQkjjfkXpTamNlPKKFFx49eG0LPOFE31HjXMu1q2lb/0yvVUnWmuvi1
         GQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=haHH6xEEDXJD3ODlka0BS0C5wOsHmEx6Ewo0XdB15Uc=;
        b=D3ebi8Ej7bP/G9Fdz1Y2KZDD7h1us9UfYsM0gKmonbe8ax3gOCEyAfH5QPq7lub60y
         +SyBxomgM5She0RMX0PhncqruH1JUjK2AWEl9erWA8RFZ3Xx/OOT8YHopcFLokoKw5rZ
         MXS3zGuAereS3j3Y3a9Ceq1WzIU+JsVTI04N/JZXoHiWpsxyo3gqI9VaBn8cL8su2mxT
         NoHTXQryguiH8c32gVbaIcukqP0DdFWrnw77qArmkAtHmDBednyaKLJuMGbIbh0mnRME
         IngRNGr3jiw2j75N3FTvhjklc2Ck5uufN53SssJ2GGAoUDVcyLVZHRTFuIHTreY8KZcA
         g1gg==
X-Gm-Message-State: AOAM533vSovlvlUgjdlk3B8rN8uLySMtOHR9l956lgJoxYE8jahFgmbl
        7V6fYaEB2n9yu51PojrG0PWelA==
X-Google-Smtp-Source: ABdhPJwv7H3K1Z9BH0dMOP+jy6GalrbBJ8Rh28BkScE3yXgCSBp3BcAdC3SvV+YLonsYVB8/uNM5hg==
X-Received: by 2002:a05:6a00:847:: with SMTP id q7mr1769819pfk.172.1597920279519;
        Thu, 20 Aug 2020 03:44:39 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id s125sm2338382pfb.125.2020.08.20.03.44.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:44:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] qcom-geni-se: remove has_opp_table
Date:   Thu, 20 Aug 2020 16:13:57 +0530
Message-Id: <4e27260253fdda236562f8bed9ec30a75e03f97c.1597919647.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597919647.git.viresh.kumar@linaro.org>
References: <cover.1597919647.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

has_opp_table isn't used anymore, remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/qcom-geni-se.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index 8f385fbe5a0e..02d1417c8ecf 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -48,7 +48,6 @@ struct geni_icc_path {
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
  * @opp_table:		Pointer to the OPP table
- * @has_opp_table:	Specifies if the SE has an OPP table
  */
 struct geni_se {
 	void __iomem *base;
@@ -59,7 +58,6 @@ struct geni_se {
 	unsigned long *clk_perf_tbl;
 	struct geni_icc_path icc_paths[3];
 	struct opp_table *opp_table;
-	bool has_opp_table;
 };
 
 /* Common SE registers */
-- 
2.25.0.rc1.19.g042ed3e048af

