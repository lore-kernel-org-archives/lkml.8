Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F1C2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CBA20769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyNX3oxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbgELVkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgELVkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:40:33 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5BC061A0C;
        Tue, 12 May 2020 14:40:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id z15so1080959pjb.0;
        Tue, 12 May 2020 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DuZB6aC1Ih/VDKY9giKPzKGYxrZfE0YIToYnjsJKSBs=;
        b=dyNX3oxLS1/eQ9CC7enfSYr4leoEyYwLjhBgBQktwgiRS7Fwk0+E6nmppTIU2/6vvi
         Pp4efqFoH5yalE50B2nfAgdKh7uJ3I6Hb7WeqMTEvGRGNzO6tlUSh4kqWwDPYOkG0o2H
         QWKpQtWPl5UwzUy/E8wv7I/hWvj983Jl6mF4l9LnHVH2VkQT3D0Z4i/08i9mVAaHzBBc
         14q3MdqGWmEcwWZBmGwWiq7/imvvTT4ZupMrJIvqnFjw8cbVhG3/XkPMpnt6/vr6kZNy
         ZuOD92dZrqNCANefPeJXVCUuTfrDTFYLyuVy1sVqGi64ihaP4A2GlvHqizCsvqZbAX2z
         GQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DuZB6aC1Ih/VDKY9giKPzKGYxrZfE0YIToYnjsJKSBs=;
        b=Wbaq9FDqtQRl0YtJ68N+TJ1PxqMrbpcF5b6aeD5bine+WDg/O4+QUc+KRFsRqDJWQH
         jKkua+0rxVMKwoeSHFpmi1htx5sorXYlme4CvZ0VXIpuSKsMn9VgRhFfmJtwNfWi433r
         7AvdLkuk1en02Aqjw7VWRKDrPw6521ihR381VCTWIb/M5FlE6KbrA0uSIbjPjRjR3T7h
         1i7b85w0+U/Gfuhioxpwko8Y7q400+pBJV6BN0i+h+/NR2rdfPij4BSHsW/42P105lHu
         my1dKyAyyCd/G01VwZwZEyc7lad75SGs/lxLRhUnz7+kIodGqL5DIwxyWCZiLIE2GJSn
         LQVA==
X-Gm-Message-State: AOAM530oVrTF8ZJSqWZASqNGZaUtD28ud81Th7nV+kIPLJpXsLWRjW2l
        331htdIbp9tIiaKAlGIGcI4=
X-Google-Smtp-Source: ABdhPJzwgDqenXkyY26Zlj3m5KCgBliHvMEYbLzuqiue6ArR1cJscg283UTJgJFmRgaFrM+kx2LqJQ==
X-Received: by 2002:a17:90a:30ef:: with SMTP id h102mr4883315pjb.110.1589319631229;
        Tue, 12 May 2020 14:40:31 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 128sm12633208pfy.5.2020.05.12.14.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 14:40:30 -0700 (PDT)
Subject: [PATCH RESEND 4/4] docs: litmus-tests: Clarify about the RCU
 pre-initialization test
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <8360e630-1a39-7f49-91de-275e7a11a86f@gmail.com>
Date:   Wed, 13 May 2020 06:40:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From c2d6a0afad370c6fda136704bac9b1ee9557d0eb Mon Sep 17 00:00:00 2001
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Mon, 11 May 2020 22:06:46 -0400
Subject: [PATCH RESEND 4/4] docs: litmus-tests: Clarify about the RCU pre-initialization test

Since this test returned to tools/memory-model/, make sure that it is
at least referenced from Documentation/litmus-tests/'s README.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
[Alan: grammar nit]
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/litmus-tests/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index ac0b270b456c..b79e640214b9 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -24,6 +24,10 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 RCU (/rcu directory)
 --------------------
 
+MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
+    Demonstrates the use of rcu_assign_pointer() and rcu_dereference() to
+    ensure that an RCU reader will not see pre-initialization garbage.
+
 RCU+sync+read.litmus
 RCU+sync+free.litmus
     Both the above litmus tests demonstrate the RCU grace period guarantee
-- 
2.17.1


