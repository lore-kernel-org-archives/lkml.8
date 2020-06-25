Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A914C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4338120781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406662AbgFYTkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:40:39 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:53726 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406069AbgFYTkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:40:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EDF0B181D330D;
        Thu, 25 Jun 2020 19:40:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: doll31_0604bd226e4f
X-Filterd-Recvd-Size: 2852
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 19:40:34 +0000 (UTC)
Message-ID: <5dbb62beffde43e1049ca37629533db5c7b2e6d6.camel@perches.com>
Subject: Re: [PATCH] platform/chrome: Clarify SPDX license with GPL-2.0-only
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Crews <ncrews@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yicheng Li <yichengli@chromium.org>
Date:   Thu, 25 Jun 2020 12:40:33 -0700
In-Reply-To: <CAHp75VcFeCf0vnk2Ea_-QdTW5gyRZvgEXwX7-VSd3rKch7pSwQ@mail.gmail.com>
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
         <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
         <026b38ff947e338a468567dfd20fbde1419bb094.camel@perches.com>
         <CAHp75VcFeCf0vnk2Ea_-QdTW5gyRZvgEXwX7-VSd3rKch7pSwQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-25 at 22:33 +0300, Andy Shevchenko wrote:
> On Thu, Jun 25, 2020 at 10:29 PM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2020-06-25 at 22:06 +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > > > Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
> > > > tag.
> > > 
> > > Is there any? Last time IIRC Greg told me that in the kernel the old
> > > and new variants are okay.
> > 
> > If there wasn't any ambiguity, the older license
> > style wouldn't be deprecated by SPDX.org.
> 
> They are _not_ deprecated according to kernel documentation:
> https://elixir.bootlin.com/linux/latest/source/LICENSES/preferred/GPL-2.0
> 
> So, fix documentation in the kernel then.

Been there, tried that. Linus is out to lunch IMO.

https://lore.kernel.org/lkml/515362d10c06567f35f0d5b7c3f2e121769fb04b.camel@perches.com/


