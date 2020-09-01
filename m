Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCEDC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885FB2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tk/7VJW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgIAK1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:27:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0446C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 03:27:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so526972pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpn9D/5jf8Cl22DmcPIsP0D+8jPdGfJ5t9xD++zoV1Y=;
        b=tk/7VJW1f+B+d95M0Sy7avts3U1k6DUjgFMhJuU1znFnZ+74BtL+25cGrXcRehXyX+
         3oBs28+vr+MiH7bp1nKwcRuK8fqq5HZoZ5aUojM2/4bF4Hh8aoNHubPGlMZkEzr/AHtH
         N3eISZ78fEOZPQbtjjLM59p97evtmvWwMieOYQrQEM1bwxPogJq8m3n0s3axUTkMAV0i
         GI82DiLS2enBEh4KJKTnyRljMFBHIp5jb68ZrDBBUGiQKCpDXJJfX0aDMqJ51+ITJY8n
         I8BSLwfr9A1aYCOKzMMYtB3GueAvRNZR26g8vI0/IrMknt4YGwkg6xq+8VJET5ea/vT1
         bnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpn9D/5jf8Cl22DmcPIsP0D+8jPdGfJ5t9xD++zoV1Y=;
        b=uOXZXBMG8sdzQdbNQXKd2JsMepi3t+SzbffyvKQi++nOztJelpjsVVimzRazRGZxKc
         8Tfk/A9GuU8YwYfrA64PW42risRzpxuZiUH6pTPqWqOJ6COf+4F/j1lmntwqlTd1FeQ4
         X/iuNs6ihIHz7x0PAl5jgGwNSKNaCmwEhzlfuyslBOj59RbkEarNSSGAu97YgTvLVQCh
         WZ5++21WSOp8aM6jfwvITdFI57/k1cqqdrwDDdzbh2wbc4UtFEbyYeUOJWPKcr0zckro
         WYmwG3506tlP+t9auYx6effrVPaM+jbqJ7zbqZxl8C5OFSaYKuHGa98V74ZsFTDTed7o
         xu7A==
X-Gm-Message-State: AOAM530ihejl3o/6E8TMFOqz2IbmjyWVBLeankLfRxwueiH4f+VYJsQ2
        Ox9ZozAhqS7TNHakqbP//MLdUw==
X-Google-Smtp-Source: ABdhPJyAoTXZaC+iT5BOYZfnb359nfLCt/TY8um+EGWfET2XBrG/hBr5Oh1T2GiOkJ2tbRfhoWcYGQ==
X-Received: by 2002:a63:4401:: with SMTP id r1mr881229pga.331.1598956046238;
        Tue, 01 Sep 2020 03:27:26 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id h11sm1419135pfq.101.2020.09.01.03.27.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 03:27:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, stephan@gerhold.net,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1()
Date:   Tue,  1 Sep 2020 15:57:18 +0530
Message-Id: <99f1c7ff37b00d2f59fbce9d934abf23932363c5.1598956021.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now for V1 OPP bindings we used to call
dev_pm_opp_of_cpumask_add_table() first and then
dev_pm_opp_set_sharing_cpus() in the cpufreq-dt driver.

A later patch will though update the cpufreq-dt driver to optimize the
code a bit and we will call dev_pm_opp_set_sharing_cpus() first followed
by dev_pm_opp_of_cpumask_add_table(), which doesn't work well today as
it tries to re parse the OPP entries. This should work nevertheless for
V1 bindings as the same works for V2 bindings.

Adapt the same approach from V2 bindings and fix this.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index d8b623cc015a..6fc56660fa52 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -886,6 +886,16 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 	const __be32 *val;
 	int nr, ret = 0;
 
+	mutex_lock(&opp_table->lock);
+	if (opp_table->parsed_static_opps) {
+		opp_table->parsed_static_opps++;
+		mutex_unlock(&opp_table->lock);
+		return 0;
+	}
+
+	opp_table->parsed_static_opps = 1;
+	mutex_unlock(&opp_table->lock);
+
 	prop = of_find_property(dev->of_node, "operating-points", NULL);
 	if (!prop)
 		return -ENODEV;
@@ -902,10 +912,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		return -EINVAL;
 	}
 
-	mutex_lock(&opp_table->lock);
-	opp_table->parsed_static_opps = 1;
-	mutex_unlock(&opp_table->lock);
-
 	val = prop->value;
 	while (nr) {
 		unsigned long freq = be32_to_cpup(val++) * 1000;
-- 
2.25.0.rc1.19.g042ed3e048af

