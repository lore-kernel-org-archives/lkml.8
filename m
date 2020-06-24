Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F34C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06B620823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593008123;
	bh=b7QM/AnAF2FLjRffq2R666yrcagu50c8AB3ZQJKmq98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r6PbyNtd02YctM+RFVP7vUMTJtPScS9Fe3k7PiCZNtPYf7TTM1N1IT6hOkiT9P6uk
	 sb5wlwFyZ4t1PsXVjAQgg4mUpRRqfWcNZKlIW2Ihp4GikVUsuUfQ6Dei61ae6E+xtN
	 d3qA64jBBTsbaBfIOmsGgzttQH6+9sjisCXimqfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391146AbgFXOPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389682AbgFXOPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:15:22 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806132076E;
        Wed, 24 Jun 2020 14:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593008121;
        bh=b7QM/AnAF2FLjRffq2R666yrcagu50c8AB3ZQJKmq98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOahzyNiRhEpLN5dUFOi42BNnIooay0Op/7I7YVPOOm8VDNPk48W/QwucjAF7hizb
         YkeCU3EKTwrUERjUHBSDaJLTIOeU1A255t/d0el+aEkmiTgOcyURiX08GP4QYD7h00
         ApMHDwF21UoDCm4KeXgiwAaPUUjoV4ccFw/y4xB4=
Date:   Wed, 24 Jun 2020 10:15:20 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 4.14 038/190] KVM: x86: only do L1TF workaround on
 affected processors
Message-ID: <20200624141520.GF1931@sasha-vm>
References: <20200619141633.446429600@linuxfoundation.org>
 <20200619141635.473250358@linuxfoundation.org>
 <6610924417787ad9e2332d399b5948ce19fbd6fc.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6610924417787ad9e2332d399b5948ce19fbd6fc.camel@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:00:59PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
>On Fri, 2020-06-19 at 16:31 +0200, Greg Kroah-Hartman wrote:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> [ Upstream commit d43e2675e96fc6ae1a633b6a69d296394448cc32 ]
>>
>> KVM stores the gfn in MMIO SPTEs as a caching optimization.  These are
>> split
>> in two parts, as in "[high 11111 low]", to thwart any attempt to use these
>> bits
>> in an L1TF attack.  This works as long as there are 5 free bits between
>> MAXPHYADDR and bit 50 (inclusive), leaving bit 51 free so that the MMIO
>> access triggers a reserved-bit-set page fault.
>
>Hi, I'm now seeing this warning in VM bootup with 4.14.y

Thanks for the report!

>Not seen with 4.19.129 and 5.4.47 that also included this commit.
>
>Any ideas what's missing in 4.14 ?

I think that this was because we're missing 6129ed877d40 ("KVM: x86/mmu:
Set mmio_value to '0' if reserved #PF can't be generated"). I've queued
it up (along with a few other related commits) and a new -rc cycle
should be underway for those.

-- 
Thanks,
Sasha
