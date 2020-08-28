Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4615DC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1880E2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgH1SRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:17:32 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:35428 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726677AbgH1SR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:17:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A8F7B5DC5;
        Fri, 28 Aug 2020 18:17:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: goose22_600e06e27077
X-Filterd-Recvd-Size: 1995
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 18:17:24 +0000 (UTC)
Message-ID: <23029e176062d707bdd5ca1d360f9bedcec3aaa6.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Allow not using -f with files that are in
 git
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Aug 2020 11:17:23 -0700
In-Reply-To: <234290e5-b8dc-22c7-d26f-60a02844ce0a@rasmusvillemoes.dk>
References: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
         <234290e5-b8dc-22c7-d26f-60a02844ce0a@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 14:23 +0200, Rasmus Villemoes wrote:
> On 25/08/2020 02.09, Joe Perches wrote:
> > If a file exists in git and checkpatch is used without the -f
> > flag for scanning a file, then checkpatch will scan the file
> > assuming it's a patch

[]

> > +sub git_is_single_file {
> > +	my ($filename) = @_;
> > +
> > +	return 0 if ((which("git") eq "") || !(-e "$gitroot"));
> > +
> > +	my $output = `${git_command} ls-files -- $filename`;
> > +	my $count = $output =~ tr/\n//;
> > +	return $count eq 1 && $output =~ m{^${filename}$};
> > +}
> 
> Isn't that somewhat expensive to do for each file?

Just FYI:  Not really.

On my 4 year old laptop git ls-files -- <file> takes
about .02 seconds.

$ time git ls-files -- 'net/l2tp/l2tp_ip.c'
net/l2tp/l2tp_ip.c

real	0m0.013s
user	0m0.009s
sys	0m0.004s

Even uncached, it's quite quick.

# sync; echo 3 > /proc/sys/vm/drop_caches
$ time git ls-files -- 'net/l2tp/l2tp_ip.c'
net/l2tp/l2tp_ip.c

real	0m0.079s
user	0m0.004s
sys	0m0.037s

cheers, Joe

