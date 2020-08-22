Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E7C214F1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598066986;
	bh=5Uk9flHxINPaa5OlAOFUuaAiQgeZi2oqIMu8KGSyZp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WWDkkLb0DFXMuFwEFai6IN5mietoynfalMVEP6wcIlh0KX1We5pl7yA5umSdBG0v4
	 emQ7JI/T4w0MWvdnCQkjwB2ZGqNicqca3B8q6DnLNTC3hLa8U4kHTbPPz77SznPtIm
	 FcywFbxLolqZ3F+PgqO8mW6XlxngcdVF9KprVDSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHVD3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 23:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgHVD3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 23:29:44 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1708207CD;
        Sat, 22 Aug 2020 03:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598066984;
        bh=5Uk9flHxINPaa5OlAOFUuaAiQgeZi2oqIMu8KGSyZp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiuZfrbSc71mqso6tI2hpJ65cT4fbLCyz2Y7+9vPZ9QElh565xdNwbHTNjVQVnL1y
         RO38xZUpZ3sxHSyrJApNW4PgEMivQzy3hcvRIq9IcCcGo6U6iJ+2FDtSH94nS0K0GD
         dsQ5ThTtTF5whdyN3NHcMRgq42cf5DtHInJq8xcE=
Date:   Sat, 22 Aug 2020 11:29:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     andy.tang@nxp.com
Cc:     amit.kucheria@linaro.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] arm64: dts: ls1088a: add more thermal zone support
Message-ID: <20200822032930.GA27575@dragon>
References: <20200715064909.9161-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715064909.9161-1-andy.tang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:49:08PM +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> There are 2 thermal zones in ls1088a soc. Add the other thermal zone
> node to enable it.
> Also update the values in calibration table to make the temperatures
> monitored more precise.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied both, thanks.
