Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB4AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D2E2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="frrID6iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgHXP64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:58:56 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:27649 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHXP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1598284729;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ekSyY2qHZjohrMi/ErCReXQ4Ow5pgNEtu5DGbXh0X+s=;
  b=frrID6iXFQpHp7PXW3sowgD0vlpKJolLSrLsD4XVLrLQcvO6ADmKeYt+
   Por/tPTf7nOCxMd01Lih62rfxxtcAZ9O8u88XPnQtKjRRkKf8jtbMGRAZ
   qcJOUGiIWepyF1FK9d+Kux3nXg5FXvTAub1AWt7xbawUA6c8ID+HCzSpX
   0=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: tHj33tqIHgCXymvnOYLLEBfAQj7VddiLPac4gs7q7F0Pli/isHdjb++5CEbv083JhpFtexRV4n
 dbvqUX+YX1R0i35X6ayU1ebc1sYOOc5AfG52Prmcq4M+G/ZL5GBR/pGQeWxbgMja/Tsux774oe
 fGrc6tE2HrNa5BhyOqhRzJ8/p8VbX6sbI2ErSqmq+jtezTHvZ7R5gidPPmSqBFqdxmKnq1ff4p
 Bx/a5uSP0jIV4ioFBhDwlRF7XzTMIeBU5UIITmdyfUKWSXm1YOg5YFsdXbo7Cb48kUcC1fjRu8
 +yE=
X-SBRS: 2.7
X-MesageID: 25501271
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,349,1592884800"; 
   d="scan'208";a="25501271"
Subject: Re: [PATCH] x86/entry: Fix AC assertion
To:     <peterz@infradead.org>
CC:     <x86@kernel.org>, Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20200824101428.GS1362448@hirez.programming.kicks-ass.net>
 <d2b0c6a5-19d8-f868-e092-e5c197ab0d0e@citrix.com>
 <20200824152135.GV1362448@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <a79f11e4-2b9f-ea8d-a032-dee84a500f73@citrix.com>
Date:   Mon, 24 Aug 2020 16:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824152135.GV1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2020 16:21, peterz@infradead.org wrote:
> On Mon, Aug 24, 2020 at 03:22:06PM +0100, Andrew Cooper wrote:
>> On 24/08/2020 11:14, peterz@infradead.org wrote:
>>> The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Further
>>> improve user entry sanity checks") unconditionally triggers on my IVB
>>> machine because it does not support SMAP.
>>>
>>> For !SMAP hardware we patch out CLAC/STAC instructions and thus if
>>> userspace sets AC, we'll still have it set after entry.
>> Technically, you don't patch in, rather than patch out.
> True.
>
>>> Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user entry sanity checks")
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Acked-by: Andy Lutomirski <luto@kernel.org>
>>> ---
>>>  arch/x86/include/asm/entry-common.h |   11 +++++++++--
>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> --- a/arch/x86/include/asm/entry-common.h
>>> +++ b/arch/x86/include/asm/entry-common.h
>>> @@ -18,8 +18,15 @@ static __always_inline void arch_check_u
>>>  		 * state, not the interrupt state as imagined by Xen.
>>>  		 */
>>>  		unsigned long flags = native_save_fl();
>>> -		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
>>> -				      X86_EFLAGS_NT));
>>> +		unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
>>> +
>>> +		/*
>>> +		 * For !SMAP hardware we patch out CLAC on entry.
>>> +		 */
>>> +		if (boot_cpu_has(X86_FEATURE_SMAP))
>>> +			mask |= X86_EFLAGS_AC;
>> The Xen PV ABI clears AC on entry for 64bit guests, because Linux is
>> actually running in Ring 3, and therefore susceptible to #AC's which
>> wouldn't occur natively.
> So do you then want it to be something like:
>
> 	if (boot_cpu_has(X86_FEATURE_SMAP) ||
> 	    (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
>
> ? Or are you fine with the proposed?

Dealers choice, but this option would be slightly better overall.

(Are there any other cases where Linux will be running in Ring 3?  I
haven't been paying attention to recent changes in PVOps.)

~Andrew
