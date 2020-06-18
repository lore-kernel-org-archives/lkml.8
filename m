Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA61C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F45208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgFRFwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:52:22 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:52010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgFRFwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:52:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1D4131DF8;
        Thu, 18 Jun 2020 05:52:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feast20_401413c26e0d
X-Filterd-Recvd-Size: 2106
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Jun 2020 05:52:19 +0000 (UTC)
Message-ID: <5dc6fb7ebfd1d38079d63e54d6fb2b05fa69001a.camel@perches.com>
Subject: Re: +
 scripts-deprecated_terms-recommend-denylist-allowlist-instead-of-blacklist-whitelist.patch
 added to -mm tree
From:   Joe Perches <joe@perches.com>
To:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        sj38.park@gmail.com, mpe@ellerman.id.au, jslaby@suse.cz,
        colin.king@canonical.com, sjpark@amazon.de,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Jun 2020 22:52:18 -0700
In-Reply-To: <20200617213222.OcDiV%akpm@linux-foundation.org>
References: <20200617213222.OcDiV%akpm@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-17 at 14:32 -0700, akpm@linux-foundation.org wrote:
> The patch titled
>      Subject: scripts/deprecated_terms: recommend denylist/allowlist instead of blacklist/whitelist
> has been added to the -mm tree.  Its filename is
>      scripts-deprecated_terms-recommend-denylist-allowlist-instead-of-blacklist-whitelist.patch
[]
> ------------------------------------------------------
> From: SeongJae Park <sjpark@amazon.de>
> Subject: scripts/deprecated_terms: recommend denylist/allowlist instead of blacklist/whitelist
> 
> This commit recommends that patches replace 'blacklist' and 'whitelist'
> with 'denylist' and 'allowlist', because the new suggestions are
> incontrovertible, doesn't make people hurt, and are more self-explanatory.
[]
> --- a/scripts/deprecated_terms.txt~scripts-deprecated_terms-recommend-denylist-allowlist-instead-of-blacklist-whitelist
> +++ a/scripts/deprecated_terms.txt
> @@ -3,3 +3,5 @@
>  # The format of each line is:
>  # deprecated||suggested
>  #
> +blacklist||denylist
> +whitelist||allowlist

I think this is a poor use of deprecated terms
as it has nothing to do with skin color.


