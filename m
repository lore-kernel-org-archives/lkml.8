Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4286FC0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C9120753
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgCLARA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:17:00 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:34410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731448AbgCLAQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:16:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E1657837F27B;
        Thu, 12 Mar 2020 00:16:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tree25_1f9cfc6638042
X-Filterd-Recvd-Size: 2861
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 00:16:57 +0000 (UTC)
Message-ID: <2a080d9c5dc6206d9a255410a61d1d9cce26d944.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: sdio_halinit:
 Remove unnecessary conditions
From:   Joe Perches <joe@perches.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Date:   Wed, 11 Mar 2020 17:15:14 -0700
In-Reply-To: <1CF27D55-EEB4-4A75-B767-A30845BD5E1B@gmail.com>
References: <20200311133811.2246-1-shreeya.patel23498@gmail.com>
         <0fed25f914c6f39b024dd3bbc4f11892c40f4a60.camel@perches.com>
         <1CF27D55-EEB4-4A75-B767-A30845BD5E1B@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-12 at 03:58 +0530, Shreeya Patel wrote:
> Hey Joe,
> 
> On March 11, 2020 10:56:29 PM GMT+05:30, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-03-11 at 19:08 +0530, Shreeya Patel wrote:
> > > Remove if and else conditions since both are leading to the
> > > initialization of "valueDMATimeout" and "valueDMAPageCount" with
> > > the same value.
> > 
> > You might consider removing the
> > 	/* Timeout value is calculated by 34 / (2^n) */
> > comment entirely as it doesn't make much sense.
> > 
> 
> You want me to remove the other comments as well?
> Since Julia suggested in another email that the comments are not useful if we are removing the condition since they were applied to only one branch ( i.e. "if" branch )

It's not an either/or/both situation.

Code like:

	if (test) {
		[block 1]
	} else {
		[block 2]
	}

where the contents of block 1 and block 2 are identical
exist for many reasons.  All of them need situational
analysis to determine what the right thing to do is.

Sometimes it's a defect from a copy/paste where some other
code was intended on one of the blocks and so that one path
has a defect somewhere and actually needs to be changed.

Sometimes the blocks were originally different, but some
code was removed from one of the blocks that lead to the
blocks being identical.  Those can be consolidated.

Sometimes test can be removed, sometimes not.

For hardware drivers like this, it's sometimes useful to
look at the latest code from the vendor and sometimes it's
better to ask the vendor what the right thing do is.

It does appear in this case that the branches should be
consolidated and comments in both branches removed.


