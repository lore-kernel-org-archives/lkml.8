Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09646C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45832086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733307AbgGWBCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:02:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35547 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729423AbgGWBCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:02:39 -0400
Received: (qmail 1334263 invoked by uid 1000); 22 Jul 2020 21:02:38 -0400
Date:   Wed, 22 Jul 2020 21:02:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Subject: Re: [PATCH] usb: gadget: net2280: fix memory leak on probe error
 handling paths
Message-ID: <20200723010238.GB1333715@rowland.harvard.edu>
References: <20200721201558.20069-1-novikov@ispras.ru>
 <20200722141741.GA1310843@rowland.harvard.edu>
 <2097231595446720@mail.yandex.ru>
 <35a367f7d71014cf9a6890abc248e18a3d07bc35.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a367f7d71014cf9a6890abc248e18a3d07bc35.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:59:06AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2020-07-22 at 22:56 +0300, Evgeny Novikov wrote:
> > Hi Alan,
> > 
> > I have neither an appropriate hardware nor an experience to deal with
> > issues that you mentioned. Our framework does not allow to detect
> > them as well at the moment. At last, it seems that rather many
> > drivers can suffer from these issues. So, it would be much better if
> > somebody else will suggest necessary fixes and test them carefully.
> > 
> > BTW, you have already discussed the race within net2280_remove() with
> > my colleague about 3 years ago. But you did not achieve a consensus
> > at that time and no fixes were made after all.
> > 
> > Anyway, one can consider both issues independently on the one fixed
> > by the patch.
> 
> FYI. It looks like I'm likely to resume my work on that driver in the
> next few weeks in which case I could probably look into these Alan.

That probably won't be needed, although thanks for the offer.  I'll CC 
you on any patches when they are submitted.

Alan Stern
