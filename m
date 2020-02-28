Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA173C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2523246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNZ+X5bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgB1Lev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:34:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36943 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1Lev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:34:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so1383254pgl.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K5rhY3MMsxBQjyesCT+5yyhC1P4a9tgFxlDIS5/IhpI=;
        b=lNZ+X5bPCD5azWhtyH3092bOsJD/JsoVPQmyDEr9YX7kZ0t8QzVt1ajadkMsSvuIg3
         rPa44oREe1N7leU8ifhF5nS42eb9HZgs6+Jda+uCpKLfp2pZce0kQ3yyttYfEVLRpzB9
         8zkUQ5M8NNLZMfzoatqvGSXdZ3/BgsVdY2aKUhjNd4/uDeMBM+cHhRZcUYaP3OPR9RoY
         Yiw2eOo4aLeav49tFCLkSxWTueZDWffJ5UHU9pZgFEdmlCCDEQKntfQapwgk/ykcF1Ih
         TV4w6WhULcRU2oqf3jyg8jDj8p4/WbtGW2gJeoFSyhngaf8DhVggrOcKRf47PzyHcIGP
         PrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K5rhY3MMsxBQjyesCT+5yyhC1P4a9tgFxlDIS5/IhpI=;
        b=DQChP3WV+55zkgUt8AavHWnj08vELNQtfx++EwAEsUn/C/rK4L3POBflgSX5FV9d2c
         9vUAeEVOKsoYB2yTIjVpWNsDcxsAxiZMWqxqgEKaHS9Q63tdnzbRZ6v+2bUgGhNwFhJ+
         jCzLpgvO/KmF/gUJNjMj7o3qg7JGj8s5cy20q/QoigvtPKDUQIbRUB4mcRVhFiT6Pi9r
         T1g7JEziWJL/wl2Nro+1sAlW8qYqLuq6UXZtdYI1MaIAe/Z0j++A7StwStGKC9zSm9a5
         xWfN97SiVg/0yY5gFTGLgDnNqxEZ8H2/46uUvbFknsz5d885an/239upV2IeBuas77Go
         WnrQ==
X-Gm-Message-State: APjAAAX17uZ7Fz9Sn6+8i5axOVug+C+0qVNVfYt3rNAIzdiJSQJyAqu5
        6bMOROGEzfKhN11C8p+1jw==
X-Google-Smtp-Source: APXvYqzcZfzXLBSX4VhzuXgeuqgybu00cuBY/mmXgK1gb23gnWBxpCcjiDygt0vcWezVMn+CsG0itA==
X-Received: by 2002:a63:4763:: with SMTP id w35mr4278259pgk.113.1582889689803;
        Fri, 28 Feb 2020 03:34:49 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d14sm11402168pfq.117.2020.02.28.03.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 03:34:49 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv5 0/3] fix omission of check on FOLL_LONGTERM in gup fast path
Date:   Fri, 28 Feb 2020 19:32:27 +0800
Message-Id: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last V4 series:
https://lore.kernel.org/patchwork/project/lkml/list/?series=397950, and be
dropped from mm tree due to conflict with "RFC: switch the remaining
architectures to use generic GUP" [1]

I rebase it and sent out V5.
V4 -> V5: move around the patched code due to code change.

[1]: https://lore.kernel.org/linux-mm/20190601074959.14036-1-hch@lst.de/ 

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

---
Pingfan Liu (3):
  mm/gup: rename nr as nr_pinned in get_user_pages_fast()
  mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path
  mm/gup_benchemark: add LONGTERM_BENCHMARK test in gup fast path

 mm/gup.c                                   | 46 +++++++++++++++++++-----------
 mm/gup_benchmark.c                         |  7 +++++
 tools/testing/selftests/vm/gup_benchmark.c |  6 +++-
 3 files changed, 41 insertions(+), 18 deletions(-)

-- 
2.7.5

