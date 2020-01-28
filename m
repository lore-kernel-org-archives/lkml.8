Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A818FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74144214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIFyqNey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgA1WgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:36:18 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40386 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA1WgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:36:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id t204so14308246qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ui1UWT3XjxwsXbc5J4SYo0+lZb6l6gnf1hsDYBb+xTU=;
        b=RIFyqNeyENx3gs0XeWvwMQ5TNNdekuGpAh1VBDTfU9ksAQTobsNMw2UMCL16Ie66Om
         XhqSXSTGsPVICohM/Ky4thuacKwfkgTvtPMS42plqvLnujJGSRjt99dkTY3SetqnAhh2
         LGxbaiEKd21FxCMfNFZEaWAOvHbWoJMaEm7CJDZ9T6yP8i3JGabcAaQz581Bm+sJjBSk
         8VafQd3JN/GN9O3v/Vpx7jS+ce7MCl/QJcgJLa2DJPS1gPnm8hAeAeMVy2HDkqSSGmqB
         k1eUS/Eq8YXzOpefndwjj7lbhAwbOxAdo3acCvjovYjq+oh/wsv0zkg19a/cnQzGfVjY
         e4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ui1UWT3XjxwsXbc5J4SYo0+lZb6l6gnf1hsDYBb+xTU=;
        b=P5//LSfJIKqKZg6aODt4Ex7gTcWSko+09fcvNGBs9W4lKSf8ikahMEJSIui8oDefbZ
         jy8FLtNBS4Ndx2UC3A7DZTA0eXOmQTLzcPtcUG2K35THgzlVCzaFR3yKp+HU4waeq7qr
         g9FlUU9RipQKSw9ZJgNacOCoSgt747EYHqAeb+SUup3PREhHYIt/mlHoCIlVe9/aht/J
         VAI0pWTG4e9yW3TINnnIg1oZnEnEPuYAxwMJ2W88WTXZOHvLU4dihRXc12AhxSDjgZjy
         4ZxUEjQWY8XbbEixaqdm6homLTc2maXrn0/83hiWd9SAZHeP4rxfiARKlfLUpYfkfnDV
         58lg==
X-Gm-Message-State: APjAAAUaL3N9KnMCLvajQvAXL/zBeqaCzhOmuRVDKJJ6Jz+ilK33tOiA
        Sn3jy5BVAQvc/80ucB5rJCYi9w==
X-Google-Smtp-Source: APXvYqyJ0GoF1Q0RI4HzDryS3Sgw+YzjiHO3vdNmSfNUxlnU2cd/sIdXHrYb2Tdvu4rtWovM+CVo6A==
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr23066628qkg.489.1580250973279;
        Tue, 28 Jan 2020 14:36:13 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 124sm13014259qko.11.2020.01.28.14.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 14:36:12 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v9 2/8] sched/topology: Add hook to read per cpu thermal pressure.
Date:   Tue, 28 Jan 2020 17:36:01 -0500
Message-Id: <1580250967-4386-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce arch_cpu_thermal_pressure to retrieve per cpu thermal
pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v6->v7:
	- Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
	  as per review comments from Peter, Dietmar and Ionela.

 include/linux/sched/topology.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index f341163..850b3bf 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -225,6 +225,14 @@ unsigned long arch_scale_cpu_capacity(int cpu)
 }
 #endif
 
+#ifndef arch_cpu_thermal_pressure
+static __always_inline
+unsigned long arch_cpu_thermal_pressure(int cpu)
+{
+	return 0;
+}
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
-- 
2.1.4

