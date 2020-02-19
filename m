Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254B1C18DFF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F078F2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRO7yMzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgBSTFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:05:53 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41394 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSTFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:05:53 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so24865467oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3W3v+68ig6DpCsCj7cxqvrURO7RlrIPZ7rtuczBdEw=;
        b=MRO7yMzk7yDrFx6YlaBjQipExwOAAl5oZs4Uw3k4YEf0IGCO46qz9pNv7mKfRtdLmz
         PEMy+4mqqmhwK9gt+RfIID4sYXypy6kmfz1f3/bMfc/HE8wlsqQQGiSvYEAjvEeIOtHa
         S6UhvT56lMx/7KvHuGwTFmdLS+x63NJs9cvcUK6OyY4jAYlq0NtF8+Y90oLe3sYVYbZG
         Z4C1gt9hZGvCpniRgDi27fhm9UHQPo3FBAsRTSTIXvJ0SCAfmlCJZJvUqjqxhIhm85Eo
         FcWe5DtoCsHrj7vx/oU+0Nb9bnw/5FAhoH0jlTXQwKcUoHzNp9GTA2nYG/bf1Wm2UWLP
         W65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3W3v+68ig6DpCsCj7cxqvrURO7RlrIPZ7rtuczBdEw=;
        b=UvzLrn+YZEwXtpv+61XOAva+8V9UDA+LHfgTZU+53NuLoLwaLV5/LZs7GdsyDVBudM
         bLm9zEoYUZ1yFK1zwnV3Q16soASIB15R4ChRzhZpcufG0pFrqbsktKAPD7wv+a+YuO0j
         WD6g7CguVmpJ04X2Nrh9thlQr0vB4yi/zTlFvNshFA4+aZo9+x3js4u98PusbOPWwXwr
         xHMYUvv0sN54Oftx/cAOKT+2Y22v+sSl0jAFVdax6f737/1hbqX8aLmfkRmlMxbz0HNG
         XFiAGHuXqSNn+By8V4GRggTTznzyDSwuOMpWgS4ucxFHCRqsZUKmgoXwiEt8Rg5eTlRA
         PLvA==
X-Gm-Message-State: APjAAAX1XAfwpOr63Xw2p0XWI86LOQa91NmM71d0wqFuSed9mwPfGReP
        0hz1uh/tXRmYBqP2ghVY/1EgDt5oOw+fVaM4N9IccQ==
X-Google-Smtp-Source: APXvYqwEay32tZ67d1pnpiUQv4wvXQaJmUw10KBTCy/isaFzhTkheZJm6RN/SlMhPx5MtBPryEnlPcoCjQaeEkl+B1s=
X-Received: by 2002:aca:1012:: with SMTP id 18mr5372313oiq.151.1582139152379;
 Wed, 19 Feb 2020 11:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com> <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
In-Reply-To: <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Feb 2020 11:05:41 -0800
Message-ID: <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 3:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
>
> > These counters will track hugetlb reservations rather than hugetlb
> > memory faulted in. This patch only adds the counter, following patches
> > add the charging and uncharging of the counter.
>
> We're still pretty thin on review here, but as it's v12 and Mike
> appears to be signed up to look at this work, I'll add them to -next to
> help move things forward.
>

Hi Andrew,

Since the patches were merged into -next there have been build fixes
and test fixes and some review comments. Would you like me to submit
*new* patches to address these, or would you like me to squash the
fixes into my existing patch series and submit another iteration of
the patch series?
