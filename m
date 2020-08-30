Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D164FC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8B22071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598771435;
	bh=FdWXXjJ7W3mVaKYCvQw8H6D4gz0Un4lUldjcDjd9Ua4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ewsq2GEuweRS8Zh5Q2h4YPXnZ7rGaWgdd+a6llHynUkfiJnrJTXUkTzFkTScjA/kZ
	 sANKjs22vbtxw12Ya0wSMb7Lno9ku0LwuEgfKAI+Y43Pw3/7Xq4R+h2O2OkLGWIDrD
	 lRILC/h+FVU+h/vySp0m1lidnTl50AQAXEW9rZ8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgH3HKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgH3HK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:10:29 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEDD92071B;
        Sun, 30 Aug 2020 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598771428;
        bh=FdWXXjJ7W3mVaKYCvQw8H6D4gz0Un4lUldjcDjd9Ua4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErAcFxYfAeaT7MNGCU3ipk2wZJZdOo9H+Gi0C7BOAJPtIgnPpi/C9T3wRGJFvydPF
         m6Dj3KwZG+tdbu8eL4Dh5iy3tYxDjmvZUguoQCMV5mkRabWeSk9PmlXDAcgQjg/9Ms
         DevSt9COsf54vlXwBEb/HfPGD8JQdux39ZgvFO3w=
Date:   Sun, 30 Aug 2020 15:10:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: arm: fsl: Add Beacon i.MX8M Mini
 Development Kit binding
Message-ID: <20200830071020.GH32096@dragon>
References: <20200823172019.18606-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823172019.18606-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 07:20:15PM +0200, Krzysztof Kozlowski wrote:
> Document the binding for Beacon EmbeddedWorks i.MX8M Mini Development
> Kit board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
