Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC51C3B195
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F922314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581661902;
	bh=/NBVVHpbeNDiTGZuyEEPBdk5MUFXngSlWT07WmFJcY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w1xuRRtuY/Kwn7N+TMUy8xPjwG4WKfgDWK21VOgQE7lk15dMu3/ynEEIsYZMwgHbn
	 Amp/tuBKv9dtfFK89ljFbBDiEV6/u1N5UXg96LjCm+f/UDcFSvDjOf/krOdb23npr5
	 tTSGP3HD0ILmt1ctgOGJRDzRvi4HHFGH6H29UpIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgBNGbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgBNGbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:31:41 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C9C2187F;
        Fri, 14 Feb 2020 06:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581661900;
        bh=/NBVVHpbeNDiTGZuyEEPBdk5MUFXngSlWT07WmFJcY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vbbhoU1fGRuk3cY3GjifI5Mo6EWdc1hi3CW77kDmBd4Uyh5kEvGodfnK5hzXj6nHO
         M5/nTYri1nMe8iQIIGePX2TIleEsxqkeE1Ov3Obt2I5wCJSlK4acM2TVsrjn2JOgBT
         iPbQRZF4FdTLTeNpSBqwkFOASe9MfxKxHh37Xr/Y=
Date:   Fri, 14 Feb 2020 14:31:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ARM: dts: imx7-colibri: add alias for RTC
Message-ID: <20200214063132.GA25455@dragon>
References: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
 <20200204111151.3426090-2-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204111151.3426090-2-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 01:11:46PM +0200, Oleksandr Suvorov wrote:
> Make sure that the priority of the RTCs is defined.
> 
> Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Applied, thanks.
