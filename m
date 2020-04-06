Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120E6C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D5F20753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDFVh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:37:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45760 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDFVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:37:28 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jLZQV-0001S6-Ah; Mon, 06 Apr 2020 23:37:03 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C4A0B100C47; Mon,  6 Apr 2020 23:37:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware (out-of-tree) module enables VMX
In-Reply-To: <20200406125010.GA29306@infradead.org>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com> <20200406125010.GA29306@infradead.org>
Date:   Mon, 06 Apr 2020 23:37:02 +0200
Message-ID: <87tv1wjny9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> On Fri, Apr 03, 2020 at 09:30:07AM -0700, Sean Christopherson wrote:
>> Hook into native CR4 writes to disable split-lock detection if CR4.VMXE
>> is toggled on by an SDL-unaware entity, e.g. an out-of-tree hypervisor
>> module.  Most/all VMX-based hypervisors blindly reflect #AC exceptions
>> into the guest, or don't intercept #AC in the first place.  With SLD
>> enabled, this results in unexpected #AC faults in the guest, leading to
>> crashes in the guest and other undesirable behavior.
>
> Out of tree modules do not matter, so we should not add code just to
> work around broken third party code.  If you really feel strongly just
> make sure something they rely on for their hacks stops being exported
> and they are properly broken.

As we agreed on elsewhere in the thread already, we are not going to
disable SLD, we just reject the module to be loaded. That's way better
than silently failing.

Aside of that I think that we should extend this kind of analysis to
other nasty patterns of out of tree modules, like directly fiddling with
CR* and other circumventions of stuff we are trying to protect.

Thanks,

        tglx
