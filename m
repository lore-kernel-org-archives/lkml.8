Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77912072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EONDCuS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHZBkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgHZBkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:40:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BC4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 18:40:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a14so728417ybm.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 18:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5gbbSEIbK4yWfAq5tI3QZ5QR0T3vBYa40yqv00FjnKE=;
        b=EONDCuS+3d189+D8AI/ERnlF2MPUIT7CBrakxJTU20KFNPZczvwfsf1FS7U8Zf4ab7
         RLTnMSpLwpGgvo9sEQb4SABuuS8pidp1RWTGa6ZtAZp9jBilnvom2oWEtMAtK8g9iQ/4
         TwhmyRdfMWBu8+9tQlT2FA6xDjRZ1Uv1DM1L4vIQz0LhLMj72Swg6ag5Oj4MkhE90jsI
         LQrA7K4nJV480H+LBMNtxrYT8HvxiZCHIfLE73B6gTp7oPCvXkoTXz5lSwmJ+T2UY4vW
         +afTo7Jj4t7u/TZGLO+qfjQBwfh19BzspsByBUfGZNEiUg7JUgj9917P0P1DFTJ6MqFQ
         p80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5gbbSEIbK4yWfAq5tI3QZ5QR0T3vBYa40yqv00FjnKE=;
        b=md3i5sBtlZvmGiUXPTx9jk0b26FWQ17dcTV8ByuYSHsksdjHcyj+Hk9ClkWPgMV2zK
         idMsEDLNaFeA3AQlb7PYwkZshk1V3cV4O2rm/ruwc91e6FsPq+p1df8Jfj2GFZCEygHM
         DkwOk8s1BVQo64MvNfgxSNZ6BAjjJtfMfiY05UFIS4C7O3g8Lhe0LZMmhPQVCCpGsrAA
         QmfUap1fKj0IM15C3KNP2NxkAsEvrgR7ydK8vgmM8NtcJKJzlRKA0pNioCfdsvwGoh9S
         qwimVQ2TTUNGh2oztkKg3Pm7xEPmRHT5NC2XwWjNmy4KxtbId6cPSzc1sZeqech00/wx
         Yo5Q==
X-Gm-Message-State: AOAM531VjKajmesfYlXDHQOhwpAN99IjMPbQNE+lMAieJ7eP/rQDUPtC
        C+eAumUU790gqrog3Gj6iZpzCrsvUckV1ehdvg==
X-Google-Smtp-Source: ABdhPJxGz/85hOODz7qBm7E2cIdEfrCvaBHLShAkLac9WkQj0OvIYzr7pzQHum6uPD4aip5+AhIe/HXpy8UENxoUeg==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a25:7643:: with SMTP id
 r64mr20062213ybc.109.1598406003331; Tue, 25 Aug 2020 18:40:03 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:39:57 -0700
Message-Id: <20200826013959.1981270-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v3 0/2] Control over userfaultfd kernel-fault handling
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is split from [1]. The other series enables SELinux
support for userfaultfd file descriptors so that its creation and
movement can be controlled.

It has been demonstrated on various occasions that suspending kernel
code execution for an arbitrary amount of time at any access to
userspace memory (copy_from_user()/copy_to_user()/...) can be exploited
to change the intended behavior of the kernel. For instance, handling
page faults in kernel-mode using userfaultfd has been exploited in [2, 3].
Likewise, FUSE, which is similar to userfaultfd in this respect, has been
exploited in [4, 5] for similar outcome.

This small patch series adds a new flag to userfaultfd(2) that allows
callers to give up the ability to handle kernel-mode faults with the
resulting UFFD file object. It then adds a 'user-mode only' option to
the unprivileged_userfaultfd sysctl knob to require unprivileged
callers to use this new flag.

The purpose of this new interface is to decrease the chance of an
unprivileged userfaultfd user taking advantage of userfaultfd to
enhance security vulnerabilities by lengthening the race window in
kernel code.

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://duasynt.com/blog/linux-kernel-heap-spray
[3] https://duasynt.com/blog/cve-2016-6187-heap-off-by-one-exploit
[4] https://googleprojectzero.blogspot.com/2016/06/exploiting-recursion-in-linux-kernel_20.html
[5] https://bugs.chromium.org/p/project-zero/issues/detail?id=808

Changes since v2:

  - Removed 'uffd_flags' and directly used 'UFFD_USER_MODE_ONLY' in
    userfaultfd().

Changes since v1:

  - Added external references to the threats from allowing unprivileged
    users to handle page faults from kernel-mode.
  - Removed the new sysctl knob restricting handling of page
    faults from kernel-mode, and added an option for the same
    in the existing 'unprivileged_userfaultfd' knob.

Lokesh Gidra (2):
  Add UFFD_USER_MODE_ONLY
  Add user-mode only option to unprivileged_userfaultfd sysctl knob

 Documentation/admin-guide/sysctl/vm.rst | 10 +++++++---
 fs/userfaultfd.c                        | 16 +++++++++++++---
 include/uapi/linux/userfaultfd.h        |  9 +++++++++
 kernel/sysctl.c                         |  2 +-
 4 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog

