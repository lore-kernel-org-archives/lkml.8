Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC57C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71BF206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFJWW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:22:58 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:59178 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726374AbgFJWW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:22:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 77216180431E1;
        Wed, 10 Jun 2020 22:22:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: horse92_09036d126dce
X-Filterd-Recvd-Size: 2747
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 22:22:56 +0000 (UTC)
Message-ID: <6e2e2095f1b6839ec78d41233fa8d908d1bd2bbe.camel@perches.com>
Subject: Re: [PATCH] checkpatch: ignore CamelCase for inttypes.h format
 specifiers
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 15:22:55 -0700
In-Reply-To: <a3d5f2c5-40fb-c97d-8365-423213926e89@broadcom.com>
References: <20200610203307.9344-1-scott.branden@broadcom.com>
         <1b2d9ead79a5a035a287b7ecba8655b2c633d5cd.camel@perches.com>
         <a3d5f2c5-40fb-c97d-8365-423213926e89@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 14:48 -0700, Scott Branden wrote:
> 
> On 2020-06-10 2:09 p.m., Joe Perches wrote:
> > On Wed, 2020-06-10 at 13:33 -0700, Scott Branden wrote:
> > > Ignore CamelCase for inttypes.h for fixed integer types format specifiers.
> > > (ex. PRIx32 for uint32_t).
> > Personally, I don't like those.
> Checkpatch is run against a lot of code outside of the linux kernel but 
> following linux coding style.

I know.  I don't have any strong feeling about this either.

But _this_ checkpatch is specifically for the linux-kernel.

I just don't want to encourage a bunch of uses of these
somewhat useless defines internal to linux-kernel sources.

> There is nothing personal about this, they are the format specifiers in 
> inttypes.h for fixed width types .

True.  It's impersonal to me too.

> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > > @@ -5157,6 +5157,8 @@ sub process {
> > >   			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
> > >   #Ignore Page<foo> variants
> > >   			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
> > > +#Ignore inttypes.h scanf/printf format specifiers for fixed size integer types
> > > +			    $var !~ /^(?:PRI|SCN)[dxoui](8|16|32|64|PTR|MAX)?$/ &&

There are missing format specifiers.
If this is done, the test should be against a variable

Something like:

our $inttype_format = qr{(?x:
		(?:PRI|SCN)
		[diouxX]
		(?:FAST|LEAST)?
		(?:8|16|32|64|MAX|PTR)
};

btw: what about 24, 48, 96, 128 and 256?

> > >   #Ignore SI style variants like nS, mV and dB
> > >   #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
> > >   			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&

