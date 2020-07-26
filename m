Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D6AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B65F20663
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGZE1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:27:11 -0400
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:52520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgGZE1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:27:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4EE8F173085C;
        Sun, 26 Jul 2020 04:27:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trick38_4d04a9326f55
X-Filterd-Recvd-Size: 3124
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jul 2020 04:27:08 +0000 (UTC)
Message-ID: <6d88f6b08442b064062449c6379aa7d3b9b68ff0.camel@perches.com>
Subject: Re: Re: checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        SeongJae Park <sjpark@amazon.de>
Date:   Sat, 25 Jul 2020 21:27:07 -0700
In-Reply-To: <20200725233557.8154-1-sj38.park@gmail.com>
References: <20200725233557.8154-1-sj38.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-26 at 01:35 +0200, SeongJae Park wrote:
> On Sat, 25 Jul 2020 10:29:23 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > On Sat, 2020-07-25 at 15:02 +0200, Michał Mirosław wrote:
> > > Hello,
> > > 
> > > I see that this patch went into next and is already inciting people to
> > > do wrong things [1]. Can you please fix it to require '--subjective'
> > > switch or otherwise mark it clearly as suggestion-only?
> > > 
> > > The coding-style as in Linus' master says about *NEW* uses of the words
> > > listed (those introductions I expect to be actually rare) and not about
> > > existing use in the code or industry. Making a noise about all uses
> > > found surely will generate a lot more irrelevant patches.
> > > 
> > > [1] https://www.spinics.net/lists/linux-tegra/msg51849.html
> > 
> > And if not reverted, perhaps do not check existing files
> > at all but only check patches and change the message to
> > show only suggestions not from a specification.
> 
> Agreed for this case.  However, excluding existing file check doesn't fully
> avoid this problem.  Also, more terms having different deprecation rules might
> be added in future.  How about allowing file check but show reference in the
> suggestion message as below?

The general problem is that drivers/staging, net/ and drivers/net
all have --strict on by default.

Emitting these deprecated terms messages with -f --file uses for
files in those directories isn't a great idea.

> diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
[]
> @@ -3,8 +3,10 @@
>  # The format of each line is:
>  # deprecated||suggested
>  #
> +# If special rules are applied on the terms, please comment those.

Disagree.  Comments about these existing uses aren't helpful.

> +#
> +# Refer to "4) Naming" section of Documentation/process/coding-style.rst for
> +# below three terms.
>  blacklist||(denylist|blocklist)
> -# For other alternatives of 'slave', Please refer to
> -# Documentation/process/coding-style.rst
>  slave||(secondary|target|...)
>  whitelist||(allowlist|passlist)


