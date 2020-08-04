Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36329C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD292086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgHDRTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:19:02 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:53411 "EHLO
        5.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbgHDRTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:19:01 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2020 13:19:00 EDT
Received: from player774.ha.ovh.net (unknown [10.108.35.158])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 84A90247070
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 19:09:30 +0200 (CEST)
Received: from etezian.org (213-243-141-64.bb.dnainternet.fi [213.243.141.64])
        (Authenticated sender: andi@etezian.org)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id 253FA151129F2;
        Tue,  4 Aug 2020 17:09:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G005bf6e1e8c-ecdf-4e2c-a38c-4357f76d3ada,
                    174E2A681E1E8355CD79DB1D1551BCD4D872E018) smtp.auth=andi@etezian.org
Date:   Tue, 4 Aug 2020 20:09:20 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: s3c24xx: correct kerneldoc comment
Message-ID: <20200804170920.GC73082@jack.zhora.eu>
References: <20200804151356.28057-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804151356.28057-1-krzk@kernel.org>
X-Ovh-Tracer-Id: 10829468256800653977
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeigdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihesvghtvgiiihgrnhdrohhrgheqnecuggftrfgrthhtvghrnheptdfgudduhfefueeujeefieehtdeftefggeevhefgueellefhudetgeeikeduieefnecukfhppedtrddtrddtrddtpddvudefrddvgeefrddugedurdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Aug 04, 2020 at 05:13:56PM +0200, Krzysztof Kozlowski wrote:
> Correct the kerneldoc for structure to fix W=1 compile warning:
> 
>     drivers/spi/spi-s3c24xx.c:36: warning: cannot understand function prototype: 'struct s3c24xx_spi_devstate '
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

thanks,

Acked-by: Andi Shyti <andi@etezian.org>

Andi
