Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1B5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C8E207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="TIa5JN+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgHYDB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 23:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHYDB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:01:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0DEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:01:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so476266pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9NGsLRgB/myp9x8VcWwBlHfzPmZW5rxcEeeEZDE/fw=;
        b=TIa5JN+6ykAGfmJvcqBUF0q3/hucGEbiYEnSZkDF2yjUeybE/nZgYKFQT0LVGgNeu4
         H9dfxspMGEaYCs55kPwIsHZ7nfxv5CHZ1PU16sGyATlRbMq15VPWb0nbtVOLv4ECX4sy
         1X30cSWrUFhaJK2aaro/Ll3IpbcEqLLTJntnESdL/kdsCvbFQQ4FA1EujHsU97uklqZu
         YUeM4kr6S2QNVhhZjWnfxyaHGTN/Tqzcc7AFMlShtldwkaqVBxz5Tib/hBrmeejRII8y
         uYaZbJoj8lVmYa00kfg30+hmp5+/hq53zYjX+nj95D9cO4lYjHnTLMIKXnNNxbBIi3UJ
         ODWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9NGsLRgB/myp9x8VcWwBlHfzPmZW5rxcEeeEZDE/fw=;
        b=SWDSlLyuJHV6CGmsnQAqrSnTouCjnrESS+fKrMZjFUgQzQe6Ub3cPm5BZ5MV6LLHa9
         puTXw6zsvByQd0kk5u+FvJT6fg0fYRg5oC3PY4JPTuBJkA5es0pTeWqVF8y/nbdXT5Y+
         6UKwSrm9+92THi0rUcfNJ52/wVBqUBMmJok2c8iSS9cDJSkFnoaPQmefqFfx9a2mxSB2
         NMRCd+lrTRUF9oUa9TsFxqzjC5395gre1yuP0wh6PweyWe+0bW+bT5jaQU2mD9t1lE8w
         PI56mV2oG0qhf9QNsRp89ATpotxAk0roytexRFZ8GzGeXbozWUj3KqXBqhK0YwOLM32C
         tWxA==
X-Gm-Message-State: AOAM533kICe4K8cFKvY8WKJcj6Iew0kcaEc971aKIGds+l59UzGRwpim
        CcRK6PL//sz8vQ5zWNHkLzaurDvDHWUscVhGC/qQcw==
X-Google-Smtp-Source: ABdhPJxUtLBk7hceCC+IvFYMFCpC6sidBFHyAHI0SqJEXqCkLucaM+YMyQdJemSL3nKBIWb9vnzHrK3M53Fa5ugJpP0=
X-Received: by 2002:a17:90a:bd0e:: with SMTP id y14mr1876544pjr.13.1598324516350;
 Mon, 24 Aug 2020 20:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200822095328.61306-1-songmuchun@bytedance.com>
 <20200824135924.b485e000d358cee817c4f05c@linux-foundation.org> <79800508-54c9-4cda-02de-29b1a6912e75@oracle.com>
In-Reply-To: <79800508-54c9-4cda-02de-29b1a6912e75@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 25 Aug 2020 11:01:17 +0800
Message-ID: <CAMZfGtXh+FP0O92ccj532Y=K4m2S==eSK8LjYEM+p6cttV0p8Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/hugetlb: Fix a race between hugetlb
 sysctl handlers
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ak@linux.intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 5:21 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/24/20 1:59 PM, Andrew Morton wrote:
> > On Sat, 22 Aug 2020 17:53:28 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> >
> >> There is a race between the assignment of `table->data` and write value
> >> to the pointer of `table->data` in the __do_proc_doulongvec_minmax().
> >
> > Where does __do_proc_doulongvec_minmax() write to table->data?
> >
> > I think you're saying that there is a race between the assignment of
> > ctl_table->table in hugetlb_sysctl_handler_common() and the assignment
> > of the same ctl_table->table in hugetlb_overcommit_handler()?
> >
> > Or not, maybe I'm being thick.  Can you please describe the race more
> > carefully and completely?
> >
>
> I too am looking at this now and do not completely understand the race.
> It could be that:
>
> hugetlb_sysctl_handler_common
> ...
>         table->data = &tmp;
>
> and, do_proc_doulongvec_minmax()
> ...
>         return __do_proc_doulongvec_minmax(table->data, table, write, ...
> with __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, ...
> ...
>         i = (unsigned long *) data;
>         ...
>                 *i = val;
>
> So, __do_proc_doulongvec_minmax can be dereferencing and writing to the pointer
> in one thread when hugetlb_sysctl_handler_common is setting it in another?

Yes, you are right.

>
> Another confusing part of the message is the stack trace which includes
> ...
>      ? set_max_huge_pages+0x3da/0x4f0
>      ? alloc_pool_huge_page+0x150/0x150
>
> which are 'downstream' from these routines.  I don't understand why these
> are in the trace.

I am also confused. But this issue can be reproduced easily by letting more
than one thread write to `/proc/sys/vm/nr_hugepages`. With this patch applied,
the issue can not be reproduced and disappears.

>
> If the race is with the pointer set and dereference/write, then this type of
> fix is OK.  However, if you really have two 'sysadmin type' global operations
> racing then one or both are not going to get what they expected.  Instead of

In our team, more than one developer shares one server which is a test server.
I guess that the panic happens when two people write
`/proc/sys/vm/nr_hugepages`.

> changing the code to 'handle the race', I think it might be acceptable to just
> put a big semaphore around it.

It is also a good idea to fix this issue. Thanks.

> --
> Mike Kravetz



-- 
Yours,
Muchun
