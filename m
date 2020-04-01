Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED0BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483932063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759627;
	bh=tak/z0Ecd2qWidWvrYPp+iIYVCOCxIJP9AZPU2SreOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EZh/NQmh8RN0GWew/7dEjBrb/TltWDjMUVnELEXb+Y0ovL2t8zi7pW2VzCxOg+ze0
	 6IOvqKrE27bX/7Stg0rFsTEFaIa/c+p8Ux8s/680geYXd6JIz2D1ds2+aoaNxikx+P
	 DurUXHjYXtdptNPsQcUo81T1I4KR+GQoGU3Qx7pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390027AbgDAQrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:47:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbgDAQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:47:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id u10so868490wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDHtrdSZNoLS1sP98Si1Rgv/b2XhOVAqCit5vWVsyBI=;
        b=bm3MJzU8/SjRZsdVM+3g3N8CAY/HNkNNwFyrw3nW4M+xxgZrPjoBn6TJiSL0PlB8oi
         QhQIjZ8b3hKMIPlJSwqqh+UyBaex/MdGCqEbrCOhYK/LDAXVUzBej1tNXuzdzgSfLZt7
         iFQeNW28LUaUwDjU75OU4YB5FbD+zJ1r4OkQ5etbePFhLJ4ndyffyD65iarNJr/mChQY
         Q4gzgPS8wPNtnhUbidagcdViR9uvEpVWRplBEvTkezUxugRmdngdYeBfVBirQajdPZKv
         bfWJQebdHunPGnOGQKyOIBbcubC6OoyeqJeLBIK+wXENhk3NFeYRAetn9LPhy1L/bWlM
         C6Xg==
X-Gm-Message-State: ANhLgQ1gZpxf2fmQVtCQVS5S0bYBDiGVvH+O70oHBxt+ZYj52/6bpdmu
        MAOc3gKaLH/SLe5u0er+t5w=
X-Google-Smtp-Source: ADFU+vvJnv8hoFK0txzman/amwiiN6I8eDWJhlhUWV6Ec77ldyMbnv+DAs+9OYypVpK0kQ5XpoJNMw==
X-Received: by 2002:a5d:5547:: with SMTP id g7mr27309581wrw.263.1585759621755;
        Wed, 01 Apr 2020 09:47:01 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id w9sm3712138wrk.18.2020.04.01.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:47:00 -0700 (PDT)
Date:   Wed, 1 Apr 2020 18:46:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200401164654.GY22681@dhcp22.suse.cz>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200401154217.GQ22681@dhcp22.suse.cz>
 <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
 <20200401160048.GU22681@dhcp22.suse.cz>
 <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
 <20200401161243.GW22681@dhcp22.suse.cz>
 <20200401161810.xvqikca2x46yqrlx@ca-dmjordan1.us.oracle.com>
 <20200401162655.GX22681@dhcp22.suse.cz>
 <CA+CK2bCGpG6kBjkGd-QP06kNtwezj8mW13Jdvbxs6ExzRaJSpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCGpG6kBjkGd-QP06kNtwezj8mW13Jdvbxs6ExzRaJSpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 12:41:13, Pavel Tatashin wrote:
> On Wed, Apr 1, 2020 at 12:26 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 01-04-20 12:18:10, Daniel Jordan wrote:
> > > On Wed, Apr 01, 2020 at 06:12:43PM +0200, Michal Hocko wrote:
> > > > On Wed 01-04-20 12:09:29, Daniel Jordan wrote:
> > > > > On Wed, Apr 01, 2020 at 06:00:48PM +0200, Michal Hocko wrote:
> > > > > > On Wed 01-04-20 17:50:22, David Hildenbrand wrote:
> > > > > > > On 01.04.20 17:42, Michal Hocko wrote:
> > > > > > > > This needs a double checking but I strongly believe that the lock can be
> > > > > > > > simply dropped in this path.
> > > > >
> > > > > This is what my fix does, it limits the time the resize lock is held.
> > > >
> > > > Just remove it from the deferred intialization and add a comment that we
> > > > deliberately not taking the lock here because abc
> > >
> > > I think it has to be a little more involved because of the window where
> > > interrupts might allocate during deferred init, as Vlastimil pointed out a few
> > > years ago when the change was made.
> >
> > I do not remember any details but do we have any actual real allocation
> > failure or was this mostly a theoretical concern. Vlastimil? For your
> > context we are talking about 3a2d7fa8a3d5 ("mm: disable interrupts while
> > initializing deferred pages")
> 
> I do not remember seeing any real failures, this was a theoretical
> window. So, we could potentially simply remove these locks until we
> see a real boot failure in some interrupt thread. The allocation has
> to be rather large as well.

Yes please! We are really great at over complicating and over
engineering stuff based on theoretical issues and build on top of that
and make the code even more complex because nobody dares to re-evaluate
and so on.

-- 
Michal Hocko
SUSE Labs
