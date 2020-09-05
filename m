Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1611FC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5A020797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgIEWXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:23:30 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36859 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgIEWXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:23:25 -0400
Received: by mail-qv1-f68.google.com with SMTP id f11so4864266qvw.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 15:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9C3RF43smdLyRCYoPU7N3p1alftqLdC9coi9jw2anA=;
        b=Wib/99MY0LXfwbLcjfFoUYT31yZM16k34zVuzvDTKOzGII/SlsWNwAKN4MJvyj3fcj
         KGRuJegqgKwVA0SUlba/yp7nUaib+KC1cLltVMYKW0w4EhTKJ/kyUw1izxfdWQMJAuRw
         TH82d6u1RbUxx7BVXAzGCO23dx8vyEqlVFICKyWvQzM2iQgw4lGljNVvCuYbdc7gwfl/
         0IPEum94wQv3k5cq7U8h6WUuuUHwLNq0jSEHVdadNdcHe2tseUsGhe7+ZXLcoy3543U/
         kWbstNfEvIrywGPjlrAxoO0YRHXulynDfr9H+fjnXiiuMKKDF5HuG2A/4w4SQjP8mW8O
         FnhQ==
X-Gm-Message-State: AOAM533lfeKBjVeLQW7vSXKjToDp3gg1em5ZeC6a+QaDJ9iojPFLGbOi
        XblwnJAr0Sg2l/Z0CRTO4PnIvmyjB/A=
X-Google-Smtp-Source: ABdhPJwnEp8mYYHrEf29nP9VkSEUP+QaWApqefZijQDy9Suhzq3yjwi7h7A+SA5emDG9jZZu6frAlA==
X-Received: by 2002:a0c:e303:: with SMTP id s3mr3593467qvl.61.1599344604618;
        Sat, 05 Sep 2020 15:23:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n203sm7323886qke.66.2020.09.05.15.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 15:23:24 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, kasan-dev@googlegroups.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Allow use of lib/string in early boot
Date:   Sat,  5 Sep 2020 18:23:21 -0400
Message-Id: <20200905222323.1408968-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The string functions can currently not be used safely in early boot
code, at least on x86, as some of that code will be executing out of
the identity mapping rather than kernel virtual address space.
Instrumentation options that insert accesses to any global data will
cause a crash.

I'm proposing to disable instrumentation for lib/string.c to allow the
string functions to be usable, and the second patch is an example use
case.

However, I'm not very familiar with the actual uses of that
instrumentation and don't know whether disabling it all for lib/string
would be a terrible idea, hence the RFC.

Thanks.

Arvind Sankar (2):
  lib/string: Disable instrumentation
  x86/cmdline: Use strscpy to initialize boot_command_line

 arch/x86/kernel/head64.c  |  2 +-
 arch/x86/kernel/head_32.S | 11 +++++------
 lib/Makefile              | 11 +++++++----
 3 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.26.2

