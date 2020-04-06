Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0523C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AA422206
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586177623;
	bh=bJ6dHQ+dU4Gwaqq98S5TKRBD0OIF5fwK51njnQkIHpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jAZd4dMO2UCf7Q8HkhNckt7hXHYTq/fa84ZF261ELW9Ykz3LQpqECi1UjpkqwVM32
	 jSfZl4aFuQFoNfG4mhry4XfOhPldmwCwFs63R8b0Ukw0PszM3IAz5v+I9t5PlAS9YE
	 snWMqQ6DSHc2kwhp3iACp2ooB8fWjzmZS8+q8gHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgDFMxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgDFMxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:53:42 -0400
Received: from linux-8ccs (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1389222205;
        Mon,  6 Apr 2020 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586177621;
        bh=bJ6dHQ+dU4Gwaqq98S5TKRBD0OIF5fwK51njnQkIHpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjrZbmPPR6KGv95jck7xM0A0OUTHFTE3Aw9ztAQC0gH+2jFYRKd3EE346MvrOUcn6
         GeZ1OEonLUZz736ojym0weT6lIc5dFFTI/pqOJBXpioOAw6rEM4av2Ssd676414zRo
         qdf37HZLNr0OW81BXTSlmwteh+hW2j3dNsK9c8mM=
Date:   Mon, 6 Apr 2020 14:53:37 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
Message-ID: <20200406125336.GA21006@linux-8ccs>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
 <20200403165631.hrxxm3pnzqa4vxln@treble>
 <alpine.LSU.2.21.2004061146590.26870@pobox.suse.cz>
 <20200406104615.GA9629@linux-8ccs>
 <20200406112732.GK20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200406112732.GK20730@hirez.programming.kicks-ass.net>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [06/04/20 13:27 +0200]:
>On Mon, Apr 06, 2020 at 12:46:17PM +0200, Jessica Yu wrote:
>> +++ Miroslav Benes [06/04/20 11:55 +0200]:
>> > On Fri, 3 Apr 2020, Josh Poimboeuf wrote:
>> >
>> > > On Fri, Apr 03, 2020 at 06:37:16PM +0200, Peter Zijlstra wrote:
>> > > > +{
>> > > > +	int i;
>> > > > +
>> > > > +	for (i = 0; i < hdr->e_shnum; i++) {
>> > > > +		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE))
>> > > > +			return -ENOEXEC;
>> > >
>> > > I think you only want the error when both are set?
>> > >
>> > > 		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE) == (SHF_EXECINSTR|SHF_WRITE))
>> >
>> > A section with SHF_EXECINSTR and SHF_WRITE but without SHF_ALLOC would be
>> > strange though, no? It wouldn't be copied to the final module later
>> > anyway.
>>
>> That's right - move_module() ignores !SHF_ALLOC sections and does not
>> copy them over to their final location. So I think we want to look for
>> SHF_EXECINSTR|SHF_WRITE|SHF_ALLOC here..
>
>So I did notice that !SHF_ALLOC sections get ignored, but since this
>check is about W^X we don't strictly care about SHF_ALLOC. What we care
>about it never allowing a writable and executable map.
>
>Adding ALLOC to the test only allows for future mistakes and doesn't
>make the check any better.

Ugh sorry, my brain shorted out and for some reason I mistakenly
thought the check excluded SHF_WRITE|SHF_EXECINSTR|SHF_ALLOC sections.
It doesn't obviously. Sorry for the noise.

