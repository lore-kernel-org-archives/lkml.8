Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44CCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773422073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGQZOGqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgE0Wr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgE0WrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:47:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D2C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u6so1129016ybo.18
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uaO5q9pQaTKgJe9+MaWFZJcIfvBVER7QDMhUyzQaTsA=;
        b=QGQZOGqPrpupB3Vp5Ef4HrGXuY4cHKgDlnXhudD88I4lnYaYraUMccM1rB+egyoBwY
         jn5dh4ZGyIOoC9cbyIPz96TyUcoM4MCn4PBgKi4X7wsWqWfsDcYvQ0nyDVc7tA1nBDvQ
         rKR9vd61VOZF3jsWwWdX/QNBxCnBRkrgUN1PK1Sn6mC5l4nFILTmNtKCfzptAk8alP9y
         FisfjA8ffax2sqzrmxGfIwh6bAhSfWzz/t+CRdOg9d+tO2obmW/yTOVBcqCu5QLepq3z
         CGjdllfjTxHLygf9Y3nf/3q8tuZV23pKo+FpvwbQLv8YpbtwhyHnLfhR9yP7dTxeZMJL
         9shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uaO5q9pQaTKgJe9+MaWFZJcIfvBVER7QDMhUyzQaTsA=;
        b=ZgV282BtGpyuM8V1Og+ANZyikxNhYR3KlD4J2bB5JsoFxQFWqVbefkq8VeGXZLsHFx
         Aaj6JiHj8V0MVcfqwVZv19fB9ty9RmuCm99puRFG4P940IAiDQz/teDe13raDPUak9Um
         K/elejQGT2I227984ZVvpxexbF9/ic461TIcp8A2AsqNW8i3m1zFDZCghNTi+ioDhh2l
         QbqjM2bMY3bqi+0Y+3mfrVL4QcgsuvRdKAqHY8+f0Es/IOcTv6zHAQZlJeysaBhb0p0R
         IVL5qfnL66aizUwyNlx8t4Gu34pSsnPwaQzeC7KCxMseHIx4JM0Sugi1ghmSSwNxMzIQ
         JEqw==
X-Gm-Message-State: AOAM533uhsnk8+Hfhg5CAvDML1/zKpt95PP+3OU4jCTQXERfksDRCCq7
        ybaVNa5+neB1l5m2nT+laYaXZsy6TCfDwr+VEYNKIQidrfr4lPPAxnNpLlfetlO1ISqRty0a79/
        YrxaT23sHDLMn1t1vIJrxyMW2eK9BXEavuxUlND7B2R8xUx7JgiHfsfVI3g+zVFDI0/FFwSl7
X-Google-Smtp-Source: ABdhPJwXL2hxpvnqkAu2gn3sIOOy1ci5pKJ+ZEBo5kAjt8MvF6xde14ZaMNyZ6HexAnAui46BrSDtx8Nhs5K
X-Received: by 2002:a25:60c4:: with SMTP id u187mr715831ybb.509.1590619636693;
 Wed, 27 May 2020 15:47:16 -0700 (PDT)
Date:   Wed, 27 May 2020 15:46:58 -0700
In-Reply-To: <20200527224659.206129-1-eranian@google.com>
Message-Id: <20200527224659.206129-5-eranian@google.com>
Mime-Version: 1.0
References: <20200527224659.206129-1-eranian@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 4/5] perf/x86/rapl: make perf_probe_msr() more robust and flexible
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies perf_probe_msr() by allowing passing of
struct perf_msr array where some entries are not populated, i.e.,
they have either an msr address of 0 or no attribute_group pointer.
This helps with certain call paths, e.g., RAPL.

In case the grp is NULL, the default sysfs visibility rule
applies which is to make the group visible. Without the patch,
you would get a kernel crash with a NULL group.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/probe.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
index c2ede2f3b2770..34ee0ee60ace8 100644
--- a/arch/x86/events/probe.c
+++ b/arch/x86/events/probe.c
@@ -10,6 +10,11 @@ not_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return 0;
 }
 
+/*
+ * accepts msr[] array with non populated entries as long as either
+ * msr[i].msr is 0 or msr[i].grp is NULL. Note that the default sysfs
+ * visibility is visible when group->is_visible callback is set.
+ */
 unsigned long
 perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 {
@@ -24,8 +29,16 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 		if (!msr[bit].no_check) {
 			struct attribute_group *grp = msr[bit].grp;
 
+			/* skip entry with no group */
+			if (!grp)
+				continue;
+
 			grp->is_visible = not_visible;
 
+			/* skip unpopulated entry */
+			if (!msr[bit].msr)
+				continue;
+
 			if (msr[bit].test && !msr[bit].test(bit, data))
 				continue;
 			/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
-- 
2.27.0.rc0.183.gde8f92d652-goog

