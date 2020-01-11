Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63079C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CBF206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDlO0IDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgAKP7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:59:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45661 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbgAKP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:59:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so4746851qkl.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 07:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BTewUQvHanfv4fZSXJWYXlMp1M1+mxVS9G9Ipk6ELlQ=;
        b=nDlO0IDO/0f+azAnHlojkW/cnYIpOn+cCXDQp4Nin6V/kogtybAFecbMDkySZWl4rU
         4PAxB56Yo+fV8ptpxmsiZ/LpYPgzeqL9cLTMJzbGe1p4Tp5R2OVBhKExnxeNrDAqM/RM
         mhMXs21TgSj7PjdoYCILJUZJcULte6sV7P0/vJBKiR+fLEONsbugZi9wJ+iDAl0lW+K4
         PTQQkE7VQES5F78kRuMAFYs13m70jHpsUPP9vOqOu8a+w3ZMUWKKe5JZc57Kg6DbyVZq
         fF+GB/XjysEDyNVAyQsOXt6AEiL8R7ZjOiw2WSvEHcDD4bH3gTi2Ao5iplrezDoXJD94
         DFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BTewUQvHanfv4fZSXJWYXlMp1M1+mxVS9G9Ipk6ELlQ=;
        b=G1g6igYe6zaeny56lINcnWlGNPDAUhyo+4FPUlidYwdb1OXTWF7Ot3HhXT6Y6OK/qd
         HX+gAp8WMfGWVZhGH/q0N+EvcVaqdBOpqLN73DT1fsl+di+jfx7U4vKz3XRagFPYTV8i
         y99/g3sW6wJk1nRMzc6o1l2fa69dX1qUr4GnyJwJ5LlR/vwgPbwt1SwAZCWHyO2gZ95e
         z5JrdSxUdxeQqJyGAeIFZIGzedznDghmY3r+g4z26t8ZsUU7uTo7XOu3X+DZh2I4AQ71
         ycyzJupXf7RyrPzE+gSFAI6wUzX8/uyFoAgoyj9QdNhVojUE48EaiEa6BwjoDAIAgoSf
         FG1w==
X-Gm-Message-State: APjAAAUk6kNfh+I3LXFG6FJbLR0iSK1LHj6vLtOWwje0JNl5BCyCaGpz
        Rji4YATjYCAmeHJGnuM/vFVHrg==
X-Google-Smtp-Source: APXvYqyJgaah0XC4D9DNCe9HRtrGyw364y+5VdE9nof8f1Vyli4SVkajgo7SDaoh+iIrHcMlCCYz7g==
X-Received: by 2002:a05:620a:548:: with SMTP id o8mr8763638qko.490.1578758356092;
        Sat, 11 Jan 2020 07:59:16 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id l49sm2843478qtk.7.2020.01.11.07.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Jan 2020 07:59:15 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v7 5/7] sched/fair: update cpu_capacity to reflect thermal pressure
Date:   Sat, 11 Jan 2020 10:59:04 -0500
Message-Id: <1578758346-507-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
References: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
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

v6->v7:
	Rewrote the patch description as per Ionela's suggestion.

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

