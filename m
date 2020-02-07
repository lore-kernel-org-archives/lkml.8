Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D88C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4DC222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581043583;
	bh=ntf3Kc5hS41m31lIgjXbPxliXLs3VtkI057Y9DO7EUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n87biFUXIJyKSGV4DjHzz1NhF1vNW9+s7ERuWqHog3ej+hnK5CtnrhmMGrFWrTGtV
	 PEKtM9LlYi3Fa0U0R3gk+wf5k7BUl4d3oJJ3x672Dg9eAmHcP0r7yw9ggG6tJqt9jl
	 dRWtrB2dzpN19HWub84BKeHDszSY7quYw5gwpfhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBGCqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgBGCqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:46:22 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F00220715;
        Fri,  7 Feb 2020 02:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581043581;
        bh=ntf3Kc5hS41m31lIgjXbPxliXLs3VtkI057Y9DO7EUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gi5h4qjtIVxIuOXP919qAAXCwx9ekAbIlIO+8KM097GQJi+BN6iO/k3xM4odVxvYT
         5Z24psU81FjVoKHdFX+cW4qX4/i2rBUKxsAuRjU6vruVdpYwTvxk9k/n537phuBDWy
         scPvhA2mNZL7lGQhKOWsA14PwwLkxFBn9z0fz56E=
Date:   Fri, 7 Feb 2020 11:46:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
In-Reply-To: <20200206175858.GG9741@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
        <20200114210336.259202220@goodmis.org>
        <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <20200206175858.GG9741@zn.tnic>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Feb 2020 18:58:58 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Feb 06, 2020 at 11:41:00PM +0900, Masami Hiramatsu wrote:
> > Oh, you are not the first person asked that :)
> > 
> > https://lkml.org/lkml/2019/12/9/563
> > 
> > And yes, I think this is important that will useful for most developers
> > and admins. Since the bootconfig already covers kernel and init options,
> > this can be a new standard way to pass args to kernel boot.
> 
> Aha, so Steve and you believe this will become the next great thing
> after sliced bread. Sorry but I remain sceptical. :)

It could change some other things. I recommend developers to use this
feature to configure their subsystem easier and admins to configure
kernel boot options more readable way.

> I would've done it differently: have it default 'n' and once it turns
> out that the major distros have enabled it and *actually* use it, *then*
> simply remove the config option. Like we usually do with functionality.
> Not the other way around.

Many distros may not use it unless it is default y. I couldn't find any
good example that the feature "default n" turns into "default y".
Would you have any example?

> In any case, I've disabled it on my machines and will wait for it
> missing to come back and bite me. :-P

Hmm, what would you afraid of? It is just a small footprint additional
feature which never be enabled without "bootconfig" on the kernel cmdline...

Thank you,

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


-- 
Masami Hiramatsu <mhiramat@kernel.org>
