Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7159AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2839B20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgDGUVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:21:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:49791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgDGUVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:21:37 -0400
IronPort-SDR: BIaomF4KtIAak56v/1CDUdIEoqAHi+pdWoPN7Kpj2hq1KzHywh7wrh8mk+4Yv/uwTRyTDzpuMy
 Stm/fzaeWNjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 13:21:36 -0700
IronPort-SDR: 7HIdM4Nl6qxtUCFxEpzsUZM2iV3EnWn6AFvbCF5JQ+Q9/IWGUwninM5SB+h6gzHA+q7a+s8ymq
 hhK5QO/V+SyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="254575428"
Received: from chenb-mobl1.amr.corp.intel.com (HELO [10.255.231.128]) ([10.255.231.128])
  by orsmga006.jf.intel.com with ESMTP; 07 Apr 2020 13:21:35 -0700
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0
 per-thread
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
References: <20200407011259.GA72735@juliacomputing.com>
 <8f95e8b4-415f-1652-bb02-0a7c631c72ac@intel.com>
 <CABV8kRw1TQsqs+z43bSfZ5isctuFGMB4g_ztDYihiiXHcy4nVA@mail.gmail.com>
 <5208ad1e-cd9b-d57e-15b0-0ca935fccacd@intel.com>
 <CABV8kRzfR32+MpAvTAPHCN902WtHSxySujcO2yAB3OT0caVDJg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <9921cb2e-a7cb-c1d0-b120-c08f06be7c7f@intel.com>
Date:   Tue, 7 Apr 2020 13:21:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABV8kRzfR32+MpAvTAPHCN902WtHSxySujcO2yAB3OT0caVDJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 10:55 AM, Keno Fischer wrote:
> On Tue, Apr 7, 2020 at 12:27 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>>>> How does this work with things like xstateregs_[gs]et() where the format
>>>> of the kernel buffer and thus the kernel XCR0 is exposed as part of our
>>>> ABI?  With this patch, wouldn't a debugger app see a state buffer that
>>>> looks invalid?
>>>
>>> Since those operate on the in-kernel buffer of these, which
>>> in this patch always uses the unmodified XCR0, ptracers
>>> should not observe a difference.
>>
>> Those operate on *BOTH* kernel and userspace buffers.  They copy between
>> them.  That's kinda the point. :)
> 
> Right, what I meant was that in this patch the kernel level
> xsaves that populates the struct fpu always runs with
> an unmodified XCR0, so the contents of the xsave area
> in struct fpu does not change layout (this is the major
> change in this patch over v1).

The userspace buffer is... a userspace buffer.  It is not and should not
be tied to the format of the kernel buffer.

> Are you referring to a ptracer which runs with a modified XCR0, and
> assumes that the value it gets back from ptrace will have an
> XSTATE_BV equal to its own observed XCR0 and thus get confused about
> the layout of the buffer (or potentially have not copied all of the
> relevant xstate because it calculated a wrong buffer size)?

I don't think it's insane for a process to assume that it can XRSTOR a
buffer that it gets back from ptrace.  That seems like something that
could clearly be an ABI that apps depend on.

Also, let's look at the comment about where XCR0 shows up in the ABI
(arch/x86/include/asm/user.h):

>  * For now, only the first 8 bytes of the software usable bytes[464..471] will
>  * be used and will be set to OS enabled xstate mask (which is same as the
>  * 64bit mask returned by the xgetbv's xCR0).

That also makes it sound like we expect there to be a *SINGLE* value
across the entire system.  It also makes me wonder *which* xgetbv is
expected to match USER_XSTATE_XCR0_WORD.  It can't be the ptracee since
we expect them to change XCR0.  It can't be the ptracer because they can
use this new prctl too.  So does it refer to the kernel?  Or, should the
new prctl() *disable* future ptrace()s?

> If so, I think that's just a buggy ptracer. The kernel's xfeature
> mask is available via ptrace and a well-behaved ptracer should use
> that (e.g. gdb does, though it looks like it then also assumes that
> the xstate has no holes, so it potentially gets the layout wrong
> anyway).

I'm trying to figure out what the semantics are of this whole thing.  It
can't be "don't let userspace observe the real XCR0" because ptrace
exposes that.  Is it, "make memory images portable, unless it's a memory
image from ptrace"?

> In general, I don't really want the modified XCR0 to affect
> anything other than the particular instructions that depend
> on it and maybe the signal frame (though as I said before,
> I'm open to either here).

Just remember that, in the end, we don't get to say what a good ptracer
or bad ptracer is.  If they're expecting semantics that we've kept
constant for 10 years, we change the semantics, and the app breaks, the
kernel is in the wrong.

I also don't feel like I have a good handle on what ptracers *do* with
their XSAVE buffers that they get/set.  How many apps in a distro do
something with this interface?
