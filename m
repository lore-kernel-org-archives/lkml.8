Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E4BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67F522597
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgGNRME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:12:04 -0400
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:50450 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726169AbgGNRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:12:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0C492180A812A;
        Tue, 14 Jul 2020 17:12:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ship30_110333026ef2
X-Filterd-Recvd-Size: 1692
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Jul 2020 17:12:02 +0000 (UTC)
Message-ID: <8d7ebe02cfbff19f31f6ac1ce098f98d8ba1850a.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Allow '+' in compatible strings
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jul 2020 10:12:00 -0700
In-Reply-To: <CAL_Jsq+c5+QFpdiNK4K=ROPAhxp=SMYS6iRFuJKooin=NbCiXw@mail.gmail.com>
References: <20200714094141.147418-1-thierry.reding@gmail.com>
         <CAL_Jsq+c5+QFpdiNK4K=ROPAhxp=SMYS6iRFuJKooin=NbCiXw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-14 at 10:21 -0600, Rob Herring wrote:
> On Tue, Jul 14, 2020 at 3:41 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The current checks will interpret a '+' character as special because
> > they use regular expression matching. Escape the '+' character if it
> > appears in a compatible string.
> 
> Ugg, looks like c6x really liked using '+'. Might need to be added in
> schema checks, too. Not sure offhand.

These are the non alphanumeric characters used in .dts and .dtsi files
with 'compatible=' strings

- 44115
, 32035
. 1131
_ 259
+ 46
/ 18
) 5
( 5

So it looks like

	"("
	")"

need to be added and escaped too

?


