Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAE1C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433A320658
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCTViZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:38:25 -0400
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:37506 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgCTViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:38:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CC5FF181D341E;
        Fri, 20 Mar 2020 21:38:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: range27_2c0c3d609a007
X-Filterd-Recvd-Size: 2461
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 21:38:22 +0000 (UTC)
Message-ID: <4512dfe1ea1e445a7ce71829d24de97c7fd30266.camel@perches.com>
Subject: Re: [PATCH v12 8/8] MAINTAINERS: perf: Add pattern that matches ppc
 perf to the perf entry.
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 20 Mar 2020 14:36:35 -0700
In-Reply-To: <20200320163157.GF1922688@smile.fi.intel.com>
References: <20200225173541.1549955-1-npiggin@gmail.com>
         <cover.1584699455.git.msuchanek@suse.de>
         <4b150d01c60bd37705789200d9adee9f1c9b50ce.1584699455.git.msuchanek@suse.de>
         <20200320103350.GV1922688@smile.fi.intel.com>
         <20200320112338.GP25468@kitsune.suse.cz>
         <20200320124251.GW1922688@smile.fi.intel.com>
         <b96c9dd4dba4afca5288a551158659bf545d29fb.camel@perches.com>
         <20200320163157.GF1922688@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(removed a bunch of cc's)

On Fri, 2020-03-20 at 18:31 +0200, Andy Shevchenko wrote:
> On Fri, Mar 20, 2020 at 07:42:03AM -0700, Joe Perches wrote:
> > On Fri, 2020-03-20 at 14:42 +0200, Andy Shevchenko wrote:
> > > On Fri, Mar 20, 2020 at 12:23:38PM +0100, Michal Suchánek wrote:
> > > > On Fri, Mar 20, 2020 at 12:33:50PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Mar 20, 2020 at 11:20:19AM +0100, Michal Suchanek wrote:
> > > > > > While at it also simplify the existing perf patterns.
> > > > > And still missed fixes from parse-maintainers.pl.
> > > > 
> > > > Oh, that script UX is truly ingenious.
> > > 
> > > You have at least two options, their combinations, etc:
> > >  - complain to the author :-)
> > >  - send a patch :-)
> > 
> > Recently:
> > 
> > https://lore.kernel.org/lkml/4d5291fa3fb4962b1fa55e8fd9ef421ef0c1b1e5.camel@perches.com/
> 
> But why?
> 
> Shouldn't we rather run MAINTAINERS clean up once and require people to use
> parse-maintainers.pl for good?

That can basically only be done by Linus just before he releases
an RC1.

I am for it.  One day...


