Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81D0C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C7620757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="wkVH2EJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgD1Rpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgD1Rpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:45:38 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239C1C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:45:38 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so17475837qts.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rD6+QlvoXId8Xl+YOpROYQir/HTlVS4cxd5DrH5tJkA=;
        b=wkVH2EJT5ZocpRW0i5Nm11VGlpqStET8dmjU5iWMCSJSZapiSEk/Tk8SDbPmYwj8H2
         wq7iwoOlgfwUt5zoD2zmO77ym6ZH9F0lPTsEvn1jWZV53B/sgJNjxKg9FEHisThz5W7V
         8UQfymCU9+C0TT0cU0zPBWWjuIG/mX+aoyS2+OOopFa2mmGAJn64ylaqJPB0JlKKpSIx
         z2Ql5kXsc3pbPkDuzt8HVlL6UO7BoC/C1X3r0lK1NK7+KePZY+9d4OurFKweZu9hhfz9
         otrWaRTtzYTTyBvFfKzmSUinghJUf6n4zVbiU1LIrYgH9Uwrcp5MLs0lrY/nVRWKiSwH
         Sxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rD6+QlvoXId8Xl+YOpROYQir/HTlVS4cxd5DrH5tJkA=;
        b=uWG3wtrSa1W+lixM12FukbJDEPzi4S3ZY1vuvf14om/oGwlqISHug3TaMmziYyJxLy
         drh9hLbJ8xiiDqyw6VemT+8UrFe+cg5ZAn2Wp0tuccm4hzlPo0uq1881V03T2sNqhDZs
         PWhMc/oyjAfzVGGq55dq7SdFG+PhFAAzxEfaiUWLYiDKzrDRu0EXBZaw79fFFmz/Aeg4
         1a/2AiuGe+hUs7yF4/Sr7ICfFr6qsSq/zxwFywoTUhE+E0BRZg9AN4iqgXHrOa10hfVR
         R3a7+Ka25vG58bsdiY+1kuSK/tv8Kbafx3IO2+11kU9WPZ7tZm3/OVOP4h3zgL8hc45d
         bK4g==
X-Gm-Message-State: AGi0PuaSnRgDVBGTviy+tts02g7Wtf1HDy6kX/BQYM6pg8VE197J0MtZ
        mn8XjrbxdT+7RiA7ptONRrglXg==
X-Google-Smtp-Source: APiQypIysUUVW77WATeTd/38hXjw0UW7Y8YAHmOnAd8rCltg+U7JxPZaRqJhRGPxNbQ2Eb9LyRAJDw==
X-Received: by 2002:ac8:e8f:: with SMTP id v15mr29118246qti.391.1588095937191;
        Tue, 28 Apr 2020 10:45:37 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id e4sm13522424qkn.11.2020.04.28.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:45:36 -0700 (PDT)
Date:   Tue, 28 Apr 2020 13:45:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200428174526.GA88367@cmpxchg.org>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
 <20200423000530.GA63356@carbon.lan>
 <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
 <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
 <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 09:46:38AM -0700, Roman Gushchin wrote:
> On Mon, Apr 27, 2020 at 04:21:01PM +0000, Christoph Lameter wrote:
> > On Fri, 24 Apr 2020, Roman Gushchin wrote:
> > 
> > > > The patch seems to only use it for setup and debugging? It is used for
> > > > every "accounted" allocation???? Where? And what is an "accounted"
> > > > allocation?
> > > >
> > > >
> > >
> > > Please, take a look at the whole series:
> > > https://lore.kernel.org/linux-mm/20200422204708.2176080-1-guro@fb.com/T/#t
> > >
> > > I'm sorry, I had to cc you directly for the whole thing. Your feedback
> > > will be highly appreciated.
> > >
> > > It's used to calculate the offset of the memcg pointer for every slab
> > > object which is charged to a memory cgroup. So it must be quite hot.
> > 
> > 
> > Ahh... Thanks. I just looked at it.
> > 
> > You need this because you have a separate structure attached to a page
> > that tracks membership of the slab object to the cgroup. This is used to
> > calculate the offset into that array....
> > 
> > Why do you need this? Just slap a pointer to the cgroup as additional
> > metadata onto the slab object. Is that not much simpler, safer and faster?
> > 
> 
> So, the problem is that not all slab objects are accounted, and sometimes
> we don't know if advance if they are accounted or not (with the current semantics
> of __GFP_ACCOUNT and SLAB_ACCOUNT flags). So we either have to increase
> the size of ALL slab objects, either create a pair of slab caches for each size.

Both options seem completely disproportionate in their memory cost,
and the latter one in terms of code complexity, to avoid the offset
calculation. As a share of the total object accounting cost, I'd
expect this to be minimal.

Does the mult stand out in an annotated perf profile?

Is it enough to bring back 500+ lines of code, an additional branch on
accounted allocations, and the memory fragmentation of split caches?

I highly doubt it.
