Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0277F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460957;
	bh=trqBGPQbqfOahUjOmNy/Euz9Ak35WCTNc+E8HyC4ktw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7kHeY5GDtGQIaG/7jZ2teDqJApIVNxXapvESVJJbsUgYQ1+7i39FwajQY4oQ2FTW
	 tcn+LYqf+U4qbXj1rhMrNbJhfz7o6YrgAjJqGoYCL0kZMWeoAGGMbZOpl8iD1AYPFN
	 jK7VCl5my6fxOeOm265/e5XASiUAWJ7CXCJAzHTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbgF2UCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbgF2UC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:02:27 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E3BC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:02:27 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id m38so114342ool.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OH0rNBT9W84o9wS9VyW5dxui8DUCwiqdXYynayWRkhE=;
        b=gyfjAP1QH+9K8XAonMYDiORbrREk2hnAYmMygagJYnS/PeSTeo/N58LOXYMLWUahyG
         XVe20skhr9p6H53LmgIF8g0gvy6EN2HG3F6zTTW/6eQ4G5uHJSWsA1z4oExHLiRBxtfh
         sqIRG2ev1wRpRxVl5JxU+XKTd+loVqFw1rP8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OH0rNBT9W84o9wS9VyW5dxui8DUCwiqdXYynayWRkhE=;
        b=Nc4atyDtwv0+ar/6HpJ/Tl9TIlaGx5enGSGFzzksCb8g8ey8nwdwvqJO7nTGXG1pnk
         DjjrhoXSVYEW9ttMzXBOJLdkTMuDTXKjRtoEU3YhEeq8i3pWd0AOvUTaiI1w2nP5jzX/
         reuqoqjhpdqw+Grd9a4iaLRuKXMJvrQY44CQEQLf7NC/N3oh3BsHvvPEpnrfIFCb/uPl
         03SN4G66j+Rs3B2pc9unA2O7rMUAGKNNQXKx/mmsWA9Kg4TKjyTvNc0k8pMKufKy54hE
         gmbG6KHSdnkHjWCahaUo+OCkgQT1VQnfWxZNKKcfRsn7hZf33wNjlLFrW2vb+c0AU0mz
         u5tg==
X-Gm-Message-State: AOAM533cHM5movVYNnIQf06xSC883mlhTYK5v8xQIc9q8FD5J2q0C7Ku
        ZwIl47UmWQrSD/3N0dX6u1Nm8Q==
X-Google-Smtp-Source: ABdhPJzhXyOuVOdh8wAFssxnqlQ8dPjp+s+W0dbcr5Y+R9um/gLKAFxVscQBA7dUfd8gQbfYxG8Tzg==
X-Received: by 2002:a4a:2259:: with SMTP id z25mr14954165ooe.29.1593460947269;
        Mon, 29 Jun 2020 13:02:27 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p73sm213895oop.36.2020.06.29.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:02:26 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     trenn@suse.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: Fix NULL but dereferenced coccicheck errors
Date:   Mon, 29 Jun 2020 14:02:23 -0600
Message-Id: <20200629200223.27322-2-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629200223.27322-1-skhan@linuxfoundation.org>
References: <20200629200223.27322-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL but dereferenced coccicheck errors found by:

make coccicheck MODE=report M=tools/power/cpupower

tools/power/cpupower/lib/cpufreq.c:384:19-23: ERROR: first is NULL but dereferenced.
tools/power/cpupower/lib/cpufreq.c:440:19-23: ERROR: first is NULL but dereferenced.
tools/power/cpupower/lib/cpufreq.c:308:19-23: ERROR: first is NULL but dereferenced.
tools/power/cpupower/lib/cpufreq.c:753:19-23: ERROR: first is NULL but dereferenced.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/lib/cpufreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 6e04304560ca..c3b56db8b921 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -285,7 +285,7 @@ struct cpufreq_available_governors *cpufreq_get_available_governors(unsigned
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -362,7 +362,7 @@ struct cpufreq_available_frequencies
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -418,7 +418,7 @@ struct cpufreq_available_frequencies
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -493,7 +493,7 @@ static struct cpufreq_affected_cpus *sysfs_get_cpu_list(unsigned int cpu,
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -726,7 +726,7 @@ struct cpufreq_stats *cpufreq_get_stats(unsigned int cpu,
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
-- 
2.25.1

