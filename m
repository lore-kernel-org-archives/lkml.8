Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFCFC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAB92076C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCTKJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:09:00 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:57604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726527AbgCTKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:09:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 69C4E18224D60;
        Fri, 20 Mar 2020 10:08:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tent22_886f8e4967e2d
X-Filterd-Recvd-Size: 2172
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 10:08:57 +0000 (UTC)
Message-ID: <b771dfc7409a99b35575c14cd4dd55d24f81ca98.camel@perches.com>
Subject: Re: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
From:   Joe Perches <joe@perches.com>
To:     Kyung Min Park <kyung.min.park@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com
Date:   Fri, 20 Mar 2020 03:07:10 -0700
In-Reply-To: <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
         <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-19 at 21:13 -0700, Kyung Min Park wrote:
> TPAUSE instructs the processor to enter an implementation-dependent
> optimized state. The instruction execution wakes up when the time-stamp
> counter reaches or exceeds the implicit EDX:EAX 64-bit input value.
> The instruction execution also wakes up due to the expiration of
> the operating system time-limit or by an external interrupt
> or exceptions such as a debug exception or a machine check exception.
[]
> diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
[]
> @@ -97,6 +97,27 @@ static void delay_tsc(u64 cycles)
>  }
>  
>  /*
> + * On Intel the TPAUSE instruction waits until any of:
> + * 1) the TSC counter exceeds the value provided in EAX:EDX
> + * 2) global timeout in IA32_UMWAIT_CONTROL is exceeded
> + * 3) an external interrupt occurs
> + */
> +static void delay_halt_tpause(u64 start, u64 cycles)
> +{
> +	u64 until = start + cycles;
> +	unsigned int eax, edx;
> +
> +	eax = (unsigned int)(until & 0xffffffff);
> +	edx = (unsigned int)(until >> 32);

trivia:

perhaps lower_32_bits and upper_32_bits


