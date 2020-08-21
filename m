Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24DE2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="dz8aD+Vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgHUMLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgHUMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:11:01 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F897C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:10:38 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so1093719qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/W+Q2C5EanLhSLHdSwnb0l9xdV162iKpsjQAENkTzs=;
        b=dz8aD+ViInktElTWiu54BR/XO8bD3mAk7HTP3qCy2R50bThFmh7svzzAraKsSaB0jL
         SaZ7yzTzX3CXz/fVp4e/mhk3WKr8uta5Fj1INNo+Af19NoHA9HhQRVFfpvvMjB9NZsCh
         IDhmu0eLGjzhgoMbO6Zu+k+ksfwTe9Su6Su7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/W+Q2C5EanLhSLHdSwnb0l9xdV162iKpsjQAENkTzs=;
        b=JrDnKQA5CH05nCNDT5l9YVPL+PLnDoQMH5ZrGA/4MiLTYbnPRDrFzZuMdyNOGHmoAf
         QZ6H3xxbwOaMigYSoQ4mHtCo5+KiHQD4UD2JHztqD/icUH/AHwV0ZMixOSSvfbiIcfkN
         5WdC1xWFbHpk/ST7qzyfUO4ox7qxHGHjanZ8P9VJsQdIJ7T2DhlBzWPQ1X35bk3Z/gYC
         1utMG9cqtRPGQLMpmgDMC8Cv/UXMS/FWqT0nzWNGKt6G/phWZ5UwRtB0Xx83RGasVJkE
         18oQWHrNoiarTGb53IJlNYg9FRhnqGvJ7F962cyyKle1L+fIcmo/Ni19NPvXwbb3OMKa
         a/EA==
X-Gm-Message-State: AOAM531OMFhxqkQ1KJVBK3sr9OdxalAdDWZVpvyUR2ynELJyHc74CqFW
        uh2BEcmd2jOeuVWFvlDS7yq2kXRHDOwZm4BP
X-Google-Smtp-Source: ABdhPJy3NuKbXK52xhHyk9Aa9WPXuuImcwEqFl5+Scnb0eJ9Nz6ML2I0HpHl6giDr+LTLx9OuOhCrA==
X-Received: by 2002:a37:e89:: with SMTP id 131mr2437257qko.279.1598011837034;
        Fri, 21 Aug 2020 05:10:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:23fc])
        by smtp.gmail.com with ESMTPSA id 20sm1956489qtp.53.2020.08.21.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 05:10:36 -0700 (PDT)
Date:   Fri, 21 Aug 2020 13:10:35 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: [PATCH v2 2/2] x86: Make source of unrecognised MSR writes
 unambiguous
Message-ID: <6f6fbd0ee6c99bc5e47910db700a6642159db01b.1598011595.git.chris@chrisdown.name>
References: <cover.1598011595.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598011595.git.chris@chrisdown.name>
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
index eaf375245549..812e64ef5ff5 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -102,8 +102,9 @@ static int filter_write(u32 reg)
 	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
 		return 0;
 
-	pr_err("Write to unrecognized MSR 0x%x by %s\n"
-	       "Please report to x86@kernel.org\n", reg, current->comm);
+	pr_err("Write to unrecognized MSR 0x%x by %s (pid: %d)\n"
+	       "Please report to x86@kernel.org\n",
+	       reg, current->comm, current->pid);
 
 	return 0;
 }
-- 
2.28.0

