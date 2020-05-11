Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64618C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9A9206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgEKQFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:05:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:4979 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbgEKQFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:05:49 -0400
IronPort-SDR: WyOoBFdLgQZkD3SGqrwvEQD9YVgA35ycz63XCKo4Jb4HX2FJ4JfeGyKLXOy1D0MHtyiwlgdXgf
 NFdiZ4LTt7og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:05:37 -0700
IronPort-SDR: CuMDmvp+guQCKnW5QRpcjkWNuNQFRokn/Nj3L8qOqtPmgy06fw4MKiTsfMC/lEktCXYOblITrY
 UgO4wK6iXg2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="463220514"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2020 09:05:37 -0700
Date:   Mon, 11 May 2020 09:05:37 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Upton <oupton@google.com>,
        Tony Cook <tony-cook@bigpond.com>, zoran.davidovac@gmail.com,
        euloanty@live.com
Subject: Re: [PATCH] KVM: Fix a warning in __kvm_gfn_to_hva_cache_init()
Message-ID: <20200511160537.GC24052@linux.intel.com>
References: <20200504190526.84456-1-peterx@redhat.com>
 <20200505013929.GA17225@linux.intel.com>
 <20200505141245.GH6299@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505141245.GH6299@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc a few other people that have reported this at one time or another.

On Tue, May 05, 2020 at 10:12:45AM -0400, Peter Xu wrote:
> On Mon, May 04, 2020 at 06:39:29PM -0700, Sean Christopherson wrote:
> > On Mon, May 04, 2020 at 03:05:26PM -0400, Peter Xu wrote:
> > > GCC 10.0.1 gives me this warning when building KVM:
> > > 
> > >   warning: ‘nr_pages_avail’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >   2442 |  for ( ; start_gfn <= end_gfn; start_gfn += nr_pages_avail) {
> > > 
> > > It should not happen, but silent it.
> > 
> > Heh, third times a charm?  This has been reported and proposed twice
> > before[1][2].  Are you using any custom compiler flags?  E.g. -O3 is known
> > to cause false positives with -Wmaybe-uninitialized.
> 
> No, what I did was only upgrading to Fedora 32 (which will auto-upgrade GCC),
> so it should be using the default params of whatever provided.
> 
> > 
> > If we do end up killing this warning, I'd still prefer to use
> > uninitialized_var() over zero-initializing the variable.
> > 
> > [1] https://lkml.kernel.org/r/20200218184756.242904-1-oupton@google.com
> > [2] https://bugzilla.kernel.org/show_bug.cgi?id=207173
> 
> OK, I didn't know this is a known problem and discussions going on.  But I
> guess it would be good to address this sooner because it could become a common
> warning very soon after people upgrades gcc.

Ya, others are hitting this as well.  It's especially painful with the
existence of KVM_WERROR.

Paolo, any preference on how to resolve this?  It would appear GCC 10 got
"smarter".
