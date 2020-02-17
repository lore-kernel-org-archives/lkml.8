Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521DCC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2625920718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581923927;
	bh=d1Kkja0ZMXgZjNlJF+Ikl9WhfLNQfqy3/oo7a/LOPEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UJkvTJqfR9B9ICn3m0p+OyDzV3pEMCizT89qPeH4Ye5Y6evUkUyTbEjftJttVH6wu
	 mlXWNlB6knaAYzNBhPxCGg2920J+mD/mNjiY3L0uU2zYJdGa7WZdIsxjRsPs8wg4h2
	 cxH1xsI5I2mqVvopSZEJ1zV94bOdtdxauKET4DlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBQHSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:18:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgBQHSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:18:33 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580CA20718;
        Mon, 17 Feb 2020 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581923913;
        bh=d1Kkja0ZMXgZjNlJF+Ikl9WhfLNQfqy3/oo7a/LOPEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWAQe1lSC3P/42E+6KUUROjTQU3z86Weq3w3YFpqAhp28V/v/FQ7T8Lq6MfP2DFc4
         bJgDaPxNPtLWWe7Zr3uFyQmVyDGbk4TpQqsyoEVCFXmJ07wn2P2Qsdrz3gRlKBnFnk
         KBer8H+lXpatyntw19wPMo5GFV8zC+FXUs0AOt98=
Date:   Mon, 17 Feb 2020 15:18:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mripard@kernel.org,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx8mn: Fix incorrect clock defines
Message-ID: <20200217071826.GD7973@dragon>
References: <1581908495-11746-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581908495-11746-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:01:35AM +0800, Anson Huang wrote:
> IMX8MN_CLK_I2C4 and IMX8MN_CLK_UART1's index definitions are incorrect,
> fix them.
> 
> Fixes: 1e80936a42e1 ("dt-bindings: imx: Add clock binding doc for i.MX8MN")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
