Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48863C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174A022CBE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263171;
	bh=GpWsUwAiIxAmSdNkfAV+/g4Oc5D3gZ30oJese6yzi6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F1davezr1XF9I+DrxdaE+r/4cQ8YBGBwlPNUAu2Qe7lKqSO6okXaTHWcfEsTX5B7t
	 V9QMiiJQwIE8EDqrfzKFxpCtxRPW35ikcr8to0qplnnOwRQnLKc1UyYP5ihvw6ZY4p
	 r+qrtVzw85yWvDmfjde7b7KdOVcMf1m8Ip0DNbfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgGTQj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbgGTPtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:49:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC11622D0A;
        Mon, 20 Jul 2020 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260158;
        bh=GpWsUwAiIxAmSdNkfAV+/g4Oc5D3gZ30oJese6yzi6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4QtA7P8pFnEpHxmH/fbUs30Ds3XMTS6QWXAwwfc2YJ/Vm6yiZ0JUakSU3+4L0xuS
         QRPHuo796DUSydjI19h4VOuUOvvRWPf7fOHfE3nRxbYfj8bC1K9yK15L9Ph2ahX1mw
         zosflom/0NK9mF/25cFxj8KFQRCWDjwpanvCPB+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finley Xiao <finley.xiao@rock-chips.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4.14 120/125] thermal/drivers/cpufreq_cooling: Fix wrong frequency converted from power
Date:   Mon, 20 Jul 2020 17:37:39 +0200
Message-Id: <20200720152808.841224489@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

commit 371a3bc79c11b707d7a1b7a2c938dc3cc042fffb upstream.

The function cpu_power_to_freq is used to find a frequency and set the
cooling device to consume at most the power to be converted. For example,
if the power to be converted is 80mW, and the em table is as follow.
struct em_cap_state table[] = {
	/* KHz     mW */
	{ 1008000, 36, 0 },
	{ 1200000, 49, 0 },
	{ 1296000, 59, 0 },
	{ 1416000, 72, 0 },
	{ 1512000, 86, 0 },
};
The target frequency should be 1416000KHz, not 1512000KHz.

Fixes: 349d39dc5739 ("thermal: cpu_cooling: merge frequency and power tables")
Cc: <stable@vger.kernel.org> # v4.13+
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200619090825.32747-1-finley.xiao@rock-chips.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/cpu_cooling.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -280,11 +280,11 @@ static u32 cpu_power_to_freq(struct cpuf
 	int i;
 	struct freq_table *freq_table = cpufreq_cdev->freq_table;
 
-	for (i = 1; i <= cpufreq_cdev->max_level; i++)
-		if (power > freq_table[i].power)
+	for (i = 0; i < cpufreq_cdev->max_level; i++)
+		if (power >= freq_table[i].power)
 			break;
 
-	return freq_table[i - 1].frequency;
+	return freq_table[i].frequency;
 }
 
 /**


