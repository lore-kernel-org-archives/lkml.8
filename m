Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5FC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2812724672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4ZkRTKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgANT5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:57:52 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44451 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgANT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:57:46 -0500
Received: by mail-qv1-f68.google.com with SMTP id n8so6260823qvg.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=loHHHS6V4PQc7Kof40yPX25pxix99gLrH/VUREm5tXI=;
        b=p4ZkRTKJulQfgPDkvEIxmKubrz472Dr5NTI5HlB7LYQ6604xHHnLTcEMYGhLoKjsr2
         ka1AbeV68kBI3xAZmU/5Hi3t/ReWXEZwzWiFSgl81IMCnB2uctFS9qzDhAE5lwDERYT4
         C1XDtFbAKhNdzZkY1AgYuUdynQGd7pl/zQ3Z5ZypuIYWnSw+oPvywMcVto1al1adhfZh
         K41XiCcDwByHOVFloWmhuSzgKcHIMK3Y5ooS92eFPayXhLazgCzNqsFsd2CH2f0H/jZY
         F8rxMrNoaBzZvy315OKAAEBj5l/w313S1L8sPcI5pBYh4sc1dyzNMvm2KkSkTxTyMfvj
         9Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=loHHHS6V4PQc7Kof40yPX25pxix99gLrH/VUREm5tXI=;
        b=L4U/ZdG3TGchOyuvMOakDRwcBeTuE6txJfjy15xvMELs4Q9s5uZ0UVtYOX/S9so+Vn
         qbLEVxiyvL7BttKz+0tI3mWwfwGKg1sMj9j9jqN45U16QbObodk+JM7aEg+121gIDXFE
         rh/h9Zp5goyNbqv0oYN2DFXjFyA1Sj6E8OL9SJbO1qwir7rBBAjgvCwlQ4YadOMbY7UV
         gtAx7u1Vv/LWmKTXXw9eAjSElukNcTRzr4mnz8t0W/cWUzTHmI1BIs5GaqS7NJYbjpG2
         /1nPxkCQpFZukP9ftsoh29YHag+0RVBKNbMcFJ0iuRmBEaRkmB+HVsDflr7c3+phaXBG
         5MBw==
X-Gm-Message-State: APjAAAWV9dDy7mvYKpVPffDAB4NTze1U5R1zmvWCcjE41T0zPTrLn3D5
        EaDH/TP7kkXjO5jG7eSZSJiXYg==
X-Google-Smtp-Source: APXvYqxcCIDEkJskRq7s63gbOAYytQGDsu95rgwhHcv1jUSzQGPqCKtSzE5sOjFTTwVSbHZsoy2dQA==
X-Received: by 2002:a0c:8bd2:: with SMTP id a18mr22177922qvc.38.1579031865881;
        Tue, 14 Jan 2020 11:57:45 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id b81sm7183497qkc.135.2020.01.14.11.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 11:57:45 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v8 2/7] sched/topology: Add hook to read per cpu thermal pressure.
Date:   Tue, 14 Jan 2020 14:57:34 -0500
Message-Id: <1579031859-18692-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce arch_cpu_thermal_pressure to retrieve per cpu thermal
pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 include/linux/sched/topology.h | 8 ++++++++
 1 file changed, 8 insertions(+)

v6->v7:
	- Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
	  as per review comments from Peter, Dietmar and Ionela.

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

