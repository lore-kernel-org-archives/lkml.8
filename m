Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A1C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42FE208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXd5SVYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgB0Bh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:37:27 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34899 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgB0Bh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:37:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so439149pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 17:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vZDwfNLVUBH6SGm2FcQoiJLrDZVGLDDEbJUTgzVuEvs=;
        b=mXd5SVYYTzZ17GeQ+3kEKesccxr9w0WIIKJiKARi3WPT7EYMzXv3gdtI/z344fipaC
         VfFDEZNUUAJyhUSvlQc4+8Db8BZmXG/l9lcTBaOEmXWnqnr/WlcSIbNCRdkap2IIpH9E
         FVAZisCtnUFEV4sazZsGkW+lwxr54D99nLRMaN3uU2lXNSdMn+0VLmZ63Np7r1BSVP7Q
         /ZjTH20IRBm80xiwEWzIaeBhFfoXjaRe9mVPo4LZ7kf3OJR3mSGvHUWS2hHW4yao3uL1
         TGB6xES+l4itrLSdjHGHyEDg4xOQQ1snSsMA0uIy4MO/gkKahmYYoS/He2VKiWhmVNqW
         1mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vZDwfNLVUBH6SGm2FcQoiJLrDZVGLDDEbJUTgzVuEvs=;
        b=YiYYNJ67nylYaRhIXVTE3rpORHS6BdqNdff4JOxb8sowDl5fSF8Vk9XsjUwZkX8jw0
         tRaKzDypXQm/+xYsuZythsedOKndy60iRcMn45n0BUN7BGaTOfGXoKbRZXPiJm63UhqW
         cjiAMDv+x6pqBJ0+DnT0qWdjQQnxKYIs4SC1wZMD8wpzvuIvnyjYoOFutP9g7zagAUaP
         ovI8KEUS8lLdPvNF36lFXLB1ZxbwrpPAGUwZT+SrD/vNJT29IlpDE1qAbGWTqe70QdAR
         FR9Rb5xuzsO8SwDQ2z52rpq5HZ5Qe//lNlJtSjw4w/maT06xNQAbgJHZy7xQUlHaDKPU
         em2Q==
X-Gm-Message-State: APjAAAW0WdOFgEvvYi6/JUmfPcNdaShj9SJffmgY/QEnDY6eP2IemEnI
        /Ygk93M9gZ4E/MKzwb5DqD40xg==
X-Google-Smtp-Source: APXvYqxEmhYf4O6qUNGfO+tvwPPmEsOadkT+TrXOCj8bNk3niEzy0lP75wQarqV47KyQlNjty9UfDg==
X-Received: by 2002:a17:90a:3603:: with SMTP id s3mr2152716pjb.61.1582767444239;
        Wed, 26 Feb 2020 17:37:24 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id w11sm4037509pgh.5.2020.02.26.17.37.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 17:37:23 -0800 (PST)
Date:   Wed, 26 Feb 2020 17:37:22 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
In-Reply-To: <cba16817-8555-f84f-134a-1ff9f168247b@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2002261656300.1381@eggly.anvils>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com> <alpine.LSU.2.11.1912041601270.12930@eggly.anvils> <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com> <alpine.LSU.2.11.2002241831060.3084@eggly.anvils>
 <cba16817-8555-f84f-134a-1ff9f168247b@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Yang Shi wrote:
> On 2/24/20 7:46 PM, Hugh Dickins wrote:
> > 
> > I did willingly call my find_get_entries() stopping at PageTransCompound
> > a hack; but now think we should just document that behavior and accept it.
> > The contortions of your patch come from the need to release those 14 extra
> > unwanted references: much better not to get them in the first place.
> > 
> > Neither of us handle a failed split optimally, we treat every tail as an
> > opportunity to retry: which is good to recover from transient failures,
> > but probably excessive.  And we both have to restart the pagevec after
> > each attempt, but at least I don't get 14 unwanted extras each time.
> > 
> > What of other find_get_entries() users and its pagevec_lookup_entries()
> > wrapper: does an argument to select this "stop at PageTransCompound"
> > behavior need to be added?
> > 
> > No.  The pagevec_lookup_entries() calls from mm/truncate.c prefer the
> > new behavior - evicting the head from page cache removes all the tails
> > along with it, so getting the tails a waste of time there too, just as
> > it was in shmem_undo_range().
> 
> TBH I'm not a fun of this hack. This would bring in other confusion or
> complexity. Pagevec is supposed to count in the number of base page, now it
> would treat THP as one page, and there might be mixed base page and THP in
> one pagevec.

I agree that it would be horrid if find_get_entries() and
pagevec_lookup_entries() were switched to returning just one page
for a THP, demanding all callers to cope with its huge size along
with the small sizes of other pages in the vector.  I don't know how
to get such an interface to work at all: it's essential to be able
to deliver tail pages from a requested offset in the compound page.

No, that's not what the find_get_entries() modification does: it
takes advantage of the fact that no caller expects it to guarantee
a full pagevec, so terminates the pagevec early when it encounters
any head or tail subpage of the compound page.  Then the next call
to it (if caller does not have code to skip the extent - which
removal of head from page cache does) returns just the next tail,
etc, until all have been delivered.  All as small pages.

(Aside from the comments, I have made one adjustment to what I
showed before: though it appears now that hugetlbfs happens not
to use pagevec_lookup_entries(), not directly anyway, I'm more
comfortable checking PageTransHuge && !PageHuge, so that it would
not go one-at-a-time on hugetlbfs pages.  But found I was wrong
earlier when I said the "page->index + HPAGE_PMD_NR <= end" test
needed correcting for 32-bit: it's working on PageHead there, so
there's no chance of that "+ HPAGE_PMD_NR" wrapping around: left
unchanged, what it's doing is clearer that way than with macros.)

Hugh

> But, I tend to agree avoiding getting those 14 extra pins at the
> first place might be a better approach. All the complexity are used to
> release those extra pins.
