Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A8C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512672073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JyhmLykP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgGULg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:36:57 -0400
Received: from ozlabs.org ([203.11.71.1]:38021 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgGULg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:36:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B9xQH045Xz9sSJ;
        Tue, 21 Jul 2020 21:36:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595331415;
        bh=8cWqEZ7b8BkO4Lc0Yw9kRlVs08QZ7978e9X0CuvOH3I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JyhmLykPfuVbCmNgLwFSzcomuXhpdEJTpqJ7z3tXJaJxIOnZheJmHY0gNc6ljONpf
         cWMncIFEKRaAuy9NXF8JOniiQPI/xhDLFO+9Ax0KCPFBLjqRf8NwaexBpxte9A0cuO
         OXhqY7VsIdhf1+ipTE9Vg2FayfKkcH/5ln1pjPAdm8TudEONBAezMcRR7wxrmuryG4
         dYAfSi4ZD+YZXmzfcgEPhyhpOGJWHWSv5Kfr+CCW9VTypwW9rTiGimSVyokaM+/onJ
         3mYDfMsC8liIOPX0svCn03YVxiDz4aP/76avkJ8BrxbNWSNbcSdXkbp+RS2HdljEsj
         F1BmP47NUh3kA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Cc:     mikey@neuling.org, apopple@linux.ibm.com,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v4 09/10] powerpc/watchpoint: Return available watchpoints dynamically
In-Reply-To: <ccfcf488-0ec9-1737-8368-a848de1d72d1@linux.ibm.com>
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com> <20200717040958.70561-10-ravi.bangoria@linux.ibm.com> <CACzsE9r0acLUkV35mVxy1AEK_xObs0yz+fD6UdbNdc6uz=Buqw@mail.gmail.com> <ccfcf488-0ec9-1737-8368-a848de1d72d1@linux.ibm.com>
Date:   Tue, 21 Jul 2020 21:36:54 +1000
Message-ID: <87k0yxrtex.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> On 7/20/20 9:12 AM, Jordan Niethe wrote:
>> On Fri, Jul 17, 2020 at 2:11 PM Ravi Bangoria
>> <ravi.bangoria@linux.ibm.com> wrote:
>>>
>>> So far Book3S Powerpc supported only one watchpoint. Power10 is
>>> introducing 2nd DAWR. Enable 2nd DAWR support for Power10.
>>> Availability of 2nd DAWR will depend on CPU_FTR_DAWR1.
>>>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/cputable.h      | 4 +++-
>>>   arch/powerpc/include/asm/hw_breakpoint.h | 5 +++--
>>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
>>> index 3445c86e1f6f..36a0851a7a9b 100644
>>> --- a/arch/powerpc/include/asm/cputable.h
>>> +++ b/arch/powerpc/include/asm/cputable.h
>>> @@ -633,7 +633,9 @@ enum {
>>>    * Maximum number of hw breakpoint supported on powerpc. Number of
>>>    * breakpoints supported by actual hw might be less than this.
>>>    */
>>> -#define HBP_NUM_MAX    1
>>> +#define HBP_NUM_MAX    2
>>> +#define HBP_NUM_ONE    1
>>> +#define HBP_NUM_TWO    2

>> I wonder if these defines are necessary - has it any advantage over
>> just using the literal?
>
> No, not really. Initially I had something like:
>
> #define HBP_NUM_MAX    2
> #define HBP_NUM_P8_P9  1
> #define HBP_NUM_P10    2
>
> But then I thought it's also not right. So I made it _ONE and _TWO.
> Now the function that decides nr watchpoints dynamically (nr_wp_slots)
> is in different file, I thought to keep it like this so it would be
> easier to figure out why _MAX is 2.

I don't think it makes anything clearer.

I had to stare at it thinking there was some sort of mapping or
indirection going on, before I realised it's just literally the number
of breakpoints.

So please just do:

static inline int nr_wp_slots(void)
{
       return cpu_has_feature(CPU_FTR_DAWR1) ? 2 : 1;
}

If you think HBP_NUM_MAX needs explanation then do that with a comment,
it can refer to nr_wp_slots() if that's helpful.

cheers
