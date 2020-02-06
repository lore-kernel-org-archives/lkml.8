Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73F6C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935E3214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kPIbp8Ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBFSQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:16:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40869 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgBFSQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:16:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so6390954otr.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqXyWTPsRk1sbEhv4F9kR6Aqgito1sCOBhDIlov5OKo=;
        b=kPIbp8EjtDr3arTeSUaNQfsuunB6rDyUC15mM8xmbQzCU6cCM9dZcABgKrZu4aA4ot
         zGuPoZjW03Kp1BP9L3alLJLvShDanfAxcTC0vG5bq/BAE5FXyJVYDAKHvx5m39Yiv3MX
         3y6ca5OVMQ8AlQEMGZpuo2T9mcNKYt6EI8Z4OfEFgWzxk2cutJWG3VAKPyeJMZETw3Se
         7IhrMnmTt3fKkQ7CP84POfDcoJX7OVACnImZLwfi4pnotY7FBPiwV+g1jHcv+pYo2k/3
         zhAr8gEiBDGGaCaQ9VTVp+Kqfq3MxqzKgQw5MLl4pU9oEDHH8EUydogxSexQaL4d5J7x
         ogaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqXyWTPsRk1sbEhv4F9kR6Aqgito1sCOBhDIlov5OKo=;
        b=P/OoT6HvIu74bF90/BY7OJAe1lb+T2xvToog1s1t8wmg28pmyWhNQzVnv/Nw3CkYnX
         /lOVcS9r+7Oaa4xCRmxLHHbzhnsaU2jqkkxdYNW1cmcHfgI93bIJaK8DoskhiVQGbY8/
         aJwoIB35QQ6R4/BTiaDaxMDvtgL4M6/JIoCl659WzO4jmY1HG1ZbXJVg4mTPKd5GgXvw
         tg0rg0uQjKAb/M5cLzS9Uiza+hSK9gq1CYw8kyHchPC2DUjOR0HgN7jcDdYQmfkLX0Mx
         foHoDtfYBEDTBC5eXpcUCsTyxTgow+VgDNhzDIHP5jbQZkF1GsKKVrjTq2M158vJBkYJ
         MsAg==
X-Gm-Message-State: APjAAAVC5R51OYsnrPNp6J33rbdF7CdDvlUl/+7n8YaNv0QTJ6MZxo09
        dTh9q/qwZzaG1pArmW+XMssHLd4PBOul4n+8VC/RiUuWThE=
X-Google-Smtp-Source: APXvYqwaTckcrFH7bGMSbhTZKw9pvz/Uc/msLLj+ylmlNbFufkDY6NdmzFxf2raQY1DpieW73ZkZW/Hdk58JVEhIdNA=
X-Received: by 2002:a9d:6a2:: with SMTP id 31mr30905207otx.313.1581012972461;
 Thu, 06 Feb 2020 10:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-2-almasrymina@google.com> <a48fbdd1-fc0e-f17d-09c2-1492c8466254@oracle.com>
In-Reply-To: <a48fbdd1-fc0e-f17d-09c2-1492c8466254@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 6 Feb 2020 10:16:01 -0800
Message-ID: <CAHS8izOYB3cz+EP4G8qNJygO7Zjq6AFbpnGrjthCXKi4DHUx3A@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
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

On Wed, Feb 5, 2020 at 2:08 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/3/20 3:22 PM, Mina Almasry wrote:
> > Augments hugetlb_cgroup_charge_cgroup to be able to charge hugetlb
> > usage or hugetlb reservation counter.
> >
> > Adds a new interface to uncharge a hugetlb_cgroup counter via
> > hugetlb_cgroup_uncharge_counter.
> >
> > Integrates the counter with hugetlb_cgroup, via hugetlb_cgroup_init,
> > hugetlb_cgroup_have_usage, and hugetlb_cgroup_css_offline.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> >
> > ---
> >
> > Changes in v11:
> > - Changed all 'reserved' or 'reservation' to 'rsvd' to reflect the user
> > interface.
>
> Thanks.
>
> Small nit,
>
> > @@ -450,8 +496,7 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
> >       struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
> >
> >       counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
> > -     rsvd_counter =
> > -             &h_cg->rsvd_hugepage[MEMFILE_IDX(of_cft(of)->private)];
> > +     rsvd_counter = &h_cg->rsvd_hugepage[MEMFILE_IDX(of_cft(of)->private)];
> >
>
> That looks like a change just to reformat a line added in the first patch?
>
> >       switch (MEMFILE_ATTR(of_cft(of)->private)) {
> >       case RES_MAX_USAGE:
>

Gah, my bad. I'll move this to patch 1.

> --
> Mike Kravetz
