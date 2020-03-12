Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAFBC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9C3206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584001374;
	bh=ngCHmcftr7xM/ExvhFVSq4edhngIRKJrIeG+6QX2/Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jU6UAv8F/PkUK1z/6dViflTT7C22NGHSYG3UwUjh97FsEMB+J4niEDjz9786DzQP1
	 4yOToLBZF0/obC1fBgZoA99Es1N4ZGe0HD1K1kOJS8y1lA9e8moxCxwvW7/nA//bCq
	 qzKo0QjPKdFZFGNp7sqA4mcpxOMVZzgPU+PYneR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCLIWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:22:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44381 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgCLIWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:22:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id l18so6170936wru.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 01:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GsxxIwFSAGEf48PcrAOgcjGCiOZstCS977zPZAz+O2I=;
        b=Y37vqHG9+7IHYu8lCqjPWWEXPpzkyJbAAUcNjcCvB/OzYjchHycS0oxiedVAlgv+nY
         xtmWb6Qxcknlwqt3m4nGS9/RMB7Fn2Axzc82a40tdU28rcaVeby16JIftJLqf+2/o15w
         vmthuLbi/h7TO+FM/lBpKoSjxdS9rnG3kpyA1NrxhKQx9v0pVah22R60y3H3J6Lagu46
         4ZpYCNJBKOjyAig5CsQCRDvDKViZ7nATnmot1axmBYD0g4/FMkcazmKdeGo4YjgGKWQU
         HfwngSVnmL/tqFO8dbnvwjRXWWfaqIslbTG0GLgR5MCQVPlUY3eWWSv0pIhTq7YsdbvE
         Hhlw==
X-Gm-Message-State: ANhLgQ12iCjozj7zgB4UCf9OIP1ZXeTmuj4Xs5r/rQbTZ5JN57BNJr6X
        oY/hDz4Z9qZwgXPYhk/J3I0=
X-Google-Smtp-Source: ADFU+vtrl/AK44eMW5i6krCVsjmsnJH8Un+S7wzGv2FklsFNv4uWwLThm5cl3vcLeda1A3Hf+xET7w==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr9428669wru.127.1584001370668;
        Thu, 12 Mar 2020 01:22:50 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id q5sm27406612wrc.68.2020.03.12.01.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:22:49 -0700 (PDT)
Date:   Thu, 12 Mar 2020 09:22:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200312082248.GS23944@dhcp22.suse.cz>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc akpm]

So what about this?

From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Thu, 12 Mar 2020 09:04:35 +0100
Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages

Jann has brought up a very interesting point [1]. While shared pages are
excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
that way. This can lead to all sorts of hard to debug problems. E.g.
performance problems outlined by Daniel [2]. There are runtime
environments where there is a substantial memory shared among security
domains via CoW memory and a easy to reclaim way of that memory, which
MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
in for the parent process which might be more privileged or even open
side channel attacks. The feasibility of the later is not really clear
to me TBH but there is no real reason for exposure at this stage. It
seems there is no real use case to depend on reclaiming CoW memory via
madvise at this stage so it is much easier to simply disallow it and
this is what this patch does. Put it simply MADV_{PAGEOUT,COLD} can
operate only on the exclusively owned memory which is a straightforward
semantic.

[1] http://lkml.kernel.org/r/CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com
[2] http://lkml.kernel.org/r/CAKOZueua_v8jHCpmEtTB6f3i9e2YnmX4mqdYVWhV4E=Z-n+zRQ@mail.gmail.com

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/madvise.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 43b47d3fae02..4bb30ed6c8d2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -335,12 +335,14 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		page = pmd_page(orig_pmd);
+
+		/* Do not interfere with other mappings of this page */
+		if (page_mapcount(page) != 1)
+			goto huge_unlock;
+
 		if (next - addr != HPAGE_PMD_SIZE) {
 			int err;
 
-			if (page_mapcount(page) != 1)
-				goto huge_unlock;
-
 			get_page(page);
 			spin_unlock(ptl);
 			lock_page(page);
@@ -426,6 +428,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 		}
 
+		/* Do not interfere with other mappings of this page */
+		if (page_mapcount(page) != 1)
+			continue;
+
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
 
 		if (pte_young(ptent)) {
-- 
2.24.1

-- 
Michal Hocko
SUSE Labs
