Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F90C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190F720725
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbgDPCsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:48:46 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:47726 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732153AbgDPCsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:48:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B8401100E7B42;
        Thu, 16 Apr 2020 02:48:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beef17_2e584604c5507
X-Filterd-Recvd-Size: 1880
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 Apr 2020 02:48:38 +0000 (UTC)
Message-ID: <c8c8f37f20625922eb114574c544ebb6332ac025.camel@perches.com>
Subject: Re: [PATCH v3 0/3] lib/vsprintf: Introduce %ptT for time64_t
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 15 Apr 2020 19:46:27 -0700
In-Reply-To: <20200416023425.GB30641@jagdpanzerIV.localdomain>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
         <20200415132011.624f35f6@gandalf.local.home>
         <20200416023425.GB30641@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-16 at 11:34 +0900, Sergey Senozhatsky wrote:
> On (20/04/15 13:20), Steven Rostedt wrote:
> > On Wed, 15 Apr 2020 20:00:43 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > It is a logical continuation of previously applied %ptR for struct rtc_time.
> > > We have few users of time64_t that would like to print it.
> > > 
> > > Andrew, since Petr can't pay attention on this perhaps it can be passed thru
> > > your tree?
> > > 
> > > Sergey, Steven, what do you think?
> > 
> > I'm fine with these changes. Sergey, what do you think?
> 
> I'm not against it in general, I'm slightly concerned if "two users"
> is enough of a justification for new vsprintf() specifier.

Me too as separate functions could be used here.


