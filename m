Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA0F20732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgFRMUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:20:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:50366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgFRMUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:20:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 28A31AD39;
        Thu, 18 Jun 2020 12:20:01 +0000 (UTC)
Date:   Thu, 18 Jun 2020 14:20:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     jim.cromie@gmail.com
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
Message-ID: <20200618121959.GB3617@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-21-jim.cromie@gmail.com>
 <20200616134507.GO31238@alley>
 <5b0fade06c46da0a469266738c684ba55d8e39f0.camel@perches.com>
 <20200617093154.v7mf5355faa4c7ob@holly.lan>
 <20200617095255.GU31238@alley>
 <CAJfuBxzDvW-nD51Zayv9K6mUuRGh5iR_+NzO4Hwf7UQEs5z28g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxzDvW-nD51Zayv9K6mUuRGh5iR_+NzO4Hwf7UQEs5z28g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-06-17 07:23:34, jim.cromie@gmail.com wrote:
> On Wed, Jun 17, 2020 at 3:52 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Wed 2020-06-17 10:31:54, Daniel Thompson wrote:
> > > On Tue, Jun 16, 2020 at 02:05:27PM -0700, Joe Perches wrote:
> > > > On Tue, 2020-06-16 at 15:45 +0200, Petr Mladek wrote:
> > > > > On Sat 2020-06-13 09:57:34, Jim Cromie wrote:
> > > > > > There are *lots* of ad-hoc debug printing solutions in kernel,
> > > > > > this is a 1st attempt at providing a common mechanism for many of them.
> > > > >
> > > > > I agree that it might make sense to provide some common mechanism.
> > > > []
> > > > > My problem with this approach is that it is too generic. Each class
> > > > > would have different meaning in each subsystem.
> > > > >
> > > > > It might help to replace any existing variants. But it would be hard
> > > > > for developers debugging the code. They would need to study/remember
> > > > > the meaning of these groups for particular subsystems. They would
> > > > > need to set different values for different messages.
> > > > >
> > > > > Could you please provide more details about the potential users?
> > > > > Would be possible to find some common patterns and common
> > > > > meaning of the groups?
> > > >
> > > > I doubt the utility of common patterns.
> > > > Verbosity is common but groupings are not.
> > > >
> > > > Look at the DRM patterns vs other groups.
> > >
> > > I've seen drm.debug mentioned a couple of times but the comments about
> > > it seem to only learn part of what is shows us.
> > >
> > > drm.debug is a form of common grouping but it acts at a sub-system level
> > > rather then whole system (and gives a whole sub-system enable/disable).
> > > This is where grouping makes most sense.
> > >
> > > The result is that drm.debug is easy to document, both in official
> > > kernel docs and in other resources (like the arch distro documentation).
> > > Having controls that are easy to document makes them easy to find and
> > > thus sub-system grouping leads directly to higher quality bug reports.
> >
> > Thanks a lot for explanation.
> >
> > Now, could anyone please tell me how this new dynamic debug feature
> > would allow to replace drm.debug option?
> >
> > I mean what steps/commands will be needed instead of, for example
> > drm.debug=0x3 command line option?
> >
>     drm use case:
> 
>     drm.debug=0x03 appears to be a kernel boot-arg example, setting 2
>     internal debug flags.  Each bit is probably controlling a separate
>     subset of all debug-prints, they may be overlapping subsets.

The meaning of the bits is define in drivers/gpu/drm/drm_print.c:

MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
"\t\tBit 0 (0x01)  will enable CORE messages (drm core code)\n"
"\t\tBit 1 (0x02)  will enable DRIVER messages (drm controller code)\n"
"\t\tBit 2 (0x04)  will enable KMS messages (modesetting code)\n"
"\t\tBit 3 (0x08)  will enable PRIME messages (prime code)\n"
"\t\tBit 4 (0x10)  will enable ATOMIC messages (atomic code)\n"
"\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
"\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
"\t\tBit 8 (0x100) will enable DP messages (displayport code)");

Wrappers using these id's are defined in include/drm/drm_print.h,
for example:

#define DRM_DEBUG_ATOMIC(fmt, ...)					\
	__drm_dbg(DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)

or

#define drm_dbg_atomic(drm, fmt, ...)					\
	drm_dev_dbg((drm)->dev, DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)


>     Those subsets are *definitely* expressible as a few dyndbg queries
>     each.  Any arbitrary subset is.
> 
>        drm.dyndbg='file drm_gem_* +p'       # gem debug
>        drm.dyndbg='file *_gem_* +p'         # *gem debug

I do not understand this. Each category is used in many files and
some files use more categories at the same time:

   git grep DRM_DEBUG_

>     With this proposed export, drm authors could exec these examples, most
>     likely in the callback that handles updates to the drm.debug variable.

I am afraid that this will not work. It would be hard to maintain
especially when more categories are used in the same source file.

It would be needed some easy to use API:

   /*
    * Print message when this module and feature is enable in dynamic
    * debug interface.
    */
   pr_debug_feature(int feature_id, fmt, ...);  to print a part

   /* Enable/disable printing debugging messages, work during early boot??? */
   dd_enable_module_feature(char *module_name, int *feature_id);
   dd_disable_module_feature(char *module_name, int *feature_id);


Note that the enable/disable functions manipulates only the "p" flag
by intention. The module.debug option decides only whether the messages
should be printed or not.

IMHO, the other flags (flmt) should be global flags. It is too big
detail to be enabled per-message. IMHO, it just makes the interface
too complicated and over engineered.

Best Regards,
Petr
