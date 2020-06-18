Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5692C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFA920706
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgFRRlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:41:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgFRRlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:41:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6A05FAC51;
        Thu, 18 Jun 2020 17:40:59 +0000 (UTC)
Date:   Thu, 18 Jun 2020 19:40:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
Message-ID: <20200618174058.GE3617@alley>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
 <20200617162536.611386-23-jim.cromie@gmail.com>
 <20200618161912.GD3617@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618161912.GD3617@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-18 18:19:12, Petr Mladek wrote:
> On Wed 2020-06-17 10:25:35, Jim Cromie wrote:
> > 1. Add a user-flag [u] which works like the [pfmlt] flags, but has no
> > effect on callsite behavior; it allows incremental marking of
> > arbitrary sets of callsites.
> > 
> > 2. Add [PFMLTU] flags, which negate their counterparts; P===!p etc.
> > And in ddebug_read_flags():
> >    current code does:	[pfmltu_] -> flags
> >    copy it to:		[PFMLTU_] -> mask
> > 
> > also disallow both of a pair: ie no 'pP', no true & false.
> > 
> > 3. Add filtering ops into ddebug_change(), right after all the
> > callsite-property selections are complete.  These filter on the
> > callsite's current flagstate before applying modflags.
> > 
> > Why ?
> > 
> > The u-flag & filter flags
> > 
> > The 'u' flag lets the user assemble an arbitary set of callsites.
> > Then using filter flags, user can activate the 'u' callsite set.
> > 
> >   #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
> >   #> echo 'u+p' > control
> > 
> > Of course, you can continue to just activate your set without ever
> > marking it 1st, but you could trivially add the markup as you go, then
> > be able to use it as a constraint later, to undo or modify your set.
> > 
> >   #> echo 'file foo.c +up' >control
> >   .. monitor, debug, finish ..
> >   #> echo 'u-p' >control
> > 
> >   # then later resume
> >   #> echo 'u+p' >control
> > 
> >   # disable some cluttering messages, and remove from u-set
> >   #> echo 'file noisy.c function:jabber_* u-pu' >control
> > 
> >   # for doc, recollection
> >   grep =pu control > my-favorite-callsites
> > 
> > Note:
> > 
> > Your flagstate after boot is generally not all =_. -DDEBUG will arm
> > compiled callsites by default, $builtinmod.dyndbg=+p bootargs can
> > enable them early, and $module.dyndbg=+p bootargs will arm them when
> > the module is loaded.  But you could manage them with u-flags:
> > 
> >   #> echo '-t' >control		# clear t-flag to use it as 2ndary markup
> >   #> echo 'p+ut' >control	# mark the boot-enabled set of callsites
> >   #> echo '-p' >control		# clean your dmesg -w stream
> > 
> >   ... monitor, debug ..
> >   #> echo 'module of_interest $qterms +pu' >control	# build your set of useful debugs
> >   #> echo 'module of_interest $qterms UT+pu' >control	# same, but dont alter ut marked set
> 
> Does anyone requested this feature, please?
> 
> For me, it is really hard to imagine people using these complex and hacky
> steps.

I think that all this is motivated by adding support for module
specific groups.

What about storing the group as yet another information for each
message? I mean the same way as we store module name, file, line,
function name.

Then we could add API to define group for a given message:

   pr_debug_group(group_id, fmt, ...);

the interface for the control file might be via new keyword "group".
You could then do something like:

   echo module=drm group=0x3 +p >control

But more importantly you should add functions that might be called
when the drm.debug parameter is changes. I have already mentioned
it is another reply:

    dd_enable_module_group(module_name, group_id);
    dd_disable_module_group(module_name, group_id);


It will _not_ need any new flag or flag filtering.

Best Regards,
Petr
