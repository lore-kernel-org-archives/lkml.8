Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42226C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220182072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592910449;
	bh=zsfKB1wuRE9SSXUBbFLTHKmSLXW6nA+V2ztTFC7lHs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B63mdouiFohg3PZSzf7DCV6tPBhRpyIxMcXJXDzTMPVxGO0Cw/THjjTLKWKsfsvDY
	 ii4rM7BnNALGA9XnpZ6Fz3D0ZCEiCe4mj2e0FP8wDGlz9CLQZt4JsvpLNSvl+GeTXk
	 MCndCVWQ1xfneYY3EhZyJNXgb+dmvDia5LTaeKT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgFWLH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbgFWLH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:07:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8059D2072E;
        Tue, 23 Jun 2020 11:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592910446;
        bh=zsfKB1wuRE9SSXUBbFLTHKmSLXW6nA+V2ztTFC7lHs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PY2qDnfEkRWh64fvJQJyDv79ltuupggMNAkE7iNBNsaD+7RGnhEkx1cYdXSH5F06H
         uZdZqJ8knVOiE20AX92B+EGOEmmP2bNOmgUtDJ0l3UyezYAgoFVvCk1mjBI8PPeioy
         09TfWUJ/d5RJW5ngA/MMsrpbsKOnex4ffkufF9a8=
Date:   Tue, 23 Jun 2020 19:07:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 0/3] arm64: dts: imx8qxp: dtb aliases fix/update
Message-ID: <20200623110720.GY30139@dragon>
References: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:49:51PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Fix order in patch 2/3, no other changes
> 
> Minor patchset to fix and update alias for i.MX8QXP
> 
> Peng Fan (3):
>   arm64: dts: imx8qxp: add alias for lsio MU
>   arm64: dts: imx8qxp: add i2c aliases
>   arm64: dts: imx8qxp: Add ethernet alias

Applied, thanks.
