Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9BEC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5F620738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594613520;
	bh=09JhWPDy5Ku5b4eWOwy1aGRkyyjcKpPVN4+FSFuKnd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SFRVkB770bBFc4Cb/XkUgi/7BEUu1X1X/XE5sBt7lTQZSvxjHm5voOBKXS+6u5wDs
	 m3xLSCAIE0vSLLMKyY8OfD8f/ibic81eSaH+OO1Op3a124/lXP0ikdlV2piFcEM57j
	 Uc2gYr5yaTQosqhlnfSJ7Z5YHovoniClCiCA/ATE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGMEL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgGMEL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:11:58 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 553FC2070B;
        Mon, 13 Jul 2020 04:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594613518;
        bh=09JhWPDy5Ku5b4eWOwy1aGRkyyjcKpPVN4+FSFuKnd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRnbMyWZDEsr4LSt6mJCkzvhgqJvYAKIX6/jgFcRL+i6IB5M5/iW2i4BE1QOp9ffz
         MhAe3KJ9kTxiP8O+BUNis4mKu6m/PEL1sTTBB2jSD3nUtgDMsuioG6Y5100Jd4KMQq
         fxrJMeqQy+dLgpyxg7nl0QTA7+TnYCDs4fUTzX5Y=
Date:   Mon, 13 Jul 2020 12:11:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        frieder.schrempf@kontron.de, catalin.marinas@arm.com,
        will@kernel.org, anson.huang@nxp.com, festevam@gmail.com,
        s.hauer@pengutronix.de, john.lee@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: Re: [PATCH v2 4/4] arm64: configs: add pca9450 pmic driver
Message-ID: <20200713041151.GC12113@dragon>
References: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
 <1593793178-9737-5-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593793178-9737-5-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 12:19:38AM +0800, Robin Gong wrote:
> Add pca9450 pmic driver.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Updated subject prefix like 'arm64: defconfig: ...' and applied patch.

Shawn
