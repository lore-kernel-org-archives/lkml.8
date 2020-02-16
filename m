Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B08C76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DCE20857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OecFXFWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBPRfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 12:35:18 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36207 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgBPRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 12:35:16 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so6166313pjb.1;
        Sun, 16 Feb 2020 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNTtBgVLy/qcKAejtYBYBKwDBWINtwQVadgcq2wXqcc=;
        b=OecFXFWn8mpigldvStNPoHEuXc6i76RtX1CJRWx0neN1mXT3cIGoQY5gMMzf0yW3UU
         6fvBb7QDc9gtMQ9bCgAsiRMRapW9YqBFIRMVg45SSoElJYSnaClN0oziimHxUq0Qrdzo
         KZpX4J3jAnetKAF4uP1Kva9szm/p38k8ivcSjgYcm4HX8ta85lEe+IM1RuIE690JcoKp
         EAsmYnvFpTPeMKSKQJITs06yp8jvq0+0rT14RJTh7jUGRJL/Nlop/xQNfNel13sWHuOw
         drjVawtXzz1I8V46Kz0SIg3NNp/hFh+kr4Yi8lFML3tyUTMt6aDce7MmA50ZSllKjb9N
         19Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNTtBgVLy/qcKAejtYBYBKwDBWINtwQVadgcq2wXqcc=;
        b=VzgW9l4FyCT66VJJaUjsECkoQRR8KNYXe9mH7ccFimwkH3XYi0CoDxsMFE7BpmMENq
         hmswElh2nBWgNtGoJ0JAXbKkxXGTWCbnuHT1pn8d0VTNSc0eBxIOGIOpxFyel6/pCk0p
         XlRKx0wcbf4GSqRRlGbUwmzQqZL8TNvv7c4M+FOnQZed64Np95H/DNkIg4WMznBZYnK2
         uVTkfc60FHAQjRWNLgXQMUNQwJJ8+TmknjRy2jXegqNtKudF/ChEswghxWyIH+4iUqRu
         eb+EN2kTW2AJ0zyfNfREgHa4Z31aqy1At3HpVOfGsq9nTsLAfwgD6KJrDYX4zgLnOVT4
         ZAzw==
X-Gm-Message-State: APjAAAVcSu57MiKnAEFXl9kI61Sr/eYoji+elIf/26TXa4MRAaBc3O89
        Y3fROPBPW3xdhuRislNPjEY=
X-Google-Smtp-Source: APXvYqwqpElMKUvJw6yaThb/Nsi0h1Fel6j7DMtb4gAkPuj7FWaplutLPwGDdfmJ3E9IUhvcpcc2/A==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr12487443pll.72.1581874515671;
        Sun, 16 Feb 2020 09:35:15 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.127])
        by smtp.gmail.com with ESMTPSA id a36sm14284724pga.32.2020.02.16.09.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 09:35:15 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv1 3/3] clk: meson: g12a: set cpu clock divider flags too CLK_IS_CRITICAL
Date:   Sun, 16 Feb 2020 17:34:46 +0000
Message-Id: <20200216173446.1823-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200216173446.1823-1-linux.amoon@gmail.com>
References: <20200216173446.1823-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Odroid N2 would fail to boot using microSD unless we set
cpu freq clk divider flags to CLK_IS_CRITICAL to avoid stalling of
cpu when booting, most likely because of PWM module linked to
the CPU for DVFS is getting disabled in between the late_init call,
so gaiting the clock source shuts down the power to the codes.
Setting clk divider flags to CLK_IS_CRITICAL help resolve the issue.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---

Following Neil's suggestion, I have prepared this patch.
https://patchwork.kernel.org/patch/11177441/#22964889
---
 drivers/clk/meson/g12a.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index d2760a021301..accae3695fe5 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -283,6 +283,7 @@ static struct clk_fixed_factor g12a_fclk_div2_div = {
 		.ops = &clk_fixed_factor_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_fixed_pll.hw },
 		.num_parents = 1,
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
@@ -681,7 +682,7 @@ static struct clk_regmap g12b_cpub_clk = {
 			&g12a_sys_pll.hw
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.25.0

