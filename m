Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB3AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5146120714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olbpfkI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgBLQUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:20:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBLQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=+UKmHxiuZF1shyZt5oca8fTPDu1pZzR6zzY6ICKT86M=; b=olbpfkI4hWORuzwrfVqSmdX12v
        4GgVopStHyZZAtAuXxWOKGr4+I+xfs7Xi35KHn2imuxJzCSDloJUjXlJ9wnF/RKvrOi0vo6BOQ7w9
        R3Em34rcq1/DtrWFt86iXuM47N6ZZpkfv54V/B0cWv3lwcAxk+Y3D7ZfMe5KWJG92MSNx+czhrqU3
        eXna46aLU0ZvuTQfdxEswxUcaP/3xRWnXq8RXvYsnznVprHK8RrQ7aNrykYkLEFyflxpSSTXd96Fa
        JBCA1QFY2SNReCR0BnqzgxAjuZaoGcX4cwBvGdxJkzEyJVKF8j8HiTopT72KlLp/0H3xCqB/pbUtm
        F7B6qsBQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1uko-0004pe-6K; Wed, 12 Feb 2020 16:20:46 +0000
Subject: Re: [PATCH 1/3] ASoC: Fix SND_SOC_ALL_CODECS imply SPI fallout
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200212145650.4602-1-geert@linux-m68k.org>
 <20200212145650.4602-2-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4cd8ffb2-0d3c-dd04-5cf7-bd4d6ccb9d43@infradead.org>
Date:   Wed, 12 Feb 2020 08:20:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212145650.4602-2-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/20 6:56 AM, Geert Uytterhoeven wrote:
> Fixes for CONFIG_SPI=n:
> 
>     WARNING: unmet direct dependencies detected for REGMAP_SPI
>       Depends on [n]: SPI [=n]
>       Selected by [m]:
>       - SND_SOC_ADAU1781_SPI [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
>       - SND_SOC_ADAU1977_SPI [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
> 
>     ERROR: "spi_async" [...] undefined!
>     ERROR: "spi_get_device_id" [...] undefined!
>     ERROR: "__spi_register_driver" [...] undefined!
>     ERROR: "spi_setup" [...] undefined!
>     ERROR: "spi_sync" [...] undefined!
>     ERROR: "spi_write_then_read" [...] undefined!
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


thanks.
-- 
~Randy

