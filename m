Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2737C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BFB20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585661802;
	bh=0wlmQUBZo5JQSwVpgZYmAAGFKA9gYa02POOYuT/NF/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gLLviLdOLfA0AM7tDTAW4uXzpaXCCb15Cfhw8N62oWIufgRHu5Ters3lIWJIpTo6G
	 E3azIGiW2G8R/2xcsx6HY/BFXpDrh7r0FzDT/t1BD+IkQAUqHcgR6HwEtQ1W5j0FV1
	 ZMZRymxC6KoeTmOmZZilaz/epBfQpwWMvxrREIh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgCaNgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbgCaNgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:36:41 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F322071A;
        Tue, 31 Mar 2020 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585661800;
        bh=0wlmQUBZo5JQSwVpgZYmAAGFKA9gYa02POOYuT/NF/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WeN+KF4FMTmmdRpDwvkiOdJiPOpuEnsz2kPVA/67mRSyyFkwjPI03/JZE9kQ2W6yJ
         inp5ZXip+joaQID7x5NHB2wuePcNqrS5pjto3R/OhYezAlJEpkxZPM2+Ul/ZWSDCzn
         GWvCwlG39jbXz48iCUHOzQHhTzEQZRaaf8CngRIc=
Date:   Tue, 31 Mar 2020 15:36:38 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [patch 2/3] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200331133637.GB24647@lenoir>
References: <20200328152117.881555226@redhat.com>
 <20200328152503.225876188@redhat.com>
 <20200331005706.GA24647@lenoir>
 <20200331115014.GA2182@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331115014.GA2182@fuller.cnet>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 08:50:14AM -0300, Marcelo Tosatti wrote:
> On Tue, Mar 31, 2020 at 02:57:08AM +0200, Frederic Weisbecker wrote:
> > On Sat, Mar 28, 2020 at 12:21:19PM -0300, Marcelo Tosatti wrote:
> Hi Frederic,
> 
> > So, what about what I suggested with having "unbound" instead, which
> > includes all the CPU-unbound work?
> > 
> >  HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_SCHED
> 
> After more thought, it would share certain flags with nohz_full=, which
> seemed confusing.

In fact I think we should also add HK_FLAG_KTHREAD | HK_FLAG_SCHED to nohz_full=

nohz_full is merely just a shortcut to isolate the tick and the unbound works anyway.

> 
> > (and yes your suggestion of including HK_FLAG_SCHED is good).
> > 
> > Because I don't see the point of exposing kthread isolation alone as an ABI
> > so far.
> > 
> > Later I suspect I'll turn all these flags into a single HK_FLAG_UNBOUND.
> 
> How about keeping the flags separate, and then on top of that do
> an "unbound" flag (less typing needed).
> 
> This would allow users to combine the individual flags (again, useful
> for debugging) while at the same time having an option which groups
> all the others?


Well, I'd rather not expose all the individual bits to the user. They rely
on kernel implementation details that shouldn't be much useful to the user.

As for internal kernel use, not sure this will ease debugging...

Thanks.
