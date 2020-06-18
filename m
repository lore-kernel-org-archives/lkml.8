Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E735C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE37521BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592463473;
	bh=V5h1ejD6zUH6DYDa9BdWTgrkpCRixg6+jUSZc62MYfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wrlfs4zA5e3oOrpqBJHYX9T0kpyeB3i+LADO9oTNE3Iijcn1iG83MeHpQ1DDL5B64
	 PER2bmZbzn7fp6yR1MEzMn2GwzkIyy5B8X77CapXo0us7LL7URTI8n5c9vsKeoa4zW
	 AIMsbVCg5gKURYf9uTjcdzgozvA/5JnBwpS8jYRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgFRG5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgFRG5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:57:52 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FBF620773;
        Thu, 18 Jun 2020 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592463472;
        bh=V5h1ejD6zUH6DYDa9BdWTgrkpCRixg6+jUSZc62MYfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DvkZ8wYEHQ6FGF1CS1rNq4FEhJewogILEGXdb75uB0zHeiauhDwqJOny+VjTwS+8
         OapYJqYyXMSL+Bg4sJ32WuWXu7/k97O/ZzWj4CXKQtkXeeoGSzResmt3ApeWRTSL8A
         LuQrO4j0vgfhcYXgmToWdLqXrEP4SGkehe/Irp9Y=
Date:   Thu, 18 Jun 2020 14:57:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: imx8m: dtb aliases update
Message-ID: <20200618065738.GB30139@dragon>
References: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 10:02:42AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Minor patchset to update device tree aliases
> 
> Peng Fan (4):
>   arm64: dts: imx8mq: Add mmc aliases
>   arm64: dts: imx8mq: Add ethernet alias
>   arm64: dts: imx8mm: sort the aliases
>   arm64: dts: imx8mp: add i2c aliases

Applied all, thanks.
