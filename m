Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A4C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E020F21556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="W392SK/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgCCT2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:28:54 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45167 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgCCT2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:28:54 -0500
Received: by mail-qk1-f196.google.com with SMTP id z12so4566668qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qmv//PLMnUie9B7qaPX/qU2EmGiQx3aYNQaNo0ftsto=;
        b=W392SK/vElOUsNDyI6oHepG0UtGX6m0kYX6/Ow+4A6i7y0LVFCm1v+UBtAfyNJ9aXU
         DjP2f7Jg4CvPNJTx6RZL+hRzsqi9lvIOBjqkvqEqmF8+tqp7DEOZ5EDY0AUWkzl4ZLoP
         qqeAF9/nY+siFpQQcUQ9+H4PwygVUezWzgo212OOraDbStRhKECFfnV51wKzz/gpf5am
         V19kFvO8Rn4F7gtCw1otjZPiV5yXW5wyPzWYKD+V/yMKxHK1LMAHn/f3BAw4KnNluKp8
         +lzv2mgJ50tJbCviVeOVdaaiZPAfb7zQ+SilPSVt2gW8COEko5S6x+hwbsFuIzJTsfzF
         syTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qmv//PLMnUie9B7qaPX/qU2EmGiQx3aYNQaNo0ftsto=;
        b=GKKjrnnduf6ik5xXgXrY5OortO+rb3G+t9gF62m+6QMT+KRhO2izqqacHOkdGnDZkT
         rCueFrHzUkOCoc2LKG17rcBwxojtjBNOA2PRyPdtsq5Oqj3QBeD6o4ABYNEPPWlPiIe8
         KMRRxytALekP851m+XVenLB8JWPvnyIZszwoOUr09+Aa1iPj6nP55f78besSsg/gvGvU
         njv84BZLjTWIWbIv3kFYlu1ick3DZnhaEIyZjbEzhVBRPdrkOzRlsb9oG8R8NitTDJ91
         7EnJF9eZjh0lzSYuNqHU1JFHZoPQD6ZrwPaIhy2kJ7S+NB3eTz5KO5x3mb3h/ydQKpnJ
         db3w==
X-Gm-Message-State: ANhLgQ1YcnBP0zh+yEC7NlHrFPJqKoC8ezj3RtDhSFc8AASvvrWyptNM
        OAVtXcGnGE5zXxEBTbHdflkEpw==
X-Google-Smtp-Source: ADFU+vtdkDuYLw9tLxiNdRRm718gud7ooWVb+GAm8SnQTcSZTLUEJwlmx9EJniPmpYaDg+cSpfidqA==
X-Received: by 2002:a05:620a:747:: with SMTP id i7mr5469399qki.375.1583263733297;
        Tue, 03 Mar 2020 11:28:53 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j7sm8872582qti.14.2020.03.03.11.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 11:28:52 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next 1/2] mm: disable KCSAN for kmemleak
Date:   Tue,  3 Mar 2020 14:28:35 -0500
Message-Id: <1583263716-25150-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak could scan task stacks while plain writes happens to those
stack variables which could results in data races. For example, in
sys_rt_sigaction and do_sigaction(), it could have plain writes in
a 32-byte size. Since the kmemleak does not care about the actual values
of a non-pointer and all do_sigaction() call sites only copy to stack
variables, just disable KCSAN for kmemleak to avoid annotating anything
outside Kmemleak just because Kmemleak scans everything.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Makefile b/mm/Makefile
index 946754cc66b6..6e263045f0c2 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -14,6 +14,7 @@ KCSAN_SANITIZE_slab_common.o := n
 KCSAN_SANITIZE_slab.o := n
 KCSAN_SANITIZE_slub.o := n
 KCSAN_SANITIZE_page_alloc.o := n
+KCSAN_SANITIZE_kmemleak.o := n
 
 # These files are disabled because they produce non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
-- 
1.8.3.1

