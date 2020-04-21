Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6373FC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4982068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587485186;
	bh=0CHCOM6VoDYf8itPO9myhF0Bjpv6UOv44mn8HVZm2Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SmbpTQeGUKMbUBXhVW3cpIxMw/Y8ClILU4DZtaDo7+mrYX/RApaavkBH3noOO0wqJ
	 zR8dJpWkOb6/McP/FVAyiFSjfFO2n/sB1rT2V1q7bQBfjO5sBHbKmmByVC1PT5IZOo
	 lgJhT7bZBL+7Df2PMvn7H0vmS1eBZW7Gu4CNm740=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDUQGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDUQGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:06:24 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4696206A1;
        Tue, 21 Apr 2020 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587485184;
        bh=0CHCOM6VoDYf8itPO9myhF0Bjpv6UOv44mn8HVZm2Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbXhui4QhT0TX3rw5thRe6Un4DWFjqiAi5KDSKShc3KZuXwHiOoSU3FnhfBR4hGTT
         xa4NTM6bOF/B6iJAV9XcCSZlh8UcfRyp+su+JfxyJbRaXDMiG0+pVyI8uB6Z3YxT/j
         VeOIotD5wJmrXM2ONW9l6a4BtoZ4KQto6Lpl5Wv8=
Date:   Tue, 21 Apr 2020 12:06:22 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Message-ID: <20200421160622.GJ1809@sasha-vm>
References: <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
 <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
 <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
 <20200413200336.GA11216@sasha-vm>
 <20200414003205.GF397326@tassilo.jf.intel.com>
 <20200417133021.GT1068@sasha-vm>
 <CALCETrW6LLmFR5Y6tmH=nPThCHefysf_nNwxHOFp4tAY4Spunw@mail.gmail.com>
 <20200420141320.GC608746@tassilo.jf.intel.com>
 <87y2qqaxkp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87y2qqaxkp.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 07:14:46PM +0200, Thomas Gleixner wrote:
>Andi Kleen <ak@linux.intel.com> writes:
>>> the *gdb developers* don't care.  But gdb isn't exactly a good example
>>> of a piece of software that tries to work correctly when dealing with
>>> unusual software.  Maybe other things like rr will care more.  It
>>
>> rr is used to replay modern software, and modern software
>> doesn't care about selectors, thus rr doesn't care either.
>>
>> Please stop the FUD.
>
>There is absolutely no FUD. Being careful about not breaking existing
>user space is a legitimate request.
>
>It's up to those who change the ABI to prove that it does not matter and
>not up to the maintainers to figure it out.

I think that this is a difficult ask; "prove that god doesn't exist".

Andi's point is that there is no known user it breaks, and the Intel
folks did some digging into potential users who might be affected by
this, including 'rr' brought up by Andy, and concluded that there won't
be breakage as a result of this patchset:

	https://mail.mozilla.org/pipermail/rr-dev/2018-March/000616.html

Sure, if you poke at it you could see a behavior change, but is there
an actual user that will be affected by it? I suspect not.

>This sits in limbo for months now just because Intel doesn't get it's
>homework done.
>
>Stop making false accusations and provide factual information instead.

If there's no known user that will be broken here, can we consider
merging this to be disabled by default and let distros try it out? This
will let us find these users while providing an easy way to work around
the problem.

-- 
Thanks,
Sasha
