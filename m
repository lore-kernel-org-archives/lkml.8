Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E1BC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE650206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="419V9ZM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDGWqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:46:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53734 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDGWqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SjTHWgdH+APmia7yev+r5og+EF8CcHtsC9+wUuc74BQ=; b=419V9ZM8i56ZctpAO/OJC4QDpJ
        0I4aBfDHchtIoOk0LriYXrHgmMGDCm3ArG+bwNDforN1Ianmzag0VF/NfbVtBHRMnFtpauief9ioM
        CdW5+oBd6nVNCksfES5xAY/3FuW+BnczEyKKC3fj1/LPtUhVat84eRiWUQIEcOffM1yQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jLwz1-001X61-Hq; Wed, 08 Apr 2020 00:46:15 +0200
Date:   Wed, 8 Apr 2020 00:46:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Spooren <mail@aparcar.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        jason@lakedaemon.net, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, daniel@makrotopia.org,
        freifunk@adrianschmutzler.de
Subject: Re: [PATCH 0/5] arm: dts: linksys: rename codename to model
Message-ID: <20200407224615.GA359603@lunn.ch>
References: <20200407210816.866084-1-mail@aparcar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407210816.866084-1-mail@aparcar.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:08:10AM -1000, Paul Spooren wrote:
> Linksys chose to use codenames for a few of their devices and sell their
> them under an entirely different name.
> 
> codename  model name
> rango  -> wrt3200acm
> mamba  -> wrt1900ac
> cobra  -> wrt1900ac-v2
> caiman -> wrt1200ac
> shelby -> wrt1900acs

Hi Paul

There was quite a bit of discussion about this when the first board
was added. If i remember correctly, it was Mamba.

Imre Kaloz, <kaloz@openwrt.org> was the one arguing for
the name armada-xp-linksys-mamba.dts.

So it seems that openwrt.org has now come full circle?

> This introduces some extra loops in OpenWrt, a distribution specialized
> on embedded Internet facing devices, as both codename and model name are
> used within the build system. The double naming requires developers to
> keep track of that mapping and introduces inconsistencies:
> 
> To build a specific device in OpenWrt profiles are used, named after the
> the compatible string for targets using device tree (similar to how .dts
> files are named in the linux source tree). However, the first item of
> the DT `compatible` list in this case is `linksys,rango`, which is
> inconsistent with the model name and not what common users would expect.
> 
> Such double naming complicates currently the automatic search for
> firmware upgrade as the build system does not support such mapping.
> Ideally the first item of the DT `compatible` list would contain a
> string suitable to be used as a filename recognizable by normal users to
> belong to that device.

> With this patch set the Linksys device tree files are moved from
> containing the codename to contain a sanitized model name and also use
> it as first entry of the DT `compatible` list.

I've no problems adding another compatible to the list. But i don't
like the idea of renaming the files. The file names could be
considered ABI! What installers/bootloaders are you going to break by
renaming them?

	   Andrew
