Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE4BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852F5214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581000066;
	bh=5F+DVXttfezw5xirpmvxPSy/Sk+UV6Nkj38IRu6gU5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DRFbS+dJlU/VTAEAMmz0Wu2IBDoScCQ5SqlbQVvhb/N2zpssGnMEZYLm0g9FCWCwK
	 DwJwAFzClnHOTMsECW5SBxrko32Iz3qRzYM53JrY7ndWglq73PKIZR06DNW/LZ1ysx
	 t3XMnyIBZQ8UNKp+ewqrj2zLbcnNrdWdahJ52LNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgBFOlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:41:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBFOlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:41:05 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2331E20838;
        Thu,  6 Feb 2020 14:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581000064;
        bh=5F+DVXttfezw5xirpmvxPSy/Sk+UV6Nkj38IRu6gU5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LyYbmzsb7DqZFk/mVKGIxTigWRVuM8b72E+rp347Aj6aoBGBD/N4akrO+uHDnx6BT
         lA7uJ6Xo04zDCKsis2drjhUiV/SDJ/Knoe9ttGeW6T+tLeeGE1asoCqF1P4SniD0K0
         Yxl+hXLC7f3qVZyDQJyrzoTVZiZMyw8VmRWP5JgE=
Date:   Thu, 6 Feb 2020 23:41:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
In-Reply-To: <20200206115405.GA22608@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
        <20200114210336.259202220@goodmis.org>
        <20200206115405.GA22608@zn.tnic>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Feb 2020 12:54:05 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Jan 14, 2020 at 04:03:20PM -0500, Steven Rostedt wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index a34064a031a5..63450d3bbf12 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1215,6 +1215,17 @@ source "usr/Kconfig"
> >  
> >  endif
> >  
> > +config BOOT_CONFIG
> > +	bool "Boot config support"
> > +	select LIBXBC
> > +	default y
> 
> Any particular reason this is default y? Why should it be enabled by
> default on all boxes?

Oh, you are not the first person asked that :)

https://lkml.org/lkml/2019/12/9/563

And yes, I think this is important that will useful for most developers
and admins. Since the bootconfig already covers kernel and init options,
this can be a new standard way to pass args to kernel boot.

And as I reported above thread, the memory footpoint of view, most code
and working memory are released after boot. Also, as Linus's suggested,
now this feature is enabled only if user gives "bootconfig" on the kernel
command line. So the side effect is minimized.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
