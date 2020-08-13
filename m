Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57691C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2747E2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597323873;
	bh=Nuw5mIFQBrem99QMknSs/J0bUVGvpZ6iKTJjKn2hiSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ki2k0mzkc0aQItwJGWSOnXsJ1Maa1dxBn1tazL3mbCQkyXndPb7Yxv18/ntJQLUKy
	 NNdaBm1eVd8l+KIvE5hpG+hA+PAfj7gdhTR1qLuYiZ3NNsh5mmSZn8D3Ya5lgwX4rS
	 rIOTcT7aLWsDTGX6TSqrQutjQMqStipkaeFpqxLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHMNEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgHMNE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:04:28 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFA37207DA;
        Thu, 13 Aug 2020 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597323868;
        bh=Nuw5mIFQBrem99QMknSs/J0bUVGvpZ6iKTJjKn2hiSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twReRzYklTVmelZWwGuHgx9+OlEATxb4XaOrAYWdecQZE6U1rPnRGX5muT0SVuZgo
         acnHgw0lCpoHdefJWsQBld+9zm3AKdDqcf+Py7UVBDSSLe7QObRZYOYtt6prRFcZue
         XN4J1JGcZMXgCfCFSCL5q/8WCvLH5bhMZ1TWVmmE=
Date:   Thu, 13 Aug 2020 15:04:22 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200813130422.GA16938@linux-8ccs>
References: <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net>
 <20200812125645.GA8675@willie-the-truck>
 <20200812141557.GQ14398@arm.com>
 <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net>
 <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Ard Biesheuvel [13/08/20 10:36 +0200]:
>On Wed, 12 Aug 2020 at 22:00, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Wed, Aug 12, 2020 at 06:37:57PM +0200, Ard Biesheuvel wrote:
>> > I know there is little we can do at this point, apart from ignoring
>> > the permissions - perhaps we should just defer the w^x check until
>> > after calling module_frob_arch_sections()?
>>
>> My earlier suggestion was to ignore it for 0-sized sections.
>
>Only they are 1 byte sections in this case.
>
>We override the sh_type and sh_flags explicitly for these sections at
>module load time, so deferring the check seems like a reasonable
>alternative to me.

So module_enforce_rwx_sections() is already called after
module_frob_arch_sections() - which really baffled me at first, since
sh_type and sh_flags should have been set already in
module_frob_arch_sections().

I added some debug prints to see which section the module code was
tripping on, and it was .text.ftrace_trampoline. See this snippet from
arm64's module_frob_arch_sections():

                else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
                         !strcmp(secstrings + sechdrs[i].sh_name,
                                 ".text.ftrace_trampoline"))
                        tramp = sechdrs + i;

Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
is never set here and the if (tramp) check at the end of the function
fails, so its section flags are never set, so they remain WAX and fail
the rwx check.
