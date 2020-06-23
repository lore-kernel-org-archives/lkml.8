Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDAFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FEC20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592884396;
	bh=Wp5chbRNJuFWD8uHzmxgXDHr5PmBm1ZhwdDYKZCk/OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FmDwJqj4xSKOdnAT8xn+To9qaAtPmWCkt1jybwOfDYU04uhqcpUCrXFELFx1JS9wH
	 /jCAPNA+C+66EyS3Hzz+ZwnclbktIBCwpt926w+sX+Te/W5l2MxGpfdyXJaZaz5iw3
	 Ba579CfDhOsFapsfVz2Wojvhnlo0fu/1ZxGZ2ZSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbgFWDxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 23:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731114AbgFWDxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:53:13 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF8220707;
        Tue, 23 Jun 2020 03:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592884393;
        bh=Wp5chbRNJuFWD8uHzmxgXDHr5PmBm1ZhwdDYKZCk/OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKcqlHDc/30jWp3TBHXsIIp436pqkk+yAVP/ZWLQAbSHrSTE4pZPBjJEjPrv2MXLA
         HxQZyQ98+mLVlXX+yW+JIiJ4rJeoSE129ywlAw8F0AzsGRWDmqsDfd8JxQJgv4RXjs
         2kFNDAQ/JxoagRrDxo6EdIzh/f2juMQurGaoPm0o=
Date:   Tue, 23 Jun 2020 11:53:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: imx8qxp: dtb aliases fix/update
Message-ID: <20200623035300.GM30139@dragon>
References: <1590977180-9957-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590977180-9957-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 10:06:17AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Minor patchset to fix and update alias for i.MX8QXP
> 
> Peng Fan (3):
>   arm64: dts: imx8qxp: add alias for lsio MU
>   arm64: dts: imx8qxp: add i2c aliases
>   arm64: dts: imx8qxp: Add ethernet alias

Applied all, thanks.
