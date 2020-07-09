Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DF0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A872073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGIIYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:24:08 -0400
Received: from foss.arm.com ([217.140.110.172]:42260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgGIIYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:24:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ECF531B;
        Thu,  9 Jul 2020 01:24:07 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55AA3F887;
        Thu,  9 Jul 2020 01:24:06 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:24:04 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/4] firmware: arm_scmi: Fix scmi_event_header fields
 typing
Message-ID: <20200709082348.GA20219@e119603-lin.cambridge.arm.com>
References: <20200708122248.52771-1-cristian.marussi@arm.com>
 <20200708122248.52771-3-cristian.marussi@arm.com>
 <CAK8P3a3mH4h9=MZiLmqk=YY8_pzQnUUvsvcL1TZQ6uJEdGUf=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3mH4h9=MZiLmqk=YY8_pzQnUUvsvcL1TZQ6uJEdGUf=w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 10:38:08PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 8, 2020 at 2:24 PM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Drop size_t in favour of fixed size u32 for consistency and shuffle
> > around fields definitions to minimize implicit padding.
> >
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> As you still have implicit padding at the end, I'd either make
> that explicit now, or leave the __packed attribute.

Do you mean expliciting that with a comment, right ? being the last member 'payld'
a flexible array must be the last in order to even compile.

I'm a bit confused anyway on how the trailing padding works on a struct like
this which ends with a flexible array definition, so I was expecting that the
trailing pads would have made no difference, given that it's used to basically
give some know layout to a blob of data via casting...

Thanks

Cristian

> 
> The payld_sz is not actually force to be misaligned with the
> reordered layout, which is what's most important.
> 
>      Arnd
