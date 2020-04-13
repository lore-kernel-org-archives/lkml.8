Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F8DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDA1206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586808221;
	bh=8JRSPtfFtwYpSXe+i9+/qeDQ6wtXz30+2CN05Ky2K6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tg44daidjVVCm1u5qm3JZ4NKvh49vX1uY0G7g8DlxgWuI0YWZF10zzRqf67ZUarH6
	 xhoyML0ME5rVh+PzkGGzbrmZR787c94cwd9cUCDxfn/aJvQN7fznIol8P7f+WV93+y
	 uGUsaa5Iokc4lKkoH3M0gSEOp1Tbdi0+14x0Ps38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgDMUDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388207AbgDMUDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:03:38 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C301020656;
        Mon, 13 Apr 2020 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586808218;
        bh=8JRSPtfFtwYpSXe+i9+/qeDQ6wtXz30+2CN05Ky2K6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yh8bmdrKCvHdJ3KwdaOzWcbYWbjRFePxlpjXNzEDybKoB30og5rJZe1DikW0Z7Orw
         tvW9XV3nzIAO3u+utBZZC1ivs0JF5PO2gbC63YJV/8Z8cMWhp6Z35K2cK6D3VIhMpq
         +p3L9RaTVEoaU4iDjjUZRy5e7yRw1Lz9Hd+7LSvQ=
Date:   Mon, 13 Apr 2020 16:03:36 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Message-ID: <20200413200336.GA11216@sasha-vm>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
 <20191115191200.GD22747@tassilo.jf.intel.com>
 <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
 <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
 <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
 <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:02:17PM +0000, Bae, Chang Seok wrote:
>
>> On Dec 4, 2019, at 12:20, Andy Lutomirski <luto@kernel.org> wrote:
>>
>> I think it could make sense to add a whole new ptrace() command to
>> tell the tracee to, in effect, MOV a specified value to a segment
>> register.  This call would have the actual correct semantics in which
>> it would return an error code if the specified value is invalid and
>> would return 0 on success.  And then a second ptrace() call could be
>> issued to read out FSBASE or GSBASE if needed.  Would this be useful?
>> What gdb commands would invoke it?
>
>We consider new commands to access GDT/LDT that hpa posted before [1] may be
>helpful. If the kernel provides the interfaces to ptracer, we expect GDB for
>both 32-/64-bits can make such changes for inferior calls:
>(1) When FS/GS selector only updated,
>	GDB used to write the selector value via SETREGS. Now it can read the
>	base value from the new APIs and write the base also. This change does
>	not harm today's kernel, and it retains the legacy behavior on
>	FSGSBASE-enabled kernels in the future.
>(2) When FS/GS base only updated,
>(3) When both FS/GS selector and base updated,
>	GDB has no change from what it used to do. The new FSGSBASE-enabled
>	kernel improves the behavior by keeping the base regardless of a
>	selector.
>
>The proposed change in GDB would do an additional GETREGS for every SETREGS
>to obtain the old value. Other ptrace-users may need a similar patch if
>sensitive to the outcome from writing FS/GS selector, but last time when we
>surveyed for other tools [2, 3], we didn't find the issue. We also didn't
>find actual users who rely on legacy behavior in practice.
>
>We'd like to hear a clear opinion of whether the GDB changes along with the
>new ptrace APIs are necessary and sufficient as preparing the FSGSBASE
>support in the kernel.

Hi folks,

Let me try to revive this work as I think that it's blocked due to
misunderstanding of the current situation.

What I gather from the Intel folks is that the GDB folks are okay with
the change as is and don't expect to be doing any changes on their end.

The intel folks are interested in resolving this, but haven't heard back
on their proposed plan (above).

Thomas/Andy want to make sure that we are doing the right thing and are
not breaking anything:

   1. The ptrace modifications are correct (we do the right thing around
   updating FS/GS).
   2. The ptrace changes don't break existing userspace. I think that
   the Intel folks confirmed it above.


Is my attempt at understanding the current situation correct?

-- 
Thanks,
Sasha
