Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A949C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3795E2076D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594628758;
	bh=bnb0Ao6sCyzm2xOSI9gjcZln3mdKoHgihfBEVcHcflM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dn/5QYDI2Y8K5O92ftgN9AgOxqCaXelBc7qg5LB/79r6vTW5EpxGWQ48/acNUZEeH
	 AbJrh288MIl/DYi4hPnoZpfhcxHXIrXRT0NcEppd6HGBfOJH2hC8vYwjaeuExQy4OK
	 +RVmvWdwtaJXZkcmXEZnKTTFZDQRifTBFEVyqZeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgGMIZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMIZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:25:56 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956EA2073A;
        Mon, 13 Jul 2020 08:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594628756;
        bh=bnb0Ao6sCyzm2xOSI9gjcZln3mdKoHgihfBEVcHcflM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HD7PYqpUpXangwjU80N7DY7WyawD/jkGv5pn81/t+gk3/Rn2eo1cV3zZQC0JL7Gmg
         UwTbwu8Nd76EKFmtBTeFN/Zo4OWEeSiea0KIIEkcY+H5Yb5S8nHySaZtA2G0FM162g
         t+iGNFenwqyXNraVGQ6i8Y/OxSU430Q3+IWbiP4s=
Date:   Mon, 13 Jul 2020 16:25:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     s.hauer@pengutronix.de, stefan@agner.ch, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] arm: dts: vf610-zii-scu4-aib: Configure fibre ports
 to 1000BaseX
Message-ID: <20200713082548.GA15718@dragon>
References: <20200709001154.7403-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709001154.7403-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:11:54PM -0700, Chris Healy wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> The SFF soldered onto the board expect the ports to use 1000BaseX.  It
> makes no sense to have the ports set to SGMII, since they don't even
> support that mode.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Chris Healy <cphealy@gmail.com>

s/arm/ARM in subject prefix, and applied.
