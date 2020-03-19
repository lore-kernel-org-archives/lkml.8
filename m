Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD55C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BCF2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYcIxAhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgCSQmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:42:43 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:39147 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgCSQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:42:42 -0400
Received: by mail-yb1-f202.google.com with SMTP id h66so1074402yba.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Dz7alAscI1YvV+X2ok1ND7NhQJcsBO33MSW+QX9MTto=;
        b=OYcIxAhVB7TkVa6WZyRwxfsKV9lKaUsk0UijSeFRvD9xTLr5/CX3x3kHaQhyHaqy1C
         APv2OCbdhn8rHtXnR1dE+KyIY0eMy//e5p9Dfw6LR8UInTfIuwqCnJHflNpvHpJ+4ScF
         A0zL74CzffXi1OhRsrWxgUDnMuKxnHz4ZSXxNmeWLaOP2UCKBFTkqc2iNvQPyv911Pcd
         3YydHB74C/AYS6D3kFPMyT9ZwGrVV8SjJK85KnmEGjHDu6ixzV4QyexmMYugujIR6ivt
         t/AZ82O8U9Q3PvPyb9qPhA+5phKUy6IsLwHdqkgzGr/p0J9/gQWBxj84w/RxveZKhhaX
         QfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Dz7alAscI1YvV+X2ok1ND7NhQJcsBO33MSW+QX9MTto=;
        b=GYYyqIF8Kpxdehd5NPAvISxK+hQ8WalMwZdLYFeG4M65awA8ns81zmpJM5FU3IVHui
         QjRO3dYQyxcePEWYrhAN8MpHFaE5QfBeSkJGzl3YXo9PAzDpp6EbZLpiw/4ai/CsxM32
         SSvhYs2Al4Z/4479ndjmhJ2JnwUa3Z2mprGU14U5RZg8aKhh3O966Y5pZiuWNwO9TBOB
         79ZkZohFSHGqOXTrjvkTjpOIG1EQOg6g/7dUcyyGi1o6mcST0vbNgoFM+/RRYoZ/5ApT
         /I/9b3gQzrChHv+QUIkK8HEVQi/yRG+OOaeqKWphbSy7Yrw6qg8J5VwQzQbSr5XyPz4n
         KMpQ==
X-Gm-Message-State: ANhLgQ33WKEz6xGiDG7zc/buM5TBPkB5bJB60zpNy1nug+xAZFtF/zO9
        tNK7TNM7WIAQZqWvs4XpEDmO50E8i0ZYyP2mh3Q=
X-Google-Smtp-Source: ADFU+vtYjo4ouzn/Ha6fj35qaYti71akcCt+bJBb5MBf7qZK7JbtPmyF4kMw+AlB8eOy7HU5Va3ZmBYJc8/OJnZa7jo=
X-Received: by 2002:a25:a281:: with SMTP id c1mr5753816ybi.327.1584636161413;
 Thu, 19 Mar 2020 09:42:41 -0700 (PDT)
Date:   Thu, 19 Mar 2020 09:42:24 -0700
Message-Id: <20200319164227.87419-1-trishalfonso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [RFC PATCH v2 0/3] KASAN/KUnit Integration
From:   Patricia Alfonso <trishalfonso@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains everything needed to integrate KASAN and KUnit.

KUnit will be able to:
(1) Fail tests when an unexpected KASAN error occurs
(2) Pass tests when an expected KASAN error occurs

KASAN Tests have been converted to KUnit with the exception of
copy_user_test because KUnit is unable to test those. I am working on
documentation on how to use these new tests to be included in the next
version of this patchset.

Changes since v1:
 - Make use of Alan Maguire's suggestion to use his patch that allows
   static resources for integration instead of adding a new attribute to
   the kunit struct
 - All KUNIT_EXPECT_KASAN_FAIL statements are local to each test
 - The definition of KUNIT_EXPECT_KASAN_FAIL is local to the
   test_kasan.c file since it seems this is the only place this will
   be used.
 - Integration relies on KUnit being builtin
 - copy_user_test has been separated into its own file since KUnit
   is unable to test these. This can be run as a module just as before,
   using CONFIG_TEST_KASAN_USER
 - The addition to the current task has been separated into its own
   patch as this is a significant enough change to be on its own.

Patricia Alfonso (3):
  Add KUnit Struct to Current Task
  KUnit: KASAN Integration
  KASAN: Port KASAN Tests to KUnit

 include/kunit/test.h       |  10 +
 include/linux/sched.h      |   4 +
 lib/Kconfig.kasan          |  13 +-
 lib/Makefile               |   1 +
 lib/kunit/test.c           |  10 +-
 lib/test_kasan.c           | 639 +++++++++++++++----------------------
 lib/test_kasan_copy_user.c |  75 +++++
 mm/kasan/report.c          |  33 ++
 8 files changed, 400 insertions(+), 385 deletions(-)
 create mode 100644 lib/test_kasan_copy_user.c

-- 
2.25.1.696.g5e7596f4ac-goog

