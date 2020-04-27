Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70641C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5735C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgD0O4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:56:03 -0400
Received: from v6.sk ([167.172.42.174]:60332 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0O4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:56:02 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 49CE4610A7;
        Mon, 27 Apr 2020 14:55:30 +0000 (UTC)
Date:   Mon, 27 Apr 2020 16:55:27 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mfd: Add ENE KB3930 Embedded Controller driver
Message-ID: <20200427145527.GA71654@furthur.local>
References: <20200424221123.106527-1-lkundrak@v3.sk>
 <20200427064824.GB3559@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427064824.GB3559@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 07:48:24AM +0100, Lee Jones wrote:
> On Sat, 25 Apr 2020, Lubomir Rintel wrote:
> 
> > Hi,
> > 
> > please take a look at the following patch set and consider applying it
> > to the MFD tree. It a new driver with DT binding documentation changes,
> > utilized by the LED driver submitted here:
> > 
> > https://lore.kernel.org/lkml/20200424220240.106055-1-lkundrak@v3.sk/
> 
> What is this?  The subject suggests this is a cover-letter for a
> patch-set, but the patches are not attached to it.  If this is the
> case, please ensure that you send it --threaded using
> 
>  `git send-email`
> 
> If it's just a random plea to go look at some set posted onto a
> mailing list without me on Cc, then no.  Please send the set again,
> properly, with me listed as a recipient.

It indeed is a cover letter for a patch set, it had the patches chained to
it, with you as a recipient, and it was sent with git send-email. If you
haven't recevied them then I have no idea why. I do apologize in case it's
my fault.

Perhaps your spam filter dropped them? In that case I'm wondering what
could bump the spam score for the patches, but not the cover letter.
In any case, the archive received them:

https://lore.kernel.org/lkml/20200424221123.106527-1-lkundrak@v3.sk/

I wouldn't mind resending the messages, but I'd prefer to understand
what happened to them first.

Lubo
