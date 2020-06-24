Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF432C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE7F20781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404029AbgFXPAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:00:38 -0400
Received: from foss.arm.com ([217.140.110.172]:59092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404006AbgFXPAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:00:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED351FB;
        Wed, 24 Jun 2020 08:00:37 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B28F73F73C;
        Wed, 24 Jun 2020 08:00:34 -0700 (PDT)
Subject: Re: [RESEND PATCH v5 1/5] driver core: add probe_err log helper
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114135eucas1p26e2e4683d60cebdce7acd55177013992@eucas1p2.samsung.com>
 <20200624114127.3016-2-a.hajda@samsung.com>
 <20200624132714.GD5472@sirena.org.uk>
 <CAHp75Ve9V1Vyxe3bEeHJ9H2J900wUXHMmXFJt-dn9sO5OMejHA@mail.gmail.com>
 <20200624140207.GE5472@sirena.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6373a4eb-2f1b-b56f-48a8-ae97b4e4476a@arm.com>
Date:   Wed, 24 Jun 2020 16:00:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624140207.GE5472@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 15:02, Mark Brown wrote:
> On Wed, Jun 24, 2020 at 04:45:28PM +0300, Andy Shevchenko wrote:
>> On Wed, Jun 24, 2020 at 4:27 PM Mark Brown <broonie@kernel.org> wrote:
> 
>>> As I said down the thread that's not a great pattern since it means that
>>> probe deferral errors never get displayed and users have a hard time
>>> figuring out why their driver isn't instantiating.
> 
>> Don't we have a file in the debugfs to list deferred drivers?
> 
> Part of what this patch series aims to solve is that that list is not
> very useful since it doesn't provide any information on how things got
> deferred which means it's of no use in trying to figure out any
> problems.
> 
>> In the case of deferred probes the errors out of it makes users more
>> miserable in order to look through tons of spam and lose really useful
>> data in the logs.
> 
> I seem to never manage to end up using any of the systems which generate
> excessive deferrals.

Be thankful... And count me in as one of those miserable users; here's one
of mine being bad enough without even printing any specific messages about
deferring ;)

Robin.

-----

[robin@weasel-cheese ~]$ dmesg | grep dwmmc
[    3.046297] dwmmc_rockchip ff0c0000.mmc: IDMAC supports 32-bit address mode.
[    3.054312] dwmmc_rockchip ff0c0000.mmc: Using internal DMA controller.
[    3.061774] dwmmc_rockchip ff0c0000.mmc: Version ID is 270a
[    3.068101] dwmmc_rockchip ff0c0000.mmc: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
[    3.079638] dwmmc_rockchip ff0d0000.mmc: IDMAC supports 32-bit address mode.
[    3.087678] dwmmc_rockchip ff0d0000.mmc: Using internal DMA controller.
[    3.095134] dwmmc_rockchip ff0d0000.mmc: Version ID is 270a
[    3.101480] dwmmc_rockchip ff0d0000.mmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
[    3.113071] dwmmc_rockchip ff0f0000.mmc: IDMAC supports 32-bit address mode.
[    3.121110] dwmmc_rockchip ff0f0000.mmc: Using internal DMA controller.
[    3.128565] dwmmc_rockchip ff0f0000.mmc: Version ID is 270a
[    3.134886] dwmmc_rockchip ff0f0000.mmc: DW MMC controller at irq 32,32 bit host data width,256 deep fifo
[    3.948510] dwmmc_rockchip ff0c0000.mmc: IDMAC supports 32-bit address mode.
[    3.956475] dwmmc_rockchip ff0c0000.mmc: Using internal DMA controller.
[    3.963884] dwmmc_rockchip ff0c0000.mmc: Version ID is 270a
[    3.970133] dwmmc_rockchip ff0c0000.mmc: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
[    4.141231] dwmmc_rockchip ff0d0000.mmc: IDMAC supports 32-bit address mode.
[    4.149178] dwmmc_rockchip ff0d0000.mmc: Using internal DMA controller.
[    4.156582] dwmmc_rockchip ff0d0000.mmc: Version ID is 270a
[    4.162823] dwmmc_rockchip ff0d0000.mmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
[    4.175606] dwmmc_rockchip ff0f0000.mmc: IDMAC supports 32-bit address mode.
[    4.183540] dwmmc_rockchip ff0f0000.mmc: Using internal DMA controller.
[    4.190946] dwmmc_rockchip ff0f0000.mmc: Version ID is 270a
[    4.197196] dwmmc_rockchip ff0f0000.mmc: DW MMC controller at irq 32,32 bit host data width,256 deep fifo
[    4.250758] dwmmc_rockchip ff0d0000.mmc: IDMAC supports 32-bit address mode.
[    4.258688] dwmmc_rockchip ff0d0000.mmc: Using internal DMA controller.
[    4.266104] dwmmc_rockchip ff0d0000.mmc: Version ID is 270a
[    4.272358] dwmmc_rockchip ff0d0000.mmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
[    4.285390] dwmmc_rockchip ff0d0000.mmc: IDMAC supports 32-bit address mode.
[    4.293333] dwmmc_rockchip ff0d0000.mmc: Using internal DMA controller.
[    4.300750] dwmmc_rockchip ff0d0000.mmc: Version ID is 270a
[    4.307005] dwmmc_rockchip ff0d0000.mmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
[    4.971373] dwmmc_rockchip ff0f0000.mmc: Successfully tuned phase to 134
[    5.027225] dwmmc_rockchip ff0d0000.mmc: IDMAC supports 32-bit address mode.
[    5.035339] dwmmc_rockchip ff0d0000.mmc: Using internal DMA controller.
[    5.042769] dwmmc_rockchip ff0d0000.mmc: Version ID is 270a
[    5.049050] dwmmc_rockchip ff0d0000.mmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
[   24.727583] dwmmc_rockchip ff0d0000.mmc: IDMAC supports 32-bit address mode.
[   24.745541] dwmmc_rockchip ff0d0000.mmc: Using internal DMA controller.
[   24.753003] dwmmc_rockchip ff0d0000.mmc: Version ID is 270a
[   24.763289] dwmmc_rockchip ff0d0000.mmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
[   25.589620] dwmmc_rockchip ff0d0000.mmc: IDMAC supports 32-bit address mode.
[   25.603066] dwmmc_rockchip ff0d0000.mmc: Using internal DMA controller.
[   25.615283] dwmmc_rockchip ff0d0000.mmc: Version ID is 270a
[   25.627911] dwmmc_rockchip ff0d0000.mmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
[   25.643469] dwmmc_rockchip ff0d0000.mmc: IDMAC supports 32-bit address mode.
[   25.651532] dwmmc_rockchip ff0d0000.mmc: Using internal DMA controller.
[   25.658960] dwmmc_rockchip ff0d0000.mmc: Version ID is 270a
[   25.665246] dwmmc_rockchip ff0d0000.mmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
[   25.677154] dwmmc_rockchip ff0d0000.mmc: allocated mmc-pwrseq
