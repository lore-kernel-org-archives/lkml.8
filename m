Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BF3C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC89D206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgELPwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:52:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgELPwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:52:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68419ABD1;
        Tue, 12 May 2020 15:52:12 +0000 (UTC)
Date:   Tue, 12 May 2020 17:52:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] allow ramoops to collect all kmesg_dump events
Message-ID: <20200512155207.GF17734@linux-b0ei>
References: <20200506211523.15077-1-keescook@chromium.org>
 <20200512131655.GE17734@linux-b0ei>
 <CA+CK2bBMUxxuTBicQ7ihKpN3jK94mMjcNCXhnAXUaODce09Wmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBMUxxuTBicQ7ihKpN3jK94mMjcNCXhnAXUaODce09Wmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-05-12 10:03:44, Pavel Tatashin wrote:
> > OK, I personally see this as two separate problems:
> >
> >    1. Missing support to set loglevel per console.
> >    2. Missing support to dump messages for other reasons.
> >
> > I would remove the paragraph about console log levels completely.
> 
> OK, I see your point, this paragraph can be removed, however, I think
> it makes it clear to understand the rationale for this change. As I
> understand, the per console loglevel has been proposed but were never
> accepted.

The proposal was not accepted because there were more requirements:

   + add console device into sysfs so that it can be modified there
   + make a reasonable backward compatible behavior

I guess that the sysfs interface discouraged the author to continue
on it.

Note that console loglevel handling is very complicated. There are
already four variables, see console_printk array in
kernel/printk/printk.c. Per console loglevel would make it even
more complicated.

It is a nighmare. And introducing max_reason parameter goes the same way.

> > Now, the max_reason logic makes sense only when all the values
> > have some ordering. Is this the case?
> >
> > I see it as two distinct sets:
> >
> >    + panic, oops, emerg: describe how critical is an error situation
> >    + restart, halt, poweroff: describe behavior when the system goes down
> >
> > Let's say that panic is more critical than oops. Is restart more
> > critical than halt?
> >
> > If you want the dump during restart. Does it mean that you want it
> > also during emergency situation?
> >
> > My fear is that this patchset is going to introduce user interface
> > (max_reason) with a weird logic. IMHO, max_reason is confusing even
> > in the code and we should not spread this to users.
> >
> > Is there any reason why the existing printk.always_kmsg_dump option
> > is not enough for you?
> 
> printk.always_kmsg_dump is not working for me because ramoops has its
> own filtering based on dump_oops boolean, and ignores everything but
> panics and conditionally oops.
> max_reason makes the ramoops internal logic cleaner compared to using dump_oops.

I see. Just to be sure. Is the main reason to add max_reason parameter
to keep complatibility of the deprecated dump_oops parameter? Or is
there any real use case for this granularity?

I made some arecheology. ramoops.dump_oops parameter was added in 2010 by the
initial commit 56d611a04fb2db77334e ("char drivers: RAM oops/panic
logger."

Note that the initial implementation printed Oops reason only when
dump_oops was set. It printed all other reasons otherwise. It seems
that there were only the two reasons at that time.

Now, printk.always_kmsg_dump parameter was added later in 2012 by
the commit c22ab332902333f8376601 ("kmsg_dump: don't run on non-error
paths by default").

IMHO, the later commit actually fixed the default behavior of ramoops.

I wonder if anyone is actually using the ramoops.dump_oops parameter
in reality. I would personally make it deprecated and change the
default behavior to work according to printk.always_kmsg_dump parameter.

IMHO, ramoops.dump_oops just increases complexity and should not have
been introduced at all. I would try hard to avoid introducing even bigger
complecity and mess.

I know that there is the "do not break existing userspace" rule. The
question is if there is any user and if it is worth it.

> I agree, the reasons in kmsg_dump_reason do not order well  (I
> actually want to add another reason for kexec type reboots, and where
> do I put it?), so how about if we change the ordering list to
> bitfield/flags, and instead of max_reason provide: "reasons" bitset?

It looks too complicated. I would really try hard to avoid the
parameter at all.

Best Regards,
Petr
