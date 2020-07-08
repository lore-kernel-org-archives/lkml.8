Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C81C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9DB2089D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594206986;
	bh=FQJDJx+jzPkra8mqaevwhmjfYTTG3AOP9YtcAEP1U7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f2oHBBNNC/btQkgWdrclxX3aqQ5P9qx9pC3cbA0M1sXW9JxEN+aXKaDTEgt/ByEoV
	 +U18ksqSrd9Z78eRGOh3MTDeIXNQ7FihPo+54GpqEDRzmZ7LBe/nRlN1MqJkM4EqUH
	 aAswoT78890wUwXy7KwP3aeoEouX1tGfvv4VL2Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgGHLQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgGHLQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:16:21 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB00720739;
        Wed,  8 Jul 2020 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594206981;
        bh=FQJDJx+jzPkra8mqaevwhmjfYTTG3AOP9YtcAEP1U7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJjTAVthLhpGGe7Qloj3DJObPsodL+zuWuZcE0AShu7qGbnW5Usu/4d/++eBios65
         3zcs479+NdLkU7bGT2dot/Z+UlXc0mqXCOssSQNyxk4AJh1OBPGxiU7R11zTlud6iq
         pcFtySW9LVEdjxAsTk4lUi8VDG5ZzaTCSTzssRgs=
Date:   Wed, 8 Jul 2020 16:46:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: allwinner: phy-sun6i-mipi-dphy: Constify structs
Message-ID: <20200708111617.GF34333@vkoul-mobl>
References: <20200629195727.9717-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629195727.9717-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 21:57, Rikard Falkeborn wrote:
> sun6i_dphy_ops and sun6i_dphy_regmap_config are not modified so make them
> const structs to allow the compiler to put them in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>    4407    1944      64    6415    190f drivers/phy/allwinner/phy-sun6i-mipi-dphy.o
> 
> After:
>    text    data     bss     dec     hex filename
>    4835    1496      64    6395    18fb drivers/phy/allwinner/phy-sun6i-mipi-dphy.o

Applied, thanks

-- 
~Vinod
