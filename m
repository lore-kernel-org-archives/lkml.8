Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137DEC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC950214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bB6r52TI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgCCXty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:49:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33512 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgCCXty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:49:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id a20so260241otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 15:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpXe9qW1IE+W6FbdZ2WrOfJnBA8frqrFQCxhnKyXLE4=;
        b=bB6r52TIAf9ibs8y+NORyBaaxS8dDSOoFewL5V+z/CPv0VD4b2OXTG6GjdIJmrw58z
         cwXa6SOKYzcoE6dWgm+bCSol1ivF2L9qVLVRz3mKzFvrJAPRf4PWTkXNXW/is292Zn74
         J55/rf2DmiKqvpVC6Odc7IREGf3IQi86Z6kTQ7sARuwR+Lvq65kG2x/EoNvUplkvFTO8
         bSq3pb01X7RoInfsU5ZI55las/N8rTcK8Glm07jN+KgrytBr1AfviEAZU3goLEalPW+n
         doZIGwWim8QgvhWhdUTNejU9cr0K+fD99+36FFBaMy74hYx5hyy0UMccTYHE1fqqH6cy
         gT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpXe9qW1IE+W6FbdZ2WrOfJnBA8frqrFQCxhnKyXLE4=;
        b=sJQ4u8dmMz1JqS9w3emSF5eun71WuBfp6ZOKq16V3xfTOEnvImv553MEIYkbPGmJiD
         i3/wcYxOuoznTl8iwHsH/PAbESBlr4IcUZrhqVrGeYidWGQyftZAQRRdnuUJgRT7O1zw
         JKjvnsRHDSn4hEmYUJ0xoyn7McJw1Yi0BW3HLHLW9tfDS4p+Xm/wVXPXqm6pYhvIIcdj
         BuCr33+LZoEvgIlRbhtyF5/iFj50pxZ/ehCyQV6FAV23YxBGrDPbe1NuHWG5rG3YaGvh
         KfkKa6G+KIViysVk9UZ7PmEN4dr1vlI4M7mj5Rxrah9BsweMAy9K3+Pxiewd/r/QNfdS
         hSOw==
X-Gm-Message-State: ANhLgQ2m/Hoc2/+E4CqxXyPjXy1VOGrmN77fUmc5BjoYHYFpjD5MW79Y
        uKlmwBIjoESw8BmgQ19+EBkPRGBnhso/xzM0GIIU+Q==
X-Google-Smtp-Source: ADFU+vu5NG+LHZgFGYQ4CEDf0TzVyEVrAmHZbBF/cGdeYsoE/2mnZSmIsLY7rEqxxdjQqEx7kSxEZ5YVlstsYogMaFY=
X-Received: by 2002:a9d:664d:: with SMTP id q13mr329754otm.30.1583279393250;
 Tue, 03 Mar 2020 15:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20200302203109.179417-1-shakeelb@google.com> <20200303093251.GD4380@dhcp22.suse.cz>
In-Reply-To: <20200303093251.GD4380@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 3 Mar 2020 15:49:41 -0800
Message-ID: <CALvZod7C9nrS4S36AfTY74cx0=58LXNNh_b+mXzXNG1j9_6RZg@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: css_tryget_online cleanups
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 1:32 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 02-03-20 12:31:09, Shakeel Butt wrote:
> > Currently multiple locations in memcg code, css_tryget_online() is being
> > used. However it doesn't matter whether the cgroup is online for the
> > callers. Online used to matter when we had reparenting on offlining and
> > we needed a way to prevent new ones from showing up.
> >
> > The failure case for couple of these css_tryget_online usage is to
> > fallback to root_mem_cgroup which kind of make bypassing the memcg
> > limits possible for some workloads. For example creating an inotify
> > group in a subcontainer and then deleting that container after moving the
> > process to a different container will make all the event objects
> > allocated for that group to the root_mem_cgroup. So, using
> > css_tryget_online() is dangerous for such cases.
> >
> > Two locations still use the online version. The swapin of offlined
> > memcg's pages and the memcg kmem cache creation. The kmem cache indeed
> > needs the online version as the kernel does the reparenting of memcg
> > kmem caches. For the swapin case, it has been left for later as the
> > fallback is not really that concerning.
>
> Could you be more specific about the swap in case please?
>

With swap accounting enabled, if the memcg of the swapped out page is
not online then the memcg extracted from the given 'mm' will be
charged and if 'mm' is NULL then root memcg will be charged. However I
could not find a code path where the given 'mm' will be NULL for
swap-in case.

>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Other than that nothing really jumped at me although I have to confess
> that I am far from deeply familiar with the sk_buff charging path.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.
