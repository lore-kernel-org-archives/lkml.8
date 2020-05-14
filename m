Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CA1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D2A20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgENH5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:57:10 -0400
Received: from elvis.franken.de ([193.175.24.41]:53041 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgENH5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:57:10 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jZ8js-0005U5-00; Thu, 14 May 2020 09:57:08 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B31E7C0482; Thu, 14 May 2020 09:41:22 +0200 (CEST)
Date:   Thu, 14 May 2020 09:41:22 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] MIPS: dts: mscc: Updated changed name for miim pinctrl
 function
Message-ID: <20200514074122.GA5880@alpha.franken.de>
References: <20200513132347.24975-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513132347.24975-1-lars.povlsen@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 03:23:47PM +0200, Lars Povlsen wrote:
> This is an add-on patch to the main SoC Sparx5 series
> (Message-ID: <20200513125532.24585-1-lars.povlsen@microchip.com>).
> 
> This changes the miim pinctrl function name from "miim1" to "miim" due
> to refactoring in the driver, obsoleting the instance number.
> 
> The change in the driver was to better fit new platforms, as the
> instance number is redundant information. Specifically, support for
> the Microchip Sparx5 SoC is being submitted, where this change became
> necessary.
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
