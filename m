Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DA1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE91D207F7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598373736;
	bh=5/aVEE+VpKD7/hu6P7jRjEZEagQqHRvGXJQdpGp19i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mgQ281hw4rrUXHlbuKYTsYD7Ar2XYoL/z+aXsE/Lz616i8uKN1v8tJs6z5IEWnVSj
	 uZDHPciWH6zPz/bxmNZmvA/0oHo3FZgcfPlNQ1gcWtVUvEZNu8vO90e0idIjGiNGux
	 CXzCVQOAbFjSYnJP9v4Kuf+jUTuoyeC7Pgqizz3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHYQmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgHYQmI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:42:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1E3207BC;
        Tue, 25 Aug 2020 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598373727;
        bh=5/aVEE+VpKD7/hu6P7jRjEZEagQqHRvGXJQdpGp19i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9amJV/OvBFEbRFH0eLFlMavkMlcrJKSut7SLkQUWL55SgoTKMFGcB4Pwjxf9JT7Z
         r4CjSPmZpHWsIG5nOUr5K9WolL/I5rG7M6BbgRieo88Iy4eYHrDR7Yk/0N09sevgkg
         Kq0A7f1TpeCLvNvxriQ85CwK95DazJTtSc+hsPEk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F316040D3D; Tue, 25 Aug 2020 13:42:03 -0300 (-03)
Date:   Tue, 25 Aug 2020 13:42:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Like Xu <like.xu@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf parse-events: Set exclude_guest=1 for user-space
 counting
Message-ID: <20200825164203.GA1059382@kernel.org>
References: <20200814012120.16647-1-yao.jin@linux.intel.com>
 <20200814124722.GG13995@kernel.org>
 <b061052d-592d-67d7-045f-481974b0687a@linux.intel.com>
 <3521b375-6f00-e815-94e5-49eae2a7c989@linux.intel.com>
 <38922f67-9f99-7fdf-1c54-0980020cd111@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38922f67-9f99-7fdf-1c54-0980020cd111@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 25, 2020 at 03:54:37PM +0800, Jin, Yao escreveu:
> Hi Arnaldo,
> 
> On 8/19/2020 11:05 AM, Like Xu wrote:
> > Hi Arnaldo,
> > 
> > On 2020/8/17 10:32, Jin, Yao wrote:
> > > Hi Arnaldo,
> > > 
> > > On 8/14/2020 8:47 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Aug 14, 2020 at 09:21:20AM +0800, Jin Yao escreveu:
> > > > > Currently if we run 'perf record -e cycles:u', exclude_guest=0.
> > > > > 
> > > > > But it doesn't make sense in most cases that we request for
> > > > > user-space counting but we also get the guest report.
> > > > > 
> > > > > Of course, we also need to consider perf kvm usage case that
> > > > > authorized perf users on the host may only want to count guest
> > > > > user space events. For example,
> > > > > 
> > > > > perf kvm --guest record -e cycles:u
> > > > Ok, probably this works, but what if I want to record guest user samples
> > > > without using 'perf kvm'?
> > > > 
> > > > Can we have a 'U' modifier, perhaps, for that?
> > > > 
> > > > I.e.
> > > > 
> > > > perf record -e cycles:uU would not set exclude_host not exclude_guest,
> > > > cycles:u excludes guest user, cycles:U excludes host user, would that be
> > > > possible?
> > > > 
> > > > Anyway, I think that with what we have, your patch makes sense, having a
> > > > way to, without using 'perf kvm' still be able to sample the guest can
> > > > be done on top. of this.
> > > > 
> > > > Xu, can we get your Reviewed-by if this addresses your concerns?
> > 
> > My concern is about do not break the perf kvm usages and Yao did it in v3.
> > 
> > Tested-by: Like Xu <like.xu@linux.intel.com>
> > 
> 
> Can this patch be accepted?

Sure.

> > > > 
> > > > - Arnaldo
> > > 
> > > Do you suggest we will create a new modifier 'U' as a follow-up patch?
> > > 
> > > cycles:u - Count host user space but it doesn't count the guest user
> > > space (exclude_host = 0, exclude_guest = 1, exclude_kernel = 1,
> > > exclude_user = 0, exclude_hv = 1)
> > > 
> > > cycles:U - Count the guest user space but it doesn't count the host
> > > user space (exclude_host = 1, exclude_guest = 0, exclude_kernel = 1,
> > > exclude_user = 0, exclude_hv = 1)
> > > 
> > > Is above understanding correct?
> > 
> > Do we really need to support sample guests without using perf kvm?
> > 
> > If it's true, I would prefer "cycles:uG" to cover guest user space
> > events only, "cycles:kG" to cover guest kernel space events only,
> > and only host events are sampled without the ":G" modifier by default.
> > 
> > I am not sure if ":G" has been used in perf.
> > 
> 
> That may be another good idea I think. :)

I have to check, but I don't think that :G is used.

- Arnaldo
