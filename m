Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4520C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47C820738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFCMoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:44:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:45058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgFCMoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:44:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 195EDAE96;
        Wed,  3 Jun 2020 12:44:10 +0000 (UTC)
Date:   Wed, 3 Jun 2020 14:44:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: twist: allow disabling reboot request
Message-ID: <20200603124405.GA22497@linux-b0ei>
References: <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
 <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
 <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
 <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
 <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
 <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
 <19d377d3-8037-8090-0f99-447f72cc1d8c@i-love.sakura.ne.jp>
 <38df9737-3c04-dca2-0df4-115a9c1634e5@i-love.sakura.ne.jp>
 <51eaa6cd-33ce-f9d8-942c-c797c0ec6733@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51eaa6cd-33ce-f9d8-942c-c797c0ec6733@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-06-03 20:03:28, Tetsuo Handa wrote:
> On 2020/05/29 22:26, Tetsuo Handa wrote:
> >     By the way, I do worry that people forget to perform these steps when they do
> >     their tests without asking syzbot...
> 
> Here is a draft of boot-time switching. Since kconfig can handle string variable up to
> 2048 characters, we could hold the content of the "your-config" file inside .config file
> in order to avoid relying on external file in "syzkaller tree". But since only one kconfig
> option is used, basically the way to temporarily include/exclude specific options (under
> automated testing by syzbot) seems to remain directly patching apply_twist_flags(), for
> https://github.com/google/syzkaller/blob/master/dashboard/config/util.sh will automatically
> overwrite CONFIG_DEFAULT_TWIST_FLAGS settings. If each twist flag were using independent
> kconfig option, the way to temporarily include/exclude specific options will become directly
> patching Kconfig file.
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 82d91547d122..78fdbb4f17b1 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -1038,4 +1038,12 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>  	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
>  	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
>  	 (perms))
> +
> +/* Flags for twisting kernel behavior. */
> +struct twist_flags {
> +	bool disable_kbd_k_spec_handler;
> +	bool disable_reboot_request;
> +};
> +extern struct twist_flags twist_flags;


Why all these options have to be in a single structure?


> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 498d344ea53a..41cfabc74ad7 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2338,4 +2338,9 @@ config HYPERV_TESTING
>  
>  endmenu # "Kernel Testing and Coverage"
>  
> +menuconfig DEFAULT_TWIST_FLAGS
> +	string "Default twist options (DANGEROUS)"
> +	help
> +	  Don't specify anything unless you know what you are doing.
> +
>  endmenu # Kernel hacking

Why such a crazy build configure option?

I think that the only way to get this upstream is to:

   + Add separate boot options that might theoretically be used also
     by other people.

   + Use boot parameters and not build configuration.

   + Avoid the meaningless word "twist" !!!


Best Regards,
Petr
