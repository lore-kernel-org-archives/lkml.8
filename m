Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EC7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2510120870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1jcbLgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgCCRmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:42:55 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39403 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgCCRmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:42:54 -0500
Received: by mail-il1-f193.google.com with SMTP id w69so3514174ilk.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gtm53TC5rqrHg3h0I9s+1/H4clMch7YrubYWxhwSBQI=;
        b=b1jcbLgwz/oSW/Syh5ZSg2zyIcmG8ytdYX3QgbkeaKBI3ELKUb//qk2+9DWlYPai3q
         PguqBBpF9nF6tmxau6uB1enqyLCxYqPmyRELbaxd5EZW9OHb/KJxRjIeCI1oAEDFtKUi
         hxbL8KD9Lgl5HhXPJSXTU7nt9PZufXI4SYW5PZQAmW+ZzE2DbPWkZKfxizkMdwAPfPbf
         ir9Z7SxvDNkruM6RUd/5XoYEegF6JGygXWV21eyaZtALdiY9iDGKvKqoQ9ZSeCIYJcIK
         Xa3O8k9/42GoiijumnPhmbD1S7HLDdic/NKH3pUTffa1xtFUCGHObxvdFD5WHaPsbTO/
         lkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gtm53TC5rqrHg3h0I9s+1/H4clMch7YrubYWxhwSBQI=;
        b=DvNv2xvBjW/m8DzrmsOI8A3XYScupcY9xe8kRFsVGIy8jRPBx6tKBaTKPUTCgNKtgk
         EjMxuYJI0Xzfl6I4OzW+Ipf5Tnx7lMhGAH0i2+WVhYMEbVL1XK8f2Yn/wuzn+rfX6sIJ
         pFngkUqxDLHT/MmMtcPYVodnBwKsA4MFECVd08q4czAJshXs/9o8Uk7pec8wPjQAybth
         BidBo8keHPzSWLVgwZRnEyEYaMciaf/uAJUx7d1UoaU/4xcnMpuDmwGCi9xDkvC/qcXQ
         EAoJILRE034sLcRQLAJqCisa+Mb+OUWcA8aGqbv4yvAQc9cbln2Lt/Y9K6k8VDuNT+6Y
         tilw==
X-Gm-Message-State: ANhLgQ2vHHof0RRHKwKoiJKoUeDhrwRb5MlIBjO6ZMBIHU+A9yIk6Db2
        ABhzKxuZKzzQqxvDD5Fx6eGWY1PXNXpmajEPQrWlGg==
X-Google-Smtp-Source: ADFU+vsOHpu+DbdIuAQmx62AW4AJRhs37uEQZV2A/j7KjzVW2A4KbAVxB1AkTRwzhrAHXDKGtYGMou87dlUCMVNTXBU=
X-Received: by 2002:a92:8458:: with SMTP id l85mr6037720ild.296.1583257373851;
 Tue, 03 Mar 2020 09:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20200302195736.24777-1-sean.j.christopherson@intel.com>
 <20200302195736.24777-3-sean.j.christopherson@intel.com> <CALMp9eThBnN3ktAfwhNs7L-O031JDFqjb67OMPooGvmkcdhK4A@mail.gmail.com>
 <CALMp9eR0Mw8iPv_Z43gfCEbErHQ6EXX8oghJJb5Xge+47ZU9yQ@mail.gmail.com> <20200303045838.GF27842@linux.intel.com>
In-Reply-To: <20200303045838.GF27842@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 3 Mar 2020 09:42:42 -0800
Message-ID: <CALMp9eSYZKUBko4ZViNbasRGJs2bAO2fREHX9maDbLrYj8yDhQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] KVM: x86: Fix CPUID range check for Centaur and
 Hypervisor ranges
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfathomable was the wrong word. I can see what you're trying to do. I
just don't think it's defensible. I suspect that Intel CPU architects
will be surprised and disappointed to find that the maximum effective
value of CPUID.0H:EAX is now 255, and that they have to define
CPUID.100H:EAX as the "maximum leaf between 100H and 1FFH" if they
want to define any leaves between 100H and 1FFH.

Furthermore, AMD has only ceded 4000_0000h through 4000_00FFh to
hypervisors, so kvm's use of 40000100H through 400001FFH appears to be
a land grab, akin to VIA's unilateral grab of the C0000000H leaves.
Admittedly, one could argue that the 40000000H leaves are not AMD's to
apportion, since AMD and Intel appear to have reached a detente by
splitting the available space down the middle. Intel, who seems to be
the recognized authority for this range, declares the entire range
from 40000000H through 4FFFFFFFH to be invalid. Make of that what you
will.

In any event, no one has ever documented what's supposed to happen if
you leave gaps in the 4xxxxxxxH range when defining synthesized CPUID
leaves under kvm.

On Mon, Mar 2, 2020 at 8:58 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Mon, Mar 02, 2020 at 08:25:31PM -0800, Jim Mattson wrote:
> > On Mon, Mar 2, 2020 at 7:25 PM Jim Mattson <jmattson@google.com> wrote:
> > >
> > > On Mon, Mar 2, 2020 at 11:57 AM Sean Christopherson
> > > <sean.j.christopherson@intel.com> wrote:
> > >
> > > > The bad behavior can be visually confirmed by dumping CPUID output in
> > > > the guest when running Qemu with a stable TSC, as Qemu extends the limit
> > > > of range 0x40000000 to 0x40000010 to advertise VMware's cpuid_freq,
> > > > without defining zeroed entries for 0x40000002 - 0x4000000f.
> > >
> > > I think it could be reasonably argued that this is a userspace bug.
> > > Clearly, when userspace explicitly supplies the results for a leaf,
> > > those results override the default CPUID values for that leaf. But I
> > > haven't seen it documented anywhere that leaves *not* explicitly
> > > supplied by userspace will override the default CPUID values, just
> > > because they happen to appear in some magic range.
> >
> > In fact, the more I think about it, the original change is correct, at
> > least in this regard. Your "fix" introduces undocumented and
> > unfathomable behavior.
>
> Heh, the takeaway from this is that whatever we decide on needs to be
> documented somewhere :-)
>
> I wouldn't say it's unfathomable, conceptually it seems like the intent
> of the hypervisor range was to mimic the basic and extended ranges.  The
> whole thing is arbitrary behavior.  Of course if Intel CPUs would just
> return 0s on undefined leafs it would be a lot less arbitrary :-)
>
> Anyways, I don't have a strong opinion on whether this patch stays or goes.
