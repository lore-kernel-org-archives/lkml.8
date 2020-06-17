Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFF6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6E52078D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFQJw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:52:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQJw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:52:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CD345AC52;
        Wed, 17 Jun 2020 09:53:00 +0000 (UTC)
Date:   Wed, 17 Jun 2020 11:52:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Joe Perches <joe@perches.com>, Jim Cromie <jim.cromie@gmail.com>,
        jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
Message-ID: <20200617095255.GU31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-21-jim.cromie@gmail.com>
 <20200616134507.GO31238@alley>
 <5b0fade06c46da0a469266738c684ba55d8e39f0.camel@perches.com>
 <20200617093154.v7mf5355faa4c7ob@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617093154.v7mf5355faa4c7ob@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-06-17 10:31:54, Daniel Thompson wrote:
> On Tue, Jun 16, 2020 at 02:05:27PM -0700, Joe Perches wrote:
> > On Tue, 2020-06-16 at 15:45 +0200, Petr Mladek wrote:
> > > On Sat 2020-06-13 09:57:34, Jim Cromie wrote:
> > > > There are *lots* of ad-hoc debug printing solutions in kernel,
> > > > this is a 1st attempt at providing a common mechanism for many of them.
> > > 
> > > I agree that it might make sense to provide some common mechanism.
> > []
> > > My problem with this approach is that it is too generic. Each class
> > > would have different meaning in each subsystem.
> > > 
> > > It might help to replace any existing variants. But it would be hard
> > > for developers debugging the code. They would need to study/remember
> > > the meaning of these groups for particular subsystems. They would
> > > need to set different values for different messages.
> > > 
> > > Could you please provide more details about the potential users?
> > > Would be possible to find some common patterns and common
> > > meaning of the groups?
> > 
> > I doubt the utility of common patterns.
> > Verbosity is common but groupings are not.
> > 
> > Look at the DRM patterns vs other groups.
> 
> I've seen drm.debug mentioned a couple of times but the comments about
> it seem to only learn part of what is shows us.
> 
> drm.debug is a form of common grouping but it acts at a sub-system level
> rather then whole system (and gives a whole sub-system enable/disable).
> This is where grouping makes most sense.
> 
> The result is that drm.debug is easy to document, both in official
> kernel docs and in other resources (like the arch distro documentation).
> Having controls that are easy to document makes them easy to find and
> thus sub-system grouping leads directly to higher quality bug reports.

Thanks a lot for explanation.

Now, could anyone please tell me how this new dynamic debug feature
would allow to replace drm.debug option?

I mean what steps/commands will be needed instead of, for example
drm.debug=0x3 command line option?

Best Regards,
Petr
