Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA105C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C117A20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586415781;
	bh=cWppHrDhyWFUnpfgT1RCt8t5EmUW09svhMX8f9UIxGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ujj+UGN6D/aJC8lCwLODeSKilQ9d1wVbIzDrOEV+ZeN49aT9dBe8Mzw7rhieBQvkp
	 22ZaKBI1UnsY4KqFXsEnCaBedG7NwtYTFg6KHSIdjXm7OLdKVMZhwIvvHEWFqGj367
	 yevSfRwf0hqDw69yidOfdWEkpmFEmdH7AtoO91Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDIHDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:03:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39629 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:03:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so10603487wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 00:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TOxDaT8KIKxTVyeGlG1DzjdQeiYJKvtYvDrAddTgvQ8=;
        b=fuQJvivam8DeVSIQ27XAr3uCcN6eBdmNJdJJY/H5NvzhqsRjIHbylMm3H7U4caIGCo
         RHe7evojXTHCLF6x6KlHH2vmrv7kTfA7a39Ils4bIfNdS9f8+7XZ6PvVsk+9rIyLp5B7
         Tx+1cLIgd1biahLzMVzNvYfRQGUS495608zgmj1hbWMajvdVFC9Y4Dh/5NIwHIpopKrM
         Irvwk5EOTPHkPzIlU/CqFCy1SbbdGldhkPZdtwCLqKn1iYPkK3Qrbr258kCxLuqIOj+d
         u60OBwGV4yUsEHuZkIIFce+TcifsBhJBKvcQQ+jT1uTeHS30ZNAfe8v3JAH8V3V91qu/
         4Lvw==
X-Gm-Message-State: AGi0PuZfn/QdbLS1q0w/SbGakFAl3mMEuVfAJZS6PohgwLkN1JzFrJWK
        gIR9AXm1mPfqZkqMefL+jOY=
X-Google-Smtp-Source: APiQypIP8qkJwWE/4Q8GNBJ5qkqY5EM+Rw79dqUzcWC6hohz2gnvV0HVxwX8Lc5nsUDUozttdaXCHg==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr13596846wru.371.1586415775488;
        Thu, 09 Apr 2020 00:02:55 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id 91sm33867682wrf.79.2020.04.09.00.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 00:02:54 -0700 (PDT)
Date:   Thu, 9 Apr 2020 09:02:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200409070253.GB18386@dhcp22.suse.cz>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408014010.80428-2-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been merged and it is actually wrong after ae46d2aa6a7f
has been merged. We can either revert or I suggest just handling >0,
like the patch below:

From 03fbe30ec61e65b0927d0d41bccc7dff5f7eafd8 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Thu, 9 Apr 2020 08:26:57 +0200
Subject: [PATCH] mm, mempolicy: fix up gup usage in lookup_node

ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal") has
added a special casing for 0 return value because that was a possible
gup return value when interrupted by fatal signal. This has been fixed
by ae46d2aa6a7f ("mm/gup: Let __get_user_pages_locked() return -EINTR
for fatal signal") in the mean time so ba841078cd05 can be reverted.
This patch however doesn't go all the way to revert it because 0 return
value is impossible. We always get an error or 1 for a single page
request.

Fixes: ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal")
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/mempolicy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 48ba9729062e..1965e2681877 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -927,10 +927,7 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
 
 	int locked = 1;
 	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
-	if (err == 0) {
-		/* E.g. GUP interrupted by fatal signal */
-		err = -EFAULT;
-	} else if (err > 0) {
+	if (err > 0) {
 		err = page_to_nid(p);
 		put_page(p);
 	}
-- 
2.25.1

-- 
Michal Hocko
SUSE Labs
