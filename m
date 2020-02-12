Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E98C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E23206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581493392;
	bh=Y/lvTukTLmPOkYD/rx8zMVp2+4fDIRR1J9tNyDvhbEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R1lokjw61xN9LmfHcKEqC+t3dxHyoHExRY+E4g8uVkL3BwKgATR5Ng86DzjPldY13
	 XH5wmAbeA0k9mXZxwdn6JBH4NaLXFeBEzYHkYtJN0KHuL3ALpGV+h6qq/fUpBNAFZy
	 xQNOMEiZ5KDP35t5b1wraQLuB21j88cxUQCxFemk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgBLHnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgBLHnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:43:11 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699FD20714;
        Wed, 12 Feb 2020 07:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581493390;
        bh=Y/lvTukTLmPOkYD/rx8zMVp2+4fDIRR1J9tNyDvhbEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzZzo+8Ixnt1JdwZyhMjOnqkAtXiIgFTYuaJ/PBsToWIPsFccM9/meR1xNiK4lwsO
         6kikxucTUYL/LZQ77Iva8UAapB2MDK36vSCza/aPKDrOc9D2BjO63s39z4EzdBqqSN
         GPyEJRZ/lVbqtVg/N7pYxbmfiSGxAYmk1m8Z9n9I=
Date:   Wed, 12 Feb 2020 15:43:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Aapo Vienamo <aapo.vienamo@iki.fi>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: mxs: Enable usbphy1 and usb1 on apx4devkit DTS
Message-ID: <20200212074303.GD11096@dragon>
References: <20200112140039.25420-1-aapo.vienamo@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112140039.25420-1-aapo.vienamo@iki.fi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 04:00:39PM +0200, Aapo Vienamo wrote:
> Enable the USB host port on the APx4 development board.
> 
> Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>

Applied, thanks.
