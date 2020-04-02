Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1259C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F05207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwo1sQwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbgDBXSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:18:15 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36076 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDBXSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:18:15 -0400
Received: by mail-il1-f194.google.com with SMTP id p13so5432768ilp.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39dgXP5mbIg8YapOVVddrrbM7IoqVqxM5hwBU1j8EUs=;
        b=dwo1sQwWh9cHbBQrmkixhDQuRMc3S2WNAcFZSWZFwhrPENB7yJ8Aq4pl4Vp+quJApm
         tGXKNwBWAP4ca9T0JhdQkFsnO1j30wqpkZYa917k1wo4pKEhpsSkMBdwYbmdEJsfO+x7
         vOsCnA5Wpv4sgcy/5xdAvsA7ATWmYV1jGglfh1J9vX7LZjrsBB1/XU87OunvRWysb9ut
         oozz4ur7HMDbGeGlFPGOVADtBfQCen7XgIv3BnV7nSijerinrdf8PXH2yYruik9EomGS
         aeMauAp3DXKGlHJt80YjBCKXrlX2hEn4/0WcoBaT/l3Vt3x6j+P6rKAqypraG1OBBmTs
         NJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39dgXP5mbIg8YapOVVddrrbM7IoqVqxM5hwBU1j8EUs=;
        b=YwEH2n+aCzZNnRv7G8pLEERlmvk4DEibGpnda7UWZTmv77eGdCNQpjmgTi4DqGeLUM
         zd+1M3XeiDnfNzmI9A35X7Br+XHlXkM9pTW8EYBAK4aLNCEIzff0u/IZZB4pE0LgnfHD
         P/qUYLt/sk+BELpSuAJE7pXZ+SUeINh5oBoO3497qKk5jJtZIz3RMhwrx+g4TO1v4IYb
         z97T3iJWJ3kLTqbc/NDu+FvAcwycAMzpU9ng5UFALeG2BB85wJPG4tI+ramcJDOnraKK
         IpXJtGqWpEh8defIThUH6q9xmS9eBPCZgozt6onlj+vODK3gdf3Z3uZOIBlVgY6E7tWK
         v4LA==
X-Gm-Message-State: AGi0PuakKnVbdZjGSnVaeQOlT1bomHfApCoOeG1o0ukygFMg2SAmT3hc
        BqQPp/9ayTFiSMM4lOEFbGnkaDD2Fl0pm9GSHabvKA==
X-Google-Smtp-Source: APiQypL/lGLPx7YT86ux57tULDVK457ntFa+LYEm+kpoKEXkiy1gvSvDDTtl7qb2LZN4VOY/qxG+D1B9NtX31AOZhFA=
X-Received: by 2002:a92:5fdb:: with SMTP id i88mr5930879ill.118.1585869492403;
 Thu, 02 Apr 2020 16:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200402124205.334622628@linutronix.de> <20200402155554.27705-1-sean.j.christopherson@intel.com>
 <20200402155554.27705-4-sean.j.christopherson@intel.com> <87sghln6tr.fsf@nanos.tec.linutronix.de>
 <20200402174023.GI13879@linux.intel.com> <87h7y1mz2s.fsf@nanos.tec.linutronix.de>
 <20200402205109.GM13879@linux.intel.com> <87zhbtle15.fsf@nanos.tec.linutronix.de>
 <08D90BEB-89F6-4D94-8C2E-A21E43646938@vmware.com> <20200402190839.00315012@gandalf.local.home>
 <alpine.DEB.2.21.2004021613110.10453@xps-7390>
In-Reply-To: <alpine.DEB.2.21.2004021613110.10453@xps-7390>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 2 Apr 2020 16:18:01 -0700
Message-ID: <CALMp9eSgKQW=rVnBq26cjNfcDXv2BWeA47oHM5pyQke7RpGykw@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Extend VMX's #AC interceptor to handle
 split lock #AC in guest
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86 <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Covelli <dcovelli@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 4:16 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Thu, 2 Apr 2020, Steven Rostedt wrote:
>
> > If we go the approach of not letting VM modules load if it doesn't have the
> > sld_safe flag set, how is this different than a VM module not loading due
> > to kabi breakage?
>
> Why not a compromise: if such a module is attempted to be loaded, print up
> a message saying something akin to "turn the parameter 'split_lock_detect'
> off" as we reject loading it- and if we see that we've booted with it off
> just splat a WARN_ON() if someone tries to load such modules?

What modules are we talking about? I thought we were discussing L1
hypervisors, which are just binary blobs. The only modules at the L0
level are kvm and kvm_intel.
