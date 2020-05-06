Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625A6C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477822078C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgEFU7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:59:52 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:46778 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728535AbgEFU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:59:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1DF73182D31F0;
        Wed,  6 May 2020 20:59:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scale25_72f58b20c6452
X-Filterd-Recvd-Size: 2727
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 May 2020 20:59:49 +0000 (UTC)
Message-ID: <303818f9b6dc16880b3bc715c16144e4245022b8.camel@perches.com>
Subject: Re: MAINTAINERS: Wrong ordering in S390 PCI SUBSYSTEM
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 06 May 2020 13:59:48 -0700
In-Reply-To: <alpine.DEB.2.21.2005062232330.23358@felia>
References: <alpine.DEB.2.21.2005060741520.7719@felia>
         <CAHp75VeNiuJ7QXvNO2=W_TjEjjK3xRbg0-Don6HkSOHV5LXRbA@mail.gmail.com>
         <alpine.DEB.2.21.2005062232330.23358@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-06 at 22:37 +0200, Lukas Bulwahn wrote:
> 
> On Wed, 6 May 2020, Andy Shevchenko wrote:
> 
> > On Wed, May 6, 2020 at 8:46 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > Hi Pierre,
> > > 
> > > with your commit de267a7c71ba ("s390/pci: Documentation for zPCI"),
> > > visible on next-20200505, ./scripts/checkpatch.pl -f MAINTAINERS
> > > complains:
> > > 
> > > WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
> > > #14723: FILE: MAINTAINERS:14723:
> > > +F:     drivers/pci/hotplug/s390_pci_hpc.c
> > > +F:     Documentation/s390/pci.rst
> > > 
> > > 
> > > This is due to wrong ordering of the entries in your submission. If you
> > > would like me to send you a patch fixing that, please just let me know.
> > > 
> > > It is a recent addition to checkpatch.pl to report ordering problems in
> > > MAINTAINERS, so you might have not seen that at submission time.
> > 
> > Why not to send a patch?
> > Same for the rest of similar mails from you.
> > 
> 
> Well, the checkpatch warning is new, so I want to find out if and make 
> sure that the involved developers are generally okay getting those patches 
> or if there is a better way handling those patches to MAINTAINERS.
> 
> I do not expect that there are too many further cases of this warning 
> appearing soon in linux-next now that checkpatch already warns about it.

Hey Lukas.

Don't expect _too_ much as checkpatch has for a long time
has done add/delete/move tests for files and emitted a
"Does MAINTAINERS need updating" message that most have
ignored or not seen as many patches are submitted without
running checkpatch.


