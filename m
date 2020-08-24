Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B47C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3123A206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LcX0Q13F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHXOWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:22:16 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:17739 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgHXOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1598278931;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6ZqAL8XzsNQ5my/LVQKdlQtrZWak9QB6BcQ1XCkyhys=;
  b=LcX0Q13FHSua+E6RI3Gw8DnmGpXVu5rcChnJwSNZUgRQE0j6eCWDazP5
   LfJeFnJ5bHxeqFjm37uyzGjJ+d4cDdr1yWMwW/wZ42P/UHnp1EO8Akg2h
   ygBxcxFzNPTP0CWBD6KxGlcUpMd87h5FoXxX8V0NGUp++WyR6gcvITwE9
   8=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: S/owU0jQ1Zek4imb6IBEJTywAXw/d+Qp+OzIR/n9oDG9pE2TJoweP+pNnI5A2f2l0WF/ZkYQLr
 IVL3NMlcEMUfKCVcz2OVtX1TecuGo9U21UtRxKiQqSTMlth2PskmKAROgdjg0RFVW/pyT5ptZP
 DBlor+Y3THdN8MmmT4WCYzGXqBcj7DSGsQHTwk58ILkLw26RPZNd8y2mF+IkFXtlf8d0Z/Dgvr
 95dioBiOMS3/0La6v9ke0ebwlvGy4cIjh4v5hLzj5yCN1vIS2qfIG0GoMgH7JtVFkswHYUgp5l
 /Tc=
X-SBRS: 2.7
X-MesageID: 25147877
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,348,1592884800"; 
   d="scan'208";a="25147877"
Subject: Re: [PATCH] x86/entry: Fix AC assertion
To:     <peterz@infradead.org>, <x86@kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>
References: <20200824101428.GS1362448@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <d2b0c6a5-19d8-f868-e092-e5c197ab0d0e@citrix.com>
Date:   Mon, 24 Aug 2020 15:22:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824101428.GS1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2020 11:14, peterz@infradead.org wrote:
> The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Further
> improve user entry sanity checks") unconditionally triggers on my IVB
> machine because it does not support SMAP.
>
> For !SMAP hardware we patch out CLAC/STAC instructions and thus if
> userspace sets AC, we'll still have it set after entry.

Technically, you don't patch in, rather than patch out.

>
> Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user entry sanity checks")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/entry-common.h |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -18,8 +18,15 @@ static __always_inline void arch_check_u
>  		 * state, not the interrupt state as imagined by Xen.
>  		 */
>  		unsigned long flags = native_save_fl();
> -		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
> -				      X86_EFLAGS_NT));
> +		unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
> +
> +		/*
> +		 * For !SMAP hardware we patch out CLAC on entry.
> +		 */
> +		if (boot_cpu_has(X86_FEATURE_SMAP))
> +			mask |= X86_EFLAGS_AC;

The Xen PV ABI clears AC on entry for 64bit guests, because Linux is
actually running in Ring 3, and therefore susceptible to #AC's which
wouldn't occur natively.

~Andrew
