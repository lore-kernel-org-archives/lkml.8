Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774C1C433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 06:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541F9208A9
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 06:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598770392;
	bh=hBZ6RdesmiE6ifrKMiMuYfbR77l9JTcrlAqse8LYc2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rfPgENMqOi/ixgMR2GMwh1yA9BxdvFQD4heaJwWix/NtL2wFTK4hmsq1oVVHi9fbq
	 YI2/zkI9j/yNR7syS5t2ewqnnElNJwXSEDbw8zRLJ9qmw+UhXeHcsslIBB8FKORhmo
	 kqT3/SgLXFcDHQGsdI6p8fQMJLHAQNjn4uiEZPqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgH3GxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 02:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgH3GxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 02:53:10 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9ABC2076D;
        Sun, 30 Aug 2020 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598770390;
        bh=hBZ6RdesmiE6ifrKMiMuYfbR77l9JTcrlAqse8LYc2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMyWtRoUuieA/AWIhGJf6M7Xrm4MC+B82hYgZFfTcrCpA2npnqKC2w+kxhcy7fLUP
         Wp3NwVuRBnZ31arT9pmzqOOdUhd4oE3Plui1BbXNsYHnBpsog+3OGwsFXPzL43wcIk
         33yf2XzlE352o+7TJkDw456VeQqYcyMZZ4iB8liA=
Date:   Sun, 30 Aug 2020 14:53:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: imx8mm-evk: Replace deprecated phy reset
 properties
Message-ID: <20200830065304.GF32096@dragon>
References: <20200823111508.1165-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823111508.1165-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 01:15:04PM +0200, Krzysztof Kozlowski wrote:
> Use preferred properties of phy node instead of deprecated
> phy-reset-gpios (and others).  This avoids copying deprecated code into
> future DTSes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.
