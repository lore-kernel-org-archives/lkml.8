Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B6DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C9D20725
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594610745;
	bh=42sLvH16N/p1HskAxb6+19GTRr4RU7NszcgWHIbzNNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NtDOoLnviySVrK0nsJpzkiJHxq48D9VJ5GMTQRXw0nOZMqFBcUg3D9qYqAJvjvJeH
	 eCvWE1PP30RJjrGn8ygSxMB0yE7ZV1Nl5Yf2aeGAJJamp7auykXpCpiP+RrfCGPIu2
	 LyP+3cm1O1snjotz0v0RZ2bw4dUD0EjRgHEQtCMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgGMDZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgGMDZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:25:44 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333182075F;
        Mon, 13 Jul 2020 03:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594610743;
        bh=42sLvH16N/p1HskAxb6+19GTRr4RU7NszcgWHIbzNNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+vq889PbBP/HPLp1htvu05JLh1JfilE/FtoRY/RMTjoe86+AEDmvnuuaopV74V+B
         0yUS9c+lOyAyV8CSXChGYykC4hxFa/qrPA0CnZkOkSzr+W2x2T+N7Px8QiNPYiDrtV
         UJTiDSqsIhO0P75OYsxXcUhG0Fr+234mD4/hR+O4=
Date:   Mon, 13 Jul 2020 11:25:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v9 0/5] mainline Protonic boards
Message-ID: <20200713032532.GD21277@dragon>
References: <20200701130330.9089-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701130330.9089-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 03:03:25PM +0200, Oleksij Rempel wrote:
> Oleksij Rempel (5):
>   dt-bindings: arm: fsl: add different Protonic boards
>   ARM: dts: add Protonic PRTI6Q board
>   ARM: dts: add Protonic WD2 board
>   ARM: dts: add Protonic VT7 board
>   ARM: dts: add Protonic RVT board

Applied all, thanks.
