Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97068C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED72207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HVouhgUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgIBMzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgIBMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:54:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4EC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 05:54:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l63so4797880edl.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jguf1LcpzdLbnb6m9J0BP0vWI/LKfE1Jts6BiXQTOXA=;
        b=HVouhgUe0h/dT/d25fmAt8+AdYkGMgTHsNTj5v0ofRuKkDS632pxM+ScRs+0Hy3nLB
         DQg3t5tY2PHuwD4M3USyJMU5+lCGOBjBvWIRfCYDvR1uXAoRV/weUz2gSAW/YzaPNURa
         bdfxgPpU+zKvGI07WPyDNuiDG/hb9hQI2afHwcrREBe+XMU2rqLo+5ZmdyRNMNgtNnAq
         bemfPQgUfLIOfyN9sCqvTNSP6TbOhP7odrcAnsvG82RdBk1oU7lD2QZd7LfgMPMz485Z
         Vgnwbx9hyLy6RbBIBo2AtdkOVIvPpzojlLk71ifI/7XXL+r1pLdsrmvR7tu76psXNaoT
         1e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jguf1LcpzdLbnb6m9J0BP0vWI/LKfE1Jts6BiXQTOXA=;
        b=rRPg/DDGBMWv6uAWf/PDGAOKw8gw4yx6IOd6/e5+B1aKuI29ZxIRH8tbuPZRP5g4A2
         /dNXnnP/fjeZ26WV12NZImdTw8TuoxcI4MyD96xaFsCyYrGFL3eHJ9kvAIgvJxEEWcxJ
         3tZ8pFIYbhpWnHQn9JV2JRPLLbBEB3VwiFeU9lpsV0H3RIKFYfzr3LLxRixio8clXy4F
         420b/ESTJgYpIGwAXpwaeWm0oSdaUdOs/4fwOC3g2RyJJKYo/XVc9NqBHomA1WyrYJYg
         XvMqktzTw5CDaNZDJNApf/t2nFKIpfFiVlaqckO1rg9w2x54Zq4l8Y6NzblwrfrOSiVh
         X8Gw==
X-Gm-Message-State: AOAM533FQYk9OYStaAN+UHS5UoH0vNRDR9eHy6n/9zRQ8HL+M7x6Nmmz
        keC6Xn+axw4nlIhTB5MJ8ULV6MrJKQdmlg0NtSsuRA==
X-Google-Smtp-Source: ABdhPJyaN78gS/ZUa0KTrLX84zGJiMFwqPH7s7EsAhv3YTCXunsjJ0gi6JjMwMbqDGXOC126EP7OpX0Pk8dwY/z8JZ4=
X-Received: by 2002:a05:6402:1d0f:: with SMTP id dg15mr6629378edb.342.1599051265010;
 Wed, 02 Sep 2020 05:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200127173453.2089565-1-guro@fb.com> <20200130020626.GA21973@in.ibm.com>
 <20200130024135.GA14994@xps.DHCP.thefacebook.com> <CA+CK2bCQcnTpzq2wGFa3D50PtKwBoWbDBm56S9y8c+j+pD+KSw@mail.gmail.com>
 <20200813000416.GA1592467@carbon.dhcp.thefacebook.com> <CA+CK2bDDToW=Q5RgeWkoN3_rUr3pyWGVb9MraTzM+DM3OZ+tdg@mail.gmail.com>
 <CA+CK2bBEHFuLLg79_h6bv4Vey+B0B2YXyBxTBa=Le12OKbNdwA@mail.gmail.com>
 <6469324e-afa2-18b4-81fb-9e96466c1bf3@suse.cz> <20200902113204.GD4617@dhcp22.suse.cz>
In-Reply-To: <20200902113204.GD4617@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Sep 2020 08:53:49 -0400
Message-ID: <CA+CK2bA6EpfSMZD6egysFqdw0tZFuPAxEJc-rQbJTnjf+u2TGA@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] The new cgroup slab memory controller
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 7:32 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 02-09-20 11:53:00, Vlastimil Babka wrote:
> > >> > > Thread #2: ccs killer kthread
> > >> > >    css_killed_work_fn
> > >> > >      cgroup_mutex  <- Grab this Mutex
> > >> > >      mem_cgroup_css_offline
> > >> > >        memcg_offline_kmem.part
> > >> > >           memcg_deactivate_kmem_caches
> > >> > >             get_online_mems
> > >> > >               mem_hotplug_lock <- waits for Thread#1 to get read access
>
> And one more thing. THis has been brought up several times already.
> Maybe I have forgoten but why do we take hotplug locks in this path in
> the first place? Memory hotplug notifier takes slab_mutex so this
> shouldn't be really needed.

Good point, it seems this lock can be completely removed from
memcg_deactivate_kmem_caches

Pasha

> --
> Michal Hocko
> SUSE Labs
