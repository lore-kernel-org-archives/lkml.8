Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCBC206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFJVmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:42:55 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:54690 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726134AbgFJVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:42:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 727EE801B568;
        Wed, 10 Jun 2020 21:42:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wrist18_451733326dce
X-Filterd-Recvd-Size: 3194
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 21:42:52 +0000 (UTC)
Message-ID: <33204a397b2d9316e09ae9829e637894b304ea00.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add check for
 NONNETWORKING_BLOCK_COMMENT_STYLE
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 10 Jun 2020 14:42:51 -0700
In-Reply-To: <021da2ca-a8d3-d0ad-28c3-6a84464353fd@broadcom.com>
References: <20200610202640.9020-1-scott.branden@broadcom.com>
         <673c2ebaf7a1ca93f3b1192a77ff62167badd896.camel@perches.com>
         <021da2ca-a8d3-d0ad-28c3-6a84464353fd@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 14:33 -0700, Scott Branden wrote:
> Hi Joe,
> 
> On 2020-06-10 2:16 p.m., Joe Perches wrote:
> > On Wed, 2020-06-10 at 13:26 -0700, Scott Branden wrote:
> > > NETWORKING_BLOCK_COMMENT_STYLE is supported by checkpatch but there
> > > doesn't seem to be any check for the standard block comment style.
> > > Add support for NONNETWORKING_BLOCK_COMMENT_STYLE to check for empty /*
> > > on first line of non-networking block comments.
> > I think there are _way_ too many instances of this form
> > in non-networking code to enable this.
> > 
> > $ git grep -P '^\s*/\*\s*\S.*[^\*][^\\]\s*$' -- '*.[ch]' | \
> >    grep -v -P '^(drivers/net/|net/)' | \
> >    wc -l
> > 51407
> That is true about many things that checkpatch now checks for that 
> didn't previously.

Not in that quantity of uses it doesn't.

I specifically did _not_ add this very same test
when I added the other comment tests.

> But, by adding to checkpatch the coding style clearly outlined in 
> coding-style.rst can be followed:

Well, because there are _so_ many false positives
that don't need change, I'm not adding this.

As is, I'm nacking it.

If you need it for your use, you should keep it in
your own tree.

> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -3408,6 +3408,16 @@ sub process {
> > >   			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
> > >   		}
> > >   
> > > +# Non-Networking with an empty initial /*
> > > +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
> > > +		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]/ &&
> > > +		    $prevrawline !~ /\*\/[ \t]*$/ &&		#no trailing */
> > > +		    $rawline =~ /^\+[ \t]*\*/ &&
> > > +		    $realline > 2) {
> > > +			WARN("NONNETWORKING_BLOCK_COMMENT_STYLE",
> > > +			     "non-networking block comments use an empty /* on first line\n" . $hereprev);

_Maybe_ this test _might_ be useful if it did a file/patch
test and used CHK on file, but even then I'm very dubious.

			my $msg_level = \&WARN;
			$msg_level = \&CHK if ($file);
			&{msg_level}(etc...)


