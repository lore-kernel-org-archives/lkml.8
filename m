Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD80C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BFF20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgD3PlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:41:22 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:37512 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbgD3PlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:41:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DCA6C18224D6A;
        Thu, 30 Apr 2020 15:41:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thing45_28b1dc48c5410
X-Filterd-Recvd-Size: 2578
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Apr 2020 15:41:19 +0000 (UTC)
Message-ID: <30efd2838a876029600806e9b53e3284ccabc88d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add support to check 'Fixes:' tag format
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Date:   Thu, 30 Apr 2020 08:41:18 -0700
In-Reply-To: <20200430125614.GA30691@udknight>
References: <20200429163645.GA13810@udknight>
         <4112ab7e-1f06-d880-e471-084c78bc84d4@web.de>
         <20200430125614.GA30691@udknight>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-30 at 20:56 +0800, Wang YanQing wrote:
> On Wed, Apr 29, 2020 at 07:40:21PM +0200, Markus Elfring wrote:
> > > “...
> > > Do not split the tag across multiple
> > > lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
> > > parsing scripts
> > > ...”
> > 
> > Why do you not like the reformatting of the quotation so far
> > (if such change descriptions should cope also with specific
> > Unicode characters)?
> > 
> > “…
> > Do not split the tag across multiple lines, tags are exempt from
> > the "wrap at 75 columns" rule in order to simplify parsing scripts.
> > …”
> > 
> > 
> 
> Sigh. I will fix it, but I want to hear from Joe Perches before
> next patch version.

Hello YanQing.

Just ignore Markus' replies here, he's well meaning
but perhaps overly focused on trying to impose formal,
but somewhat antique grammar and word choice uses that
aren't particularly important for review.

The most common variant I see here is someone writes

Fixes: SHA1 ("Truncated commit description...")

to apparently avoid a long line.

btw:

you can test your patch using checkpatch and --git like:

$ git log -10000 --no-merges --grep="Fixes:" --format=%H | \
  while read commit ; do \
    ./scripts/checkpatch.pl --git $commit --types=GIT_COMMIT_ID --quiet --nosummary; \
  done

You could filter that either by modifying the patch
changing to "GIT_COMMIT_ID_TEST" and changing to
types=GIT_COMMIT_ID_TEST just for Fixes or maybe
use another grep like grep -B3 -A3 "Fixes:" -i


