Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C1C35240
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DDD2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvEXh6vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgA1HUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:20:17 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35070 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgA1HUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:20:16 -0500
Received: by mail-pl1-f202.google.com with SMTP id v24so5186318plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=geIt7NTj15qXn0Pd7vHPLbcleORDZqpFgUWoIN42PEM=;
        b=QvEXh6vx1uu5+MqSyqNpYaqM0+WH+gnl/II2vETCPrUPXtj+INkYpNvum2xVSiePqx
         t2/NWdcygIobxjQwa6b1OnLgvNTscgcCzwk3Kw36NhrFIWMkNB+UMzrLz77/vEJkezdN
         15guaSPb7ab1mnGvB+LtN0ErleZfv4RBuk2g7w4q3DMM5WCH/e9o2GfN///ZX1kp+P2k
         9OtN5uEDF4qS+QZEf323rO0sMLIeC/Xw2+dPQ0tCmivr5rQ4PxRJoq7SiQXxSHuWxBpw
         M/ivCrQQeOhdoSDO7BN4ynNQSAV+TGlgrrSPB/kV0uDwtRpyqiwvZ/W28+FQICH5XA89
         pVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=geIt7NTj15qXn0Pd7vHPLbcleORDZqpFgUWoIN42PEM=;
        b=rlF0elF/7gGoeQ9dX1jgENT+zfL/D/wg6ZB0xE9ixC/QhK0OW3OzTa5RibzV/pUUSU
         8DWRv5ADMn8Y5oxpO6ZwtS6O0CXulmrX5fWUcnQ44BfLLuRsVzJ3j7UrC+Em+pR6pCtS
         88i6CXY2O9FdwJJK9U7YpLl3ZBswezV+pao/wj5tR3S3LRpP6p4qUaxYdmJFiM1sH+jx
         bsURCdC0MMYlPb+4J0bMdMUXcJBBl36RvHG4ZzrZQI1WpyanTRjEAAhAYIPEj8E0MC7l
         LLEzyzL9HrD+BHiwi7zUH7J74f6HfcPbNiGCIMeg+qa20FTd8gopr3bMaker4ovgPwol
         BikQ==
X-Gm-Message-State: APjAAAVewQ3AJsr5IaN++qMT7jMKkDbuHeOs0jVSiXJjrDlrWFLiZpof
        fsHcskWm0woRIzBggZXohKZ13c6RXVjZujfKNe3ORw==
X-Google-Smtp-Source: APXvYqzxUoPIpd2+KXb0X0NAkTjM1rpz5agpoINUJNKoxT6jjwLdIPKlYS+TLWvc+a1bwy5Pu70qMjsB/y7aNJ72Gg23zw==
X-Received: by 2002:a65:4b89:: with SMTP id t9mr9307336pgq.102.1580196015485;
 Mon, 27 Jan 2020 23:20:15 -0800 (PST)
Date:   Mon, 27 Jan 2020 23:19:55 -0800
Message-Id: <20200128072002.79250-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 0/7] kunit: create a centralized executor to dispatch all
 KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
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
The last two of three patches in this series add features which depend
on this:

PATCH 5/7 Prints out a test plan right before KUnit tests are run[1];
          this is valuable because it makes it possible for a test
          harness to detect whether the number of tests run matches the
          number of tests expected to be run, ensuring that no tests
          silently failed.

PATCH 6/7 Add a new kernel command-line option which allows the user to
          specify that the kernel poweroff, halt, or reboot after
          completing all KUnit tests; this is very handy for running
          KUnit tests on UML or a VM so that the UML/VM process exits
          cleanly immediately after running all tests without needing a
          special initramfs.

In addition, by dispatching tests from a single location, we can
guarantee that all KUnit tests run after late_init is complete, which
was a concern during the initial KUnit patchset review (this has not
been a problem in practice, but resolving with certainty is nevertheless
desirable).

Other use cases for this exist, but the above features should provide an
idea of the value that this could provide.

Alan Maguire (1):
  kunit: test: create a single centralized executor for all tests

Brendan Higgins (5):
  vmlinux.lds.h: add linker section for KUnit test suites
  arch: um: add linker section for KUnit test suites
  init: main: add KUnit to kernel init
  kunit: test: add test plan to KUnit TAP format
  Documentation: Add kunit_shutdown to kernel-parameters.txt

David Gow (1):
  kunit: Add 'kunit_shutdown' option

 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/um/include/asm/common.lds.S              |  4 +
 include/asm-generic/vmlinux.lds.h             |  8 ++
 include/kunit/test.h                          | 82 ++++++++++++-------
 init/main.c                                   |  4 +
 lib/kunit/Makefile                            |  3 +-
 lib/kunit/executor.c                          | 71 ++++++++++++++++
 lib/kunit/test.c                              | 11 ---
 tools/testing/kunit/kunit_kernel.py           |  2 +-
 tools/testing/kunit/kunit_parser.py           | 76 ++++++++++++++---
 .../test_is_test_passed-all_passed.log        |  1 +
 .../test_data/test_is_test_passed-crash.log   |  1 +
 .../test_data/test_is_test_passed-failure.log |  1 +
 13 files changed, 217 insertions(+), 54 deletions(-)
 create mode 100644 lib/kunit/executor.c

-- 
2.25.0.341.g760bfbb309-goog

