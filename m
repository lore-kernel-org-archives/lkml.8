Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8256AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F2420708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="ZMZBd3C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgESFpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgESFpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:45:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C75C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 22:45:16 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v5so10097269lfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 22:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f76EOTr9ng0HQJqS68gOEOMao8wCn3C/r3Rj0POH9q8=;
        b=ZMZBd3C4Oqz8XC6fRUUSAI8r6H/HvXwKZ4VKzRdjB86o0RPVdXqE7FekRxhhIpxc57
         ysKgcMYfNh/MsQ25weGNYlqKTQfsozwcSw2csNnB8nCzwI6XllSAFUBTREd7fuGxUsaX
         AHdzwnF2XPr8jv6EJ33fAfnd2dmPM5N3X5ukG2ULEhZ7Epc7aJo8D2SmWVAn0USkTj7p
         pU9Gbbe6SoDbMZLOuj05pxPDGnwGR7/V/2Mk4fyRnnHn1dtaYewNeC/RXgR75MOPzxpY
         9yMjSIt2CUcqJjcdgy/dr4brp+tOosEH3E4Ru37UnZYNnLWHyOpUqbW5OcCebtjTyizU
         GTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f76EOTr9ng0HQJqS68gOEOMao8wCn3C/r3Rj0POH9q8=;
        b=prifEl1pSAqAk+XLj74w1ayg55/X1bLxgCXX8T5eURyI/gmMxqNcYijetz+McHKCJ7
         y65c+uiDcm7VFd13ktnxPEP6jWc0jIVtSyHOgLVYFu5Vm9omF89L8PKk2mhbjSHqmV5C
         pgtPqrx7tvuJ9xsFMMz5RkI6wKShnzr8r06jeugk9296xv9+PGT7B8rBvyrtkIqkWzhS
         lpgbW+JJsGfjRk0tysjdSTv+yuCg+dS0sGliEcZ4125fXFO0BYu8xjwNP5ex9hulyhbZ
         /0+e8bFhQKpGH7Bi3lwQCcGCgNA7pHLF9hUM+Gi3cYN3f370gO1GmdhSkvSVimwmoiWZ
         crXQ==
X-Gm-Message-State: AOAM532159Y3tv3Jz2drRt3rT8p9UZ9nWfSu3lqjWOdRoEiC1s2F0/YH
        YdoMUJ8xQuidriw34SrvgEfeUQ==
X-Google-Smtp-Source: ABdhPJzThNm5a6/nvPnTKurFxSLJKcfIIu9iNXbnWA/NOV0iHFCtMVkCkSI2rTos5e8exn/p52/OpQ==
X-Received: by 2002:a19:6914:: with SMTP id e20mr7618653lfc.27.1589867114782;
        Mon, 18 May 2020 22:45:14 -0700 (PDT)
Received: from buimax ([109.204.208.150])
        by smtp.gmail.com with ESMTPSA id m13sm8304025lfk.12.2020.05.18.22.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 22:45:14 -0700 (PDT)
Date:   Tue, 19 May 2020 08:45:12 +0300
From:   Henri Rosten <henri.rosten@unikie.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, lukas.bulwahn@gmail.com
Subject: Re: [PATCH 4.4 17/86] phy: micrel: Disable auto negotiation on
 startup
Message-ID: <20200519054510.GA28178@buimax>
References: <20200518173450.254571947@linuxfoundation.org>
 <20200518173453.976038108@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518173453.976038108@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 07:35:48PM +0200, Greg Kroah-Hartman wrote:
> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> [ Upstream commit 99f81afc139c6edd14d77a91ee91685a414a1c66 ]

I notice 99f81afc139c has been reverted in mainline with commit b43bd72835a5.  
The revert commit points out that:

"It was papering over the real problem, which is fixed by commit
f555f34fdc58 ("net: phy: fix auto-negotiation stall due to unavailable
interrupt")"
 
Therefore, consider backporting f555f34fdc58 instead of 99f81afc139c.

Notice if f555f34fdc58 is taken, then I believe 215d08a85b9a should also 
be backported.

Thanks,
-- Henri

> 
> Disable auto negotiation on init to properly detect an already plugged
> cable at boot.
> 
> At boot, when the phy is started, it is in the PHY_UP state.
> However, if a cable is plugged at boot, because auto negociation is already
> enabled at the time we get the first interrupt, the phy is already running.
> But the state machine then switches from PHY_UP to PHY_AN and calls
> phy_start_aneg(). phy_start_aneg() will not do anything because aneg is
> already enabled on the phy. It will then wait for a interrupt before going
> further. This interrupt will never happen unless the cable is unplugged and
> then replugged.
> 
> It was working properly before 321beec5047a (net: phy: Use interrupts when
> available in NOLINK state) because switching to NOLINK meant starting
> polling the phy, even if IRQ were enabled.
> 
 
