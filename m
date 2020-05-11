Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA854C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A388A20708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgEKQFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:05:09 -0400
Received: from foss.arm.com ([217.140.110.172]:35334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgEKQFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:05:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D66A30E;
        Mon, 11 May 2020 09:05:07 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [10.57.42.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4638F3F305;
        Mon, 11 May 2020 09:05:06 -0700 (PDT)
Date:   Mon, 11 May 2020 17:05:04 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [RFC PATCH 0/3] SCMI System Power Support
Message-ID: <20200511160504.GA17648@e119603-lin.cambridge.arm.com>
References: <20200427210806.37422-1-cristian.marussi@arm.com>
 <CAL_JsqKV8j8Jm_7B7no6SsZ9AAv=WjqOx9EmCp3fomUXRO-FzQ@mail.gmail.com>
 <DB7PR08MB3657577B2251084FF2B4A0EF9EAA0@DB7PR08MB3657.eurprd08.prod.outlook.com>
 <CAL_JsqK6+2c9jXfsipqH0qakTGrszSGN4+kZqGstOmkWj40JGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK6+2c9jXfsipqH0qakTGrszSGN4+kZqGstOmkWj40JGQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:11:45PM -0500, Rob Herring wrote:
> On Thu, Apr 30, 2020 at 12:23 PM Cristian Marussi
> <Cristian.Marussi@arm.com> wrote:
> >
> > Hi Rob
> >
> > thanks for the feedback.
> 
> Plain text for maillists please.
> 
Yes I know, sorry, used wrong client by mistake.

> >
> > > On top of this a new SCMI driver has been developed which registers for
> > > ----
> > > such System Power notification and acts accordingly to satisfy such
> > > plaform system-state transition requests that can be of forceful or
> > > graceful kind.
> >
> > > I needed this 7 years ago. :) (hb_keys_notifier in
> > > arch/arm/mach-highbank/highbank.c)
> >
> > ...better later than never
> >
> > > Such alternative, if deemed worth, should clearly be configurable via DT
> > > (also in terms of which signals to use), BUT all of this work is not done
> > > in this series: and that's the reason for the RFC tag: does it make sense
> > > to add such a configurable additional option ?
> >
> > >Which process signal to use in DT? I don't think so.
> >
> > ... beside the awkward bad idea of mine of configuring it via DT
> > (which I'll drop possibly using modparams for this config), my question
> > was more about if it makes sense at all to have another alternative mechanism
> > (other than orderly_poweroof/reboot)) based on signals to gracefully ask userspace
> > to shutdown
> 
> gregkh will tell you no to module params.
> 
> If the signal is not standard, then we probably shouldn't go that route.
> 

Before this reply, I posted a v2 with alternative signal-method configurable by modparam;
it's anyway a small addition which I can easily remove in a v3.

Thanks

Cristian
