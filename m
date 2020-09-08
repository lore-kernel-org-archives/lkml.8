Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CFAC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8156E208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599562462;
	bh=vvMiXR8spWwHMb+QxzD+PUuB6XpvOzXxHSAg0g2aaZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CnkEDrkfmCoLMTwEdXWyQqmdavKR3QSD1i9W/Ag8rcxXETj612DBfeTOXfS0/Oh8A
	 wvKK+RUw5AgLEAMpwWITOrn61xCX1RtXu+TzX28tbY7FH7g9ypg3HkkmBbrjiUEi91
	 p3Vk58a4QVh+g6et1vFVLB6S4Qy+IAE7bJ82p6rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgIHKyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgIHKxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:53:30 -0400
Received: from localhost (unknown [122.182.239.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 157C82087C;
        Tue,  8 Sep 2020 10:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599562407;
        bh=vvMiXR8spWwHMb+QxzD+PUuB6XpvOzXxHSAg0g2aaZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdZAcsVpxkSPQGIu7813LmCvxXjzLGMaw7vlVi3SEmYmA3z1MQdXymXxLgImz//i8
         wAynp+ut5Z8MiQsWWcv4fA+/J/ZRZtbkCEuXT0l5m9RLbUfwzp9PhEz6pHEKUnkKdI
         jI2ecwwAIKUPMSuNolJg7A/8dENgIjPJHjA0MNG8=
Date:   Tue, 8 Sep 2020 16:23:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Roger Quadros <rogerq@ti.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] phy: ti: am654: Fix a leak in serdes_am654_probe()
Message-ID: <20200908105319.GE77521@vkoul-mobl>
References: <20200905124648.GA183976@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905124648.GA183976@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-09-20, 15:46, Dan Carpenter wrote:
> If devm_phy_create() fails then we need to call of_clk_del_provider(node)
> to undo the call to of_clk_add_provider().

Applied, thanks

-- 
~Vinod
