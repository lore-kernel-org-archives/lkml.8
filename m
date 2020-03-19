Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC3FC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA4720724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="V5D/Uhrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgCSKtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:49:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33454 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:49:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id c20so1229086lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZgArXkgg7VigGgHtZdS83FecIAuksnVOCfY2x1G6swc=;
        b=V5D/UhrqH9nir4DZuCT4o+58QLB+3H1nrQQixA2gKjXeJQzY/DIorUMc+vaBDVHV+b
         ryXYXpjG4vmEFYYYVE86zFyWPPDfMJ1/UJs4LX1RyF5SxpmYiyWnpw4jdRQ4RNCpWtOW
         AqDpFTwvbuDmJqhpigmd006fEeUkdpT5qdSk+PTxjVTS3q3FqIrkRr2xviFbcRG2Paii
         p4U9dRJVnt6g6FZF2CHdd1XO0ZY6koh4VqQNShVdEj+gFtsBEwSW9oPwO9yTJ2R0uMx2
         cy/PBB9FwpVNfe4TKE9IQ9Y5lOF6fTBto1YnVIzWkBUxXfE8BTjaZkIcAF7XYQ22I8tg
         f6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZgArXkgg7VigGgHtZdS83FecIAuksnVOCfY2x1G6swc=;
        b=FwS3bEUIG9hqJb2ZRUbODJ3nR9KYH8PFcOqArNoioOR4/kCwWOOq7VyPiX8j5A5LBW
         m4mQaNy5MCG+5aKHPrWGrg1I8KBfT+7CSLJkXl0wZANba1AzVtUYOeSWg0BGfezZVUE1
         PciAGfygf7O4eH1H6YsMz+sTYxmn2zP3bN/RWO8tt5f53GHhxNYQl0RX+hJkWDAQYW66
         skiunH/xaeK0Ec2C22+4TsP8M36TkFIUe4y2/m85Bbf0KeTIqTT5u7pG3pEo/QBGznCF
         1GnbmFYdo3/5+q4FRyCf/HOA/ciD5dSDgs1Za1ap3gGcT+nu5IBlJk42ZSNdJFAsmPsB
         XOew==
X-Gm-Message-State: ANhLgQ0yUmZFsRCqfIO6FXYNkkz7CU+2zqjL1KKjmJNmk3DJqWUEmnFm
        SN+PB0f48DzSnKuROjKtlqRcPA==
X-Google-Smtp-Source: ADFU+vsfw8i29iF8nIn7p+4M7LH5qStagxnbxJgTlPmOqZ1DYd2bXsG3komKYQucbAMOFr45pqpK6A==
X-Received: by 2002:ac2:5f58:: with SMTP id 24mr1748538lfz.81.1584614977988;
        Thu, 19 Mar 2020 03:49:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e9sm1167045ljp.24.2020.03.19.03.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 03:49:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D3BCE100D62; Thu, 19 Mar 2020 13:49:38 +0300 (+03)
Date:   Thu, 19 Mar 2020 13:49:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix potential page state corruption
Message-ID: <20200319104938.vphyajoyz6ob6jtl@box>
References: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200319001258.creziw6ffw4jvwl3@box>
 <2cdc734c-c222-4b9d-9114-1762b29dafb4@linux.alibaba.com>
 <db660bef-c927-b793-7a79-a88df197a756@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db660bef-c927-b793-7a79-a88df197a756@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:39:21PM -0700, Yang Shi wrote:
> 
> 
> On 3/18/20 5:55 PM, Yang Shi wrote:
> > 
> > 
> > On 3/18/20 5:12 PM, Kirill A. Shutemov wrote:
> > > On Thu, Mar 19, 2020 at 07:19:42AM +0800, Yang Shi wrote:
> > > > When khugepaged collapses anonymous pages, the base pages would
> > > > be freed
> > > > via pagevec or free_page_and_swap_cache().  But, the anonymous page may
> > > > be added back to LRU, then it might result in the below race:
> > > > 
> > > >     CPU A                CPU B
> > > > khugepaged:
> > > >    unlock page
> > > >    putback_lru_page
> > > >      add to lru
> > > >                 page reclaim:
> > > >                   isolate this page
> > > >                   try_to_unmap
> > > >    page_remove_rmap <-- corrupt _mapcount
> > > > 
> > > > It looks nothing would prevent the pages from isolating by reclaimer.
> > > Hm. Why should it?
> > > 
> > > try_to_unmap() doesn't exclude parallel page unmapping. _mapcount is
> > > protected by ptl. And this particular _mapcount pin is reachable for
> > > reclaim as it's not part of usual page table tree. Basically
> > > try_to_unmap() will never succeeds until we give up the _mapcount on
> > > khugepaged side.
> > 
> > I don't quite get. What does "not part of usual page table tree" means?
> > 
> > How's about try_to_unmap() acquires ptl before khugepaged?

The page table we are dealing with was detached from the process' page
table tree: see pmdp_collapse_flush(). try_to_unmap() will not see the
pte.

try_to_unmap() can only reach the ptl if split ptl is disabled
(mm->page_table_lock is used), but it still will not be able to reach pte.

> > > 
> > > I don't see the issue right away.
> > > 
> > > > The other problem is the page's active or unevictable flag might be
> > > > still set when freeing the page via free_page_and_swap_cache().
> > > So what?
> > 
> > The flags may leak to page free path then kernel may complain if
> > DEBUG_VM is set.

Could you elaborate on what codepath you are talking about?

> > > > The putback_lru_page() would not clear those two flags if the pages are
> > > > released via pagevec, it sounds nothing prevents from isolating active
> 
> Sorry, this is a typo. If the page is freed via pagevec, active and
> unevictable flag would get cleared before freeing by page_off_lru().
> 
> But, if the page is freed by free_page_and_swap_cache(), these two flags are
> not cleared. But, it seems this path is hit rare, the pages are freed by
> pagevec for the most cases.
> 
> > > > or unevictable pages.
> > > Again, why should it? vmscan is equipped to deal with this.
> > 
> > I don't mean vmscan, I mean khugepaged may isolate active and
> > unevictable pages since it just simply walks page table.

Why it is wrong? lru_cache_add() only complains if both flags set, it
shouldn't happen.

> > > > However I didn't really run into these problems, just in theory
> > > > by visual
> > > > inspection.
> > > > 
> > > > And, it also seems unnecessary to have the pages add back to LRU
> > > > again since
> > > > they are about to be freed when reaching this point.  So,
> > > > clearing active
> > > > and unevictable flags, unlocking and dropping refcount from isolate
> > > > instead of calling putback_lru_page() as what page cache collapse does.
> > > Hm? But we do call putback_lru_page() on the way out. I do not follow.
> > 
> > It just calls putback_lru_page() at error path, not success path.
> > Putting pages back to lru on error path definitely makes sense. Here it
> > is the success path.

I agree that putting the apage on LRU just before free the page is
suboptimal, but I don't see it as a critical issue.


-- 
 Kirill A. Shutemov
