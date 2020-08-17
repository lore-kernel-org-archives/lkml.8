Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EC4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9946F238E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="C/V/yGu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgHQP0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgHQPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:24:39 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666F4C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:24:39 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w9so12658287qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U4Ljhge3b+epbgJXir/y5ETgZWDFNKeJO8zvcM0T4us=;
        b=C/V/yGu/4HGw7a6hMLP9ENVYj7zDu12bR05GBt/EgSs8a6JahItGEOI83s5DtjzNsi
         4B4yy5oUx78hTyZUwHMrh/tJ4KzD3RW1fnpbH1UeMuFB6sKYcv4jFiWLkadC7mq8qpzU
         YpJxg2NhFWQqLqM47/UhmR+u9Ho3XekXb7wRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U4Ljhge3b+epbgJXir/y5ETgZWDFNKeJO8zvcM0T4us=;
        b=m9CICk9WpwxR6YgOEktydJAEp7QvMwTFRLMhed/xiDefxSEfukMGlsCDqJNh6nyxwW
         NrlPTuvABLsf/fWOFssiy58wlosxxNxeDdf8YnXlNiEWfnjs/DVa08u9VeIC653dJdlR
         foz066hzHiFMoaxGTUINFRiQPxsw0uG6fB2NhG1VnoE/1ei5QQ3ttmY+oPcqUz04IiM/
         DbfarsYIrA3kC1gJfxkXBqJXrFKdI6gnCYca8P0fhxyZ/CqsZxS9nPRU4+f81FE4TFlg
         zOpv68eqhKGhQLfpWKUmoV3adw7gDS7lQ6orx+U+71dPvOikLOvnVgO9E4DfE+qpglaS
         INuw==
X-Gm-Message-State: AOAM533WBOswoQZRTHDUi++wp+LScy7dxTgo6fG1MKOeMKsEZgVFK8xN
        CUgV5Jjt21FWxd6jDcCPMHryN5NFHcwWlvAIy8Y=
X-Google-Smtp-Source: ABdhPJz5Q/JCWN/QUYuwgiY1Gs+yTS5fb3FSC/aue1dAnIvbCvUr5tP+Ffo/P3UhtLcre9qjYlsHjA==
X-Received: by 2002:aed:2358:: with SMTP id i24mr14078467qtc.234.1597677878337;
        Mon, 17 Aug 2020 08:24:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:47cc])
        by smtp.gmail.com with ESMTPSA id i7sm17771201qkb.131.2020.08.17.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:24:37 -0700 (PDT)
Date:   Mon, 17 Aug 2020 16:24:36 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: [PATCH 2/2] x86: Make source of unrecognised MSR writes unambiguous
Message-ID: <df42b70ed20d616d7c2d7f42cd38300115584619.1597677395.git.chris@chrisdown.name>
References: <cover.1597677395.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597677395.git.chris@chrisdown.name>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many cases the comm enough isn't enough to distinguish the offender,
since for interpreted languages it's likely just going to be "python3"
or whatever. Add the pid to make it unambiguous.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 arch/x86/kernel/msr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 3babb0e58b0e..76b6b0011d62 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -99,8 +99,9 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs) || reg == MSR_IA32_ENERGY_PERF_BIAS)
 		return 0;
 
-	pr_err("Write to unrecognized MSR 0x%x by %s\n"
-	       "Please report to x86@kernel.org\n", reg, current->comm);
+	pr_err("Write to unrecognized MSR 0x%x by pid %s:%d\n"
+	       "Please report to x86@kernel.org\n",
+	       reg, current->comm, current->pid);
 
 	return 0;
 }
-- 
2.28.0

