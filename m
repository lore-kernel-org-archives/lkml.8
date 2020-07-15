Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEF1C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA73206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgGOHYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:24:25 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:38350 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728888AbgGOHYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:24:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 7CD20837F24D;
        Wed, 15 Jul 2020 07:24:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stew37_580af1526ef7
X-Filterd-Recvd-Size: 1850
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Jul 2020 07:24:23 +0000 (UTC)
Message-ID: <23ef3ca9616418b702df891443d0f4864edd58ff.camel@perches.com>
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in
 gasket_core.c
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>, Zhixu Zhao <zhixu001@126.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        rcy@google.com, rspringer@google.com, toddpoynor@google.com,
        dan.carpenter@oracle.com
Date:   Wed, 15 Jul 2020 00:24:22 -0700
In-Reply-To: <20200715071748.GC2305231@kroah.com>
References: <20200617161127.32006-1-zhixu001@126.com>
         <20200714234440.27009-1-zhixu001@126.com>
         <20200715071748.GC2305231@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 09:17 +0200, Greg KH wrote:
> On Wed, Jul 15, 2020 at 07:44:40AM +0800, Zhixu Zhao wrote:
> > On Thu, Jun 18, 2020 at 12:11:27AM +0800, Zhixu Zhao wrote:
> > > A coding alignment issue is found by checkpatch.pl.
> > > Fix it by using a temporary for gasket_dev->bar_data[bar_num].
> > > 
> > > Signed-off-by: Zhixu Zhao <zhixu001@126.com>
> > 
> > Hi, there~
> > 
> > Does anybody have any further comments on this?
> > Can it be merged?
> 
> I never saw the first version of this, are you sure it got sent to the
> mailing list?  It's not in any archives anywhere.

I saw it.  It's here:
https://lore.kernel.org/lkml/20200617161127.32006-1-zhixu001@126.com/

> Also, 3 days is really fast for a simple coding style cleanup to be
> worried about.  Give it usually at least 2 weeks.

Originally sent June 17.



