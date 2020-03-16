Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7867C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772EB20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+YssmEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgCPEg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 00:36:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46042 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgCPEgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 00:36:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id b22so7388164pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 21:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lXdwJTvT1iuUgFQw8gaQa71v7GEvPOebjKf9KF4NkGk=;
        b=m+YssmEXSmxxKpanK0Py/G1CD7THoku3KfWUEjhQ64ywgxFx7K04VJsvqUa+zQ0TJc
         oQGIJTQNoxlz648QVzrDfVhfmWtUddCXWRwvi3t6xgBqFmXTieRwvYMdNy8M7FaPF/ni
         KCzrOyNBMhpqfMkIe7jlupVWTfS1MMYDjzlRkvNDti3/Xat/AGwOEWu51eS3kpX02CKZ
         PocLODYkwiIxKgvNuPAcEPl0q7O9zRoe3fKZ9BbBIucQIanw7PN3J9c03G1uEkDfAMQ7
         2FozxnrOiPBOO2gy4lLkF/BSqL8kbH7jp5bqqT5q4EeNh5xcYqmwkQ+EMwtTOw/h8sw/
         by0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lXdwJTvT1iuUgFQw8gaQa71v7GEvPOebjKf9KF4NkGk=;
        b=tVLX5Bc9yBCTyGbvRIul7MWF+fO/JlNBEbZwLeGTM/I+spjaTfYI4DR6KbuG30BqnS
         evJN6PA2Mx00NXgTuOFlI2VRQ8D7A3CUO8IXxGhi/B0F+5QtoWAVG6pyNKPQtwtR7OMA
         E5tBkr2dWE6o6I6THzZYCd4XVmlaQ/DkhM1dN0ttTLRroIBp6Zxa5YaI8MKhz72cPeA1
         umSVRS/WBvuEjd1vBN95+nDMK0A1txds/DzFFHxQazIr8umgh0HvCb/+QAfT0xyCpCB6
         o7LbGKfcz0ZqOJk2pqkiih3qvkLPEEuc0drxX2ccOc7PVbh1HyEV1nzrjihD095YC7la
         /0Mg==
X-Gm-Message-State: ANhLgQ3AJagpzGuyAi73XJQKL0dhK7cgT8I2qRIyNC8nkUwFRRntSwFP
        ClhyPOmrbp8Mn7I44NNjMA==
X-Google-Smtp-Source: ADFU+vtpikXbG80LUhDgL6M5gaBDKvXS9P9nuWps703VcR0eojTmUjTTdQ2WJ8FmAdERUj0r3IvO8Q==
X-Received: by 2002:a17:90a:654a:: with SMTP id f10mr23563849pjs.50.1584333384681;
        Sun, 15 Mar 2020 21:36:24 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d6sm18544296pjz.39.2020.03.15.21.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 21:36:24 -0700 (PDT)
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
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv6 0/3] fix omission of check on FOLL_LONGTERM in gup fast path
Date:   Mon, 16 Mar 2020 12:34:01 +0800
Message-Id: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 -> v6:
  rebase code to latest linux-mm git tree

  improve commit log

  [3/3], rename GUP_FAST_LONGTERM_BENCHMARK as PIN_FAST_LONGTERM_BENCHMARK due
  to LONGTERM should be a special case of pin page.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Pingfan Liu (3):
  mm/gup: rename nr as nr_pinned in get_user_pages_fast()
  mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path
  mm/gup_benchemark: add LONGTERM_BENCHMARK test in gup fast path

 mm/gup.c                                   | 29 +++++++++++++++++++----------
 mm/gup_benchmark.c                         |  7 +++++++
 tools/testing/selftests/vm/gup_benchmark.c |  6 +++++-
 3 files changed, 31 insertions(+), 11 deletions(-)

--
2.7.5

