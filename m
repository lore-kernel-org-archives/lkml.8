Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCB8C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FCA20709
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585989190;
	bh=VRCV/so7BKnM0P790h0/Q9OlUCaaiajC8qyNLu19kTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wIkil17tTH81x7sem5Gvw9i/ZCvxv1JPS839Ug4KfMB/7xITRD/reIt4Po547Wk3C
	 e1LTBCZsDSnnMFxXuczbEQm/BGgOFSsbM13yLPlTqRWEz4afPTMePNERYaWz/m3qjk
	 DjT+sB9GzVgUebrSTJubu9mLVa64UiSYnnqoXJJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgDDIdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDDIdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:33:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD01206F5;
        Sat,  4 Apr 2020 08:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585989188;
        bh=VRCV/so7BKnM0P790h0/Q9OlUCaaiajC8qyNLu19kTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MqCoEbX7Zf7roHVsgb3PwItJ3gY5pTGfQbIXgN+W8np9k/acj5NQquzfDzbrME2+d
         +tBWPDLYwo3zkAxhaPLxrvKp4qOOvAdK6pSIjmrmj5hmhnZ/wrvenpXUj4QlywPAJr
         PCJ0s4QvVymhbpIf6n0/S3u+LXdh6qt3wXNIeEX8=
Date:   Sat, 4 Apr 2020 17:32:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse,
 -msse2 without any visible FPU state protection
Message-Id: <20200404173257.a9231d8129ce616145960c26@kernel.org>
In-Reply-To: <3f5565d3-90a5-be3e-d79d-715d7b94880d@infradead.org>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
        <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
        <20200402141308.GB20730@hirez.programming.kicks-ass.net>
        <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
        <20200403112113.GN20730@hirez.programming.kicks-ass.net>
        <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
        <3f5565d3-90a5-be3e-d79d-715d7b94880d@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020 20:15:11 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 4/3/20 8:08 PM, Masami Hiramatsu wrote:
> > +static inline int insn_is_fpu(struct insn *insn)
> > +{
> > +	if (!insn->opcode.got)
> > +		insn_get_opcode(insn);
> > +	if (inat_is_fpu(insn->attr)) {
> > +		if (insn->attr & INAT_FPUIFVEX)
> > +			return insn_is_avx(insn);
> > +		return 1;
> > +	}
> 
> 	return 0; // ??

Oops, right!

Hm, I need to add a caller for this API...

Thanks,

> 
> > +}
> > +
> 
> 
> -- 
> ~Randy
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
