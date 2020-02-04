Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EFDC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5657C2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsFcX+Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBDWdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:33:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44318 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgBDWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:33:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so43776otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4vakGMhq6osED8dfnagmL3LnH1bwD9GWqExnkD8isg=;
        b=nsFcX+UkIOs3W64Y+ii8sN4utrUNClWWK5j8fLw1Ozps4Upa29eosAErByGTJMMSqn
         Uf54fKPlPvLy5rfQ9BS358JoA3gtI3jRPeOyoIzrFbZSX8/bmN5BY7kBdDXJ6C8KwkR0
         9i8ASESnQJDGufhIdNEgD9F9netV75Xy/p+TGbhvSsb6/ewtPCOO2S64aoJ9fnpC7UKY
         jFombvtN7ivWbvbzKzGqbC8qRE58Ytm3Yjx1iGJNsOFNfC8IrPVmU6sPiPncRg2RYTMw
         pYaT+e7IB6zBYtbxpTG8uREOPXipUZkLdLF+1xsoG8xZvthYb28fCvuwZokw362nmqfi
         y07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4vakGMhq6osED8dfnagmL3LnH1bwD9GWqExnkD8isg=;
        b=qmUnfbTuy49yyu4cxWX/rcQZBoqiXZD3O9qvCUcnznFltl1frS8qLrZHtGb1y5aiJr
         DTLkCNvCR92M7l7V8F33eyP8mQidXocq4EH2D6ooeGoc9KSqJlsz56ptNnT6qt6yT/7a
         5518VHpYQ9TKABLMeX1UzIXC6N9M13O7otaz2i1Xj7u1vvXQxqEWgtoURC8BG4dhERpK
         MmYovBWbbunGiFQBmr1JD/RahA/wkgdb+FTLSKlEwx/oou48ML7piWy9QrByzfIABs/+
         CY5rZmkcLTiPf9cwxqy2fq1gKLMFxVvNuvV/CrJZT2L9jndglWGRAv2fYqkCvZ/gbKSJ
         6qHw==
X-Gm-Message-State: APjAAAWhUwFXqzcO1QmpdFwKmh6TfEOUh56gPA8O7J6KXD7NWFvtubFC
        t61LIGKJeMUUuNdeNvXurzNozwfjeWWNHDE9AJ4Qyg==
X-Google-Smtp-Source: APXvYqwAB6r7PiMCLRtXLPkmBSmepkc4OT2+jLlJkQ9zZgPfaqu9E0ylfzzT6UFq8J3qZq5LgZpjdufN9HeUGzf+FTk=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr23746990oto.355.1580855620419;
 Tue, 04 Feb 2020 14:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-8-almasrymina@google.com> <0fa5d77c-d115-1e30-cb17-d6a48c916922@linux.ibm.com>
 <CAHS8izPobKi_w8R4pTt_UyfxzBJJYuNUw+Z6hgFfvZ1Xma__YA@mail.gmail.com>
In-Reply-To: <CAHS8izPobKi_w8R4pTt_UyfxzBJJYuNUw+Z6hgFfvZ1Xma__YA@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 4 Feb 2020 14:33:29 -0800
Message-ID: <CAHS8izNmSYumXpYXT1d8tAm36=-BRjXqdCDjLB6UNMwn5xhPZg@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 12:36 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Tue, Feb 4, 2020 at 8:26 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
> >
> >
> > There are still a couple of places where 2MB page size is being used.
> > These are my workarounds to get the tests running on ppc64.
> >
>
> Thanks for the changes!
>
> > Also I had missed running charge_reserved_hugetlb.sh the last time.
> > Right now, it stops at the following scenario.
> >
> > Test normal case with write.
> > private=, populate=, method=2, reserve=
> > nr hugepages = 10
> > writing cgroup limit: 83886080
> > writing reseravation limit: 83886080
> >
> > Starting:
> > hugetlb_usage=0
> > reserved_usage=0
> > expect_failure is 0
> > Putting task in cgroup 'hugetlb_cgroup_test'
> > Method is 2
> > Executing ./write_to_hugetlbfs -p /mnt/huge/test -s 83886080 -w  -m 2  -l
> > Writing to this path: /mnt/huge/test
> > Writing this size: 83886080
> > Not populating.
> > Using method=2
> > Shared mapping.
> > RESERVE mapping.
> > Allocating using SHM.
> > shmid: 0x5, shmget key:0
> > shmaddr: 0x7dfffb000000
> > Writing to memory.
> > Starting the writes:
> > .write_result is 0
> > .After write:
> > hugetlb_usage=16777216
> > reserved_usage=83886080
> > ....kiling write_to_hugetlbfs
> > ...Received 2.
> > Deleting the memory
> > Done deleting the memory
> > 16777216
> > 83886080
> > Memory charged to hugtlb=16777216
> > Memory charged to reservation=83886080
> > expected (83886080) != actual (16777216): Reserved memory charged to hugetlb cgroup.
> > CLEANUP DONE
> >
> >
>
> So the problem in this log seems to be that this log line is missing:
>     echo Waiting for hugetlb memory to reach size $size.
>
> The way the test works is that it starts a process that writes the
> hugetlb memory, then it *should* wait until the memory is written,
> then it should record the cgroup accounting and kill the process. It
> seems from your log that the wait doesn't happen, so the test
> continues before the background process has had time to write the
> memory properly. Essentially wait_for_hugetlb_memory_to_get_written()
> never gets called in your log.
>
> Can you try this additional attached diff on top of your changes? I
> attached the diff and pasted the same here, hopefully one works for
> you:
>

I got my hands on a machine with 16MB default hugepage size and
charge_reserved_hugetlb.sh passes now after my changes. Please let me
know if you still run into issues.
