Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAD1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B618E208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMTDeSA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgE0WrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE0WrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:47:16 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DAC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:15 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k35so6114911qva.18
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4rgQHj0e4rf2gKwkFZaKemGDRL0W5vamS2+zR9c8gWM=;
        b=BMTDeSA5xRUXFpTQeoVkWY8C3uEkAEVow71OZ5ZnEDkAQL0nigc+V/hKtAsFLAXavH
         dgfjcMQBVB/x/01JXMj8XJHgorNibQ7JATwBvagi9tMqGdS9pq3tMRozJarFqj7GXZH+
         T3uCGY8lCBMevwGjz5QShJ3VHPgx47cOSK3DehkYFY/lt1ByBTGFmxGb8XeRtg7HqvWx
         WC1i7C3Nm+eAy8XwWhRinsnN00PeHFvPXupmoaHaUvyB4/HMXtH6e3Ib1dvfCtwP7boA
         FzbqorEa/HdUA/OQ+GMyc0FlHBpVextzJJ70IkQWLpZoAJ3TGoUbGvnrbUP/mkzhSdPJ
         sD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4rgQHj0e4rf2gKwkFZaKemGDRL0W5vamS2+zR9c8gWM=;
        b=jj27p11NE3swHpM5KT/VcaZm4SETuN/1JKNlNbNvpKnJwDg7kle6i+nuxmxeiYSlj1
         ltIOLh1y3fopKnVfhKgL1DhKkzNfveXXcM7DPtw112Q/t5djH1nDM4zHVn5zuOiI74eX
         1U6+HUJd63pvgTUb80l0omTN8g5dHA1TbdemDlnUAAc3omwQ4wck6KPxGYGEHkPpKaWQ
         92i5aQdr3onwB92J8vqnoUWDLInOGZqshWvY3GszFNaCkf8k9IQtedEY/CwXrJQ88+B4
         lKSzs87af2SixIy9PLxcagYmXfz2hIwAdhgH8u3NT615HiGkPBT/KHidSaR13gJXK7g8
         y6aw==
X-Gm-Message-State: AOAM532/KKL5BnuxkzbhaRz5OG2+RnmJFQ2Ul01XhhGZlJAG4sPbvkcR
        PI4h2VGGxXMRVNcO/XF/cPVnNBnrC2Up5/aZ6z0tteLh07dlbcjhX6NiLFKP280Luvp1aHtt/LS
        CSyYrmUXjxkaWZWgDdUJ0NoMzs48eOOKSesafxM2NGM3G24JQzKy0sz04/BrxmF9xJWbsuL0w
X-Google-Smtp-Source: ABdhPJzxDLTKMbF6fHEzohkPrNbbv2yrVYQKS7aY6Psdazpz4EufoMGpb5hkzZZNOYvHetCFwMA+RhG7KPzq
X-Received: by 2002:a0c:b259:: with SMTP id k25mr262137qve.111.1590619634659;
 Wed, 27 May 2020 15:47:14 -0700 (PDT)
Date:   Wed, 27 May 2020 15:46:57 -0700
In-Reply-To: <20200527224659.206129-1-eranian@google.com>
Message-Id: <20200527224659.206129-4-eranian@google.com>
Mime-Version: 1.0
References: <20200527224659.206129-1-eranian@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 3/5] perf/x86/rapl: flip logic on default events visibility
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the default visibility of the attribute_group
for each RAPL event. By default if the grp.is_visible field is NULL,
then sysfs considers that it must display the attribute group.
If the field is not NULL (callback function), then the return value
of the callback determines the visibility (0 = not visible). The RAPL
attribute groups had the field set to NULL, meaning that unless they
failed the probing from perf_msr_probe(), they would be visible. We want
to avoid having to specify attribute groups that are not supported by hw
in the rapl_msrs[] array, they don't have MSR address to begin with.
Therefore, we intialize the visible field of all RAPL attribute groups
to a callback that returns 0. If the RAPL msr goes through probing
and succeeds the is_visible field will be set back to NULL (visible).
If the probing fails the field is set to a callback that return 0 (no visible).

Signed-off-by: Stephane Eranian <eranian@google.com>

---
 arch/x86/events/rapl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 72990e9a4e71f..fcb21fbcfe0d0 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -460,9 +460,16 @@ static struct attribute *rapl_events_cores[] = {
 	NULL,
 };
 
+static umode_t
+rapl_not_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return 0;
+}
+
 static struct attribute_group rapl_events_cores_group = {
 	.name  = "events",
 	.attrs = rapl_events_cores,
+	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_pkg[] = {
@@ -475,6 +482,7 @@ static struct attribute *rapl_events_pkg[] = {
 static struct attribute_group rapl_events_pkg_group = {
 	.name  = "events",
 	.attrs = rapl_events_pkg,
+	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_ram[] = {
@@ -487,6 +495,7 @@ static struct attribute *rapl_events_ram[] = {
 static struct attribute_group rapl_events_ram_group = {
 	.name  = "events",
 	.attrs = rapl_events_ram,
+	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_gpu[] = {
@@ -499,6 +508,7 @@ static struct attribute *rapl_events_gpu[] = {
 static struct attribute_group rapl_events_gpu_group = {
 	.name  = "events",
 	.attrs = rapl_events_gpu,
+	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_psys[] = {
@@ -511,6 +521,7 @@ static struct attribute *rapl_events_psys[] = {
 static struct attribute_group rapl_events_psys_group = {
 	.name  = "events",
 	.attrs = rapl_events_psys,
+	.is_visible = rapl_not_visible,
 };
 
 static bool test_msr(int idx, void *data)
-- 
2.27.0.rc0.183.gde8f92d652-goog

