Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F637C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BEF206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgHDA64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:58:56 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:35118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbgHDA6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:58:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8E29C181D330D;
        Tue,  4 Aug 2020 00:58:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rat04_10160b926fa2
X-Filterd-Recvd-Size: 2290
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue,  4 Aug 2020 00:58:53 +0000 (UTC)
Message-ID: <5f7a5ec560775f3c43fdbb6ac93f858d8b5e37f3.camel@perches.com>
Subject: Re: [PATCH] via-velocity: Add missing KERN_<LEVEL> where needed
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>
Cc:     romieu@fr.zoreil.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 17:58:52 -0700
In-Reply-To: <20200803.154248.2020214547846261577.davem@davemloft.net>
References: <e45d15ad36a0c9a994b5a1136c72518215c99f7a.camel@perches.com>
         <20200803.154248.2020214547846261577.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-03 at 15:42 -0700, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Sat, 01 Aug 2020 08:51:03 -0700
> 
> > Link status is emitted on multiple lines as it does not use
> > KERN_CONT.
> > 
> > Coalesce the multi-part logging into a single line output and
> > add missing KERN_<LEVEL> to a couple logging calls.
> > 
> > This also reduces object size.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> The real problem is the whole VELOCITY_PRT() private debug log
> control business this driver is doing.
> 
> It should be using the standard netdev logging level infrastructure.
> 
> > +                     VELOCITY_PRT(MSG_LEVEL_INFO, KERN_INFO "set Velocity to forced full mode\n");
> 
> You can't tell me that this "KERN_INFO blah blah blah" is really
> something we should add more of these days, right?
> 
> If you're going to improve this driver's logging code please do
> so by having it use the standard interfaces.

The existing code is not great and definitely odd.

This is just a bug fix until such time as it's better.

VELOCITY_PRT is not just used for debugging.

The default is output if MSG_LEVEL_INFO and
there's a control for further output.

This is just fixing Linus' change for KERN_CONT
uses on separate lines from awhile ago.

It'd be nice if a via maintainer actually fixed it.


