Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D44220637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCEQj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:39:58 -0500
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:33138 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbgCEQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:39:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 661E9100E7B4B;
        Thu,  5 Mar 2020 16:39:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: joke94_3982612ce0113
X-Filterd-Recvd-Size: 2689
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Mar 2020 16:39:55 +0000 (UTC)
Message-ID: <e31a520573d20552223a16cf18be0674972a3fb2.camel@perches.com>
Subject: Re: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        John Garry <john.garry@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Date:   Thu, 05 Mar 2020 08:38:20 -0800
In-Reply-To: <15ad3c68-4e67-0c92-a0e1-c62861673561@infradead.org>
References: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
         <e265e7df-fd8c-691f-389a-c0e0e377ed9e@huawei.com>
         <84f8504924380fc6380216d03d28a2285e3d106e.camel@perches.com>
         <55edba5c-78d6-12e2-eff6-f16c204badee@huawei.com>
         <15ad3c68-4e67-0c92-a0e1-c62861673561@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 08:21 -0800, Randy Dunlap wrote:
> On 3/5/20 8:20 AM, John Garry wrote:
> > On 05/03/2020 16:01, Joe Perches wrote:
> > > On Thu, 2020-03-05 at 15:53 +0000, John Garry wrote:
> > > > On 05/03/2020 15:15, Joe Perches wrote:
> > > > > commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
> > > > > controller driver") likely inadvertently used a select statement
> > > > > with a CONFIG_ prefix, remove the prefix.
> > > > > 
> > > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > 
> > > > It's a pity checkpatch can't pick this stuff up...
> > > 
> > > You are free to write a rule and submit a patch.
> > > 
> > 
> > I'm not opposed to the idea...

It'd be better I think to update the grammar
verification in the tool that parses these files.

see: scripts/kconfig/...

> > > The grammar is pretty hard to verify from a patch
> > > fragment though.
> > > 
> > > There are 2 existing nominal false positives.
> > > 
> > > $ git grep 'select\b.*\bCONFIG_' -- '*/Kconfig*'
> > > drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
> > > drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
> > 
> > Ah, that's in the help text. I guess that those can be ignored simply based on the indentation.

The grammar is per line whitespace independent, so not necessarily.

> > drivers/platform/chrome/Kconfig:        select CONFIG_MFD_CROS_EC_DEV
> > 
> > The 2nd looks like it's incorrect.
> 
> Yes, we just got a patch for that one today.

That's the reason I submitted this one.


