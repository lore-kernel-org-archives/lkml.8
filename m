Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27815C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FDB208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgG0ORZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:17:25 -0400
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:50792 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731012AbgG0ORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:17:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A86F2182CF670;
        Mon, 27 Jul 2020 14:17:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: park62_3b1655626f61
X-Filterd-Recvd-Size: 2448
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jul 2020 14:17:11 +0000 (UTC)
Message-ID: <a594ffa8112a9696260d8a01fa7941b125cf6226.camel@perches.com>
Subject: Re: [PATCH v2] spi: spi-topcliff-pch: drop call to wakeup-disable
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Date:   Mon, 27 Jul 2020 07:17:10 -0700
In-Reply-To: <CAHp75Vfuw1rAYxy41hVKNaqZQg4W-_Y=6St-X0yb5O4zN6qCfw@mail.gmail.com>
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
         <20200727131742.82289-1-vaibhavgupta40@gmail.com>
         <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com>
         <20200727134646.GA114726@gmail.com>
         <CAHp75Vfuw1rAYxy41hVKNaqZQg4W-_Y=6St-X0yb5O4zN6qCfw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-27 at 17:08 +0300, Andy Shevchenko wrote:
> Joe, can we amend checkpatch to at least shout about simple typos in
> the tag area?
> See below for the context.
> 
> On Mon, Jul 27, 2020 at 4:48 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> > On Mon, Jul 27, 2020 at 04:38:40PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 27, 2020 at 4:21 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> 
> ...
> 
> > > > Fix: f185bcc77980("spi: spi-topcliff-pch: use generic power management")
> > > 
> > > Fixes: and missed space.
> 
> (1)
> 
> > > > Reported by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > 
> > > Missed dash.
> > > Does checkpatch complain?
> > No, I got this message:
> > "* .patch has no obvious style problems and is ready for submission"
> 
> (2)

Not reasonably so far as I can tell, no.

The test for a signature uses -by:

Fix: starting a line seems a reasonable thing
that someone might want to have in a commit
message.


