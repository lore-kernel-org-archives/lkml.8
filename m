Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1CEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B823920780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592883789;
	bh=cDkDjDJ9XyK6peIfZDlp8sh1nsx50bXhbCY50HUtazo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aij69DMyoXA91TPwHqaYgEOLDXL8FoDbp89ptAclZvrtHWEevHac1XMVkHL7KK1Bz
	 rjtxNavDgis2MYbjGrU+g0PagtuqSJLgPmMTvaGXzwZQ61/lZ7pfhi5OTdbjEPB1At
	 PFGYbC1rrYv/NTCxEXL/IUaOZ820vhkHXTSRkEig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgFWDnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 23:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbgFWDnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:43:07 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB18B206C1;
        Tue, 23 Jun 2020 03:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592883787;
        bh=cDkDjDJ9XyK6peIfZDlp8sh1nsx50bXhbCY50HUtazo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhrocqJyoFgA4kBRum4a6RttO3Tpc7vn6TKns+27/d6KOV9khJW0+gOdcbv2Mgn64
         ZMljqrRp4o1n/v5qXPS7NxlxKTNxtqJsmopU/gNWaVKguXp2qjfDT+0kn4yMJe5F8w
         iwvI+Frw+D/ocMM/ib4GiGc942cWeBGq9FRnau+c=
Date:   Tue, 23 Jun 2020 11:43:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-gw53xx: allow boot firmware to set
 eth1 MAC
Message-ID: <20200623034240.GK30139@dragon>
References: <1590695583-1327-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590695583-1327-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:53:03PM -0700, Tim Harvey wrote:
> The GW53xx has a PCIe based GbE as the 2nd ethernet device. The
> boot firmware will populate the local-mac-address field of the
> device aliased to ethernet1 thus adding the PCIe device to
> dt allows boot firmware to set its MAC address.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
