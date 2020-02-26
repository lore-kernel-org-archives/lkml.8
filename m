Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9C8C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A642121927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582680856;
	bh=Kjuv90ZjEjmAGSmEae/Z2LP6m0gsb/GyA826skbWBVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nXA5CCUv1RhWeOxr/ThElQXl2dHN+LEt22Nmt/D9hyuM8rpIRvszedh/ikd9TIxR9
	 l0RU2n+Py0+HDrSuEB9fDOcd/mSWVpyXHDV7Y3QXgEUT3Vq0hA4UUcSlpqixrOOeyr
	 E8ei0YVJloi7xqV1pKzRnqS4oFpBaZvyz1PuF900=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgBZBeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:34:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgBZBeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:34:15 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607C521744;
        Wed, 26 Feb 2020 01:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582680854;
        bh=Kjuv90ZjEjmAGSmEae/Z2LP6m0gsb/GyA826skbWBVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qtFhlcLkuLnklw/zhFq2+nIRHrqcdOKiqeh49JeEuMwArKOtQac6s5U4OzVwmB/Qk
         Dy7q+tZBilxcx1HhrEF84Ew4i9cBqjxgAGENDtQ4R5BNHc9RxqQNes9NzHCQ/lhz8o
         M9aR/VTDW+GbONklVlWdohIqfw+LTR+HWAaj2s/A=
Date:   Wed, 26 Feb 2020 10:34:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bootconfig: Fix CONFIG_BOOTTIME_TRACING dependency
 issue
Message-Id: <20200226103409.9036c0384866979025232c6c@kernel.org>
In-Reply-To: <aa78add3-a6d9-e316-cfba-3432e347bec4@infradead.org>
References: <20200225220551.d9a409bc04b77cdf48eae3ea@kernel.org>
        <158264140162.23842.11237423518607465535.stgit@devnote2>
        <c9604764-bd0f-67e9-56c8-fb6ffaf9b430@infradead.org>
        <20200225125335.5bbc3ed4@gandalf.local.home>
        <aa78add3-a6d9-e316-cfba-3432e347bec4@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 09:59:25 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 2/25/20 9:53 AM, Steven Rostedt wrote:
> > On Tue, 25 Feb 2020 09:49:25 -0800
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> >>> Fixes: d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by default")
> >>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>  
> >>
> >> Hi,
> >> I'm no fan of "select", but this does fix the kconfig warnings and
> >> build errors that I have reported.  Thanks.
> > 
> > I'm not big on select either, but this is fine (I'm running it through my
> > tests now).
> > 
> >>
> >> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> > 
> > Is it OK if I change this to "Tested-by:"?
> 
> Yes, as long as someone doesn't read (interpret) that as runtime-tested-by. :)

Thanks Randy and Steve!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
