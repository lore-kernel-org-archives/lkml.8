Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B96C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7FB2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rv2jM3Dg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgDASJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:09:14 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:44730 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbgDASJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:09:14 -0400
Received: by mail-pj1-f74.google.com with SMTP id t7so802069pjb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jmllqegwWYAse5zHietOLbFHZdle7VlA5/QFT40kKC8=;
        b=Rv2jM3DgzSP4Xgu5R0bGlbm/XbkjWgjn9ZfxagNK/fsTGyOPNrB1GQnZB7E9xUQGhM
         HymPJy1XezMr1M8wxNVgCxl2s3SL5YIMRiHzHxQ+N8Tm9g4CE8l/eV769aP0lmhUqw30
         WO5cecwf8lips48fgnBJrCUMGiNTl3nZg0xnRu/8Ey0ZlaEygBY6633+f66FFnmvZfdU
         a1E5N43q18UK6/1lSXUufsmbfBBAKTiOJ7uEdKbGRWLUHgPpOE38ux5OJezhCj2tD2v6
         NHs/R55WHObGci9vAS1nbsO/jOXONQSHDsebLkOgWVwkfwTura+ZUaSU0yZibHZ0ntM2
         nZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jmllqegwWYAse5zHietOLbFHZdle7VlA5/QFT40kKC8=;
        b=jpcDbcjJd3JsKA6y7J1CBsTcmGpuA/jv2Ttmt5gYGnhEb8ZtnW9/gcmDuxdni28Rji
         dtj+dWKUyDVet061Oy8SmmAsQsWgzMKgDNjRIyWIQbDs8Q5nckus539TWsc5GtQNghkF
         wrVAmb0v7N6O/38xycIvEPMRyxJYqmHCGrU8pkkfbBqXa+j07k1Ps5+xskLCXBvbdBRp
         FoBwVV30xO/vtWNJehGS0QEwMSbl5+t/mY0CRRsKJV86L6mt2UiAZ8rVyp+piV3tGYKo
         YveWj/PpnYnq0gpI1zTPaKhEMELmRUZ0QYA9Vq0KBP8B5FAsgbY9g0gH4ftN6PUXXTnW
         2Ykg==
X-Gm-Message-State: AGi0PuYfuXKBYtwt5ZXeuakLcWYSC2EdxNzp5W+4Jts5xDyzlZIrZV4m
        RDrmbtIf8VbR5SZXnxJeY9dE4/BcCsSoWXriyus=
X-Google-Smtp-Source: APiQypJThTvE5BVy1/uDkIgtR6oC6K45RKp+7YCT9Dy8l4iKdORgDudBLxhldR7SZFjRpPEx8cKSPb5x2GDuF+Dv+9Q=
X-Received: by 2002:a17:90a:25a8:: with SMTP id k37mr6384885pje.14.1585764551345;
 Wed, 01 Apr 2020 11:09:11 -0700 (PDT)
Date:   Wed,  1 Apr 2020 11:09:03 -0700
Message-Id: <20200401180907.202604-1-trishalfonso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 0/4] KUnit-KASAN Integration
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

Convert KASAN tests to KUnit with the exception of copy_user_test
because KUnit is unable to test those.

Add documentation on how to run the KASAN tests with KUnit and what to
expect when running these tests.

Depends on [1].

Changes since v2:
 - Due to Alan's changes in [1], KUnit can be built as a module.
 - The name of the tests that could not be run with KUnit has been
 changed to be more generic: test_kasan_module.
 - Documentation on how to run the new KASAN tests and what to expect
 when running them has been added.
 - Some variables and functions are now static.
 - Now save/restore panic_on_warn in a similar way to kasan_multi_shot
 and renamed the init/exit functions to be more generic to accommodate.
 - Due to [2] in kasan_strings, kasan_memchr, and
 kasan_memcmp will fail if CONFIG_AMD_MEM_ENCRYPT is enabled so return
 early and print message explaining this circumstance.
 - Changed preprocessor checks to C checks where applicable.

[1] https://lore.kernel.org/linux-kselftest/1585313122-26441-1-git-send-email-alan.maguire@oracle.com/T/#t
[2] https://bugzilla.kernel.org/show_bug.cgi?id=206337

Patricia Alfonso (4):
  Add KUnit Struct to Current Task
  KUnit: KASAN Integration
  KASAN: Port KASAN Tests to KUnit
  KASAN: Testing Documentation

 Documentation/dev-tools/kasan.rst |  70 +++
 include/kunit/test.h              |   5 +
 include/linux/kasan.h             |   6 +
 include/linux/sched.h             |   4 +
 lib/Kconfig.kasan                 |  15 +-
 lib/Makefile                      |   3 +-
 lib/kunit/test.c                  |  13 +-
 lib/test_kasan.c                  | 686 +++++++++++++-----------------
 lib/test_kasan_module.c           |  76 ++++
 mm/kasan/report.c                 |  33 ++
 10 files changed, 521 insertions(+), 390 deletions(-)
 create mode 100644 lib/test_kasan_module.c

-- 
2.26.0.rc2.310.g2932bb562d-goog

