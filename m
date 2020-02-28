Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EFAC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDFF246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582870352;
	bh=cRh1tPtGAw1viMwKMfbbGI536nqanUnqN75l1R2pCEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=j3P870c5mEDNHY5OWErrHtQKoRAOg+V/U4LAfa5AvOkN4sLCwri6gkWFgQkK41oAp
	 f2H6aHyHJYFCYfyuT0Gemz523tHnF+sAUAC3RTmVt+TTnKXtUr91QvxhrS4e4qMZn1
	 wbj+W2saUWQwOsD4Uek/K22heUDvjzf+yBfzqJ8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgB1GMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:12:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB1GMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:12:30 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC392468A;
        Fri, 28 Feb 2020 06:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582870349;
        bh=cRh1tPtGAw1viMwKMfbbGI536nqanUnqN75l1R2pCEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nGZAYuX9p1OHbRA8wVx4VtO2aEFzdLkn0VVPIkNOTeGQry6CHXDeUqngNhMQtbFfR
         NepeMTt3K6kF4WC0BYSkAivz5lljD632eLhDm3LFsXRcCfbJItJVVp4ULlgItDEHOY
         +n0YLLiOcES6i5UxN2eWHKEhhbPDTUikp/YB/zDw=
Date:   Fri, 28 Feb 2020 15:12:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 1/2] Documentation: bootconfig: Update boot
 configuration documentation
Message-Id: <20200228151226.3672a6e575d985ed2cda33aa@kernel.org>
In-Reply-To: <c8494bca-a5f7-0bc6-63f5-b9ec056eb894@infradead.org>
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
        <158278835238.14966.16157216423901327777.stgit@devnote2>
        <c8494bca-a5f7-0bc6-63f5-b9ec056eb894@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 20:50:19 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
> A few more comments for you:
> 
> On 2/26/20 11:25 PM, Masami Hiramatsu wrote:
> > Update boot configuration documentation.
> > 
> >  - Not using "config" abbreviation but configuration or description.
> >  - Rewrite descriptions of node and its maxinum number.
> >  - Add a section of use cases of boot configuration.
> >  - Move how to use bootconfig to earlier section.
> >  - Fix some typos, indents and format mistakes.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Documentation/admin-guide/bootconfig.rst |  172 +++++++++++++++++++-----------
> >  Documentation/trace/boottime-trace.rst   |    2 
> >  2 files changed, 112 insertions(+), 62 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> > index cf2edcd09183..4bac98250bc0 100644
> > --- a/Documentation/admin-guide/bootconfig.rst
> > +++ b/Documentation/admin-guide/bootconfig.rst
> > @@ -11,19 +11,98 @@ Boot Configuration
> >  Overview
> >  ========
> >  
> > -The boot configuration expands the current kernel command line to support
> > +Boot configuration expands the current kernel command line to support
> >  additional key-value data when booting the kernel in an efficient way.
> 
>                 maybe      s/when/while/

Ah, right.

> 
> > -This allows administrators to pass a structured-Key config file.
> > +This allows administrators to pass a structured-Key configuration file
> > +as a way to supplement the kernel command line to pass system boot parameters.
> >  
> > -Config File Syntax
> > -==================
> > +Compared with the kernel command line, the boot configuration can provide
> > +scalability (up to 32 KiB configurations), readability (structured
> 
> This makes it sound like bootconfig supports 32 thousand configurations, but
> (I think) it allows up to 32 KiB of configuration data.

OK, I'll add "data".

> 
> > +configuration with comments) and compact expression of option groups.
> > +
> > +When to Use the Boot Configuration?
> > +-----------------------------------
> > +
> > +The boot configuration supports kernel command line options and init daemon
> > +boot options. All sub-keys under "kernel" root key are passed as a part of
> > +kernel command line [1]_, and one under "init" root key are passed as a part
> 
>                                  ones  {or those}

OK.

> 
> > +of init command line. For example, ::
> > +
> > +   root=UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82 ro quiet splash console=ttyS0,115200n8 console=tty0
> > +
> > +This can be written as following boot configuration file.::
> > +
> > +   kernel {
> > +      root = "UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82" # nvme0n1p3
> > +      ro       # mount rootfs as read only
> > +      quiet    # No console log
> > +      splash   # show splash image on boot screen
> > +      console = "ttyS0,115200n8" # 1st console to serial device
> > +      console += tty0            # add 2nd console
> > +   }
> > +
> > +If you think that kernel/init options becomes too long to write in boot-loader
> > +configuration file or want to comment on each options, you can use this
> 
>                                          on each option,

Oops, OK. 

> 
> > +boot configuration. If unsure, you can still continue to use the legacy
> > +kernel command line.
> > +
> > +Also, some subsystem may depend on the boot configuration, and it has own
> > +root key. For example, ftrace boot-time tracer uses "ftrace" root key to
> > +describe their options [2]_. In this case, you need to use the boot
> 
>             its

OK

Thank you!

> 
> > +configuration.
> > +
> > +.. [1] See :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
> > +.. [2] See :ref:`Documentation/trace/boottime-trace.rst <boottimetrace>`
> 
> 
> -- 
> ~Randy
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
