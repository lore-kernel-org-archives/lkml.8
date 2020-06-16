Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765E7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EE0208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgFPLer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:34:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgFPLer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:34:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AE866AFE5;
        Tue, 16 Jun 2020 11:34:48 +0000 (UTC)
Date:   Tue, 16 Jun 2020 13:34:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 13/24] dyndbg: combine flags & mask into a struct, use
 that
Message-ID: <20200616113443.GB2238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-14-jim.cromie@gmail.com>
 <20200615151414.GI31238@alley>
 <CAJfuBxyTsrsyMZFhET3yxM1APobY98ykBLuQ2LEhHKsOYtyjEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxyTsrsyMZFhET3yxM1APobY98ykBLuQ2LEhHKsOYtyjEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-06-15 23:47:26, jim.cromie@gmail.com wrote:
> On Mon, Jun 15, 2020 at 9:14 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Sat 2020-06-13 09:57:27, Jim Cromie wrote:
> > > combine flags & mask into a struct, and replace those 2 parameters in
> > > 3 functions: ddebug_change, ddebug_parse_flags, ddebug_read_flags,
> > > altering the derefs in them accordingly.
> > >
> > > This simplifies the 3 function sigs, preparing for more changes.
> > > We dont yet need mask from ddebug_read_flags, but will soon.
> > > ---
> > >  lib/dynamic_debug.c | 46 +++++++++++++++++++++++----------------------
> > >  1 file changed, 24 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > > index 93c627e9c094..8dc073a6e8a4 100644
> > > --- a/lib/dynamic_debug.c
> > > +++ b/lib/dynamic_debug.c
> > > +struct flagsettings {
> > > +     unsigned int flags;
> > > +     unsigned int mask;
> > > +};
> >
> > static int ddebug_change(const struct ddebug_query *query,
> > > -                     unsigned int pflags, unsigned int mask)
> > > +                      struct flagsettings *mods)
> >
> > > -static int ddebug_read_flags(const char *str, unsigned int *flags)
> > > +static int ddebug_read_flags(const char *str, struct flagsettings *f)
> >
> > > -static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
> > > -                            unsigned int *maskp)
> > > +static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
> >
> > What "mods" stands for, please?
> >
> modifying_flags, or modifiers.
> the original flags & mask bundled together
> ie the pfmlt in
>    echo +pfmlt > control

Honestly, storing flags and mask is a hack that makes the code
tricky like hell.

IMHO, it would be much easier to define something like:

struct flags_operation {
	unsinged int flags;
	enum flags_operation_type op;
}

Where the opration would be:

enum flags_operation_type {
	DD_FLAGS_SET,		/* for '=' */
	DD_FLAGS_ADD,		/* for '+' */
	DD_FLAGS_DEL,		/* for '-' */
	DD_FLAGS_FILTER_MATCH,
	DD_FLAGS_FILTER_NON_MATCH,
};

Then you could define

     struct flags_operation fop_change;
     struct flags_operation fop_filter;

Then you could do in ddebug_change():

	if (fop_filter) {
		switch(fop_filter->op) {
			case DD_FLAGS_FILTER_MATCH:
				if ((dp->flags & fop_filter->flags) != fop_filter->flags)
					continue;
				break;
			case: DD_FLAGS_FILTER_NON_MATCH:
				if ((dp->flags & fop_filter->flags)
					continue;
				break;
			default:
				// warn error;
		}
	}

	switch (fop_change->op) {
		case DD_FLAGS_SET:
			dp->flags = fop_change->flags;
			break;
		case DD_FLAGS_ADD:
			dp->flags |= fop_change->flags;
			break;
		case DD_FLAGS_DEL:
			dp->flgas &= ^(fop_change->flgas);
			break;
		default:
			// error;
	}


It might be more lines. But the bit operations will become straightforward.
and the code self-explaining,


> does the above help ?
> I could go with modifying_flags
> keep in mind the name has to suit all + - = operations
> 
> I'll review all the new names. I recall you didnt like filterflags either,
> so I wasnt sufficently clear there either.
> Im mulling a better explanation.


The above would make the code manageable. Another question is the user
interface.

I still wonder if it is worth it.
What is the motivation for this fitlering?
Is it requested by users?
Or is it just a prerequisite for the user-specific filters?

We need to be really careful. User interface is hard to change
or remove later.

Best Regards,
Petr
