Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F01C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FE3206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588058715;
	bh=GLu5j27TIX4wZFikcdS3374+orGJgRuWeeuefdu1XMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bEFEESUen/y1wlShZEhinNGFZmAZC4lCnscmv/R5PCPbKqYhXmBDLAxTbvHtmVYj7
	 ppBYE5ZNcBugw8+MpNImlLEi+h5excHm3885b2bsb8X+mzL/iaJCiWVEBAEcueGvTZ
	 i+WtYbZFhOpEf8CtB1+C5DGUq61874m/astVTaNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD1HZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgD1HZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:25:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A6E20661;
        Tue, 28 Apr 2020 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588058714;
        bh=GLu5j27TIX4wZFikcdS3374+orGJgRuWeeuefdu1XMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpheMqqd0u7obdLb311fFWl0BWxLCIGElMpzR1JL+EihHlxLyJdxEAwhK4VvGdvaK
         LMO3BvQ1yvDDuzCNWC/3b8XDj6TzxcjtBA7kyGe/WOQsT2l266x1XYEN3utRQjv+ld
         vuEeQRiIBnmS97jAdAO5hSbLU/lwE+4vU4tF/PT8=
Date:   Tue, 28 Apr 2020 08:25:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/mm: Reject invalid NUMA option
Message-ID: <20200428072509.GA4049@willie-the-truck>
References: <20200424045314.16017-1-gshan@redhat.com>
 <20200424101132.GC1167@C02TD0UTHF1T.local>
 <f83c0ce1-b1b2-31f4-60c8-15567b87a8ff@redhat.com>
 <20200427225406.7cacc796@gandalf.local.home>
 <20200427225944.185d4431@gandalf.local.home>
 <20200427230920.3d606a2e@gandalf.local.home>
 <7e85ea83-de5f-c789-2e3c-e468a50ed4bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e85ea83-de5f-c789-2e3c-e468a50ed4bd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:35:20PM +1000, Gavin Shan wrote:
> On 4/28/20 1:09 PM, Steven Rostedt wrote:
> 
> [...]
> 
> > 
> > Could this be a bug in the implementation of strncmp() in
> > arch/arm64/lib/strncmp.S. As I don't know arm64 assembly, I have no idea
> > what it is trying to do.
> > 
> > But strncmp("o","off",3) returning zero *is* a bug.
> > 
> 
> I think it's false alarm. The patch has been in my local repo for a while.
> I checked out 5.7.rc3 and tried passing "numa=o" to the kernel, @numa_off
> is unchanged and its value is false. I also check the return value from
> strncmp() as below, it's correct. Nothing is broken. I should have retested
> before posting it. Sorry for the noise. Please ignore the crap patch :)

Hmm, it's still worrying that you had that patch kicking around though, as
it sounds like it /used/ to be broken. Would you be able to test the LTS
kernels (5.4, 4.19, 4.14, 4.9, 4.4) to check that we're not missing a
backport, please? Sorry to be a pain, but I'd like to get to the bottom of
this!

Thanks,

Will
