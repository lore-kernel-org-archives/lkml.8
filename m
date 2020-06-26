Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218A7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009BF20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jebeIARZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgFZVKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgFZVJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEA3C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z187so7442072pgd.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hiFp+uoptqOZ2rqi90LxI+MqGbDbXrg3yHQVzKDmQQ4=;
        b=jebeIARZ4MbpC/qohszlae0SxIiUjfS+aHdsgRsyl+nDoZ13dCApmFMyUJeVDOsHAY
         KIcGcHJ+1BS4bpjJljRbXhZa/cLiJQCxIz3INsZbN4Us+V8lP8TK5psKf814t/EGk6wE
         pXdYgr4IlD1bc5vMRTxWpR8bW/X9rqzObf6oG1rnxRKPcgwcVlXdkP64PXWb7NSXT5a6
         NEtpZlVx+hSr8lknL1TKy8c7BgSEPoFVGkkI3sTvx7LhXrKgu9GToCMGaLH+nZo8xo8H
         YHmDwLXC56KXjbSBDnypaQ9i4502TKmtFeLoqT6X6hTKa14dhV4gfc4ThT1/79Jdq8SS
         8zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hiFp+uoptqOZ2rqi90LxI+MqGbDbXrg3yHQVzKDmQQ4=;
        b=DnU2gHK61eW7Ba+MGERrMNjya5P85/zX5F3Tt71wtK/3onfwsnDFWfbQ3sF+4lpSTd
         BRYzc5t5kK3nO1UqhEbsugScS1sJ7XdoH2TaBvMzmWSqyNK+VjU5kxzWcX1coT18Zq6h
         7hegBqmStuugq/RsjBm7FlQ+OkDFL/55tIhSksI5Ph7YYaCXwxJNOIc3u3UdsDqzNETj
         qGrKC52LgW1lj6joDRrm0YFtyFWyHHPbHG/XcxVCLfnyG31S8EIlGT12tgtuWpQC5Ism
         FmZnHAJZ8gZpG2jncULkkseKBM9eJHtSAwGoiHKC5TPwVVgKkCBhI/qJAryRZpEF5BAN
         fMtg==
X-Gm-Message-State: AOAM530JaGwSQuU4YzQBRe6G6nQfcT4p+Ru2c3qYUVw+UWX/ZxjmDkhK
        I+0RXycWjpUcSlR6p1honmxa/I/CI4E6oJPpjSC+Ng==
X-Google-Smtp-Source: ABdhPJxSwQ68iEnNXkgolra98q2cg2bDfdpdwE62xg8GhSSGsb9iaN0w7iVXuEbw7sVWlA1D/tARVHhauyHs3D3fWH+8JQ==
X-Received: by 2002:a17:90a:f206:: with SMTP id bs6mr5554851pjb.48.1593205769580;
 Fri, 26 Jun 2020 14:09:29 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:08 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 03/12] arch: microblaze: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a linker section to microblaze where KUnit can put references to its
test suites. This patch is an early step in transitioning to dispatching
all KUnit tests from a centralized executor rather than having each as
its own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/microblaze/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index df07b3d06cd6b..4fc32f8979a60 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -128,6 +128,10 @@ SECTIONS {
 
 	__init_end = .;
 
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
+
 	.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
 		/* page aligned when MMU used */
 		__bss_start = . ;
-- 
2.27.0.212.ge8ba1cc988-goog

