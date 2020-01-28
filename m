Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB59FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CDE2468E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220666;
	bh=hfMSIEhrEdw1IN71cdDTkdMr00ySuylu7hx2F/qVbAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/y33Nno4U373zn9b3aqrKtwGz4MCwgDYBTVkcnmavzJ0in+1DT+JW0UcYmEO7ltV
	 GtQ7D/sufGvsSfxkKNSf2FTA0C/mR0A9dvk9Njptb6ZIlre6NY8KSwZ5/t1icYVpmt
	 bwhiU2fY5R6/xbQ8/nCDzoa0F3EvihLzpiXFWQGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgA1OLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgA1OK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:10:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1FD2468E;
        Tue, 28 Jan 2020 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220657;
        bh=hfMSIEhrEdw1IN71cdDTkdMr00ySuylu7hx2F/qVbAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyLm4GRT0f0IEOYrzWe6u/kor5g6kS48DAvry7gnASpgthg3Re2vEktnkbQeggJHA
         0t01PC8TTv4kHSJIYMIEufQurO6RLwMn3ariFmmgPgNAfSLk17uQ6J2GVV9yp8rNkK
         VXKpJclgm424JrUqWXqSbc/pczyJ+1bzTGuVTlqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 094/183] thermal: cpu_cooling: Actually trace CPU load in thermal_power_cpu_get_power
Date:   Tue, 28 Jan 2020 15:05:13 +0100
Message-Id: <20200128135839.487789507@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

[ Upstream commit bf45ac18b78038e43af3c1a273cae4ab5704d2ce ]

The CPU load values passed to the thermal_power_cpu_get_power
tracepoint are zero for all CPUs, unless, unless the
thermal_power_cpu_limit tracepoint is enabled too:

  irq/41-rockchip-98    [000] ....   290.972410: thermal_power_cpu_get_power:
  cpus=0000000f freq=1800000 load={{0x0,0x0,0x0,0x0}} dynamic_power=4815

vs

  irq/41-rockchip-96    [000] ....    95.773585: thermal_power_cpu_get_power:
  cpus=0000000f freq=1800000 load={{0x56,0x64,0x64,0x5e}} dynamic_power=4959
  irq/41-rockchip-96    [000] ....    95.773596: thermal_power_cpu_limit:
  cpus=0000000f freq=408000 cdev_state=10 power=416

There seems to be no good reason for omitting the CPU load information
depending on another tracepoint. My guess is that the intention was to
check whether thermal_power_cpu_get_power is (still) enabled, however
'load_cpu != NULL' already indicates that it was at least enabled when
cpufreq_get_requested_power() was entered, there seems little gain
from omitting the assignment if the tracepoint was just disabled, so
just remove the check.

Fixes: 6828a4711f99 ("thermal: add trace events to the power allocator governor")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Javi Merino <javi.merino@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 87d87ac1c8a04..96567b4a4f201 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -607,7 +607,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 			load = 0;
 
 		total_load += load;
-		if (trace_thermal_power_cpu_limit_enabled() && load_cpu)
+		if (load_cpu)
 			load_cpu[i] = load;
 
 		i++;
-- 
2.20.1



