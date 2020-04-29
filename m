Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD3C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE78520787
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD2Ccw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:32:52 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:44880 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2Ccw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:32:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 20E12180A7351;
        Wed, 29 Apr 2020 02:32:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cause42_52f75aad21c32
X-Filterd-Recvd-Size: 3266
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Apr 2020 02:32:50 +0000 (UTC)
Message-ID: <8e225a3166998c441049e9561703f357919d5499.camel@perches.com>
Subject: Re: [PATCH 2/2] gpio: Make "offset" and "unsigned int", not just
 "unsigned"
From:   Joe Perches <joe@perches.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     LinusW <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Apr 2020 19:32:48 -0700
In-Reply-To: <CAD=FV=VtUEgwwB6C4GhTKx3TP37=i4shtwbG41r=wkELcpNmyQ@mail.gmail.com>
References: <20200428172322.1.I396f351e364f3c09df7c7606e79abefb8682c092@changeid>
         <20200428172322.2.Iacb3c8152c3cf9015a91308678155a578b0cc050@changeid>
         <a23b7a97f349e6f74b993a4e127564ad3f7d6929.camel@perches.com>
         <CAD=FV=Us6LyfgeXvxnqq+KhHN1djok1y+W_xzSb-KGFy2wgEMg@mail.gmail.com>
         <bc5c8165908facbb4781b2f29903dfacdf625e83.camel@perches.com>
         <CAD=FV=VtUEgwwB6C4GhTKx3TP37=i4shtwbG41r=wkELcpNmyQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-28 at 18:04 -0700, Doug Anderson wrote:
> Hi,

<slurring but replying with hi again...>

> On Tue, Apr 28, 2020 at 5:57 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2020-04-28 at 17:50 -0700, Doug Anderson wrote:
> > > $ git grep -P -n '\bunsigned\s+(?!int|long)' include/linux/gpio/driver.h
> > include/linux/gpio/driver.h:352:                                                unsigned offset);
> > include/linux/gpio/driver.h:354:                                                unsigned offset);
> > include/linux/gpio/driver.h:356:                                                unsigned offset);
> > include/linux/gpio/driver.h:358:                                                unsigned offset);
> > include/linux/gpio/driver.h:360:                                                unsigned offset, int value);
> > include/linux/gpio/driver.h:362:                                                unsigned offset);
> > include/linux/gpio/driver.h:367:                                                unsigned offset, int value);
> > include/linux/gpio/driver.h:372:                                              unsigned offset,
> > include/linux/gpio/driver.h:375:                                                unsigned offset);
> > include/linux/gpio/driver.h:462:                        unsigned offset);
> > include/linux/gpio/driver.h:660:int gpiochip_generic_request(struct gpio_chip *gc, unsigned offset);
> > include/linux/gpio/driver.h:661:void gpiochip_generic_free(struct gpio_chip *gc, unsigned offset);
> > include/linux/gpio/driver.h:662:int gpiochip_generic_config(struct gpio_chip *gc, unsigned offset,
> 
> ...riiiiiggght.   ...and now I run your sed script _after_ my patch
> and I get no hits.  ...so I'm still confused about what you want me to
> do that's not already done in my patch.

So you did say it's the g&t.
It seems I only looked at the first diff block.

cheers, <hck>, Joe

