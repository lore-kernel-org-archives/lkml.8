Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6180C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC34204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qa2EBwHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgIAQPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgIAQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:15:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A32C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 09:15:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so845479pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jzUV1ToBnPSzuyXeMWjIThN/0jU4c6GM1tdII/RDC3M=;
        b=Qa2EBwHkepYbnrf459ys3AYVZFFdsy1Y3PcpfKOk3PfdKt+pLJB8U9oVzNpEzsyn73
         YFhI7tgxaZlR+EQY6LKBh0OcrLFzNkJmd3raQkpfsBIYdVMtEyMYZZx0GswKGIltGToS
         G+uVYCKvKUVjKNH1ohJVwguCQ0DX0f8P/hji9zzx4ngf5JHGzDo75ejUk+h6ev8VX1qL
         PH6vImgO4a4OjgHWREmh7SaejKv/eLj2HSzfVN/peM0nFBBvbaKTj2IJws9f51ZPKe8i
         gP1yhhiCkfgGvlsiBbCElMYUZ0bmiI+R+nL6zhf4Xp9kn0huqiAqvzocpUd5egE7ijhv
         nybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jzUV1ToBnPSzuyXeMWjIThN/0jU4c6GM1tdII/RDC3M=;
        b=QLpZFr/rTDOuhycjlhH3ogh/Yw4DDAUwR4BN6Z8SN898v/+IZgb/IYyIteWGQ1buV4
         ok13dzOt6HPLNXpErnGhh5kr3xfOekYDxe+p554xkxOwilFV7tIZwp594DgwwUtCAGY3
         AESfQ4jcVpe519+r7MB6IqDFyJw1XmsSe+agUWr1jzXaj192nN4gJ/GKpaeaBa5AJ8vC
         xcmLcAIhYbFAuK/yU+6OUxq6O+tNLYhzxB1LUnxdE6wytPh65Ua0WoGp2jO3g+EGV0eI
         oL1kBLOOT0MMlSkB6ZR6SfoGydYdY+aZ/7Bu1wxVWHjKqB8ylbXEqzRN57uwCNC7BcJQ
         ZqNw==
X-Gm-Message-State: AOAM5308BOtp5B2iChdo9dDIAHDghKFrJQ+ILHVcz/Ehq3PEuRnvdzUn
        B9extPi4ajQv2zmeOo8H/gaE5g==
X-Google-Smtp-Source: ABdhPJz+CXSBMLxjORPZ02TS54ZJrZBVY0+DTj3EswB4Eolon8bJ/NdGrtm/qHdYBJE0ZZeswpFkyA==
X-Received: by 2002:a17:902:b683:: with SMTP id c3mr2069892pls.248.1598976914697;
        Tue, 01 Sep 2020 09:15:14 -0700 (PDT)
Received: from nagraj.lan ([175.100.146.50])
        by smtp.gmail.com with ESMTPSA id d77sm2553169pfd.121.2020.09.01.09.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 09:15:13 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Colin Cross <ccross@google.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michel Lespinasse <walken@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        chenqiwu <chenqiwu@xiaomi.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Adrian Reber <areber@redhat.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v7 0/3] Anonymous VMA naming patches
Date:   Tue,  1 Sep 2020 21:44:56 +0530
Message-Id: <20200901161459.11772-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version v4 of these patches was sent by Colin Cross a long time ago [1]
and [2]. At the time, these patches were not merged, and it looks like they
just fell off the radar since.

In our efforts to run Android on mainline kernels, we realised that since past
some time, this patchset is needed for Android to boot, hence I am re-posting
it to try and get these discussed and hopefully merged.

I have rebased these for v5.9-rc3 and fixed minor updates as required.

---
v6: Rebased to v5.9-rc3 and addressed review comments:
    - added missing callers in fs/userfaultd.c
    - simplified the union
    - use the new access_remote_vm_locked() in show_map_vma() since that
       already holds mmap_lock
v7: fixed randconfig build failure when CONFIG_ADVISE_SYSCALLS isn't defined

Colin Cross (2):
  mm: rearrange madvise code to allow for reuse
  mm: add a field to store names for private anonymous memory

Sumit Semwal (1):
  mm: memory: Add access_remote_vm_locked variant

 Documentation/filesystems/proc.rst |   2 +
 fs/proc/task_mmu.c                 |  24 +-
 fs/userfaultfd.c                   |   7 +-
 include/linux/mm.h                 |  14 +-
 include/linux/mm_types.h           |  25 +-
 include/uapi/linux/prctl.h         |   3 +
 kernel/sys.c                       |  32 +++
 mm/interval_tree.c                 |   2 +-
 mm/madvise.c                       | 356 +++++++++++++++++------------
 mm/memory.c                        |  49 +++-
 mm/mempolicy.c                     |   3 +-
 mm/mlock.c                         |   2 +-
 mm/mmap.c                          |  38 +--
 mm/mprotect.c                      |   2 +-
 14 files changed, 381 insertions(+), 178 deletions(-)

-- 
2.28.0

