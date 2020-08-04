Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34B2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC3A20842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwW8r91A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHDUrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHDUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:47:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46699C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:47:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127so36478192ybh.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bdWZwbCIT3bffqBHb6yQ2UmqBVzTTDxDz7sK3Dmf5r4=;
        b=KwW8r91AHMUBg5mbfjpRjTR0cf8DPX1yH2l3+2XlygGEQCNkBkp2T2avLdbvlR2jc5
         ZQm2c//EyKWM6yPtV07c6G5etRYsRM9DZ2B75umwcvYj/eSDCb/0pmH3ChoVnbPee3sb
         9Nad960qcZ7Pntd3PNRvjToJEh98i1sw+0BoWjYtw9qBBjJ/OGfyiru1BE6QPWoaurg7
         u3xRcgLuUVZ44ozwU2hkrDxmjUESSDaE6J28cl2lPisJzKQK0i2ZR1wuI+4/SybCfSy6
         4co+aJUXzsaFTtcH1WE9aHdxc0jxWuPbUzb8KHakh/FPkJ210Kk3i2DBCdADP7ALt38o
         f3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bdWZwbCIT3bffqBHb6yQ2UmqBVzTTDxDz7sK3Dmf5r4=;
        b=sF4ZJ8vECU84HAZQyrLZLome5Pp2gV/dlYtZ9oPbYRG40ZNf58D1TzNpwoagjyaAub
         cNVBLbxibwEi1neyyW6Ud19vbmUzwk11c1LmbOHgfiZLL8wK2yLw7gqYiyJvO9DRsVHs
         d/QjiBy5hVypl1xDe8ITNC5SFtnEl0rYVwr5dPgwlsYky4yW0l8icbrx9XVLZX40Y7o3
         Oy6T4uge+1+z/avBQ7RJG9aF+d0ZGZOBcGlDN9cMFo1FR6DWm/UO6GIOkUAVcTY9XXvQ
         vuTastlnaMnPdx1AGdx0raLAckwazu/sloVXAzypUBFMb1JMhOGpNiJ9nChn8sUOPTgi
         S32w==
X-Gm-Message-State: AOAM5336F8l4iICLtFK0gIlDb7NOxp8QvGgEJZdvk9tCSTd9piUfkvei
        sBmxHxqGKiCgd22RZJEjaJ92ZcINdSzmFArDpbitMg==
X-Google-Smtp-Source: ABdhPJwYimCKG7zFBoA8l8yiip0nr1b5jytYj7cr6BxJOxfhLVlpZg6kC8ksmiseCKfq3ISGowf5zR5F1rWu8FFPMWnf3Q==
X-Received: by 2002:a25:5887:: with SMTP id m129mr39203687ybb.11.1596574072436;
 Tue, 04 Aug 2020 13:47:52 -0700 (PDT)
Date:   Tue,  4 Aug 2020 13:47:40 -0700
Message-Id: <20200804204745.987648-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v6 0/5] kunit: create a centralized executor to dispatch all
 KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

## TL;DR

This patchset adds a centralized executor to dispatch tests rather than
relying on late_initcall to schedule each test suite separately along
with a couple of new features that depend on it.

## What am I trying to do?

Conceptually, I am trying to provide a mechanism by which test suites
can be grouped together so that they can be reasoned about collectively.
The second to last patch in this series add features which depend on
this:

PATCH 04/05 Prints out a test plan[1] right before KUnit tests are run;
            this is valuable because it makes it possible for a test
            harness to detect whether the number of tests run matches
            the number of tests expected to be run, ensuring that no
            tests silently failed. The test plan includes a count of
            tests that will run. With the centralized executor, the
            tests are located in a single data structure and thus can be
            counted.

In addition, by dispatching tests from a single location, we can
guarantee that all KUnit tests run after late_init is complete, which
was a concern during the initial KUnit patchset review (this has not
been a problem in practice, but resolving with certainty is nevertheless
desirable).

Other use cases for this exist, but the above features should provide an
idea of the value that this could provide.

## Changes since last revision:
 - Renamed the KUNIT_TEST_SUITES the KUNIT_TABLE section and moved it
   from INIT_DATA_SECTION to INIT_DATA; this had the additional
   consequence of making the first several architecture specific patches
   unnecessary - suggested by Kees.
 - Dropped the kunit_shutdown patches; I think it makes more sense to
   reintroduce them in a later patchset.

Alan Maguire (1):
  kunit: test: create a single centralized executor for all tests

Brendan Higgins (4):
  vmlinux.lds.h: add linker section for KUnit test suites
  init: main: add KUnit to kernel init
  kunit: test: add test plan to KUnit TAP format
  Documentation: kunit: add a brief blurb about kunit_test_suite

 Documentation/dev-tools/kunit/usage.rst       |   5 ++
 include/asm-generic/vmlinux.lds.h             |  10 ++-
 include/kunit/test.h                          |  76 +++++++++++++-----
 init/main.c                                   |   4 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/executor.c                          |  43 ++++++++++
 lib/kunit/test.c                              |  13 +--
 tools/testing/kunit/kunit_parser.py           |  76 ++++++++++++++----
 .../test_is_test_passed-all_passed.log        | Bin 1562 -> 1567 bytes
 .../test_data/test_is_test_passed-crash.log   | Bin 3016 -> 3021 bytes
 .../test_data/test_is_test_passed-failure.log | Bin 1700 -> 1705 bytes
 11 files changed, 180 insertions(+), 50 deletions(-)
 create mode 100644 lib/kunit/executor.c


base-commit: 145ff1ec090dce9beb5a9590b5dc288e7bb2e65d
-- 
2.28.0.163.g6104cc2f0b6-goog

