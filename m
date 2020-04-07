Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD384C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6517A2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxLby8j0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgDGXv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:51:59 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55566 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDGXv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:51:59 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so411123pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yi5N0/kPtibwvaPoEsen6lkTis7zla3Rx4lUTaY+3hg=;
        b=UxLby8j0hhHK4v1rgi2F9QL6OFUcWgpvoK4MUJ1TfyKvzIaQtPSrOQXbKEc8chl8/b
         etKzy10ELjXhrSdv8O/k5aUryyIeqGTGdlS0B1zbeKx7Pwmn9bJa4U8kuAO9bZIHHBDg
         NsnZM3NwmDwu6nV3x2xsHwCJGGbFkLHLFSh90EQ9Igf90f5cFYjDQUkF7Yr1gv6E1TYt
         wQdXhyzvnUwN4hip5j9DdmZQYteAY7gQQZYmWbuZc7TL3e3MKEHoud/n1ryATmDZmaAi
         OjhNruGj2jFxI+u+IbvlAXk3FOkCLIqfcnjuf3VfTk/JFHO0roPF1RKYxCXZuIRl2bDQ
         JylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yi5N0/kPtibwvaPoEsen6lkTis7zla3Rx4lUTaY+3hg=;
        b=MROwglufSOUV3bv/SEIcsOu5eZ0wIGdBPW3aeUhhvL+e1RIpOpvg/ANp5IfzpODN2+
         8hx0ukf40KprBSUHnTzHdy8Shm/k4hr7uwdw6h7r9lEiYl3P+XdN7o/QSbVTVJBii49Y
         nxewJFSyZqHhV45v22ssLket5XRjxhxRuf+oShyUBHA3MxkCiW92djRMMEZ3slB7z6wq
         Mgge9zM/8pcpqN5eql5O5YNK5WseU1a72dzXloHd0w4Zc6TF8Rl0k/rgvPL4kKCcxSlW
         4/sktC3pcKegqj5eNPDY+m5QzwcRNVdzTBxut1Vc8oUPIgHz8wGCiRxKh69PGebO/IR5
         vBLw==
X-Gm-Message-State: AGi0PuanGvwzFrJg0oAjDwWp6gagcu0STypzj7X6+iU8GVXGcs3Sfw3e
        1RMk6YJNZUovZw8kIyRgCD8=
X-Google-Smtp-Source: APiQypKN8Prkhxpg+xN01/pXYsicaesT0t7aLWZFCH+WZp5ZGHKV3aSCBAIzIkXVi24udZnCBdPpfA==
X-Received: by 2002:a17:902:d685:: with SMTP id v5mr4751396ply.256.1586303517938;
        Tue, 07 Apr 2020 16:51:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4700:9b2:1d50:a6a4:b3be:b3e4? ([2601:647:4700:9b2:1d50:a6a4:b3be:b3e4])
        by smtp.gmail.com with ESMTPSA id n7sm14245864pgm.28.2020.04.07.16.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 16:51:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <e390a895-cc09-0e9b-a05d-0c9b7bc6bfbd@redhat.com>
Date:   Tue, 7 Apr 2020 16:51:54 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, hch@infradead.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4B5EE1A-AD3C-4098-8784-E19356A25A48@gmail.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
 <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
 <20200407212754.GU2452@worktop.programming.kicks-ass.net>
 <e390a895-cc09-0e9b-a05d-0c9b7bc6bfbd@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 7, 2020, at 3:12 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 07/04/20 23:27, Peter Zijlstra wrote:
>> On Tue, Apr 07, 2020 at 02:22:11PM -0700, Nadav Amit wrote:
>>> Anyhow, I do not think it is the only use-case which is not covered =
by your
>>> patches (even considering CRs/DRs alone). For example, there is no =
kernel
>>> function to turn on CR4.VMXE, which is required to run hypervisors =
on x86.
>> That needs an exported function; there is no way we'll allow random
>> writes to CR4, there's too much dodgy stuff in there.
>=20
> native_write_cr4 and pv_ops (through which you can do write_cr4) are
> both exported, and so is cpu_tlbstate which is used by __cr4_set_bits
> and friends.  Am I missing something glaringly obvious?

No, I was the one who missed the obvious thing.

Having said that, I still think there are additional cases that need to =
be
handled. For instance, I see that is_erratum_383() in KVM (AMD) flushes =
the
local TLB by writing to CR3 the previous value. I am not familiar with =
the
erratum. Maybe I am missing something again, but I do not see an =
appropriate
exported alternative in the kernel.

