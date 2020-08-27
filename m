Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E9C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B6620786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEail3GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgH0FY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgH0FYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:24:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81168C061240
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:24:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so2510847pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhfHAFDbpQiI2qmNMkVR2Ozx/52piMfWpn81D9slgEk=;
        b=iEail3GAFJeMcRamyGcoOWimiwBP3351QoCwb550QfDEmueo2f5Up1cP1aRZpsUxf5
         knnL3BCvhCPLy7nj8b/R1U4aMJ7HBRUl+aTWqz5FnjPBfekU6WrUyK0MZA7A8xNOF/Yu
         3IOVZwTyff0eyOVo6JvUObWBRPKo9RAcQwytJQkYkIe8OK67mP3l8IxypnMDoNY5x6uO
         XD6MGAcFXCi5qmTbZ6XHFMTimoDaRAU0bG3FW7RmCIZMUn3LO6BOQmP2XtpircSXOnKY
         0j4KYNtc/e3Ob+HE/6MSRrdeTrlOKWgM5tMKAlIGg8EWaHr+EZ4oYCEjM5GnKHXcYVqk
         jg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhfHAFDbpQiI2qmNMkVR2Ozx/52piMfWpn81D9slgEk=;
        b=fDcMIaVGhYRTuMMOfJRX2OfH5J4oIcS2dGXGUilQ3D8PC+6jXT/j17SIFxhwLIi9aV
         iMN55r5UTGiDlopCuFi178EFWIR6CLab+CdGQahtshwLh8eQlNgh6Q8c+4N0WTIYmKbC
         P/1NeqGOX1tovkFSeHDv5aOASpYBIOl0DcmBQOaHFql+FX9PjCZrrTZtV1TuJ5AInMdF
         k+KZ6IXvBkprCocKDX/ue2wHsy/P7hqz30TPm286wCCx4rHLVmn8nyENLe7rBknnY1Nv
         AikPePbUuUSPBoxe7q8Da/BBL6IZHpPcC2alTS60kbkUtJBh0R3XTe1IIecjeBa+P4oC
         Rc2g==
X-Gm-Message-State: AOAM533TqKep9yk9ey2Q+tazV8ipkLqqm37N59BKOoa/g9EVtxCueDbR
        mfmA0XL/4QK9V6C2T6f/hnEuow==
X-Google-Smtp-Source: ABdhPJxrEHCOAV1jiwJkVH1zcYuRU1n8rhjP1ZFhV6JBrsua33uDfI/zAOkLzeaURCgsy40vctLedw==
X-Received: by 2002:a63:4144:: with SMTP id o65mr13004377pga.8.1598505865037;
        Wed, 26 Aug 2020 22:24:25 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id j14sm777047pgj.3.2020.08.26.22.24.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 22:24:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: Do WARN() for invalid relation
Date:   Thu, 27 Aug 2020 10:54:16 +0530
Message-Id: <1c643a64707d889e0ccab641df78c7a620325697.1598505843.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <906198d77aa73613a1b588425aa45e5025ee60cb.1598505843.git.viresh.kumar@linaro.org>
References: <906198d77aa73613a1b588425aa45e5025ee60cb.1598505843.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relation can't be invalid here, if it is just WARN() and return 0.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 8f141d4c859c..a911e5d06845 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -956,8 +956,8 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 	case CPUFREQ_RELATION_C:
 		return cpufreq_table_find_index_c(policy, target_freq);
 	default:
-		pr_err("%s: Invalid relation: %d\n", __func__, relation);
-		return -EINVAL;
+		WARN_ON_ONCE(1);
+		return 0;
 	}
 }
 
-- 
2.25.0.rc1.19.g042ed3e048af

