Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D0C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8312E2078A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598189215;
	bh=0qGx5NN8Kgj21Cjr7tgWm5nfk3bYJh4Htl1Z973oAZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tz+Rt/2HMx9BOvh6QNFjxoj4MI4YvEK+mD2xkT9EMoG79nRQugKV7dITyAoBd6bG3
	 90rmDlaKsWLqk+yTye7IwzZUOMk2KOX9NgV5xQwHRq+W9c9EAdADpyHg4eyHxFDX8F
	 KfdVfV4uAmAK98ydeha/NaoCgrPjUkkcivDv4YWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHWN0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 09:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgHWN0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 09:26:53 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4118206C0;
        Sun, 23 Aug 2020 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598189212;
        bh=0qGx5NN8Kgj21Cjr7tgWm5nfk3bYJh4Htl1Z973oAZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GoJ9Bdif0RTVHpE3vlXyu/GAlsuZ3AsO8K2TXjxXZzkCHMk+US5biW33MvpK642oM
         eQhWpxbChUqgMj1FPrm4InYdwytonTjbqDq8O6pdIP11aVNHEuIaKAL4nYzUT/21Ss
         0KGqfOBqcxLoYzyJ16e/fv9gzcK5/Coq0IENrh+g=
Date:   Sun, 23 Aug 2020 18:56:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add new UniPhier AHCI PHY driver
Message-ID: <20200823132648.GO2639@vkoul-mobl>
References: <1594888344-32066-1-git-send-email-hayashi.kunihiko@socionext.com>
 <c60c0fc3-cb89-36e3-f18e-9a030ece72f1@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c60c0fc3-cb89-36e3-f18e-9a030ece72f1@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 21-08-20, 18:20, Kunihiko Hayashi wrote:
> Gentle ping.
> Are there any comments in this series?

Sorry I dont have this in my inbox, can you please rebease and resend to
me as well

Thanks
> 
> Thank you,
> 
> On 2020/07/16 17:32, Kunihiko Hayashi wrote:
> > This series adds support for AHCI PHY interface implemented in Socionext
> > UniPhier SoCs. This driver supports PXs2 and PXs3 SoCs.
> > 
> > Changes since v3:
> > - Eliminate a meaningless blank line and a line break
> > - Fix misspelling
> > 
> > Changes since v2:
> > - Adjust copyright year
> > - Add helper for enabling the controller
> > - Remove redundant .init in uniphier_pxs2_data
> > - Add comments for dummy read accesses
> > - Fix return value in uniphier_ahciphy_init
> > - dt-bindings: Add Reviewed-by line
> > 
> > Changes since v1:
> > - dt-bindings: Fix items in reset-names
> > 
> > Kunihiko Hayashi (2):
> >    dt-bindings: phy: Add UniPhier AHCI PHY description
> >    phy: socionext: Add UniPhier AHCI PHY driver support
> > 
> >   .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |  76 +++++
> >   drivers/phy/socionext/Kconfig                      |  10 +
> >   drivers/phy/socionext/Makefile                     |   1 +
> >   drivers/phy/socionext/phy-uniphier-ahci.c          | 321 +++++++++++++++++++++
> >   4 files changed, 408 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> >   create mode 100644 drivers/phy/socionext/phy-uniphier-ahci.c
> > 
> 
> ---
> Best Regards
> Kunihiko Hayashi

-- 
~Vinod
