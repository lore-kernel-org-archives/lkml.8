Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D4C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C8222522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579789173;
	bh=7Ehhr3RcKJp5rNbXCW0vgv3MFQ61Ixyk+/w7br8QJmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uGuAK/4pLN6FcoQ55Y8lMeDah7zRk17IJZFPVnBNqRpoWO2Nep9bCr8nm3F6jlPcs
	 ylmEl/43hobnrc7sqk8QJKE3je4mzsZbXl8G+RRl17nI0jNWXGrzc/gQncwYHhgmvG
	 ttIKvBwdeSblVa+iPPmxplpym9XpOlz4mPXcuqa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAWOTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgAWOTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:19:32 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E94720718;
        Thu, 23 Jan 2020 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579789171;
        bh=7Ehhr3RcKJp5rNbXCW0vgv3MFQ61Ixyk+/w7br8QJmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ck30PxMR219a4zqfvKd4pZH/W0pXpeM6HsUMaSYrapQJaqTeQ74QBD6nwm7Cx6YTj
         vffmkdId3V46x6gVqqZsYjuA8Gg84SIiF/EpOErte7d8xjV0Qce8UKgD7FSYUKaXj7
         Lkcta7GlBVGkGWU6j1FiBYhe4TisWB9piXZMdSz0=
Date:   Thu, 23 Jan 2020 09:19:30 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 104/671] ARM: dts: r8a7743: Fix sorting of
 rwdt node
Message-ID: <20200123141930.GD1706@sasha-vm>
References: <20200116165502.8838-1-sashal@kernel.org>
 <20200116165502.8838-104-sashal@kernel.org>
 <3a84e4dc-1d2a-3809-ffac-33d75eb73351@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3a84e4dc-1d2a-3809-ffac-33d75eb73351@cogentembedded.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 12:32:21PM +0300, Sergei Shtylyov wrote:
>Hello!
>
>On 16.01.2020 19:45, Sasha Levin wrote:
>
>>From: Biju Das <biju.das@bp.renesas.com>
>>
>>[ Upstream commit 383f6024981d32425fa453bf2e66b546fdbc1314 ]
>>
>>Watchdog node is incorrectly placed on r8a7743 SoC dtsi. This patch fixes
>>the sorting order.
>>
>>Fixes: b5beb5d4c81c358f50a8310108 ("ARM: dts: r8a7743: Add watchdog support to SoC dtsi")
>>
>>Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>>Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>>---
>>  arch/arm/boot/dts/r8a7743.dtsi | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>
>   I doubt that the DT node reordering is worth merging into the 
>-stable kernels...

You're right, I'll drop it. Thanks!

-- 
Thanks,
Sasha
