Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77371C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F6F2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="m5SmGIhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgHUXjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHUXix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:38:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55677C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:38:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w11so3748583ybi.23
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=AIeTG1aOto6QWgzjIJ7H0uGNsioq4yEktBb08O5yHtY=;
        b=m5SmGIhzd05a7usVFpx1WGCmCRqFe0EP+v3QLGfMdweg1+TjucvJm7w9yxElHiA7KT
         XA+Ju20DOAzsQ+m+y0F9VZPmT5MdlXRyuHY3qpw/GQqeMEYTxITwSPYXkKvhRaDTQ6vW
         4yT9s+FUaYsOp7muv2lAQIQRsoIQkWrC/vT9hPoZ6+1ai51LCES5f2cmJ8m0FYg2HUwj
         2Q4i6lEQLUZctl2qRkSAtGo9g31jabDk+2x88RZUznEHkdpAcdMfy3YQYniw++q17rgK
         VohREQw64MKUZU1Fd+zlzqEmCNcoXiHBxHkhNRLylIALkWkd1IIRTm8j/EKOav7EGGPq
         FS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=AIeTG1aOto6QWgzjIJ7H0uGNsioq4yEktBb08O5yHtY=;
        b=qVYnOfFanvqQ3k8fQTicOW58zP3QPd/4WX6zGnmcLqSGV9/01fGWJgVHZstzagGr98
         Wvjc7IcNPENbIUOQV5d21qtkLfOUS8RWQCW4guRpaWPc9udrUrpNxDCY/fj7Pu+nMPs9
         ayzx3QED/7nyUY4kuo9WjRq4ywtvbA8YlWhXJDtuY14U2KavVcJoqAVatw8oqIaD6Q2M
         TBDoDSjukzR9IzQA2x/ai8ylNH8d/srbvPMlTSaWLHLUR5TVR42nX8frI62/uRSS6koK
         cYBOeTX6DqWWKC1Q+D5Cro0DP3ltuCLzNSPkK35nDArpuJV1tp4HzCdgr4fUy05/EtDD
         uTew==
X-Gm-Message-State: AOAM531uurzx6fAcBHrWYU6MQ30FkFUZBhzmAWczyP1ECSsVKHqAuCej
        ejU2wukqNeBASIlcHB7P/tjosmPMyw+i0Fg=
X-Google-Smtp-Source: ABdhPJxzWhuKaZWd7UdTjEpC3MrtsB7oSdznkzYO8NxREmTlTFJCKmi8a7hKrxUtQoP0NYhbQ52/aq9uy5Dz2Hk=
X-Received: from ckennelly28.nyc.corp.google.com ([2620:0:1003:1003:3e52:82ff:fe5a:a91a])
 (user=ckennelly job=sendgmr) by 2002:a25:2489:: with SMTP id
 k131mr7431236ybk.221.1598053131440; Fri, 21 Aug 2020 16:38:51 -0700 (PDT)
Date:   Fri, 21 Aug 2020 19:38:46 -0400
Message-Id: <20200821233848.3904680-1-ckennelly@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 0/2] Selecting Load Addresses According to p_align
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ELF loading mechancism provides page-aligned mappings.  This
can lead to the program being loaded in a way unsuitable for
file-backed, transparent huge pages when handling PIE executables.

While specifying -z,max-page-size=0x200000 to the linker will generate
suitably aligned segments for huge pages on x86_64, the executable needs
to be loaded at a suitably aligned address as well.  This alignment
requires the binary's cooperation, as distinct segments need to be
appropriately paddded to be eligible for THP.

For binaries built with increased alignment, this limits the number of
bits usable for ASLR, but provides some randomization over using fixed
load addresses/non-PIE binaries.

Changes V3 -> V4:
* Code tweaks based on on-thread feedback
* Addressed compiler warning

Changes V2 -> V3:
* Minor code tweaks based on off-thread feedback

Changes V1 -> V2:
* Added test

Chris Kennelly (2):
  fs/binfmt_elf: Use PT_LOAD p_align values for suitable start address.
  Add self-test for verifying load alignment.

 fs/binfmt_elf.c                             | 25 ++++++++
 tools/testing/selftests/exec/.gitignore     |  1 +
 tools/testing/selftests/exec/Makefile       |  9 ++-
 tools/testing/selftests/exec/load_address.c | 68 +++++++++++++++++++++
 4 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/exec/load_address.c

-- 
2.28.0.297.g1956fa8f8d-goog

