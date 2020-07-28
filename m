Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95677C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795D62075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgG1W5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38990 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbgG1W5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id w9so16228061qts.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jurQF93+85jwDZNwqfmqXsgKLM5ROOgolOX/GMRL9vk=;
        b=uT+Jy7+WX8yXLByXdr7y5gbxN24pSCqW7UoFKQoXiku6WydFVHBM3At+8A28yLQIIK
         qFAcI1x9NrIC+kyfjJfAA4SyBovUntTawPTIcN/+XgezzwmSX1kzHu+auoa6EzhMZJD9
         2IUfwWvw1UMX3lkKKChAQGGJKvvWQvOsmKCgoFBUhAGwDS8i3tVbq2LlJ8Q8xw4IdhzB
         hMHqcPvnmBUGZ/R/wjGwe4+PboCj+0VGRhsbkJ3oyfbG9ssKoHZGEPAUbTix8U6VBGf6
         2vUuqrHizqGVUarE/P3ILS2q6QVvv2WvB6Ih7qnGDfB6oswggPYLTkhUUZqiQwgoo0uI
         QMaA==
X-Gm-Message-State: AOAM532utE5H+2RwBpRDsrQ5S9psDcsMT1PfQ8pWlPRNN3jmoX3mSEv/
        AqeoMFiFPXgU6p7zklxgmLA=
X-Google-Smtp-Source: ABdhPJwzAG77024gLGy3/O8wRBtBBMtjtcehAvVp+4oNxomR2s32VbinxBKeHDuwMhOdoXP787dtnA==
X-Received: by 2002:ac8:4e2f:: with SMTP id d15mr28808653qtw.20.1595977043478;
        Tue, 28 Jul 2020 15:57:23 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/21] x86/kaslr: Cleanup and small bugfixes
Date:   Tue, 28 Jul 2020 18:57:01 -0400
Message-Id: <20200728225722.67457-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
- Fix the first patch: command line size should be strlen + 1 to account
  for terminating NUL. Avoid calling add_identity_map if cmdline was
  NULL, though it should do nothing in that case anyway.
- Add a patch to drop the check to see if there are arguments we care
  about before parsing the command line.
- Split up patches (Ingo/Kees).
- The gb_huge_pages change now also gets rid of parsing the argument
  altogether for 32-bit.
- Slot number is changed to unsigned long instead of unsigned int
  (Kees).
- Make everything u64 instead of trying to use 32-bit on x86-32, and add
  check in find_random_phys_addr to make sure the address is within the
  required range (Ingo/Kees).

v1->v2:
- Fix a bug in the bugfix 5/8: overlap.start can be smaller than
  region.start, so shouldn't subtract before comparing.


Arvind Sankar (21):
  x86/kaslr: Make command line handling safer
  x86/kaslr: Remove bogus warning and unnecessary goto
  x86/kaslr: Fix process_efi_entries comment
  x86/kaslr: Initialize mem_limit to the real maximum address
  x86/kaslr: Fix off-by-one error in __process_mem_region
  x86/kaslr: Drop redundant cur_entry from __process_mem_region
  x86/kaslr: Eliminate start_orig from __process_mem_region
  x86/kaslr: Drop redundant variable in __process_mem_region
  x86/kaslr: Drop some redundant checks from __process_mem_region
  x86/kaslr: Fix off-by-one error in process_gb_huge_pages
  x86/kaslr: Short-circuit gb_huge_pages on x86-32
  x86/kaslr: Simplify process_gb_huge_pages
  x86/kaslr: Drop test for command-line parameters before parsing
  x86/kaslr: Make the type of number of slots/slot areas consistent
  x86/kaslr: Drop redundant check in store_slot_info
  x86/kaslr: Drop unnecessary alignment in find_random_virt_addr
  x86/kaslr: Small cleanup of find_random_phys_addr
  x86/kaslr: Make minimum/image_size unsigned long
  x86/kaslr: Replace unsigned long long with u64
  x86/kaslr: Make local variables 64-bit
  x86/kaslr: Add a check that the random address is in range

 arch/x86/boot/compressed/kaslr.c | 233 +++++++++++++------------------
 arch/x86/boot/compressed/misc.h  |   4 +-
 2 files changed, 102 insertions(+), 135 deletions(-)

-- 
2.26.2

