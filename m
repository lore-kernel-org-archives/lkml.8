Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3171DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D502206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGZH3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:29:09 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:37286 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbgGZH3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:29:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1274718029210;
        Sun, 26 Jul 2020 07:29:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: anger99_0c069d326f56
X-Filterd-Recvd-Size: 3826
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jul 2020 07:29:06 +0000 (UTC)
Message-ID: <beabe887ee1b761781f5d980a96f2c28b088c56b.camel@perches.com>
Subject: Re: Re: Re: checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        SeongJae Park <sjpark@amazon.de>
Date:   Sun, 26 Jul 2020 00:29:05 -0700
In-Reply-To: <20200726071825.22532-1-sj38.park@gmail.com>
References: <20200726071825.22532-1-sj38.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-26 at 09:18 +0200, SeongJae Park wrote:
> On Sat, 25 Jul 2020 21:27:07 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > On Sun, 2020-07-26 at 01:35 +0200, SeongJae Park wrote:
> > > On Sat, 25 Jul 2020 10:29:23 -0700 Joe Perches <joe@perches.com> wrote:
> > > 
> > > > On Sat, 2020-07-25 at 15:02 +0200, Michał Mirosław wrote:
> > > > > Hello,
> > > > > 
> > > > > I see that this patch went into next and is already inciting people to
> > > > > do wrong things [1]. Can you please fix it to require '--subjective'
> > > > > switch or otherwise mark it clearly as suggestion-only?
> > > > > 
> > > > > The coding-style as in Linus' master says about *NEW* uses of the words
> > > > > listed (those introductions I expect to be actually rare) and not about
> > > > > existing use in the code or industry. Making a noise about all uses
> > > > > found surely will generate a lot more irrelevant patches.
> > > > > 
> > > > > [1] https://www.spinics.net/lists/linux-tegra/msg51849.html
> > > > 
> > > > And if not reverted, perhaps do not check existing files
> > > > at all but only check patches and change the message to
> > > > show only suggestions not from a specification.
> > > 
> > > Agreed for this case.  However, excluding existing file check doesn't fully
> > > avoid this problem.  Also, more terms having different deprecation rules might
> > > be added in future.  How about allowing file check but show reference in the
> > > suggestion message as below?
> > 
> > The general problem is that drivers/staging, net/ and drivers/net
> > all have --strict on by default.
> > 
> > Emitting these deprecated terms messages with -f --file uses for
> > files in those directories isn't a great idea.
> 
> Thank you for kindly explaining your concenrs in detail.  However, I think it's
> ok to do this check even without '--strict' for files if we explicitly says
> it's suggestion only, as Michal said.  My patch does so.
> 
> > > diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
> > []
> > > @@ -3,8 +3,10 @@
> > >  # The format of each line is:
> > >  # deprecated||suggested
> > >  #
> > > +# If special rules are applied on the terms, please comment those.
> > 
> > Disagree.  Comments about these existing uses aren't helpful.
> 
> Sorry, I don't understand your point here.  Why do you think it's not helpful?
> If 'checkpatch' finds the deprecated terms, it will ask people to read this
> file, which explains special rules for each of the deprecations if exists.  The
> rule is, in the case of 'slave', 'applies to new uses only'.  Therefore, people
> could stop sending the noisy unnecessary patches to the maintainers.

Because it will describe this for _every_ instance
of any deprecated word in the file.


