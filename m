Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F320C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C59E214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588131053;
	bh=qIWp40UBMVyqIHUX5jhv/ynDwCsy5pkdSuR+Fpjjbwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hZTuF6nXSvW26ynCfwDaHcGoSmLvwyh+yEdizxMydu5nDv0P1f7X2F1bSsx2AAuqp
	 JKN7f9iWo8TRGy4IlutYmBs1a6E71QTjK+GFDD/+gwGYmI4Z+aSImxLVn/1GShWZjg
	 2BGivb3pqoh1gwbtaW3K+QG+b8Fzt2M/vi1Jo4Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgD2Daw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgD2Daw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:30:52 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB217206D8;
        Wed, 29 Apr 2020 03:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588131051;
        bh=qIWp40UBMVyqIHUX5jhv/ynDwCsy5pkdSuR+Fpjjbwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5zHhFGfgDuf9Pm9jITNH4Hal9+bC61h6UF3QWjz18lljYzNFSz6xptM02dowbq6Z
         4VTb+Aje2aBZfSrn+r6MQdoUYYAKdJES3uZBN5qZ4TNkgDJulngcFpgvVCR3pr+n0E
         VMfmUfCFC02M/z7mMuV3embpanStmBa7a9hokmXg=
Date:   Wed, 29 Apr 2020 11:30:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: imx8mp: update input_val for
 AUDIOMIX_BIT_STREAM
Message-ID: <20200429033045.GO32592@dragon>
References: <1587719115-28728-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587719115-28728-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 05:05:15PM +0800, Shengjiu Wang wrote:
> Update input_val for AUDIOMIX_BIT_STREAM according to latest RM.
> 
> Fixes: 6d9b8d20431f ("arm64: dts: freescale: Add i.MX8MP dtsi support")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.
