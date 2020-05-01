Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72751C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FAF208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEAUvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:51:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:62859 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgEAUvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:51:07 -0400
IronPort-SDR: bSxClE756ScLStAo+n1RStKKg4zuDonkxXjuFHxA+qNmUVu9HC+ocWB+zl44AqySwqC0qF+4aa
 MRYN/pX3pMrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 13:51:07 -0700
IronPort-SDR: 1J/GPXbfbR06ENSBA5cKOfIP+HoDBTDNtWVKgkcDy0VaCyVd2fbRdGHO7+Enkk+vIIsRnE9kPi
 SJoi6L2XY71A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; 
   d="scan'208";a="460375152"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga006.fm.intel.com with ESMTP; 01 May 2020 13:51:06 -0700
Date:   Fri, 1 May 2020 13:51:06 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Joshua Abraham <j.abraham1776@gmail.com>
Cc:     pbonzini@redhat.com, corbet@lwn.net, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kvm: Fix KVM_KVMCLOCK_CTRL API doc
Message-ID: <20200501205106.GE4760@linux.intel.com>
References: <20200501193404.GA19745@josh-ZenBook>
 <20200501201836.GB4760@linux.intel.com>
 <20200501203234.GA20693@josh-ZenBook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501203234.GA20693@josh-ZenBook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:32:34PM -0400, Joshua Abraham wrote:
> On Fri, May 01, 2020 at 01:18:36PM -0700, Sean Christopherson wrote:
> > No, the current documentation is correct.  It's probably not as clear as
> > it could be, but it's accurate as written.  More below.
> > 
> > The ioctl() signals to the host kernel that host userspace has paused the
> > vCPU.
> > 
> > >  The host will set a flag in the pvclock structure that is checked
> > 
> > The host kernel, i.e. KVM, then takes that information and forwards it to
> > the guest kernel via the aforementioned pvclock flag.
> > 
> > The proposed change would imply the ioctl() is somehow getting routed
> > directly to the guest, which is wrong.
> 
> The rationale is that the guest is what consumes the pvclock flag, the
> host kernel does nothing interesting (from the API caller perspective) 
> besides setting up the kvmclock update. The ioctl calls kvm_set_guest_paused() 
> which even has a comment saying "[it] indicates to the guest kernel that it has 
> been stopped by the hypervisor." I think that the docs first sentence should 
> clearly reflect that the API tells the guest that it has been paused. 

I don't disagree, but simply doing s/host/guest yields a misleading
sentence and inconsistencies with the rest of the paragraph.
