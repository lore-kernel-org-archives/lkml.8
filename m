Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD68C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465B520836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593180720;
	bh=AcfcmxTEwMLpCjHwrcUyTxMAtd9c6cjebHh5Zyo//Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ScbW2RIqGzETSNbgVIA+Y++nX8tDcb6xJxno/oR4uJnzgCpZ12CknPzQbOOJ8GKWq
	 W7+gHUCXL+bF5vKLqLeLvpJjkFMucYIFJjaU8HAVeHNlxsDnVVnrLGhCzH0cBJORBn
	 rlk6jrOX0xhysyTXi/IlbeVhtmxpyvLV1hAdsz5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgFZOL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbgFZOL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:11:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFE32207D8;
        Fri, 26 Jun 2020 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593180717;
        bh=AcfcmxTEwMLpCjHwrcUyTxMAtd9c6cjebHh5Zyo//Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1psbawtvBUFIcq1/KN23kw74uk42iRCdrj+GSqtH9rVDrsSmfdgDOTe9e01JxX+/
         rlMIh7sp0HQ2bvwST1H18rhLtCilWibJ2ccrspRUxGiMZsrCZJfHfSD0+OrqDAYKWa
         0/9C+PHOCYG2k+PfxniePDC8py6FyRR54nHYs7so=
Date:   Fri, 26 Jun 2020 16:11:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Subject: Re: [PATCH] platform/chrome: Clarify SPDX license with GPL-2.0-only
Message-ID: <20200626141152.GB4140284@kroah.com>
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
 <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
 <20200626043358.GB175080@kroah.com>
 <6eafe066-ce79-4fad-7a91-c75a564e6663@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eafe066-ce79-4fad-7a91-c75a564e6663@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 10:32:55AM +0200, Enric Balletbo i Serra wrote:
> Hi,
> 
> On 26/6/20 6:33, Greg Kroah-Hartman wrote:
> > On Thu, Jun 25, 2020 at 10:06:03PM +0300, Andy Shevchenko wrote:
> >> On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
> >> <enric.balletbo@collabora.com> wrote:
> >>>
> >>> Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
> >>> tag.
> >>
> >> Is there any? Last time IIRC Greg told me that in the kernel the old
> >> and new variants are okay.
> > 
> > They are just fine, leave it alone, the in-kernel LICENSES/ files show
> > the valid SPDX tags that the kernel allows at this point in time.
> > 
> 
> I guess my confusion comes from seeing patch series doing this change in the ML
> instead of really reading the documentation. If it's clear, and as per in-kernel
> docs, it is, that a GPL-2.0 tag is a GPL-2.0 only license, that's fine with me.

It is clear, no churn needed, thanks!

greg k-h
