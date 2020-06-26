Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C4EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C35206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgFZKpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:45:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:61254 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgFZKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:45:19 -0400
IronPort-SDR: n0ojoOkY7TbVwJEO9W5XoEADSGnZt9ZaBkEU+5CiIwLu+BAUlNN4bManESOzT4Afd4Kg8LeSXG
 k+WQrRj0MxCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="230053509"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="230053509"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 03:45:18 -0700
IronPort-SDR: RA/ZNeU+CVrYx6dmKm5sZlO3kE+98yXe7qJHBl1eLlfxEx/8rO3MHpJhAgh3/CaaPQQN8Tty/Q
 GjJryRrU6/IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="424040522"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 03:45:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jolr7-00G4At-VC; Fri, 26 Jun 2020 13:45:13 +0300
Date:   Fri, 26 Jun 2020 13:45:13 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
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
Message-ID: <20200626104513.GQ3703480@smile.fi.intel.com>
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
 <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
 <026b38ff947e338a468567dfd20fbde1419bb094.camel@perches.com>
 <CAHp75VcFeCf0vnk2Ea_-QdTW5gyRZvgEXwX7-VSd3rKch7pSwQ@mail.gmail.com>
 <CAHp75VeZj72VDHSm48Diomz4q0+dJ6gjknqHQpfon3PU9Te5-w@mail.gmail.com>
 <43e55eb146d8e66ba1aaf057b807e6bd6ed16d78.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e55eb146d8e66ba1aaf057b807e6bd6ed16d78.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 12:52:21PM -0700, Joe Perches wrote:
> On Thu, 2020-06-25 at 22:35 +0300, Andy Shevchenko wrote:
> > On Thu, Jun 25, 2020 at 10:33 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Jun 25, 2020 at 10:29 PM Joe Perches <joe@perches.com> wrote:
> > > > On Thu, 2020-06-25 at 22:06 +0300, Andy Shevchenko wrote:
> > > > > On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
> > > > > <enric.balletbo@collabora.com> wrote:
> > > > > > Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
> > > > > > tag.
> > > > > 
> > > > > Is there any? Last time IIRC Greg told me that in the kernel the old
> > > > > and new variants are okay.
> > > > 
> > > > If there wasn't any ambiguity, the older license
> > > > style wouldn't be deprecated by SPDX.org.
> > > 
> > > They are _not_ deprecated according to kernel documentation:
> > > https://elixir.bootlin.com/linux/latest/source/LICENSES/preferred/GPL-2.0
> > > 
> > > So, fix documentation in the kernel then.
> > 
> > That said, NAK to the patch as long as in-kernel documentation says it's valid.
> 
> Maintainers and authors should get to chose whatever
> license text they prefer with the assent of the licensors.
> 
> A NAK here by you doesn't make much sense to me.

Yes, it's a private opinion from a PDx86 maintainer.

-- 
With Best Regards,
Andy Shevchenko


