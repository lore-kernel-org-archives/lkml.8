Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93B4C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73AE20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgBKLpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:45:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:33482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBKLpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:45:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 95712B384;
        Tue, 11 Feb 2020 11:45:09 +0000 (UTC)
Date:   Tue, 11 Feb 2020 12:45:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1] MAINTAINERS: Sort entries in database for VSPRINTF
Message-ID: <20200211114508.zfvwpqgu5w2gzhwa@pathway.suse.cz>
References: <20200128143425.47283-1-andriy.shevchenko@linux.intel.com>
 <20200210142154.x2azckvduvh3xuea@pathway.suse.cz>
 <20200210145129.GV10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210145129.GV10400@smile.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-02-10 16:51:29, Andy Shevchenko wrote:
> On Mon, Feb 10, 2020 at 03:21:55PM +0100, Petr Mladek wrote:
> > Hi Andy,
> > 
> > On Tue 2020-01-28 16:34:25, Andy Shevchenko wrote:
> > > Run parse-maintainers.pl and choose VSPRINTF record. Fix it accordingly.
> > 
> > Also the order does not look defined in the file. When I run
> > parse-maintainers.pl on the entire MAINTAINERS file:
> 
> See [2] for the details.
> 
> >  MAINTAINERS | 5584 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
> >  1 file changed, 2787 insertions(+), 2797 deletions(-)
> > 
> > The file has 18545 lines. It means that huge amount of entries
> > do not follow the order.
> 
> Yes, but it's getting better.
> 
> [1]: 7683e9e52925 ("Properly alphabetize MAINTAINERS file")
> [2]: https://lore.kernel.org/lkml/CA+55aFy3naVgbRubhjfq7k4CcSiFOEdQNkNwHTLDLmepECu9yA@mail.gmail.com/

Ok, the message [2] is Linus' reaction on a similar patch.
He complained that

 (a) the ordering wasn't complete
 (b) this wasn't scripted.

In fact, parse-maintainers.pl was created to automatize such clean ups
and allow to fix all entries at once.

Fixing only VSPRITF record is a tiny-piece-by-piece approach.
It is an approach that will create a lot of work for many people.

If you want to do a clean up then please ask Linus to do it by the
script.

Also please add a check into checkpatch.pl to reduce regressions.

Best Regards,
Petr
