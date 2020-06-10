Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB059C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81E32087E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFJIpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:45:45 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:58062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726081AbgFJIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:45:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1E1A118041BE6;
        Wed, 10 Jun 2020 08:45:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spot20_41123cb26dc9
X-Filterd-Recvd-Size: 1788
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 08:45:42 +0000 (UTC)
Message-ID: <9fcbcf91beb884ef8eac64471fe769edebce660c.camel@perches.com>
Subject: Re: Re: [PATCH v3 1/2] checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, apw@canonical.com,
        colin.king@canonical.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Date:   Wed, 10 Jun 2020 01:45:41 -0700
In-Reply-To: <20200610080102.17456-1-sjpark@amazon.com>
References: <20200610080102.17456-1-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 10:01 +0200, SeongJae Park wrote:
> On Wed, 10 Jun 2020 00:13:42 -0700 Joe Perches <joe@perches.com> wrote:
[]
> > This is a direct copy of the spelling dictionary
> > loading code, so maybe these could be consolidated.
> 
> Agreed, how about below one?
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 524df88f9364..226f24e1f1f3 100755
[]
> +sub read_word_corrections {
> +	my ($file) = @_;
> +	my $suspects;
> +	my %fixes;

Right.

But I think this should take a hash reference
as the second argument so the complete hash
isn't created and returned.

[]

> +# Load deprecated terms and build regular expression list.
> +my %deprecated_terms_fix = read_word_corrections($deprecated_terms_file);

So this might be something like:

my %deprecated_terms;
read_word_corrections($deprecated_terms_file, \%deprecated_terms);

etc...


