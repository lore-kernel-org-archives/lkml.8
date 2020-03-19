Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1348C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBCC20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCSJcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:32:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43072 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgCSJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:32:06 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 3cc464a615647ce3; Thu, 19 Mar 2020 10:32:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pm tree
Date:   Thu, 19 Mar 2020 10:32:03 +0100
Message-ID: <3605097.fqFkneqFLU@kreacher>
In-Reply-To: <20200319164259.34a3df52@canb.auug.org.au>
References: <20200317185252.3cfeecde@canb.auug.org.au> <20200318231837.4041cd8f@canb.auug.org.au> <20200319164259.34a3df52@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 19, 2020 6:42:59 AM CET Stephen Rothwell wrote:
> 
> --Sig_/Pgc07lYg4LlrlRQi0UWj2DK
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi Stephen,
> 
> On Wed, 18 Mar 2020 23:18:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
> wrote:
> >
> > Hi Colin,
> >=20
> > On Wed, 18 Mar 2020 11:52:00 +0000 Colin Ian King <colin.king@canonical.c=
> om> wrote:
> > > =20
> > > > This was fixed today (by including linux/ioh), but the latest update =
> to
> > > > the pm tree has removed that include again.
> > > >    =20
> > > Hopefully it won't be reverted from linux-next? =20
> >=20
> > Linux-next just contains what its constituent trees contain each day ...
> 
> I have had to revert commit
> 
>   08c07cefb304 ("ACPI: sysfs: copy ACPI data using io memory copying")

Dropped from linux-pm now and sorry for the breakage.

Colin, please resend this one when all of the dependencies are in place in the
Linus' tree.

Thanks!



