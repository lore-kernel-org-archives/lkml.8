Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7326CC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8C924672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+yNqQbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgANT5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:57:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36469 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgANT5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:57:53 -0500
Received: by mail-qt1-f194.google.com with SMTP id i13so13606818qtr.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLlwwEoUAm+IeVaQ5UGMBrKt+Sfrt78NBkP9mGdBcjE=;
        b=L+yNqQbM+LgHuYuCpsbdsM8Odt8JKYpxcCzUyIvfSSNeSBFwg0D7D2mO/RXGQksqt+
         DC7CQqVDe+drLGQSo/2o9vCoFQ5T5IxETjUPxm30xrj2ysQ9MuK7+1sG/KNnqQusgZj7
         hQK1lfzrmxMI8tPCWlnSQiLDmIYl5HPNt3FumzICaX/clE5rmQX1a0Syu236wOM2yXLM
         J5Mo8CjxhCrFEVj42kM6/i5sj5RXL5SNkd0+/VU3R0o0S+gQyAB8IXbMz6Wfr70XcRaj
         gTxvfCmZBtuN/knVlKYDW4AYWszMJVVe4qF08MqN2Pg3BwVNFtZKi/8LeNsqgbwNQ1MI
         MHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLlwwEoUAm+IeVaQ5UGMBrKt+Sfrt78NBkP9mGdBcjE=;
        b=j9z2FBmMsrYCeY2yPdmTnxsG1BuxuX/TkyPnbDW58WXGw/E6+9A1h2jl1Q2se3+eLc
         A+sXQaQh5OCRf1Yf1MlxLbGhUAyKJDfHtzcm8tRA6BDfMOykvPPUocwhKUnP+GNeGbA/
         DvGKgkjcoqV52M2jNbDBq7GSigW2Vmj10BSnjudCqPixIHZHqZd+M738Nb3jOGMGUi2K
         DL5n/QEaVIQX2CO7JkR4ZIauXOEc0/zkDd6hXo0BuADrZJ+mX2LR7lK/FaEkWNiKQ73w
         a1zc3DAroHTk/eWLU+4Pkyeg8qukqi1pdGTYEAt6XONsF5o7nACIlzworXvI2Wil3tCU
         prRg==
X-Gm-Message-State: APjAAAXW7+48jmkpKNnHPBfD/vXuJCJQjPsLPZ/VfC67QdByxf0xkGk5
        Q0iXMZR98QWjUvQSzU9Hea8B8Q==
X-Google-Smtp-Source: APXvYqwxtWnA5mVFeHofwFFybaJAOaX7c1zMQugI+nllpDZ10simKG8aofQrHpIqa6Scfh82bIMrHg==
X-Received: by 2002:ac8:769a:: with SMTP id g26mr237834qtr.259.1579031872251;
        Tue, 14 Jan 2020 11:57:52 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id b81sm7183497qkc.135.2020.01.14.11.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 11:57:51 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v8 5/7] sched/fair: update cpu_capacity to reflect thermal pressure
Date:   Tue, 14 Jan 2020 14:57:37 -0500
Message-Id: <1579031859-18692-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_capacity initially reflects the maximum possible capacity of a cpu.
Thermal pressure on a cpu means this maximum possible capacity is
unavailable due to thermal events. This patch subtracts the average thermal
pressure for a cpu from its maximum possible capacity so that cpu_capacity
reflects the actual maximum currently available capacity.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 311bb0b..2b1fec3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7733,8 +7733,15 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 	if (unlikely(irq >= max))
 		return 1;
 
+	/*
+	 * avg_rt.util avg and avg_dl.util track binary signals
+	 * (running and not running) with weights 0 and 1024 respectively.
+	 * avg_thermal.load_avg tracks thermal pressure and the weighted
+	 * average uses the actual delta max capacity(load).
+	 */
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
+	used += READ_ONCE(rq->avg_thermal.load_avg);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.1.4

