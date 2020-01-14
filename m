Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8BEC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 22:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B80724676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 22:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXtYSede"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgANW4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:56:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44184 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgANW4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 17:56:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so14301752otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipIhJjAH0mlgj9mgI3WhoNWssFh6GjBw0YOeerhZCcU=;
        b=BXtYSedeHXcXqhdhhWIbtaBy54tVxbI3e9loIGv5zhO5CDgbahYX7y+Orjx6CD4zCZ
         0VhZIf5F4aluPlRU7PpNhbbEGba3pmcWe+cL3CBi5DKya+w5q6G9eUjD6Y6LZi3IlJ3t
         DrJUFTIu5BCbGGqB1F/xwGxS7UBhnEduOl7KTKpELe4ehBWkmis+mzbELNb1lGuQU++3
         QqqpluWfbXgvT/3D7WUNnyrjmuuZFxOwFtqlIlsp5tc9+S7eipRPEcevYerqbyHWNTNb
         Hhqn87JV86nkgRWq1rMf/JsZJIoYLMVRDfzRbSZxDqafJRFy4Ttng/Rd5qCfuV8koCw1
         S2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipIhJjAH0mlgj9mgI3WhoNWssFh6GjBw0YOeerhZCcU=;
        b=sFi7xMyLs8aydDrqqtd/C0DdpUynD7wTvVlkZ1LZJs+BFp9peg74qRlbOOa0qJnX7n
         nC6Xo12tAcmX1WqN+Cd63PmyEQ8LbwbO+5oBjRXGU/XUuP+9zRTzxnWfxIVLZLWNLOvC
         8Qw6VSR4n+JEm51YrF+XJj/KrG+bUji4GTHvb5Cpl2x0m24Y9AEUwmCiu+qACpYF/jDZ
         1+w4V5evyBYSO4E6YZxY43s+HJuDe5yjn8YNhOm66D3BmQtONBLG4nVf8TarL83J4YJO
         hWkEfbkCU24h8P7uq8lgNj30nPfJc4jQVNiodFdy68Gzvzn3FHo2hocs/CljUUxpvcQR
         KMaQ==
X-Gm-Message-State: APjAAAV6QCVfV/6KgN9LGZHTVDpnr8PL52cS9kvTrLCps1D5t0fShsi2
        Ok4RH9jYqLvD9HeOLOzlyMybjvzabES7Hpps8UbCKQ==
X-Google-Smtp-Source: APXvYqyQmL6MY3CQ5veK4yvMgm0Vfzi0RP3qvYcRSIpcE0TmezTJR9GdGI42+n8t1PA73eDd8usJHxZikf9yyvXL7gA=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr557782oto.355.1579042565055;
 Tue, 14 Jan 2020 14:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191217231615.164161-2-almasrymina@google.com> <0855cae0-872e-0727-aa7c-55051d8f0871@oracle.com>
In-Reply-To: <0855cae0-872e-0727-aa7c-55051d8f0871@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 14 Jan 2020 14:55:53 -0800
Message-ID: <CAHS8izNcZnJmWOoagAkDtgKj9JfOoW0xuSuMAhO3wh3A1x2Dqw@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 2:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > +extern void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
> > +                                         unsigned long nr_pages,
> > +                                         struct cgroup_subsys_state *css);
> > +
>
> Do we need a corresponding stub for the !CONFIG_CGROUP_HUGETLB case?
>

Not necessary AFAICT because the code is only called from code guarded
by CONFIG_CGROUP_HUGETLB.

Addressing comments from you and David in v10 shortly. Thanks for the review!
