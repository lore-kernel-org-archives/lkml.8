Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587FCC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D5F20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgCLGQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:16:47 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:51386 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387784AbgCLGQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:16:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D9D6B181D341E;
        Thu, 12 Mar 2020 06:16:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: room59_74f27b9f71a53
X-Filterd-Recvd-Size: 2513
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 06:16:43 +0000 (UTC)
Message-ID: <e4443663a51ecf601e137990019075b7dae6a457.camel@perches.com>
Subject: Re: [PATCH -next 004/491] PERFORMANCE EVENTS SUBSYSTEM: Use
 fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Date:   Wed, 11 Mar 2020 23:15:00 -0700
In-Reply-To: <20200311153000.GP12561@hirez.programming.kicks-ass.net>
References: <cover.1583896344.git.joe@perches.com>
         <73d22360c5c665fd7f480a209ae46807dfb07bbe.1583896348.git.joe@perches.com>
         <20200311153000.GP12561@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 16:30 +0100, Peter Zijlstra wrote:
> On Tue, Mar 10, 2020 at 09:51:18PM -0700, Joe Perches wrote:
> > Convert the various uses of fallthrough comments to fallthrough;
> > 
> > Done via script
> > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> The subject can use a little less screaming, but the actual patch is
> fine.

Patch subject come from the MAINTAINERS subsystem/section heading
because I don't see a better way to script the patch subject that
is more effective.

Using something like:

$ cat get_patch_subject_prefix.bash
#!/bin/bash
git log --format="%s" --no-merges -200 --since=2-years-ago $@ | \
  cut -f1 -d":" | \
  sort  | uniq -c | sort -rn | head -1 | \
  sed 's/^[[:space:]]*[[:digit:]]*[[:space:]]*//'
$

Does well for some sets of files, less well for others.

For instance:

$ ./get_patch_subject_prefix.bash drivers/net/ethernet/intel/
ice

which is just one of 10 or so subsystems of intel/...

And there's no way I'm going to individually edit
~500 patches for every specific maintainer's preference.


