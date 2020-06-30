Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123AFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE0220702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593545430;
	bh=rEjh/g2S0tM9y4L43jJdE5PRYKCoFH1gQ/JFjzpI3J8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mPt41kf1UZYI5VPceiM/M0EnYN+7s9gSN03Oj9fpu4oj9rzo++WyRv3VcKd0Hwitt
	 aK44c6dwxRYY0cFVaey4Rxw67/bvLlrWlIuejxrKsH0D1j1hQrlrnifZPzrKgSMVjN
	 3bMHvM90pLWIgOHK5Bl0U3cb78iKfXSUtYX8/+VI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgF3Ta3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgF3Ta2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:30:28 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA06206C0;
        Tue, 30 Jun 2020 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593545428;
        bh=rEjh/g2S0tM9y4L43jJdE5PRYKCoFH1gQ/JFjzpI3J8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YrsWemV8NJvx04mW005Zc9MA2OgNruHQsVtdKH2T4vxRF2Zqm0xlQEPT9UKJUZbyq
         ueVxKtzRjyE3noo1bvlLdwBw6z1lWqVx7WxIogIstM89v0LpL+fRtcftaeRrm4t6Rz
         Ri8R1z08mqiVd1eaw1NHQ/BbeC/ASKIm1lBJFDtE=
Date:   Tue, 30 Jun 2020 12:30:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 00/10] net: improve devres helpers
Message-ID: <20200630123026.39d97211@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200629120346.4382-1-brgl@bgdev.pl>
References: <20200629120346.4382-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 14:03:36 +0200 Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> So it seems like there's no support for relaxing certain networking devres
> helpers to not require previously allocated structures to also be managed.
> However the way mdio devres variants are implemented is still wrong and I
> modified my series to address it while keeping the functions strict.
> 
> First two patches modify the ixgbe driver to get rid of the last user of
> devm_mdiobus_free().
> 
> Patches 3, 4, 5 and 6 are mostly cosmetic.
> 
> Patch 7 fixes the way devm_mdiobus_register() is implemented.
> 
> Patches 8 & 9 provide a managed variant of of_mdiobus_register() and
> last patch uses it in mtk-star-emac driver.
> 
> v1 -> v2:
> - drop the patch relaxing devm_register_netdev()
> - require struct mii_bus to be managed in devm_mdiobus_register() and
>   devm_of_mdiobus_register() but don't store that information in the
>   structure itself: use devres_find() instead

Acked-by: Jakub Kicinski <kuba@kernel.org>
