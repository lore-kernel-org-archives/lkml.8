Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D728C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5164420828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582525422;
	bh=OsPgg0jY2d2muGW/C79n94xMbYStT13zHqGcvLqf3y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qBJMErFVHTUBnfDVX+FZJUfe6UcoQSU5aBlL/xrVtMI/rBCVuQ0TiSuvz2KnB52c3
	 9+7u3uNSaDKK0o+V6rgtfh9chPYAc68/X+90A1JWPsvjccmpxAQvWuwkDR4HlDOh1F
	 gW5n1pY1IJdaTscWpOOPbIfnUOgWMXszRCwUkGvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBXGXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgBXGXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:23:35 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB9B20661;
        Mon, 24 Feb 2020 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582525415;
        bh=OsPgg0jY2d2muGW/C79n94xMbYStT13zHqGcvLqf3y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejxIowobUWbHpDL2VqIuu3+29xFVJ+OL41TWpQKVnsKCAYGEpPCD+FwlzgrC96Ex4
         GAOGDEWGYbTb+Lqf4csoXeytrZidb0hD1l5KOm5ggy+pH2Gb/0h6XPPzO6KFkpduDr
         RPA3HYPUHQ52qztTPqBcCnzXQ7niO0upLNQNplus=
Date:   Mon, 24 Feb 2020 14:23:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Add Aster carrier board support for Colibri iMX7
 CoM
Message-ID: <20200224062326.GJ27688@dragon>
References: <20200219130043.3563238-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219130043.3563238-1-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:00:48PM +0000, Oleksandr Suvorov wrote:
> 
> This series adds devicetrees for the Toradex Aster board along with
> Toradex Computer on Module Colibri iMX7S/iMX7D.
> 
> Changes in v2:
> - Change X11 license to MIT
> - Change X11 license to MIT
> - Sort nodes alphabetically
> - Document compatibles for an Aster board in the separate commit of
>   the series
> - Drop the undocumented device (spidev-around work will be sent in
>   the separate patchset)
> 
> Oleksandr Suvorov (3):
>   ARM: dts: imx7-colibri: Convert to SPDX license tags for Colibri iMX7
>   dt-bindings: arm: fsl: add nxp based toradex colibri-imx7 bindings
>   ARM: dts: imx7-colibri: add support for Toradex Aster carrier board

Applied all, thanks.
