Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC1C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F2A20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G208phQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFZWgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40457 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbgFZWgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sy544NXeYcNhbxOT1ou9Gq9AWlj9fShUn5juJrQIV8c=;
        b=G208phQbiLPfwXeCG40aN7rhmi/grXk9fQqhXSfwXuLNCj4rjjO7HqY00XF6EqCMtiioeF
        DPTMoY8J7w4Ys8I07kBFloLZDm4UVkHfKQgWB2iqZQg++yeIPqANhaKUI1FJY9KsP6jm8f
        9Rx176hSHv7xxGvTYj/9ni22b/mgLBY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67--5cmlnH1Mz2kaLxs1JO3Og-1; Fri, 26 Jun 2020 18:36:33 -0400
X-MC-Unique: -5cmlnH1Mz2kaLxs1JO3Og-1
Received: by mail-qt1-f199.google.com with SMTP id p9so7555147qtn.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sy544NXeYcNhbxOT1ou9Gq9AWlj9fShUn5juJrQIV8c=;
        b=jGmBqtwZ3H2fUFzzFSwscu5YDHkzSlu1hBGkr5ZjeEu5XdW+RK3a/c2d4xMUjmPDZ6
         3ut8bqMcHivUIJ8m2vwlVkWLsX6p7hKDSGbLPoiJncpkOn7Hbq/MOzjokI0ca8YbB7DI
         3bnoViGyGNxdzjLLhtwVRbAkfi9jJMWHtJBMW6SRGOJLBIz16Gimyb0O/NN4bY2/jg1X
         TAMdALAphHmzh2QY1CyFFxiXRCKubC1O0imBCwXu6o1QnsbaPCgMKQ/ZfQyuEQ40BAom
         J3y/U17F5SK9MtXMeVR9DMJUdNbDoEJe/OdZ9J52KV8ERfzBPFZTTM/sBPtI2F18advF
         noCA==
X-Gm-Message-State: AOAM532jQsYJTJDLI4vwQOy/MX/qS0VXr2OxXv41+z/JJDs0ZAzxMtJd
        JS3jVOFg/vfbcfQnCy36TgC7HrA0DiszVMy+iO86PG0LwDDER+17t79K6UbJOnJj5c4ucsD2Ksh
        hwAu5gN4Oe5aHOHKHgBWQEh9i
X-Received: by 2002:a37:85c2:: with SMTP id h185mr4770362qkd.131.1593210992724;
        Fri, 26 Jun 2020 15:36:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcoi8cepaE8ANXOFi2PVyO15Jfd50jgJOhFJOBCe30ERvg9/Lt2pXNeV+XAP5+YiAoyA3fUQ==
X-Received: by 2002:a37:85c2:: with SMTP id h185mr4770348qkd.131.1593210992522;
        Fri, 26 Jun 2020 15:36:32 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id b4sm8623557qka.133.2020.06.26.15.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 19/26] mm/sh: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:30 -0400
Message-Id: <20200626223630.199909-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Yoshinori Sato <ysato@users.sourceforge.jp>
CC: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sh/mm/fault.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index a4e670a9c9b3..ba6f7ed570e5 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -464,22 +464,13 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (unlikely(fault & (VM_FAULT_RETRY | VM_FAULT_ERROR)))
 		if (mm_fault_error(regs, error_code, address, fault))
 			return;
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

