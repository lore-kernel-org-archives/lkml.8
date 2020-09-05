Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD3C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C010120797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599292525;
	bh=Y2I/qCv+Z0KAL8/oHVNkRuctkT/tRO33ur9JGFxnRSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sExVXXzgfFyG2qqiHCvPlo5Nw98OB0cf55b1+90i+U+vAEU8sM63R1FUV5ef0A16b
	 +oROK3Urh/fNPLR4uOrxDzLio7UWKsKBCmpdpPxUHqN4tNcdrRyYpEyrU/gWjW7HDV
	 axAFS9+mY1PH/regSeBVHD71zL6j7GJR8yX3A2ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIEHzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 03:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgIEHzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:55:24 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A8F20760;
        Sat,  5 Sep 2020 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599292523;
        bh=Y2I/qCv+Z0KAL8/oHVNkRuctkT/tRO33ur9JGFxnRSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I648Tj3XgPXu8t+h1U4YWpZX7aoJ8ko47Z8+F/j7UpmyLnLU6oeCoWa3A9NYDPKsN
         UFxbgPKl5vo9TebEe/h+AkAmgrfFm9S1wGS2MFV7T1+WhP2dNWZNQSrdsJKk9LYYkB
         IFjgtLtocHW6vtn2IGpf82PD5PkTSu6qP0MbnaGM=
Date:   Sat, 5 Sep 2020 15:55:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-var-som: Add 32.768 kHz clock to PMIC
Message-ID: <20200905075518.GO9261@dragon>
References: <20200902163223.17784-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902163223.17784-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:32:23PM +0200, Krzysztof Kozlowski wrote:
> The ROHM BD71847 PMIC has a 32.768 kHz clock.  Adding necessary parent
> allows to probe the bd718x7 clock driver fixing boot errors:
> 
>     bd718xx-clk bd71847-clk.1.auto: No parent clk found
>     bd718xx-clk: probe of bd71847-clk.1.auto failed with error -22
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
