Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCE0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC492076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RsMZkts9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHCOWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:22:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A555AC06174A;
        Mon,  3 Aug 2020 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j2YFIam7494qTnawoI5t1lPh5O713n3GMls1dHCPXuo=; b=RsMZkts9WY+1FGSehXFi1VUhA
        uAHprLNgD2y2iMK2QdcWMXML3fYnbOHpXir2T8oJPcvLMMkS44Rl+9GJa+/04KVxu97aFil56BN0R
        ey8yQBLTBlNk4xZWEWQrwcOc4cOGTVEcn8ILOHHsv2HsMwT78++K+t1kMluqwh1wUEQgZV0SLA+UD
        wIFZafthZEFovFFkMDtHWL/8pUKkaY1ZAjJjRDY2j/dbJxVcHNguZ4JGNsRJCTq8cELNT5D9RTVSo
        MBVK7Fq6QAZgR42Hqv0BP26U1dJCj442YakkjGsKP8L9IjaMY/emfnqxjf5CPtzQgu5BkA78faX8q
        TMGlafSCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47824)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k2bMS-0001bs-Mj; Mon, 03 Aug 2020 15:22:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k2bMS-00039a-8c; Mon, 03 Aug 2020 15:22:44 +0100
Date:   Mon, 3 Aug 2020 15:22:44 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: exynos: clear L220_AUX_CTRL_NS_LOCKDOWN in
 default l2c_aux_val
Message-ID: <20200803142244.GO1551@shell.armlinux.org.uk>
References: <860eb8a1eed879e55daf960c96acdac514cbda93.1596028601.git.guillaume.tucker@collabora.com>
 <20200803133439.GB476@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803133439.GB476@kozik-lap>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 03:34:39PM +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 29, 2020 at 02:47:31PM +0100, Guillaume Tucker wrote:
> > The L220_AUX_CTRL_NS_LOCKDOWN flag is set during the L2C enable
> > sequence.  There is no need to set it in the default register value,
> > this was done before support for it was implemented in the code.  It
> > is not set in the hardware initial value either.
> > 
> > Clean this up by removing this flag from the default l2c_aux_val, and
> > add it to the l2c_aux_mask to print an alert message if it was already
> > set before the kernel initialisation.
> > 
> > Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> > ---
> >  arch/arm/mach-exynos/exynos.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Makes sense. I'll take it after the merge window.

Yes, because platforms actually have no control over this bit through
these values.

Please fix the description to use the right define, it's
L310_AUX_CTRL_NS_LOCKDOWN not L220_AUX_CTRL_NS_LOCKDOWN.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
