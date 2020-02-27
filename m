Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE073C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B6B24695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582806998;
	bh=WVQFRXBahP96gdkhPZydltW4Lze2BFsGr6dnKM53hho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XxL0IiLH77X4iMKFOG0AiVpaeXwFC3qzhQKdnijMmp7LL5/Atlt260GdRjk+WgZ/z
	 nwWrYXx8fAjkJ48RVnHhun+zL+8WQ0A9BMv2mQyRIG5vj8IBNf0yOtzW2VzdQeN3ol
	 4AY2sLWt7QKmnWMBAOOGy6w8i4v/1AwZkktJBhxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgB0Mgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgB0Mgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:36:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33F524692;
        Thu, 27 Feb 2020 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582806996;
        bh=WVQFRXBahP96gdkhPZydltW4Lze2BFsGr6dnKM53hho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIhu14lK1yDymB6alpgF9NHwX2ng77anG/DaHYXsT7F4WU3RZCLXrEin4O7jUgESa
         B0Wj73ivWfV3DFapyOCxCwrDKh56Ckj/4XkGc49sNQhmyPWKbSd6X+ZldUsyc116Kb
         W7+lVKRwbnw4Z0wafRg44nWIAS9ML+Poe1iJsmUE=
Date:   Thu, 27 Feb 2020 13:36:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lech Perczak <l.perczak@camlintechnologies.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200227123633.GB962932@kroah.com>
References: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 11:09:49AM +0000, Lech Perczak wrote:
> Hello,
> 
> After upgrading kernel on our boards from v4.19.105 to v4.19.106 we found out that syslog fails to read the messages after ones read initially after opening /proc/kmsg just after booting.
> I also found out, that output of 'dmesg --follow' also doesn't react on new printks appearing for whatever reason - to read new messages, reopening /proc/kmsg or /dev/kmsg was needed.
> I bisected this down to commit 15341b1dd409749fa5625e4b632013b6ba81609b ("char/random: silence a lockdep splat with printk()"), and reverting it on top of v4.19.106 restored correct behaviour.

That is really really odd.

> My test scenario for bisecting was:
> 1. run 'dmesg --follow' as root
> 2. run 'echo t > /proc/sysrq-trigger'
> 3. If trace appears in dmesg output -> good, otherwise, bad. If trace doesn't appear in output of 'dmesg --follow', re-running it will show the trace.
> 
> I ran my tests on Debian 10.3 with configuration based directly on one from 4.19.0-8-amd64 (4.19.98-1) in Qemu.
> I could reproduce the same issue on several boards with x86 and ARMv7 CPUs alike, with 100% reproducibility.
> 
> I haven't yet digged into why exactly this commit breaks notifications for readers of /proc/kmsg and /dev/kmsg, but as reverting it fixed the issue, I'm pretty sure this is the one. It is possible that the same happened in 5.4 line, bu I hadn't had a chance to test this as well yet.

I can revert this, but it feels like there is something else going wrong
here.  Can you try the 5.4 tree to see if that too has your same
problem?

thanks,

greg k-h
