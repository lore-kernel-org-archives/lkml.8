Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F5DC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B7F2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bX0//RWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgDXQZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgDXQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:25:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7ACC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:25:19 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b12so10934922ion.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9NwqAXZ16ztzXp1zBHQSfRgUn9IPW7nGp69A48BIn8=;
        b=bX0//RWI4pfNyrf5ltw0MZ7T8jjJo+mVgXpEIRZ/TK+g22E360mDtxydj6ANgQgPNH
         Cuv8aKELAVTZmphsVtBozRfQm9NW1+brDA5zVf4j8vESw2ov47Tc5T76AmOiDcCrnt9K
         88x6h5AhlaN82qbZq/ZNywNq0H/ChvmpSdpQxz6fAqBt9Cf4kUMkVpqzfIRZEPyN2/eI
         RLCvSAfhfD5IVD+G/C552dqTJ1hbnr/DuxbS+aQMGGDUZ38g1VE7V9NvsxMKp3qNxfO4
         hkcaFQdcT51zgVFW198KHIrbB0d0yhbkhDhPrzyvu1tQ+v8SDi57iyiEsIxA9XCVV6wA
         uMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9NwqAXZ16ztzXp1zBHQSfRgUn9IPW7nGp69A48BIn8=;
        b=M5RK1EfFJEw+812drngY1DzR69hjhEtYrFrE9xUlFIhIUQ3bDO8+ykyIFe6gWn4zpv
         EaBcGk7LQgVwNwnD+PUM1/hRHAnkZibWAqRCibT/9EJCkNnJVsgHzfIfpUIcTEry620z
         NWYltDpBv8xenfS+D3tnxDj4JLnXAObF1njpRBRdxlp7pYVA0QMMsEBg37aB4E1BYhji
         hIfHmlSRtDba9c18mIIsAWI9e8ze9KMSOlYu0RzqSdOLQ316Qa4rcNC8Ie564yW6edI6
         kLUnH7riB064R9zfVn+1MkakhnoRIX0d1Z3rS9XrLL8sSfHjGC0hdQvu7/oksOKnXfKu
         9Rqw==
X-Gm-Message-State: AGi0Pua5VZ9F9KhiDPX3mjVrKFvigp5r5PD6HtbpMwA8a+uPsUtHWNYJ
        zyVZSRor+XXxFpHiVxZ5CAMzHH840kJEak5KzacV1w==
X-Google-Smtp-Source: APiQypIwqVR6Y+rC8zImSR9nN/+vSOB4mAAWXn8idVMSqNTEUa3+FFp62JpBUKiv2CeoArFWHhJgEDvaFKQIcWkeBFY=
X-Received: by 2002:a6b:91d4:: with SMTP id t203mr9533511iod.70.1587745518057;
 Fri, 24 Apr 2020 09:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <1587704935-30960-1-git-send-email-lirongqing@baidu.com>
 <20200424100143.GZ20730@hirez.programming.kicks-ass.net> <20200424144625.GB30013@linux.intel.com>
In-Reply-To: <20200424144625.GB30013@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 24 Apr 2020 09:25:06 -0700
Message-ID: <CALMp9eQtSrZMRQtxa_Z5WmjayWzJYhSrpNkQbqK5b7Ufxg-cMA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] kvm: x86: emulate APERF/MPERF registers
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Li RongQing <lirongqing@baidu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 7:46 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Apr 24, 2020 at 12:01:43PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 24, 2020 at 01:08:55PM +0800, Li RongQing wrote:

> This requires four RDMSRs per VMX transition.  Doing that unconditionally
> will drastically impact performance.  Not to mention that reading the MSRs
> without checking for host support will generate #GPs and WARNs on hardware
> without APERFMPERF.
>
> Assuming we're going forward with this, at an absolute minimum the RDMSRs
> need to be wrapped with checks on host _and_ guest support for the emulated
> behavior.  Given the significant overhead, this might even be something
> that should require an extra opt-in from userspace to enable.

I would like to see performance data before enabling this unconditionally.
