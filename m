Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1693DC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE64F20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bd6n+8zN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBGLla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:41:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33274 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgBGLl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:41:29 -0500
Received: from zn.tnic (p200300EC2F0B4B0058591680225327CB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4b00:5859:1680:2253:27cb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0A231EC0C99;
        Fri,  7 Feb 2020 12:41:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581075687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zWVlnd2Oa3c51Xyhbdjk8lqSWwDOrWoirAz/KJZLaB8=;
        b=bd6n+8zNqvAHY+OrS6NXp1EddnLQA0AIcw2bYFeYWXQ8Z/OYtcs9qJniVxo//IA9ULi57T
        ky1zivROl7QnhYQwZz58N5qrbgBRwlcVQsd6RUOg/gFinWEZ7s3k+XLx2wfNYi3+IxvjtB
        0E112YxgKTpCDr0yKKv1P2zNhV/9Xlo=
Date:   Fri, 7 Feb 2020 12:41:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
Message-ID: <20200207114122.GB24074@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
 <20200114210336.259202220@goodmis.org>
 <20200206115405.GA22608@zn.tnic>
 <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
 <20200206175858.GG9741@zn.tnic>
 <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 11:46:17AM +0900, Masami Hiramatsu wrote:
> It could change some other things. I recommend developers to use this
> feature to configure their subsystem easier and admins to configure
> kernel boot options more readable way.

Well, I could use an actual justification for why I would need it.
Because, frankly, I haven't sat down and thought: "hmm, this boot
command line supplement thing is awful and I need a better one." IOW,
it has never bothered me so far. But I'm always open to improvements as
long as they don't make it worse. :)

> Many distros may not use it unless it is default y. I couldn't find any
> good example that the feature "default n" turns into "default y".
> Would you have any example?

We - SUSE - always reevaluate our configs for the next service pack and
enable things which make sense and customers use. So all the new drivers
get enabled, kernel infra which makes sense too, etc.

If the bootconfig thing proves useful, I will glady enable it in our
tree.

> Hmm, what would you afraid of? It is just a small footprint additional
> feature which never be enabled without "bootconfig" on the kernel cmdline...

Not afraid - I don't know why I need it. Everything I don't need =>
off. But again, if there's a good use case, I will enable it. The usual
feature evaluation thing we all do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
