Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E113C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594610539;
	bh=59mZYRNAzcxgHIO3OMwPaOI3VjJIXJrdO39yAFq5mxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lmFXZtGHlemT1JYuaPNCCXdWtWy1MCN9w16oowpTdxi++XZWI6U/Ip6dqjlOu0eB8
	 TE8wUpJ3MW07IBNy1Gc8LmKMxjZzCgVXvjiCjuRB2TFPpT5106mSespCaOUGSv2WxN
	 igWAy7wp/I2h/DGF7xsFhY0+NEfno2McqfWQMl6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgGMDWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMDWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:22:17 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EB08206E2;
        Mon, 13 Jul 2020 03:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594610537;
        bh=59mZYRNAzcxgHIO3OMwPaOI3VjJIXJrdO39yAFq5mxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9Z8rFVc8LGG0fLJt9zmjolvrFqpVzB2yq3XuaRC2J07hHBD1n3J607TuXx3/ywIP
         zcMjQigf7sjNMbHtNL3fvWoLp+F2cyinbykF5LwUuTcxxVxogZCWv6rhI7wYkNni9T
         mrRzVZ4Qz4H+IDWOZGnCQgHvPTfwrP0wjvsM1DxU=
Date:   Mon, 13 Jul 2020 11:22:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6ul: Add ASRC device node
Message-ID: <20200713032207.GC21277@dragon>
References: <1593575216-19921-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593575216-19921-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 11:46:56AM +0800, Shengjiu Wang wrote:
> Add ASRC device node.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.
