Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC7C54FCE
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB1C2076E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTZ4qqI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCVLeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:34:36 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40863 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCVLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:34:36 -0400
Received: by mail-pj1-f67.google.com with SMTP id bo3so4680508pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 04:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zDGPRLuuarDLZQ+WNCYaUMcWvomGYPw+wDeEhFuyAxg=;
        b=tTZ4qqI8gga79iORQO4aSwsOLs8Yx/oiMadUveAi+Lccml/GBARWHBhFicqu031aPq
         WL91VEhgpk5NsD+uLMsEHY0JDeAKGVuJIUcbbN3s0WFjvjMNSNRSmd3kbCQBgZrYJV60
         y59imIi8lqIU4BX4NIGophpxyiM5ZACJlRD/t4IsBwOm8x/zmg3idt3MYLxqSMGHQrXF
         dSbv9mIB6aXY04+JUgguuI3eQZ3IuwfN25GTbJFPeluQD6eUc7O/PMI2Rq26/ce2ZU1c
         NqBVwhGEvwXntep14zfUTemq84+sclsnly4JYyrsbRL0oVzicqJWCrAUivU52NwG2XlG
         rmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zDGPRLuuarDLZQ+WNCYaUMcWvomGYPw+wDeEhFuyAxg=;
        b=D9MlgpuKxAACTxComsoyMe53oH4827b47s2+LghUDMGLaX/tUUhIMbHyOJLnrIrTNs
         Bv9brbV/KVEnU6vdBLW3YNGmwlFcPOJrdAyhRGybwpW91pJPBia+Mf7aBFVoQskqiPOb
         fgHRy+L6UEZ6jzOcrXS+g1FQbx2y3saB4FyGY2tRYkP3wDdQlFb5dXifAMeiDp3LuaAR
         chJ2XKUrfohND/O3XgXXA51GVV5atNrB7cwJHc7L8F7AXFZjE3lyOXYtWJUiRtHuvjKz
         Q8cZjS6JLF9dja67Zgf4KmH7N6deNxzQFFBYSpKxJhFDggAzbbaW35sIDjYZl+nJ+ece
         ZCKA==
X-Gm-Message-State: ANhLgQ0BpOwWc1HBsndsPrz2hLxZY4n+xmj/9qzJGK9QzIZyu4HNlOX0
        VPaenjiGQ4zpX/k6WsYZbA==
X-Google-Smtp-Source: ADFU+vvrlH1pgAg0vtxEQZa5VzkGRdw9MDjvg8et5+0lNbwBODVngaKCdH3mejXZoRlgEEQzZePgDw==
X-Received: by 2002:a17:90a:33d1:: with SMTP id n75mr19066395pjb.167.1584876874787;
        Sun, 22 Mar 2020 04:34:34 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i23sm10474445pfq.157.2020.03.22.04.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 04:34:34 -0700 (PDT)
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
Subject: [PATCHv8 0/2] fix omission of check on FOLL_LONGTERM in gup fast path
Date:   Sun, 22 Mar 2020 19:32:11 +0800
Message-Id: <1584876733-17405-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7 -> v8:
    - drop the [3/3] in v7, which is a test case without real use case now.
    - apply renamming in __get_user_pages_fast() besides internal_get_user_pages_fast()
    - improve the note in code with [2/2]

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

Pingfan Liu (2):
  mm/gup: rename nr as nr_pinned in get_user_pages_fast()
  mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path

 mm/gup.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--
2.7.5

