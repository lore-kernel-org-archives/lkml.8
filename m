Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C78C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E8D206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VK+0jpev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBTAFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:05:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44128 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBTAFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:05:52 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so25684960oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=On4/X6XTdlAfrZHKoVhgecOTEOux4GHMdiEnySmBdt8=;
        b=VK+0jpevVkZp/UHyagl40Y2dezLtobNOAkPWNA2EFwgtAnqWXAvRKL2fUDYjIIYuOX
         5sD5qSv5bL+cr76lEQf4F46fwYdhqauQO/x/HQNTZ0vVr6HL9LZOVD6/suQ3H0O7Caep
         qwIOgwYDsQ9Dgev+b1WryYQ43HfiGsFPeyaTa2mBQ9iRyhI96dyn+5Msdo/n+suooF0w
         b+VcqixzW9m6IGvKS6k2wPw3kiwfoRYj6ynaXhaSWThUHIR+lDRULTcPDalnZsalZW69
         X6syUyxegauMHYLgPzslGiMCLpScqFt1HGn7ExxFY9FrlOAiKd+ceTkoGJ2L7dqWkMOa
         4jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=On4/X6XTdlAfrZHKoVhgecOTEOux4GHMdiEnySmBdt8=;
        b=YK1C/ud4O0eBz4SDM6oyDFlmwNL4X8LzgTCYsuEIvRQaH+EIi9X8vug6ZjChxs8Ha1
         cNI8dUATUl/fhkCao8DPF8/6Cq4SeUuqh/D/AqZA635VVeRybVRdz0fZPkip2WIFxsLy
         4BECCbvrJ7xCqDFs15Ir3T/ZTwL8rBe4nZu4OaQJxKmgYVx28ZRq75+0nY71jwVzYE09
         HzDYa6rW9JyX5OCUGaDvzvApCseUBNrjOfqt9yA4My2YWxGqnANBfRRT1JTF9k4gh2+z
         pl22QCo5SJCZqQt69Wu3d6rTbHdvNAELqWKyp70Zm4CNnL6Lh4Coo8dj9FpkjdG1QmII
         ORAg==
X-Gm-Message-State: APjAAAVNSNyFRJHQrYx9a/FNZ+4IfK+69p6mYrvzyg/RUq+7HuPozfac
        AzrdN32V3qw8jfW+oLelZfhUQFc9YATK5jFdf0Ikng==
X-Google-Smtp-Source: APXvYqx7kVH16uapNvK9tOipvAvk7gTbvKB9LtiGZMaNftmOXBmHqRRY9147oKxDVcrMXpx3fHZc1RbJlcQ1qSDu6Mg=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr183736oig.103.1582157151087;
 Wed, 19 Feb 2020 16:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211213128.73302-8-almasrymina@google.com> <37a49c35-567f-1663-33cd-3dac150020a0@linux.ibm.com>
In-Reply-To: <37a49c35-567f-1663-33cd-3dac150020a0@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Feb 2020 16:05:40 -0800
Message-ID: <CAHS8izOumQZJw9yDLSJz8buYc8oUL8oiex8Ji62QcpTX4J6G_g@mail.gmail.com>
Subject: Re: [PATCH v12 8/9] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
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

On Wed, Feb 12, 2020 at 12:50 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
>
>
> On 12/02/20 3:01 am, Mina Almasry wrote:
> > The tests use both shared and private mapped hugetlb memory, and
> > monitors the hugetlb usage counter as well as the hugetlb reservation
> > counter. They test different configurations such as hugetlb memory usage
> > via hugetlbfs, or MAP_HUGETLB, or shmget/shmat, and with and without
> > MAP_POPULATE.
> >
> > Also add test for hugetlb reservation reparenting, since this is
> > a subtle issue.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Cc: sandipan@linux.ibm.com

Hi folks,

Sandipan provided a Tested-by but this is more or less the only patch
in the series that is awaiting review. Can someone take a look?

Shuah, you started reviewing this months ago and I addressed the
comments. Maybe you can take another look?

Thanks in advance!
