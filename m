Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03E5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E84D2072A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jchYExzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHASqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgHASqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:46:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5431C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 11:46:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so12018574wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6ic/oET+3gSWAf5LX0GShGl++u6aR0SY5x3/TYTLcg=;
        b=jchYExzC5VePtGHjihJDBDhju1KCuN5Fp3UCitHba3iW5NzRK8nXnM9TNY7pODxK/a
         xZZ+pYpFMFS/nwePYZJwgo1m8PHcoS8AJvG3AgljXbBOQUYTIYdUJ7zDrPtjigaOnOR6
         ojZyh345gq+prLeYnYOTmMMc77WvYcGHCWjbjs7lWPtcISJqA7dqbT+2XToc2Kich9Cz
         JweYtQ634aB5tcEQLmPA3gfD4mOupq3QZjibV4HgA87gAl+Gy+BT9vJNJbiJm9+/RW93
         18jVaNRNLmCDgpZVcfmIqVIteWUkHQZdqOfYbDvSHQ21Xwn4vhjZ/mfs+zeKTICty/Sx
         sizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6ic/oET+3gSWAf5LX0GShGl++u6aR0SY5x3/TYTLcg=;
        b=QbhlwRl8ZUWQ9Q1CfX1ft6ORqCSJ/5qRPyJclHXcpL5jSuwqB429N9RRqG9k5G/aeH
         /08Nr8BS/9jIqzgJQJddPlQhCYSgR9TPtu6feIzeJazX43pzfmY1Wwik+yJK8bzVbhy1
         hgNf00eQS3ioAN2HuTp/CFPxRmJaf3PJCmOhBvpmtfn0Yb0U80HJMi6n6kChHFkvZquu
         RRob39jl9e3cAGQJtIcSF4y1U5OFO/dpIZOz8SlYlMwP9Y3cauQBsHtFR54Y6vDM9uX8
         Y/YUccWQ9I7GRbXbL1SiyoElxjOsF+vEtxQbQeZaO3K+nPfdqhWQV8CeUnrnVlzNVcms
         mxow==
X-Gm-Message-State: AOAM530MUCCRrf6vY7vpG74R8V4bUiA6XjBBG9ujCbB5VNQkKdDQyt+Q
        BrjSbY4gPsXEhdYWA/XNXqO/FlLUUnqs1uA=
X-Google-Smtp-Source: ABdhPJz4/wYiSEOjIwyNO4xLdm7s7XClnCHgwPaPx25MJpXvu4L1uXfaxmqSAlrZHUmJue4rOzL9cA==
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr8778854wmu.188.1596307600282;
        Sat, 01 Aug 2020 11:46:40 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id g7sm17468447wrv.82.2020.08.01.11.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 11:46:39 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/4] context_tracking: uninitialize static variables
Date:   Sat,  1 Aug 2020 19:46:03 +0100
Message-Id: <20200801184603.310769-5-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200801184603.310769-1-jbi.octave@gmail.com>
References: <0/4>
 <20200801184603.310769-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch tool reports an error at a staic variable declaration

"ERROR: do not initialise statics to false"

This is due to the fact that this variable is stored in the buffer
In the .bss section, one can not set an initial value
Here we can trust the compiler to automatically set them to false.
The variable has since been uninitialized.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/context_tracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 36a98c48aedc..21881c534152 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -190,7 +190,7 @@ NOKPROBE_SYMBOL(context_tracking_user_exit);
 
 void __init context_tracking_cpu_set(int cpu)
 {
-	static __initdata bool initialized = false;
+	static __initdata bool initialized;
 
 	if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
-- 
2.26.2

