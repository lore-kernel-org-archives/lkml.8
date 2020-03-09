Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28127C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFD72146E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgCIXOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:14:08 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:38113 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgCIXOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:14:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2F0F96125;
        Mon,  9 Mar 2020 23:14:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: vest79_5dc54df15e11b
X-Filterd-Recvd-Size: 2015
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 23:14:04 +0000 (UTC)
Message-ID: <69ed8a468b3e4776d277292a2e4b2f9b3c266f23.camel@perches.com>
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 09 Mar 2020 16:12:24 -0700
In-Reply-To: <alpine.DEB.2.21.2003092035300.2953@felia>
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
         <CABXOdTcrxoBCz24Ap=YJYZnr+oLAmaR10xZ9ar2mYbE1=RAoug@mail.gmail.com>
         <5129f7dbd8506cc9fd5a8f76dc993d789566af6c.camel@perches.com>
         <alpine.DEB.2.21.2003090702440.3325@felia>
         <20200309070534.GA4093795@kroah.com>
         <alpine.DEB.2.21.2003092035300.2953@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 22:03 +0100, Lukas Bulwahn wrote:
> I am starting with the "bigger" clustered files in drivers, and then try 
> > > to look at files in include and Documentation/ABI/.

If you want to spend the time tracking stuff down,
it may be best to to
start with include/

> > > Here is a rough statistics on how many files from each directory are in
> > > THE REST:
> > > 
> > >    1368 include

There are very likely some files there that should
actually be listed as part of a subsystem.

> > >     327 lib

Not many that aren't trivial or ancient.

> > >     321 Documentation

Probably a few

> > >     100 drivers

What's not already maintained is probably ancient.

Everything else may not matter much.

