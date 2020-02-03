Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B42C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B5B20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBCKl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:58 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:50236 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgBCKl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:41:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D32D5121A;
        Mon,  3 Feb 2020 10:41:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: range25_4ab6e8725fd55
X-Filterd-Recvd-Size: 2515
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon,  3 Feb 2020 10:41:53 +0000 (UTC)
Message-ID: <5f67af4339e0b9b56b43fb78ebab73e05009e307.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: exfat: remove DOSNAMEs.
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>,
        devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        linux-kernel@vger.kernel.org,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 03 Feb 2020 02:40:43 -0800
In-Reply-To: <20200203094601.GA3040887@kroah.com>
References: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
         <20200203080532.GF8731@bombadil.infradead.org>
         <20200203081559.GA3038628@kroah.com>
         <20200203082938.GG8731@bombadil.infradead.org>
         <20200203094601.GA3040887@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-03 at 09:46 +0000, Greg Kroah-Hartman wrote:
> On Mon, Feb 03, 2020 at 12:29:38AM -0800, Matthew Wilcox wrote:
> > On Mon, Feb 03, 2020 at 08:15:59AM +0000, Greg Kroah-Hartman wrote:
> > > On Mon, Feb 03, 2020 at 12:05:32AM -0800, Matthew Wilcox wrote:
> > > > On Tue, Feb 04, 2020 at 01:31:17AM +0900, Tetsuhiro Kohada wrote:
> > > > > remove 'dos_name','ShortName' and related definitions.
> > > > > 
> > > > > 'dos_name' and 'ShortName' are definitions before VFAT.
> > > > > These are never used in exFAT.
> > > > 
> > > > Why are we still seeing patches for the exfat in staging?
> > > 
> > > Because people like doing cleanup patches :)
> > 
> > Sure, but I think people also like to believe that their cleanup patches
> > are making a difference.  In this case, they're just churning code that's
> > only weeks away from deletion.
> > 
> > > > Why are people not working on the Samsung code base?
> > > 
> > > They are, see the patches on the list, hopefully they get merged after
> > > -rc1 is out.
> > 
> > I meant the cleanup people.  Obviously _some_ people are working on the
> > Samsung codebase.
> 
> We can't tell people to work on :)

That's more an argument to remove exfat from staging
sooner than later.


