Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B8BC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD9D2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eNuL1zAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCWQJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:09:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32800 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgCWQJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:09:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id v7so6233765qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kAhcxP8/eNJxKmPp4P/1zEx2VH3e7bOqUzz83MhM5no=;
        b=eNuL1zAguHPlqQybPhPa1MXls3PQYb5vdLS5AZjgIq8RkZBCaxVVIIJpgVPW7QrGSY
         KA7ZAYszAWHP6UbEIF7t3zDnHlCOL9PW6k4i9mtF7oVXKTMo0W6DhnV6FOCLEaxS3BZL
         Nl+nfv/a30GWZzhldB3ExREp3xIPvsWdTuISOXGXdlKFmE6QIipUAkCffJK9vyX8B5L+
         bVwjJ+7ef9TJV7QA9dy/U3o8SdwKDb5X7jK6dCtQUslWMIalmrWiQxEGYimgiQYMsFYf
         di9FRqrqUb+Wgu/STcRhGoXM0jqV7OuNMKpOEUF2xp2NMaMyKKc9aLgUCcsVQJUjR88e
         okYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kAhcxP8/eNJxKmPp4P/1zEx2VH3e7bOqUzz83MhM5no=;
        b=qUOJ82/vocWKYOW0LU6V9YHu8DwP+LMuQ783zcXQwkSWo3oBjngNVzP26PaSRN+m8S
         dAjYvYTeYW/jB2/3bugNUl0UtfbH8qn3HWZ9+1JDnxZIN272ToopVOpQHvK4MbCTsSuT
         2dKJzOQxYhoYdkSzGG3wjmjK8JaXJpM9Q9t+EwipT1fSWLy9vi/QfQuc/9RsXGzrcoWP
         qDKdqznYi3SuJLkk9XCyqEpwC+0tI39WyQdSzGYuK9fSHNZ4FDNCjOfIXBvY28QIWtyS
         we+4Na3arHUC5bc4U9v0eRRSfPOKbAYqH/k+dAsb8bt4tyCRvaX6MpmolDbsFLrivCAW
         v7Lg==
X-Gm-Message-State: ANhLgQ3Clibp07V0JuIqMlerJvG9wBoAIdZKZiMx7N4BFYVSmVZPh1xn
        33W1NpB8VFGyjk9SlPFKTxzIWA==
X-Google-Smtp-Source: ADFU+vsws2eqOZlxDQQkmlsIvJQ1ivBDR/Au9oUOqDUQqVvEuamycFbO8yG/pIZC6ehrGORsRcL+Yg==
X-Received: by 2002:a05:620a:22ef:: with SMTP id p15mr19433497qki.495.1584979796923;
        Mon, 23 Mar 2020 09:09:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a11sm1005364qto.57.2020.03.23.09.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 09:09:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGPeF-00053p-1f; Mon, 23 Mar 2020 13:09:55 -0300
Date:   Mon, 23 Mar 2020 13:09:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Longpeng (Mike)" <longpeng2@huawei.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, arei.gonglei@huawei.com,
        weidong.huang@huawei.com, weifuqiang@huawei.com,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: fix a addressing exception caused by
 huge_pte_offset()
Message-ID: <20200323160955.GY20941@ziepe.ca>
References: <1582342427-230392-1-git-send-email-longpeng2@huawei.com>
 <51a25d55-de49-4c0a-c994-bf1a8cfc8638@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a25d55-de49-4c0a-c994-bf1a8cfc8638@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 04:38:19PM -0700, Mike Kravetz wrote:

> Andrew dropped this patch from his tree which caused me to go back and
> look at the status of this patch/issue.
> 
> It is pretty obvious that code in the current huge_pte_offset routine
> is racy.  I checked out the assembly code produced by my compiler and
> verified that the line,
> 
> 	if (pud_huge(*pud) || !pud_present(*pud))
> 
> does actually dereference *pud twice.  So, the value could change between
> those two dereferences.   Longpeng (Mike) could easlily recreate the issue
> if he put a delay between the two dereferences.  I believe the only
> reservations/concerns about the patch below was the use of READ_ONCE().
> Is that correct?

I'm looking at a similar situation in pagewalk.c right now with PUD,
and it is very confusing to see that locks are being held, memory
accessed without READ_ONCE, but actually it has concurrent writes.

I think it is valuable to annotate with READ_ONCE when the author
knows this is an unlocked data access, regardless of what the compiler
does.

pagewalk probably has the same racy bug you show here, I'm going to
send a very similar looking patch to pagewalk hopefully soon.

Also, the remark about pmd_offset() seems accurate. The
get_user_fast_pages() pattern seems like the correct one to emulate:

  pud = READ_ONCE(*pudp);
  if (pud_none(pud)) 
     ..
  if (!pud_'is a pmd pointer')
     ..
  pmdp = pmd_offset(&pud, address);
  pmd = READ_ONCE(*pmd);
  [...]

Passing &pud in avoids another de-reference of the pudp. Honestly all
these APIs that take in page table pointers and internally
de-reference them seem very hard to use correctly when the page table
access isn't fully locked against write.

This also relies on 'some kind of locking' to prevent the pmdp from
becoming freed concurrently while this is running.

.. also this only works if READ_ONCE() is atomic, ie the pud can't be
64 bit on a 32 bit platform. At least pmd has this problem, I haven't
figured out if pud does??

> Are there any objections to the patch if the READ_ONCE() calls are removed?

I think if we know there is no concurrent data access then it makes
sense to keep the READ_ONCE.

It looks like at least the p4d read from the pgd is also unlocked here
as handle_mm_fault() writes to it??

Jason
