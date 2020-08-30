Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320B3C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FB12083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Saoa5TwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgH3U5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3U5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:57:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82F7C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 13:57:32 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n23so3726400otq.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=7+rqYxdMNzxpQkgiuLt1+T6fd+MHGo54dmJx47wXxQs=;
        b=Saoa5TwJHduY8V3CfvN3er7C4PYgAoNqzJ2AfvdsytTT3Kcb8L6IJLmalGwsvPAQcQ
         VaJre6UNaEXltzOjmsTeFj05kXOUhXbc/I9nOHny3J8DqypHWoG3TkoaNSkzP/YiCiHQ
         T63BN9vRu6xZrkKsP86sTc1ISLIDrmLIK2gptBpv5zF3/XL5GFOjfTML71mQMAngt9tL
         BV4ZsluMgjiCPhYZa81FKE/XEd8e8pdI2inuZ2Zd2VRjjKaV91j77bNh7j8bdOhhdBx8
         RVp2+DdKZak2j7/rP13kIs4LALBcDTqs/5Bl2ZKNXYtopUF1bI/0cRQXZ2gUJN8SUXEq
         wxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=7+rqYxdMNzxpQkgiuLt1+T6fd+MHGo54dmJx47wXxQs=;
        b=EqFfqRZxr9dOFC19XSk4L2cIpfZ1G2CTfyOa49Qb3VZZMurPnrk9mJ+FGObD5VXEgE
         YH9OO/stCvZ6xsx9h1WAUIgx18wXtXzIMOkPmc2LaBYsBeNJD6lrcWC1tZe7X1C0mojI
         R8g5+WJSD31BCYi3Aa21Hg7ulhPwYk8rxGRB2GB4Q5EUmHXUhYc/1q8ewP9xE/i46854
         QQ2k/SV1tK2/p5QR4vEDLl6nZAR7cbru0zcgMA4zsoH/kUflS2WP8bNq6iHDX7AzzqWW
         viWmcJd1Mp/b+WOBLd8X+EfEtUFYhxe/lPUB+PtVi2Ll5Q3EM7wFDxgTWTN5I6hZx2zf
         MVdA==
X-Gm-Message-State: AOAM531s5Jr3H/Ld/fH2BoY4Qi3clTu5lh3ChnZRL7QSWCakaPM2m1Yf
        zGUPg3iFNB0SCbapV0mOd6gzUuP7FzoG4g==
X-Google-Smtp-Source: ABdhPJz7aggOh080yfLbNfe+ExZH7Vh8iCixZzUv3LZ8/DXUuFL+VHdYwAU8Lti0yFGN3M3ufNJ4Kw==
X-Received: by 2002:a05:6830:44c:: with SMTP id d12mr5199801otc.38.1598821047764;
        Sun, 30 Aug 2020 13:57:27 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 111sm1352817otc.15.2020.08.30.13.57.25
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 13:57:26 -0700 (PDT)
Date:   Sun, 30 Aug 2020 13:57:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/5] mm: fixes to past from future testing
Message-ID: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a set of independent fixes against 5.9-rc2: prompted by
testing Alex Shi's "warning on !memcg" and lru_lock series, but
I think fit for 5.9 - though maybe only the first for stable.

[PATCH 1/5] ksm: reinstate memcg charge on copied pages
[PATCH 2/5] mm: migration of hugetlbfs page skip memcg
[PATCH 3/5] shmem: shmem_writepage() split unlikely i915 THP
[PATCH 4/5] mm: fix check_move_unevictable_pages() on THP
[PATCH 5/5] mlock: fix unevictable_pgs event counts on THP

 mm/ksm.c     |    4 ++++
 mm/migrate.c |    3 ++-
 mm/mlock.c   |   24 +++++++++++++++---------
 mm/shmem.c   |   10 +++++++++-
 mm/swap.c    |    6 +++---
 mm/vmscan.c  |   10 ++++++++--
 6 files changed, 41 insertions(+), 16 deletions(-)
