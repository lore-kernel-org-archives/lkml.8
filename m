Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B05D20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbgDBRew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:34:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38755 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389558AbgDBRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:34:51 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jK3jg-0000Nl-Dp; Thu, 02 Apr 2020 19:34:36 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D0441100D52; Thu,  2 Apr 2020 19:34:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch v2 1/2] x86,module: Detect VMX modules and disable Split-Lock-Detect
In-Reply-To: <2d2140c4-712a-2f8d-cde7-b3e64c28b204@intel.com>
References: <20200402123258.895628824@linutronix.de> <20200402124205.242674296@linutronix.de> <20200402152340.GL20713@hirez.programming.kicks-ass.net> <725ca48f-8194-658e-0296-65d4368803b5@intel.com> <20200402162548.GH20730@hirez.programming.kicks-ass.net> <2d2140c4-712a-2f8d-cde7-b3e64c28b204@intel.com>
Date:   Thu, 02 Apr 2020 19:34:35 +0200
Message-ID: <87pncpn650.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:
> On 4/3/2020 12:25 AM, Peter Zijlstra wrote:
>> On Fri, Apr 03, 2020 at 12:20:08AM +0800, Xiaoyao Li wrote:
>>> And, shouldn't we clear X86_FEATURE_SPLIT_LOCK_DETECT flag?
>> 
>> Don't think you can do that this late. Also, the hardware has the MSR
>> and it works, it's just that we should not.
>> 
>
> Actually, I agree to keep this flag.
>
> But, during the previous patch review, tglx wants to make
>
> 	sld_off = no X86_FEATURE_SPLIT_LOCK_DETECT
>
> I'm not sure whether he still insists on it now.

Obviously I cant.

> I really want to decouple sld_off and X86_FEATURE_SPLIT_LOCK_DETECT.
> So if X86_FEATURE_SPLIT_LOCK_DETECT is set, we can virtualize and expose 
> it to guest even when host is sld_off.

Can we first have a sane solution for the problem at hand?

Aside of that I'm still against the attempt of proliferating crap,
i.e. disabling it because the host is triggering it and then exposing it
to guests. The above does not change my mind in any way. This proposal
is still wrong.

Thanks,

        tglx


