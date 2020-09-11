Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8F7C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF38221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599824975;
	bh=T5hi2wkZ1BsNn5NEzkD7Mfirzp6ADMP2cxY2M3N8TkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ScRMcrgsUeZmwJPT86OROmMREiu5KwrEhbnA7zZFRmphHtqiTCkOxC3refJTJxZyc
	 zhh1oT1tg7JY5ZSX+9rjXtfiNhC6tObN5Ri3MNkVWv0+aSBJo3uKXTOyTFO4sKJh5L
	 6pxlzdhiNPqdBEvIbeTfgqivyOMY/E9VSByzKowE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgIKLta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgIKLrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:47:17 -0400
Received: from localhost (unknown [122.171.196.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 172A4221E7;
        Fri, 11 Sep 2020 11:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599824837;
        bh=T5hi2wkZ1BsNn5NEzkD7Mfirzp6ADMP2cxY2M3N8TkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHpEoEUKlZdeWR4fKbgkvrv0OLAT5h0g4wHB9Pt1B/+9ZlbbRHo9Tl2xNgsDtnHXb
         mpW3YSsF5ZZiQULHcl5fKRCl8oUV9BFqjzF6w7+6+wikDOwps7GTssubqgGfmHpi3H
         evXqSKxU1aYKqopaUBWbgSs7hCpsDKOwvWQuZyXg=
Date:   Fri, 11 Sep 2020 17:17:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] Add PHY USB3 drivers for Hikey 970
Message-ID: <20200911114711.GX77521@vkoul-mobl>
References: <cover.1599716786.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599716786.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-09-20, 07:52, Mauro Carvalho Chehab wrote:
> This patch series add the PHY layer needed in order to support the USB
> functionality on Hikey 970 boards.
> 
> v3:
> - split a namespace patch on two (one with code changes and another
>   one with dt-bindings changes);
> - placed just the PHY driver on this series. Another series will add the
>   USB HUB driver and the DTS changes required to enable USB support
>   for this board.

I have only cover in my inbox, no other patches. Even lore doesn't show
the series, not sure what happened here

> 
> Mauro Carvalho Chehab (6):
>   phy: hisilicon: phy-hi3670-usb3: use a consistent namespace
>   dts: phy: phy-hi3670-usb3.txt: use a consistent namespace
>   phy: hisilicon: phy-hi3670-usb3: fix coding style
>   phy: hisilicon: phy-hi3670-usb3: change some DT properties
>   dt-bindings: phy: convert phy-kirin970-usb3.txt to yaml
>   MAINTAINERS: add myself as maintainer for Kirin 970 USB PHY
> 
> Yu Chen (2):
>   phy: hisilicon: add USB physical layer for Kirin 3670
>   phy: hisilicon: phy-hi3670-usb3: fix some issues at the init code
> 
>  .../bindings/phy/hisilicon,hi3670-usb3.yaml   |  72 ++
>  MAINTAINERS                                   |   9 +-
>  drivers/phy/hisilicon/Kconfig                 |  10 +
>  drivers/phy/hisilicon/Makefile                |   1 +
>  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 671 ++++++++++++++++++
>  5 files changed, 762 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
>  create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
> 
> -- 
> 2.26.2
> 

-- 
~Vinod
