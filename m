Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF1C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B2920753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgDHTio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:38:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56494 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgDHTio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:38:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 2D46728917A
Message-ID: <58f011c7bd67c886892ac98505b916cc95adf495.camel@collabora.com>
Subject: Re: [PATCH] media: staging: rkisp1: avoid unused variable warning
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Yichong Zhong <zyc@rock-chips.com>,
        Jacob Chen <cc@rock-chips.com>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Allon Huang <allon.huang@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 08 Apr 2020 16:38:30 -0300
In-Reply-To: <CAK8P3a1K5T2e2kAQMVi=ubPN3v4rYgtb9TaGC6evNXSUc4embQ@mail.gmail.com>
References: <20200408155325.2077345-1-arnd@arndb.de>
         <3336c3105120d2f90dbc20d47ff98e722a123d5b.camel@collabora.com>
         <CAK8P3a1K5T2e2kAQMVi=ubPN3v4rYgtb9TaGC6evNXSUc4embQ@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-08 at 21:08 +0200, Arnd Bergmann wrote:
> On Wed, Apr 8, 2020 at 7:56 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > On Wed, 2020-04-08 at 17:52 +0200, Arnd Bergmann wrote:
> > > When compile-testing with CONFIG_OF disabled, we get a warning
> > > about an unused variable, and about inconsistent Kconfig dependencies:
> > > 
> > > WARNING: unmet direct dependencies detected for PHY_ROCKCHIP_DPHY_RX0
> > >   Depends on [n]: STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=m] && (ARCH_ROCKCHIP [=n] || COMPILE_TEST [=y]) && OF [=n]
> > >   Selected by [m]:
> > >   - VIDEO_ROCKCHIP_ISP1 [=m] && STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=m] && VIDEO_V4L2 [=m] && VIDEO_V4L2_SUBDEV_API [=y] &&
> > > (ARCH_ROCKCHIP [=n] || COMPILE_TEST [=y])
> > > 
> > > drivers/staging/media/rkisp1/rkisp1-dev.c: In function 'rkisp1_probe':
> > > drivers/staging/media/rkisp1/rkisp1-dev.c:457:22: error: unused variable 'node' [-Werror=unused-variable]
> > >   457 |  struct device_node *node = pdev->dev.of_node;
> > > 
> > > Simply open-coding the pointer dereference in the only place
> > > the variable is used avoids the warning in all configurations,
> > > so we can allow compile-testing as well.
> > > 
> > 
> > Hello Arnd,
> > 
> > Thanks for your patch.
> > 
> > I believe this is already fixed here:
> > 
> > https://patchwork.linuxtv.org/patch/62774/
> > https://patchwork.linuxtv.org/patch/62775/
> 
> Ok, sorry for the duplicate. I only tested on mainline from a few days ago,
> so I must have missed it getting merged in the meantime.
> 

No worries!

Those were was sent very recently, and won't be
merged any time soon :-)

Ezequiel


