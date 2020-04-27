Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A9DC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD65D206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgD0ROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:14:31 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:36250 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgD0ROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:14:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 918CD180A7352;
        Mon, 27 Apr 2020 17:14:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: land80_616b262899562
X-Filterd-Recvd-Size: 1600
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 17:14:29 +0000 (UTC)
Message-ID: <ed61ea55a275e520e6245c9fe33f2f076d5cbe3c.camel@perches.com>
Subject: Re: [PATCH 2/2] drivers: staging: rts5208: rtsx.c fix Unbalanced
 braces around else-if statements
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Apr 2020 10:14:28 -0700
In-Reply-To: <20200427160430.GA3549342@kroah.com>
References: <20200427152442.26597-1-john.oldman@polehill.co.uk>
         <20200427152442.26597-2-john.oldman@polehill.co.uk>
         <20200427160430.GA3549342@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 18:04 +0200, Greg KH wrote:
> On Mon, Apr 27, 2020 at 04:24:42PM +0100, John Oldman wrote:
> > Make a better job of fixing coding style issues, this time fixing
> > all blocks as per Joe Perches' comment.
[]
> Why is this not just one patch?

Hi John.

These _should_ be one patch.

The subject line should be versioned and affirmative like:

Subject: [PATCH V2] staging: rts5208: rtsx: Use balanced braces for if/else if blocks

The subject should not include "fix", as this is a coding style
issue and not really a logical defect.

Lastly the "this time fixing" bit should be below the --- line.

cheers, Joe

