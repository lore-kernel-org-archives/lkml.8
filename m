Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653D7C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2C220B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587130224;
	bh=NXlVchWe7hf7sE1zRJjwsb4MedfW39f20DQI4dszWw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d3RDykJJct+wqH9KIvketsEJ9hM+yK9DeX9+eTjKenqEhG6xE4ZFO8XUbD3EXwFpq
	 mVJLjMmQ8p0KFpwFNyiUp19LX6mQYlySIJDpd1giPDqwa2sCOfP4SaM01Cp29XsQ+V
	 jJtWLUiaLyy5mfZKEJjUcUN7n2r9iJS9BdNux+xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgDQNaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbgDQNaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:30:22 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C0E2078E;
        Fri, 17 Apr 2020 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587130222;
        bh=NXlVchWe7hf7sE1zRJjwsb4MedfW39f20DQI4dszWw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8Jtv6etCZh02R0GLu/Axm/f2A1Pozeyp14I2pHgm5gHmrBh51RIsJxgFffVeTVRo
         wtyD7Uw/4RZxZE7ox0OHawHGvrBOLQ1vspq8EittjckmFxe2V8cOOwz9VHBM0+I/tQ
         RbF69o7YMFFyWxvhUQbDT3pwiDlemcFi41/xj6vo=
Date:   Fri, 17 Apr 2020 09:30:21 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
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
Message-ID: <20200417133021.GT1068@sasha-vm>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
 <20191115191200.GD22747@tassilo.jf.intel.com>
 <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
 <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
 <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
 <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
 <20200413200336.GA11216@sasha-vm>
 <20200414003205.GF397326@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200414003205.GF397326@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 05:32:05PM -0700, Andi Kleen wrote:
>> Is my attempt at understanding the current situation correct?
>
>Yes.
>
>Nothing breaks, and it's a nice improvement for context switch
>performance, in NMI/PMU performance, and also gives user space two free
>registers to play around with.

Thomas, Andy,

Could you list your outstanding objections to this patchset? I know it
might be rehashing stuff you've already mentioned in this thread but I
think that there's a disconnect between folks and it'll help with
restarting everything.

-- 
Thanks,
Sasha
