Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC524206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406844AbgFYTw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:52:29 -0400
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:56156 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406569AbgFYTw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:52:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 92C37181D3025;
        Thu, 25 Jun 2020 19:52:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: swing96_4211ca926e4f
X-Filterd-Recvd-Size: 8103
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 19:52:22 +0000 (UTC)
Message-ID: <43e55eb146d8e66ba1aaf057b807e6bd6ed16d78.camel@perches.com>
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
Date:   Thu, 25 Jun 2020 12:52:21 -0700
In-Reply-To: <CAHp75VeZj72VDHSm48Diomz4q0+dJ6gjknqHQpfon3PU9Te5-w@mail.gmail.com>
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
         <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
         <026b38ff947e338a468567dfd20fbde1419bb094.camel@perches.com>
         <CAHp75VcFeCf0vnk2Ea_-QdTW5gyRZvgEXwX7-VSd3rKch7pSwQ@mail.gmail.com>
         <CAHp75VeZj72VDHSm48Diomz4q0+dJ6gjknqHQpfon3PU9Te5-w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-25 at 22:35 +0300, Andy Shevchenko wrote:
> On Thu, Jun 25, 2020 at 10:33 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jun 25, 2020 at 10:29 PM Joe Perches <joe@perches.com> wrote:
> > > On Thu, 2020-06-25 at 22:06 +0300, Andy Shevchenko wrote:
> > > > On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
> > > > <enric.balletbo@collabora.com> wrote:
> > > > > Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
> > > > > tag.
> > > > 
> > > > Is there any? Last time IIRC Greg told me that in the kernel the old
> > > > and new variants are okay.
> > > 
> > > If there wasn't any ambiguity, the older license
> > > style wouldn't be deprecated by SPDX.org.
> > 
> > They are _not_ deprecated according to kernel documentation:
> > https://elixir.bootlin.com/linux/latest/source/LICENSES/preferred/GPL-2.0
> > 
> > So, fix documentation in the kernel then.
> 
> That said, NAK to the patch as long as in-kernel documentation says it's valid.

Maintainers and authors should get to chose whatever
license text they prefer with the assent of the licensors.

A NAK here by you doesn't make much sense to me.

$ ./scripts/get_maintainer.pl  drivers/platform/chrome/
Benson Leung <bleung@chromium.org> (maintainer:CHROME HARDWARE PLATFORM SUPPORT)
Enric Balletbo i Serra <enric.balletbo@collabora.com> (maintainer:CHROME HARDWARE PLATFORM SUPPORT)
linux-kernel@vger.kernel.org (open list)

$ git log --no-merges --format="%an <%ae>" drivers/platform/chrome | sort | uniq -c | sort -rn
     53 Enric Balletbo i Serra <enric.balletbo@collabora.com>
     23 Gwendal Grignou <gwendal@chromium.org>
     16 Nick Crews <ncrews@chromium.org>
     15 Dmitry Torokhov <dmitry.torokhov@gmail.com>
      9 Prashant Malani <pmalani@chromium.org>
      9 Benson Leung <bleung@chromium.org>
      8 Javier Martinez Canillas <javier.martinez@collabora.co.uk>
      6 Shawn Nematbakhsh <shawnn@chromium.org>
      5 Nick Dyer <nick.dyer@itdev.co.uk>
      5 Daniel Campello <campello@chromium.org>
      4 Tzung-Bi Shih <tzungbi@google.com>
      4 Thierry Escande <thierry.escande@collabora.com>
      4 Stephen Boyd <swboyd@chromium.org>
      4 Pi-Hsun Shih <pihsun@chromium.org>
      4 Olof Johansson <olof@lixom.net>
      4 Eric Caruso <ejcaruso@chromium.org>
      4 Douglas Anderson <dianders@chromium.org>
      4 Bill Richardson <wfrichar@chromium.org>
      4 Arnd Bergmann <arnd@arndb.de>
      3 Wolfram Sang <wsa+renesas@sang-engineering.com>
      3 Stephen Barber <smbarber@chromium.org>
      3 Raul E Rangel <rrangel@chromium.org>
      3 Peter Zijlstra <peterz@infradead.org>
      3 Olof Johansson <olofj@chromium.org>
      3 Evan Green <evgreen@chromium.org>
      3 Enrico Granata <egranata@chromium.org>
      3 Brian Norris <briannorris@chromium.org>
      2 Jett Rink <jettrink@chromium.org>
      2 Javier Martinez Canillas <javier@osg.samsung.com>
      2 Gustavo A. R. Silva <gustavo@embeddedor.com>
      2 Guenter Roeck <linux@roeck-us.net>
      2 Gene Chen <gene.chen@intel.com>
      2 Dan Carpenter <dan.carpenter@oracle.com>
      2 Christian Engelmayer <cengelma@gmx.at>
      2 Aaron Durbin <adurbin@chromium.org>
      1 YueHaibing <yuehaibing@huawei.com>
      1 Yilun Lin <yllin@chromium.org>
      1 Yicheng Li <yichengli@chromium.org>
      1 Wolfram Sang <wsa@the-dreams.de>
      1 Wen Yang <wenyang@linux.alibaba.com>
      1 Wenkai Du <wenkai.du@intel.com>
      1 Wei Yongjun <yongjun_wei@trendmicro.com.cn>
      1 Vincent Palatin <vpalatin@chromium.org>
      1 Vic Yang <victoryang@google.com>
      1 Tomeu Vizoso <tomeu.vizoso@collabora.com>
      1 Tim Wawrzynczak <twawrzynczak@chromium.org>
      1 Thomas Gleixner <tglx@linutronix.de>
      1 Thierry Reding <treding@nvidia.com>
      1 Simon Que <sque@chromium.org>
      1 Sergiu Cuciurean <sergiu.cuciurean@analog.com>
      1 Sarthak Kukreti <sarthakkukreti@chromium.org>
      1 Salvatore Bellizzi <lkml@seppia.net>
      1 Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
      1 Robin Schroer <sulamiification@gmail.com>
      1 Ravi Chandra Sadineni <ravisadineni@chromium.org>
      1 Rajat Jain <rajatja@google.com>
      1 Nicolas Boichat <drinkcat@chromium.org>
      1 Neil Armstrong <narmstrong@baylibre.com>
      1 Navid Emamdoost <navid.emamdoost@gmail.com>
      1 Nathan Chancellor <natechancellor@gmail.com>
      1 Mohammed Habibulla <moch@chromium.org>
      1 Mika Westerberg <mika.westerberg@linux.intel.com>
      1 Michael Mullin <masmullin@gmail.com>
      1 Masahiro Yamada <masahiroy@kernel.org>
      1 Logan Gunthorpe <logang@deltatee.com>
      1 Linus Torvalds <torvalds@linux-foundation.org>
      1 Krzysztof Kozlowski <krzk@kernel.org>
      1 Kirill Smelkov <kirr@nexedi.com>
      1 Kees Cook <keescook@chromium.org>
      1 kbuild test robot <lkp@intel.com>
      1 kbuild test robot <fengguang.wu@intel.com>
      1 Joseph Lo <josephl@nvidia.com>
      1 Jon Flatley <jflat@chromium.org>
      1 Jeffery Yu <jefferyy@nvidia.com>
      1 Jarkko Nikula <jarkko.nikula@linux.intel.com>
      1 Hyungwoo Yang <hyungwoo.yang@intel.com>
      1 Heiner Kallweit <hkallweit1@gmail.com>
      1 Guenter Roeck <groeck@chromium.org>
      1 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
      1 Geliang Tang <geliangtang@163.com>
      1 Emil Karlson <jekarlson@gmail.com>
      1 Emilio López <emilio.lopez@collabora.co.uk>
      1 Colin Ian King <colin.king@canonical.com>
      1 Clinton Sprain <clintonsprain@gmail.com>
      1 Chuhong Yuan <hslester96@gmail.com>
      1 Christoph Hellwig <hch@lst.de>
      1 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
      1 Charlie Mooney <charliemooney@chromium.org>
      1 Bhumika Goyal <bhumirks@gmail.com>
      1 Bernardo Perez Priego <bernardo.perez.priego@intel.com>
      1 Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
      1 Archana Patni <archana.patni@intel.com>
      1 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
      1 Al Viro <viro@zeniv.linux.org.uk>


