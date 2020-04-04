Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D73C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7916206E2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z7oS8zO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgDDDPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 23:15:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgDDDPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 23:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ibkTI/yyTgRhpR95ppr6ajtD7LeL8TZWLWwT1L/4/y0=; b=Z7oS8zO1OCznvgpB0S548tE2FE
        fV4rCljvLaG2+ieGlEb7UzfiZkiPXP8SoK5pb3RUpXs0Y2iQypL8NzcANc/kfF/jdsuum2M2jdulg
        U9qvrCWDebhNxnzOcws+cp07Ab84DC3N/oNYeKq8HN1sBbOdssBfbY9m6dkN8mzM/b34Mg869mx4b
        SAz3VVXrNxYs2IwEYiS8pndoluZqJi7f53yL9jxkXHB1NhFKdiji2UO0dNIrEpGMQhBCu0amvENIH
        Pq/rjGbLfLozdgOH0uWCIBynJOAVc7mM1BqGV3PBvCwglZZIVV6v5WZG3O8QLuRxT56OY41BRuKgv
        LrlXk70Q==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKZH7-0006sn-MZ; Sat, 04 Apr 2020 03:15:13 +0000
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jann Horn <jannh@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
 <20200403112113.GN20730@hirez.programming.kicks-ass.net>
 <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3f5565d3-90a5-be3e-d79d-715d7b94880d@infradead.org>
Date:   Fri, 3 Apr 2020 20:15:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 8:08 PM, Masami Hiramatsu wrote:
> +static inline int insn_is_fpu(struct insn *insn)
> +{
> +	if (!insn->opcode.got)
> +		insn_get_opcode(insn);
> +	if (inat_is_fpu(insn->attr)) {
> +		if (insn->attr & INAT_FPUIFVEX)
> +			return insn_is_avx(insn);
> +		return 1;
> +	}

	return 0; // ??

> +}
> +


-- 
~Randy

