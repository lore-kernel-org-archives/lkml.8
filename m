Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C4C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EF82070A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584905862;
	bh=EYj1ZjIKsB8UScswc5qhZWW0Mbv6Cjij0kOFbxjDnfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iW3U7UvoU7anM3Q27EGS4E1EigKbBZWNhRadWlSfx/3oBLknKLS3KTem72OhAvYSt
	 Y4ruKjQDgqDV/htdF/NMgbWQpAPAw5so4m33wCMPSkzHCqjFfGTIrsXPdXA+Sqdqx1
	 sCvwqDsxidFc4LG9sFO9RL3OGYTm1ozafOLIwe3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCVThl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgCVThl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 15:37:41 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FEBB2070A;
        Sun, 22 Mar 2020 19:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584905860;
        bh=EYj1ZjIKsB8UScswc5qhZWW0Mbv6Cjij0kOFbxjDnfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1q81UiRrdoT3EWkQSrFE/8Oxf5fsbuOdedj+OpfPoWQfNboDFhUWxv7q5Cmew0r3I
         lscAWsJuoUPQ+YbVM+cjiOtP9jryH8U4n1X2CSx2Rq587hM0J3ux2/ETMi761OGcF9
         ik1/p1oamSU1FIdpifNjRfJIxwijWCSJDdA+nlQs=
Date:   Sun, 22 Mar 2020 15:37:39 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.5 01/41] spi: spi-omap2-mcspi: Handle DMA size
 restriction on AM65x
Message-ID: <20200322193739.GO4189@sasha-vm>
References: <20200316023319.749-1-sashal@kernel.org>
 <20200316115057.GB5010@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200316115057.GB5010@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:50:57AM +0000, Mark Brown wrote:
>On Sun, Mar 15, 2020 at 10:32:39PM -0400, Sasha Levin wrote:
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> [ Upstream commit e4e8276a4f652be2c7bb783a0155d4adb85f5d7d ]
>>
>> On AM654, McSPI can only support 4K - 1 bytes per transfer when DMA is
>> enabled. Therefore populate master->max_transfer_size callback to
>> inform client drivers of this restriction when DMA channels are
>> available.
>
>As ever this only provides information to other drivers which may be
>buggy.

I'll drop it, thanks!

-- 
Thanks,
Sasha
