Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10B8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 04:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C661F2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 04:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgHUEZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 00:25:07 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:49976 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725270AbgHUEZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 00:25:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9DBFB173086C;
        Fri, 21 Aug 2020 04:25:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheet48_5e1546627036
X-Filterd-Recvd-Size: 1931
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 04:25:04 +0000 (UTC)
Message-ID: <9230a7f0b80b4a984f18c979ca3c703edd7d6f98.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Fix the usage of capture group ( ... )
From:   Joe Perches <joe@perches.com>
To:     Mrinal Pandey <mrinalmni@gmail.com>, apw@canonical.com,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 20 Aug 2020 21:25:03 -0700
In-Reply-To: <20200820045232.tmun7jlppeeesg4p@mrinalpandey>
References: <20200714032352.f476hanaj2dlmiot@mrinalpandey>
         <alpine.DEB.2.21.2007300746330.13710@felia>
         <a2773089a844047407855f2da7bd72c2970d2e6b.camel@perches.com>
         <20200820045232.tmun7jlppeeesg4p@mrinalpandey>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 10:22 +0530, Mrinal Pandey wrote:
> On 20/07/30 12:31AM, Joe Perches wrote:
> > On Thu, 2020-07-30 at 07:58 +0200, Lukas Bulwahn wrote:
> > > Hi Joe,
> > > 
> > > did you see this quick fix to checkpatch.pl? Can you comment on the 
> > > commit and can we get a quick ack on that fix, please?
> > 
> > Yes, in a bit.
> > 
> > > General question on patches for ./scripts/checkpatch.pl:
> > > How do they travel to Linus?
> > 
> > Generally via Andrew Morton.
> > 
> > > Do you pick those patches and provide them to Andrew Morton?
> > > Or do you just ack them and we need to send them to Andrew Morton to get 
> > > them into mainline?
> > 
> > Generally, ack and forward.

https://lore.kernel.org/lkml/20200714032352.f476hanaj2dlmiot@mrinalpandey/

Andrew, can you pick up this patch please.

Thanks

