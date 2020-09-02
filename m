Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B132C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2857D20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SX43yO/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBMfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:35:13 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98369C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 05:35:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n13so4731960edo.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 05:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4rF/yq5M8ifTAczaYaXvE/5Rh0KHOWFFE/+jNdXZrs=;
        b=SX43yO/lEpB+wj0mnfbD4nBzXL8bX3IZcPZnzMlnu3ip23vQ2I8ocHqN1f9i8/4tDI
         bGLkc0pEP1LTiWJiGYvj77n/Nb5hpc167l+QaiVDmlebzyHAvB+iJP1U58CF5gK+hrrF
         z1jDRw6vgfAdo1jOY8vW9v9NPpTUaLTd7pN2/s6j7SLqc17yJLr1l6EgSo80rhZOxkoP
         DrcRcsL0FHNKw9gqxeFj53SeErvNxsq6y9htoAWg19HX8jFTb4PbfsE8Hoi0/Whq5cLW
         A3omfeeb54TcWf1YbK22kl3lFx1mQbDvMW6wjZ2Ve4mGNmuwqllqkeMnAQQzn/b8R6qK
         H8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4rF/yq5M8ifTAczaYaXvE/5Rh0KHOWFFE/+jNdXZrs=;
        b=gFRVICS4AE7KzC9QO1ZSCHB2p1VaaNGWeSjqIlK+Q3rX26lWotxZrapHQ85brZRAW/
         daSw+oel562jHvgq+sXS+JXYxW0Y8zsrtGYcoHaa9lER9YierqdBNGSl54srqNIP4LDf
         tel/J9Yt+m0y/HrusmM2pdir4PTcV7KHSW/f8qNonrt2iJbqUSqmauzvTizazxQCTD5w
         xmJQ3xrYAcVwmAVAuSUHTg0cKMX+zG9Ll5Ejo/uQNBf3cy0IGL9VSNV8B8kAhdtmTZL+
         z0za/DgkL9kT0YN9uS2MkTAfeaUESxOXFyiD6o+nWbxFgrS/7mPi9xu5Kwks4D3qF4Gn
         vrDQ==
X-Gm-Message-State: AOAM532Q/A6tFg+J3RBhpsVFwtNxYW4Nf0qqzyIu53LdnSDOCBk1Jv+s
        8RUK+e2Lxs9dKX+wwx4PNPvh3gUBWG9qvbo3b5MtEA==
X-Google-Smtp-Source: ABdhPJwDY5rfx6SUKhnLfANCZH4T5a7778rYWZ4Dkd+N+1SS1+FyIo0aivBzlr1A066niH50hwCEBfUC59DPTKJn+Hw=
X-Received: by 2002:a05:6402:17da:: with SMTP id s26mr1105652edy.221.1599050109841;
 Wed, 02 Sep 2020 05:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200127173453.2089565-1-guro@fb.com> <20200130020626.GA21973@in.ibm.com>
 <20200130024135.GA14994@xps.DHCP.thefacebook.com> <CA+CK2bCQcnTpzq2wGFa3D50PtKwBoWbDBm56S9y8c+j+pD+KSw@mail.gmail.com>
 <20200813000416.GA1592467@carbon.dhcp.thefacebook.com> <CA+CK2bDDToW=Q5RgeWkoN3_rUr3pyWGVb9MraTzM+DM3OZ+tdg@mail.gmail.com>
 <CA+CK2bBEHFuLLg79_h6bv4Vey+B0B2YXyBxTBa=Le12OKbNdwA@mail.gmail.com>
 <20200901052819.GA52094@in.ibm.com> <CA+CK2bDZW4F-Y7PDiVZ_Jdbw8F5GCa26JRSXyxFbdu-Q6dEpRg@mail.gmail.com>
 <20200902062311.GB52094@in.ibm.com>
In-Reply-To: <20200902062311.GB52094@in.ibm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Sep 2020 08:34:34 -0400
Message-ID: <CA+CK2bB4bSUHc8wONCdbBXtnxmR_dvxVVW2mKs_hGnyG0+Gv6g@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] The new cgroup slab memory controller
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am on an old codebase that already has the fix that you are proposing,
> so I might be seeing someother issue which I will debug further.
>
> So looks like the loop in __offline_pages() had a call to
> drain_all_pages() before it was removed by
>
> c52e75935f8d: mm: remove extra drain pages on pcp list

I see, thanks. There is a reason to have the second drain, my fix is a
little better as it is performed only on a rare occasion when it is
needed, but I should add a FIXES tag. I have not checked
alloc_contig_range race.
