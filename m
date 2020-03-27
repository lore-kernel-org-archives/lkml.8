Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562D8C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299952073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="d5Htk3uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgC0RG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:06:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40902 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgC0RGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:06:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id 19so10949928ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPiYQU9lO5biWqzE5gRv0d6ffIyj9ud5WElOpnXNcJU=;
        b=d5Htk3uOkHuKfVYikbo3VhAb7ueKn1UtMjJ3iVQP08RCYqdyTKISnELs2Dyop9JaJ3
         bzr4lCd5P9s/Q9gpLTlwi2eRVwFYDH3AcUues7X4g77QQdBSKz4EaF/b1PFI9JaS+IJi
         9L4IvqJgSIXGzqgjdlBYa/YnGsj9EqNeS+XWebQUky3B/Jw6Yhxt9scxvx028I2XJrL1
         f7oic21ds5O1pImnl41obLTQFNd2RVNKSnE55HhvlltzFV/D7jJkUaW01ZeipjZwKlVr
         cannKNm7n57jy9KSJsZMWOAL0hDklcFlfRiWwORCfF3IsuHoCNpsQA6ctrR8jiTYkn5i
         PrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPiYQU9lO5biWqzE5gRv0d6ffIyj9ud5WElOpnXNcJU=;
        b=Kt+pSxQSiyGOGip3NLIsmXSZISq62+zpclmtA4+/Xx6SOM02eVj9JDB2nYSwspvJYs
         5eptqwOBBHT2PuoqZDsyuivtE0dxDstrdt6/oC6qs8QhLC6eNhXvqTRG3ykX61mTxaks
         eOusMuAXDmcsCPG/08NwOjZOqbxbUGQOabe27vjKFWk9TS4RN+cltM8b0L7K71o/wLt+
         Ira+L1p94GdhqyjR++dAviqllhowMgRSjUsr0Jsh5nxah3nex9DR3dw5OH2i2an5dFVv
         6bOt3pl1G4UMq/cmMI3JoTwsVl62Bm4sqQ1n+66K8FlMI39EyH1XZAp1m9wjL9WeQkKK
         YTzg==
X-Gm-Message-State: AGi0PuZrKMP1s6U3XDqZjiBZ8plghqykLJWhvQX/+Xyp4xfVob8KG3zS
        QQkf+AhVdCfY8YsAZ1VueodDVw==
X-Google-Smtp-Source: APiQypJLALeXcx+yXtPsyw9ITyRblR+4nUxsp2NRHWMj6K+9Xm6k69PdiGCGFwzQWP0Q1zx9TpUdcw==
X-Received: by 2002:a2e:8195:: with SMTP id e21mr5295041ljg.49.1585328763673;
        Fri, 27 Mar 2020 10:06:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i11sm3265630lfo.84.2020.03.27.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:06:03 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 5679F100D24; Fri, 27 Mar 2020 20:06:07 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/7] thp/khugepaged improvements and CoW semantics
Date:   Fri, 27 Mar 2020 20:05:54 +0300
Message-Id: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds khugepaged selftest (anon-THP only for now), expands
cases khugepaged can handle and switches anon-THP copy-on-write handling
to 4k.

Please review and consider applying.

Kirill A. Shutemov (7):
  khugepaged: Add self test
  khugepaged: Do not stop collapse if less than half PTEs are referenced
  khugepaged: Drain LRU add pagevec to get rid of extra pins
  khugepaged: Allow to callapse a page shared across fork
  khugepaged: Allow to collapse PTE-mapped compound pages
  thp: Change CoW semantics for anon-THP
  khugepaged: Introduce 'max_ptes_shared' tunable

 Documentation/admin-guide/mm/transhuge.rst |   7 +
 mm/huge_memory.c                           | 247 +-----
 mm/khugepaged.c                            | 124 ++-
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/khugepaged.c    | 924 +++++++++++++++++++++
 5 files changed, 1057 insertions(+), 246 deletions(-)
 create mode 100644 tools/testing/selftests/vm/khugepaged.c

-- 
2.26.0

