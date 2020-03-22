Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A753C54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D04E2072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584909301;
	bh=qUrulLhd4Y0KFwsOkytBopO2azVJZkm2UDeUUR6e3jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zKKRs7zTV8h1tcuyloaNrwTBz9EsEEMKbILyY8leq174BuDWA+UtErDwKjbhuqeWq
	 Td8TbCYE8QlRSQlqvrd0YSA/I29ZGxCjtPy3SDvQQzSvke1J+FS0RBBeAozhQdNYg+
	 t2R/mbyvKfHEHCNv0/dOVtIji4FgK0Xl0SWfc3Tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCVUfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 16:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCVUfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 16:35:00 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2229B20722;
        Sun, 22 Mar 2020 20:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584909299;
        bh=qUrulLhd4Y0KFwsOkytBopO2azVJZkm2UDeUUR6e3jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yAZ2wFYF379++8WuK5/OS0buoaLaIy2O5/FGAt8ce9e0OsKUYQp/bdCBJZkhZuacS
         O8yv8+qs1E+C6/chp2j/DZW0g0YXN06HevShMRBTOH33uwlsebxzYH8xdDhpOJbpN3
         M9SZlRW9E2EaJPbfxgkKHFuSaazQQwUzpRicStD8=
Date:   Sun, 22 Mar 2020 16:34:58 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 5.5 00/65] 5.5.11-rc1 review
Message-ID: <20200322203458.GR4189@sasha-vm>
References: <20200319123926.466988514@linuxfoundation.org>
 <fcf6db4c-cebe-9ad3-9f19-00d49a7b1043@roeck-us.net>
 <20200319145900.GC92193@kroah.com>
 <32c627bf-0e6b-8bc4-88d3-032a69484aa6@roeck-us.net>
 <20200320144658.GK4189@sasha-vm>
 <20200322195134.GA3127@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200322195134.GA3127@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 08:51:34PM +0100, Pavel Machek wrote:
>Hi!
>
>> > > Thanks for letting me know, I've now dropped that patch (others
>> > > complained about it for other reasons) and will push out a -rc2 with
>> > > that fix.
>> > >
>> >
>> > I did wonder why the offending patch was included, but then I figured that
>> > I lost the "we apply too many patches to stable releases" battle, and I didn't
>> > want to re-litigate it.
>>
>> I usually much rather take prerequisite patches rather than do
>> backports, which is why that patch was selected.
>
>Unfortunately, that results in less useful -stable.

This is different than the usual "too many patches in -stable" argument
you keep bringing up; here we *know* that we need a certain patch, but
you claim that I should pick up a piece of code I'm unfamiliar with and
try to hammer it to work on an older kernel rather than take a
prerequisite patch to do that for me.

Not only that in my experience taking prerequisites was the safer
option, it's also the case that piling up modified backports causes the
stable tree to diverge from upstream, making older trees much more
difficult to maintain than what they are now.

Does it always work? Obviously not, but it's much easier for reviewers
to notice a mistake of bringing in a patch rather than a subtle issue
with a backport.

I'll happily look at hard data comparing (real) regression rates of
cases where prerequisites were taken vs a modified backport of a patch.
Please also remember to include cases where the prerequisite patch ended
up being a fix on it's own that we should have picked up.

Otherwise, I'm not sure how you think that you're contributing to the
discussion here.

-- 
Thanks,
Sasha
