Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF682C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8371D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582211164;
	bh=qZGMqmf13kGIaYi/07SmSX1RGyMwOKwiwho8FB8lkTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vsC4lEAoO8XocwOIiMcBVhd7oHXMJWJe0RQPwynIJAbVuMI28K45avOkwXgyl5PHB
	 b/WiYzPkepWhf1e3T7Q8cmh+raf5NrJXtLNSactn1iOA6ZPx57aBH2pw7b28bUSZUn
	 7aEULy9dW+jNyxU3HyPwrpUFKTTH0qhRYvEoklDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBTPGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgBTPGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:06:02 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14FA2071E;
        Thu, 20 Feb 2020 15:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582211162;
        bh=qZGMqmf13kGIaYi/07SmSX1RGyMwOKwiwho8FB8lkTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NryJuAResREVCHM8mQNQCcamlRvxhjbRJxG0YuRw7rtC44JpxQ5ZDgw9dU/I10TDI
         DvepeERBJ3zq76TvxDDwTS+DVnXwkyVH0SAF6bhnilPh4OQrZKvVTIYw4ROgIOmOHk
         rNIQ1sC5bmZKTPVzN1InK+HWplCsUgImxfL5KERE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j4nOq-006km6-8n; Thu, 20 Feb 2020 15:06:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Feb 2020 15:06:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     minyard@acm.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org, Corey Minyard <tcminyard@gmail.com>
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
In-Reply-To: <20200220145048.GH3704@minyard.net>
References: <20200219152403.3495-1-minyard@acm.org>
 <1416dca51b52dff349923184f41d48e8@kernel.org>
 <20200220145048.GH3704@minyard.net>
Message-ID: <375815af3c711b94dd2ee56326c2dd3b@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: minyard@acm.org, will@kernel.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, cminyard@mvista.com, linux-kernel@vger.kernel.org, tcminyard@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-20 14:50, Corey Minyard wrote:
> On Thu, Feb 20, 2020 at 02:21:36PM +0000, Marc Zyngier wrote:
>> On 2020-02-19 15:24, minyard@acm.org wrote:
>> > From: Corey Minyard <cminyard@mvista.com>
>> 
>> [...]
>> 
>> > After studying the EL0 handling for this, I realized an issue with using
>> > MDSCR to check if single step is enabled: it can be expensive on a VM.
>> > So check the task flag first to see if single step is enabled.  Then
>> > check MDSCR if the task flag is set.
>> 
>> Very tangential remark: I'd really like people *not* to try and 
>> optimize
>> Linux based on the behaviour of a hypervisor. In general, reading a
>> system register is fast, and the fact that it traps on a given 
>> hypervisor
>> at some point may not be true in the future, nor be a valid assumption
>> across hypervisors.
> 
> Normally I would agree, but I based this upon git commit
> https://github.com/torvalds/linux/commit/2a2830703a2371b47f7b50b1d35cb15dc0e2b717
> which seemed to say that it was a significant enough factor to do in 
> the
> EL0 case.

And that's a blast from a distant past. Hypervisors have changed 
drastically
over these 6 years, and I'm still sitting on a bunch of patches that 
*could*
change the way MDSCR_EL1 is handled.

         M.
-- 
Jazz is not dead. It just smells funny...
