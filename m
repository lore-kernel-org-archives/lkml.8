Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6ADC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A267620718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gayc+oHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAWSEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:04:43 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:56131 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgAWSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:42 -0500
Received: by mail-pj1-f73.google.com with SMTP id bg6so2014111pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kn8HZu/EyvR9ymq67hLBoXpwH5gJWxf8SifOgi6S8zE=;
        b=gayc+oHAI9zN5b0/03xCzShBxN/WC8D2wZUQzrvrA4a8Ok5/cCHnf7ocuW/udyqRq4
         qNvLtjz/r0qjh1yMl+DIt1S4o06FzUbNUdkF38Z+c8RTEvh1cChTO05OT/w5Lz9tGbrO
         wclRK3FhRL9yqoFyuLusmCJ5xdoWnB5shFaIEtDQ4LRKbKzCZndBeju/xwFnze+oxnI5
         RZC4MZ6u+xrlAxJXHTDlPLLAyt12nO7334cKIbKC5AihX2UgL+VvIipsoK88othnIzKa
         ZYl515ugP/UefCp2y1q2ADAgQ7RVyxOJETooXL13wpPg57v1hwY/SXmLoKN4fSflTDVI
         Wjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kn8HZu/EyvR9ymq67hLBoXpwH5gJWxf8SifOgi6S8zE=;
        b=iKgfFx8INIlrjs5RroIGLGPsfsbjwXZXxZXFFW8LGT+anRK1akTou+N+aadTChXFMT
         TotZdw0lCpIh6MGBvzJXdk8HIm0jlumFMpjyAYl7pZ0ZOTNbpfAyXNIWQmS5wrpUgL1s
         GAjxsO7AyMJMPlCUbBKBS2Db6Lu6Ylm19dbnh1Mmvj2R/CtPB/uPVOWdAV/UXIZ8wkTP
         FQCuTlGEwSFhcj1EWmfQQfAzZV0Jw5SjN09oYKuSkYCIbBUjk5Gzm730Cq7ISauhZZea
         PL8igeaMwuHYbl8twXrLYwQhRyc5rtKdZfpjCDX0lkL3IK+5QWylxnJ0cc/lGwpWCcbw
         v8KQ==
X-Gm-Message-State: APjAAAXeG6Mm1YBEWqgEoT8SUGLSGmTE08G6ZtUcMErTJWM7FbxcENs0
        AxdhthdOhHaFbPZfMgf0SpkTf2CrIABLLEjnm6ts7uQ9391jI+Gp/ZrsiFcW5kWOnNl3heXIYc3
        MkgGiXThEbZsPri2zELGnJI9Uq3BDEbdNNXTGHljO6q4qAcG6hZ86TE/4PI3NiK9g7NY3OnqC
X-Google-Smtp-Source: APXvYqxqrRXE16kM6yIDMn+KPoeZ2CKFEsGQZqIPRn2ZutzCuwTTppZzgh96c6OwNyyUAmd6AOoMidiREkQL
X-Received: by 2002:a63:3cb:: with SMTP id 194mr5353607pgd.123.1579802681044;
 Thu, 23 Jan 2020 10:04:41 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:26 -0800
Message-Id: <20200123180436.99487-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 00/10] Create a userfaultfd demand paging test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling page faults for many vCPUs during demand paging, KVM's MMU
lock becomes highly contended. This series creates a test with a naive
userfaultfd based demand paging implementation to demonstrate that
contention. This test serves both as a functional test of userfaultfd
and a microbenchmark of demand paging performance with a variable number
of vCPUs and memory per vCPU.

The test creates N userfaultfd threads, N vCPUs, and a region of memory
with M pages per vCPU. The N userfaultfd polling threads are each set up
to serve faults on a region of memory corresponding to one of the vCPUs.
Each of the vCPUs is then started, and touches each page of its disjoint
memory region, sequentially. In response to faults, the userfaultfd
threads copy a static buffer into the guest's memory. This creates a
worst case for MMU lock contention as we have removed most of the
contention between the userfaultfd threads and there is no time required
to fetch the contents of guest memory.

This test was run successfully on Intel Haswell, Broadwell, and
Cascadelake hosts with a variety of vCPU counts and memory sizes.

This test was adapted from the dirty_log_test.

The series can also be viewed in Gerrit here:
https://linux-review.googlesource.com/c/virt/kvm/kvm/+/1464
(Thanks to Dmitry Vyukov <dvyukov@google.com> for setting up the Gerrit
instance)

v4 (Responding to feedback from Andrew Jones, Peter Xu, and Peter Shier):
- Tested this revision by running
  demand_paging_test
  at each commit in the series on an Intel Haswell machine. Ran
  demand_paging_test -u -v 8 -b 8M -d 10
  on the same machine at the last commit in the series.
- Readded partial aarch64 support, though aarch64 and s390 remain
  untested
- Implemented pipefd polling to reduce UFFD thread exit latency
- Added variable unit input for memory size so users can pass command
  line arguments of the form -b 24M instead of the raw number or bytes
- Moved a missing break from a patch later in the series to an earlier
  one
- Moved to syncing per-vCPU global variables to guest and looking up
  per-vcpu arguments based on a single CPU ID passed to each guest
  vCPU. This allows for future patches to pass more than the supported
  number of arguments for each arch to the vCPUs.
- Implemented vcpu_args_set for s390 and aarch64 [UNTESTED]
- Changed vm_create to always allocate memslot 0 at 4G instead of only
  when the number of pages required is large.
- Changed vcpu_wss to vcpu_memory_size for clarity.

Ben Gardon (10):
  KVM: selftests: Create a demand paging test
  KVM: selftests: Add demand paging content to the demand paging test
  KVM: selftests: Add configurable demand paging delay
  KVM: selftests: Add memory size parameter to the demand paging test
  KVM: selftests: Pass args to vCPU in global vCPU args struct
  KVM: selftests: Add support for vcpu_args_set to aarch64 and s390x
  KVM: selftests: Support multiple vCPUs in demand paging test
  KVM: selftests: Time guest demand paging
  KVM: selftests: Stop memslot creation in KVM internal memslot region
  KVM: selftests: Move memslot 0 above KVM internal memslots

 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   5 +-
 .../selftests/kvm/demand_paging_test.c        | 680 ++++++++++++++++++
 .../testing/selftests/kvm/include/test_util.h |   2 +
 .../selftests/kvm/lib/aarch64/processor.c     |  33 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  27 +-
 .../selftests/kvm/lib/s390x/processor.c       |  35 +
 tools/testing/selftests/kvm/lib/test_util.c   |  61 ++
 8 files changed, 839 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/demand_paging_test.c
 create mode 100644 tools/testing/selftests/kvm/lib/test_util.c

-- 
2.25.0.341.g760bfbb309-goog

