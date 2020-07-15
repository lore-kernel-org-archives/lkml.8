Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6A5C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F722064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgGOJEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:04:14 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:43546 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729856AbgGOJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:04:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1BD8A182CED5B;
        Wed, 15 Jul 2020 09:04:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crowd16_1d14ee826ef8
X-Filterd-Recvd-Size: 2534
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Jul 2020 09:04:08 +0000 (UTC)
Message-ID: <128a9f7de9885257736b3bb2648ea90bcbc2c760.camel@perches.com>
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in
 gasket_core.c
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Zhixu Zhao <zhixu001@126.com>, rcy@google.com,
        rspringer@google.com, toddpoynor@google.com
Date:   Wed, 15 Jul 2020 02:04:06 -0700
In-Reply-To: <20200715083727.GY2549@kadam>
References: <20200617161127.32006-1-zhixu001@126.com>
         <20200714234440.27009-1-zhixu001@126.com>
         <20200715071748.GC2305231@kroah.com>
         <23ef3ca9616418b702df891443d0f4864edd58ff.camel@perches.com>
         <20200715075755.GA2516028@kroah.com> <20200715083727.GY2549@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 11:37 +0300, Dan Carpenter wrote:
> On Wed, Jul 15, 2020 at 09:57:55AM +0200, Greg KH wrote:
> > On Wed, Jul 15, 2020 at 12:24:22AM -0700, Joe Perches wrote:
> > > On Wed, 2020-07-15 at 09:17 +0200, Greg KH wrote:
> > > > On Wed, Jul 15, 2020 at 07:44:40AM +0800, Zhixu Zhao wrote:
> > > > > On Thu, Jun 18, 2020 at 12:11:27AM +0800, Zhixu Zhao wrote:
> > > > > > A coding alignment issue is found by checkpatch.pl.
> > > > > > Fix it by using a temporary for gasket_dev->bar_data[bar_num].
> > > > > > 
> > > > > > Signed-off-by: Zhixu Zhao <zhixu001@126.com>
> > > > > 
> > > > > Hi, there~
> > > > > 
> > > > > Does anybody have any further comments on this?
> > > > > Can it be merged?
> > > > 
> > > > I never saw the first version of this, are you sure it got sent to the
> > > > mailing list?  It's not in any archives anywhere.
> > > 
> > > I saw it.  It's here:
> > > https://lore.kernel.org/lkml/20200617161127.32006-1-zhixu001@126.com/
> > 
> > Ah, doh, sorry.
> > 
> > Zhixu, please address the comments given to you on the series and resend
> > it as a new version.
> 
> He responded but not as a reply to my email.  It turns out I made a
> mistake.
> 
> Anyway, just resend, Zhixu.

It's a pity a resend is being requested.

It'd be a better process if the original patch could
be applied via the link akin to a git pull.


