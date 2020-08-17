Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47603C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190A92075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597670720;
	bh=fRSsjlMiQ7T0SidfHl12cOpI7j4a3NuX7eV9gm9EXh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S2kQyJlrHpzXm4+NBkr18VyR15PIeqv8Noac/VwYQK8Fc3rNPjCKAE9vIjqRSdI+8
	 z08Zk0l2283vkDj7pDnMFtl4TgWnxX6a7PyU2W5RnTg4WB502+ovllcOjuBoK8eZ2U
	 sS3zMmoyWCgSnldSTKpUoSG0TJwfQfw8GbLZJ3Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgHQNZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbgHQNZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:25:18 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF752072D;
        Mon, 17 Aug 2020 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597670717;
        bh=fRSsjlMiQ7T0SidfHl12cOpI7j4a3NuX7eV9gm9EXh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHiZpRKqhmi3LiLIjISwh73O/ByjCTkh+COyWqPsPIo9+eNAiPQ9CYr9YKn5Ik4GC
         Pikr/lHpp3axcNOMDVYlJAGpwCcvxaIDLWm8RSFU0KiLr2iGa7xgw9BjbLLRvCR6Qz
         asc+Q8tZg8ABuua3pj9PK98ZASdGkp6FZDrs34tQ=
Date:   Mon, 17 Aug 2020 21:25:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qp-sabreauto: enable pcie
Message-ID: <20200817132511.GF16951@dragon>
References: <1595316176-8533-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595316176-8533-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 03:22:56PM +0800, Richard Zhu wrote:
> Add the reset-gpio property, and enable PCIe on iMX6QP SABREAUTO board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Applied, thanks.
