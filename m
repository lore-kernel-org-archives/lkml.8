Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CFF206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXZgt6M0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIAJTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAJTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:19:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B9C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 02:19:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q3so229983pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKDhu57eucllC3stfGqQp1RE01bX+WGNmYWYWmVH8uA=;
        b=RXZgt6M0hedr66aPYeE2aauHPij9YS02v77RUWGPdFoRPTmaHiWoV2/ZHZGvh2s+PH
         z8B4C/jKSh6jqgfT68oeMtzuwAbB17NiYecsPX6EPenPw5YQNEJIot+4EXtvBiVDIUYj
         wAnkzO7OHtxYdN/UTr1YslXdsXWMtlhFSqNjPPRoEE21Y3vbuhXzaiWig/GqXceOHNrn
         4FrFXHeqnQojl9FcQNEmRS6zxtRZTp6PcYdWrZnD6u+GS9TEt5HDI/8LtOkgSs0DP1W/
         ebBBKVWfe7ZAjjC+FCpWfpjBoMZeTrcb4ERxEorsNO2Co7B0GJ4o1kROXApEH3lLX0yG
         8Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKDhu57eucllC3stfGqQp1RE01bX+WGNmYWYWmVH8uA=;
        b=b+IaBDe0gOTXEZ9SuOgC2zem6eRo0zbwaCtNTR0MiaquoeG5jx3i8aTWlZcHXPKPO7
         LDLaOnEAoLkfia1CWMvSxg//WMvRhk7JCI4n4xbAsS0c2gA2htrIMn0++qFzI4c8Z/fE
         kdPuk9Hg8Y9SOSsui0fiXAQkgbGcFxqYVdPDiNAtiPM8HCw9TKKhaJEALUeLmbtNkCa4
         onT7LHM2NfF4rDZK54tOLSmg3Ay5JUT58RW0sv/QDO1yrgVP4oC7ULRZRUTIDkRCvqjV
         koGkfZsREIzXH6bqQgdDL18cbNf2koBnI7l7MfSHBnJZLC10NEPdjSdhKZHtMzh90pod
         7wBg==
X-Gm-Message-State: AOAM532kOCMjRBj/7OHo/5w2rZskkC7JUSN/GqHpAZS0CTSxGQxTEaHc
        FwqP47Bk1WGziaVuyq9dVNQCyA==
X-Google-Smtp-Source: ABdhPJxNhlDc7MD1X6GJIQAMM12QfFMgW/k9pVSpFNWL3PeQOJU5cYC3DaCNmL0oO3FG1jrng2zvKw==
X-Received: by 2002:a17:90a:e98f:: with SMTP id v15mr684361pjy.41.1598951957568;
        Tue, 01 Sep 2020 02:19:17 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id u191sm1337707pgu.56.2020.09.01.02.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 02:19:16 -0700 (PDT)
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
        Thomas Cedeno <thomascedeno@google.com>,
        linux-fsdevel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v6 0/3] Anonymous VMA naming patches
Date:   Tue,  1 Sep 2020 14:48:58 +0530
Message-Id: <20200901091901.19779-1-sumit.semwal@linaro.org>
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

For v5, I rebased these for v5.9-rc3 and fixed minor updates as required.

---
v6: Rebased to v5.9-rc3 and addressed review comments:
    - added missing callers in fs/userfaultd.c
    - simplified the union
    - use the new access_remote_vm_locked() in show_map_vma() since that
       already holds mmap_lock

[1]: https://lore.kernel.org/linux-mm/1383170047-21074-1-git-send-email-ccross@android.com/
[2]: https://lore.kernel.org/linux-mm/1383170047-21074-2-git-send-email-ccross@android.com/

Best,
Sumit.

Colin Cross (2):
  mm: rearrange madvise code to allow for reuse
  mm: add a field to store names for private anonymous memory

Sumit Semwal (1):
  mm: memory: Add access_remote_vm_locked variant

 Documentation/filesystems/proc.rst |   2 +
 fs/proc/task_mmu.c                 |  24 +-
 fs/userfaultfd.c                   |   7 +-
 include/linux/mm.h                 |   7 +-
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
 14 files changed, 374 insertions(+), 178 deletions(-)

-- 
2.28.0

