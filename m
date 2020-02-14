Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5689C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F36206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbgBNTy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:54:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:16319 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbgBNTy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:54:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="257632479"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 14 Feb 2020 11:54:55 -0800
Date:   Fri, 14 Feb 2020 11:54:55 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm/emulate: fix a -Werror=cast-function-type
Message-ID: <20200214195454.GG20690@linux.intel.com>
References: <1581695768-6123-1-git-send-email-cai@lca.pw>
 <20200214165923.GA20690@linux.intel.com>
 <1581700124.7365.70.camel@lca.pw>
 <CALMp9eTRn-46oKg5a9h79EZOvHGwT=8ZZN15Zmy5NUYsd+r8wQ@mail.gmail.com>
 <1581707646.7365.72.camel@lca.pw>
 <28680b99-d043-ee02-dab3-b5ce8c2e625b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28680b99-d043-ee02-dab3-b5ce8c2e625b@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:33:50PM +0100, Paolo Bonzini wrote:
> On 14/02/20 20:14, Qian Cai wrote:
> >> It seems misguided to define a local variable just to get an implicit
> >> cast from (void *) to (fastop_t). Sean's first suggestion gives you
> >> the same implicit cast without the local variable. The second
> >> suggestion makes both casts explicit.
> > 
> > OK, I'll do a v2 using the first suggestion which looks simpler once it passed
> > compilations.
> > 
> 
> Another interesting possibility is to use an unnamed union of a
> (*execute) function pointer and a (*fastop) function pointer.

I considered that when introducing fastop_t.  I don't remember why I
didn't go that route.  It's entirely possible I completely forgot that
anonymous unions are allowed and thought it would mean changing a bunch
of use sites.
