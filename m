Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7AEC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D284A2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581493658;
	bh=khRNRuCZwxnKABFVYe1snupsbWNrsELF2kP13DYwuWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HdLKcCYzX3PACJJsMC58Ztz+92w7vxAGX3wtIQfuzQXdPx/2oBVO8gIQlry56LRkK
	 hRhKcqzSDWyC46gROSygoLNOIhIXL50/4Q0AMuHrkXfFd6N+5/CdW+AfWp6fkyV3Vj
	 psTyEx0zNQAbkIq0byglnV+o6nHMjUufjmWcbjno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgBLHri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbgBLHrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:47:37 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9499E206DB;
        Wed, 12 Feb 2020 07:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581493657;
        bh=khRNRuCZwxnKABFVYe1snupsbWNrsELF2kP13DYwuWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/XcnxHy23iM4GNy0ATaZ9fXD01JkDVv2jFLkWtBH1hr5bIaQRG2L5y3SZntbR+4w
         ui4xuR/WJ9uh3d6CPKUWk8Zc8gyBCc/IIQpmDb+0dmzDSK07ZPd9YY0lnR5qgA3AHT
         uT//b0xogwwtTzSr597rYSqWVx9ahQIK3PW/PtOI=
Date:   Wed, 12 Feb 2020 15:47:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, stefan@agner.ch,
        kernel@pengutronix.de, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        catalin.marinas@arm.com, will@kernel.org, abel.vesa@nxp.com,
        bjorn.andersson@linaro.org, olof@lixom.net, maxime@cerno.tech,
        leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V9 3/3] arm64: defconfig: Select CONFIG_PINCTRL_IMX8MP by
 default
Message-ID: <20200212074724.GE11096@dragon>
References: <1579052348-32167-1-git-send-email-Anson.Huang@nxp.com>
 <1579052348-32167-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579052348-32167-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:39:08AM +0800, Anson Huang wrote:
> Enable CONFIG_PINCTRL_IMX8MP by default to support i.MX8MP
> pinctrl driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
