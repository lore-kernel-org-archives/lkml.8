Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B78CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D3820663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdxG8jLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgGOI1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgGOI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so1459823wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Z0fv79A73/vZIqM6ECnqpdpU/+7K2Y0w7fARWedt1c=;
        b=wdxG8jLedDYRfjs4gGzseOHpJxQaqy1oTFNhn/v43wZILfD7sUfWOlTF/WfpZ53GiT
         9oirELAFbfOr4p5MsvB+3S3+PtP7e/IqharXV5TfUubJv6rBsfC9LqbdjWCx3fsWArRs
         RN3YAggQmoJk6eGn/MiyEbYw3IQ0k4T1WmIM+5/iLbtAJYlKiflIyr5p2Jtis7DbFJlz
         l+3GYbFdxmaVQCDR3DqZ7fiLFedXA2147Ou9CguKQ4q7pNY/y7oT+rcs2qaXJju7JgkL
         YgJfJG1bNq9KJ6W7Mt551x+CpJvCFlviz24zy1H4Bb9SL4Xv68oacZ7TTVxXCoVhg5mE
         Af6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Z0fv79A73/vZIqM6ECnqpdpU/+7K2Y0w7fARWedt1c=;
        b=CKNEeRJ3yp/zTRABqsLpth45fT5OQuYtQOMLXIGhUAwv2IDSmVOrwzEDpXXWtfGYby
         1Bcxhv83i1IYMJ/pfTVqNhEitEhZWZtQiu21rhJbXQBxzI63uV7fr2E3WXLhkSgnBzsS
         od2sCcOYeFXyRSKnt+FKjp7VU8wDFbD04vZkl11zJ9TuIdySL4ouIFsav8z66Q+dUWp2
         gcyxztnGxu+80LKLXeTCKVRV+RvSQ8LXbr0nN+LYU7dL5lWCqi9m++EC9w507Uh7BbAN
         2e3iNESLpLNkK50n+Cw+jdVlbJb0oI4ISbo4G7x751+fFgNeLVsR6WGQ7cxlMP/ZxeEr
         9Ldg==
X-Gm-Message-State: AOAM532oo5ze88wXMppm7k6N1j7xV6/SY1h8NxEGhTeuJlLaEZoWsz4L
        x9fZn4xMle9KZVV12w8qvwq/bg==
X-Google-Smtp-Source: ABdhPJxYpuDnFCKTJN9z/Su7SsjnFEtm4WYtkojHvEEbT9vOYYaxPZnzu+/urdXDpBhf2vcZO8Fd6Q==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr10347220wrt.191.1594801606598;
        Wed, 15 Jul 2020 01:26:46 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/13] cpufreq: powernv-cpufreq: Fix a bunch of kerneldoc related issues
Date:   Wed, 15 Jul 2020 09:26:28 +0100
Message-Id: <20200715082634.3024816-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repair problems with formatting and missing attributes/parameters, and
demote header comments which do not meet the required standards
applicable to kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'last_lpstate_idx' not described in 'global_pstate_info'
 drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'last_gpstate_idx' not described in 'global_pstate_info'
 drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'policy' not described in 'global_pstate_info'
 drivers/cpufreq/powernv-cpufreq.c:182: warning: Function parameter or member 'i' not described in 'idx_to_pstate'
 drivers/cpufreq/powernv-cpufreq.c:201: warning: Function parameter or member 'pstate' not described in 'pstate_to_idx'
 drivers/cpufreq/powernv-cpufreq.c:670: warning: Function parameter or member 't' not described in 'gpstate_timer_handler'
 drivers/cpufreq/powernv-cpufreq.c:670: warning: Excess function parameter 'data' description in 'gpstate_timer_handler'

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 068cc53abe320..2e5a8b8a4abaa 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -64,13 +64,14 @@
  *				highest_lpstate_idx
  * @last_sampled_time:		Time from boot in ms when global pstates were
  *				last set
- * @last_lpstate_idx,		Last set value of local pstate and global
- * last_gpstate_idx		pstate in terms of cpufreq table index
+ * @last_lpstate_idx:		Last set value of local pstate and global
+ * @last_gpstate_idx:		pstate in terms of cpufreq table index
  * @timer:			Is used for ramping down if cpu goes idle for
  *				a long time with global pstate held high
  * @gpstate_lock:		A spinlock to maintain synchronization between
  *				routines called by the timer handler and
  *				governer's target_index calls
+ * @policy:			Associated CPUFreq policy
  */
 struct global_pstate_info {
 	int highest_lpstate_idx;
@@ -170,7 +171,7 @@ static inline u8 extract_pstate(u64 pmsr_val, unsigned int shift)
 
 /* Use following functions for conversions between pstate_id and index */
 
-/**
+/*
  * idx_to_pstate : Returns the pstate id corresponding to the
  *		   frequency in the cpufreq frequency table
  *		   powernv_freqs indexed by @i.
@@ -188,7 +189,7 @@ static inline u8 idx_to_pstate(unsigned int i)
 	return powernv_freqs[i].driver_data;
 }
 
-/**
+/*
  * pstate_to_idx : Returns the index in the cpufreq frequencytable
  *		   powernv_freqs for the frequency whose corresponding
  *		   pstate id is @pstate.
@@ -660,7 +661,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
 /**
  * gpstate_timer_handler
  *
- * @data: pointer to cpufreq_policy on which timer was queued
+ * @t: Timer context used to fetch global pstate info struct
  *
  * This handler brings down the global pstate closer to the local pstate
  * according quadratic equation. Queues a new timer if it is still not equal
-- 
2.25.1

