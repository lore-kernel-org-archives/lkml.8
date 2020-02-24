Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E5C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A742080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I4/tVjd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgBXQbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:31:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgBXQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=qh1LUc+qxPHEVoho6FaU1vCoNs7OEstk4AiDTBBk/Bo=; b=I4/tVjd7cQH/PskjU6+l3QSZ5/
        Fo5TtMoEvO9vFR+dVEvxJQMHwu94R/1Eb6PQyp+L3gP446cMb73QLJVTGnPKkiB02f4xoN2KeH0Sx
        /2WpDaCoklEyqK3OdB0Sg5ew6kLIST3tWfV8Yz1qROK0+8L/Ye0V4SASIlp78U1jyvOFWVN9jVu1h
        vvQgBodx7XJXEHN9UohBU0hVpjUZGGMUcIH6GfmL3feUoQpBFk6ROzMaYX50anXza4ZrX6ljzTQTC
        AUMqkRFOdQcyc4LqmditI6nA0SSwUvK0R8FvpGcY1i0rXP9Mh5Hm2W35Hj1qZLBQQy5avC49UKGGQ
        tscH4WBQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6Gdb-0003UZ-47; Mon, 24 Feb 2020 16:31:19 +0000
Subject: Re: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200224112537.14483-1-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eac16b4c-8920-78a0-6ca5-dd72cf83888d@infradead.org>
Date:   Mon, 24 Feb 2020 08:31:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224112537.14483-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 3:25 AM, Geert Uytterhoeven wrote:
> On i386 randconfig:
> 
>     sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
>     wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
>     sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
>     wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
>     sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
>     wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'
> 
> Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> Before commit ea00d95200d02ece ("ASoC: Use imply for
> SND_SOC_ALL_CODECS"), SND_SOC_ALL_CODECS used:
> 
>     select SND_SOC_WM9705 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
>     select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
>     select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
> 
> but SND_SOC_AC97_BUS_NEW never existed in upstream.
> Should there be another dependency>
> 
> See also "non-existent SND_SOC_AC97_BUS_NEW (was: Re: [PATCH v9] ASoC:
> pxa: switch to new ac97 bus support)"
> http://lore.kernel.org/r/CAMuHMdU3uxfBwKd8SkOtZSDV5Ai3CKc3CWRhDy0Cz94T1Hn0iA@mail.gmail.com
> ---
>  sound/soc/codecs/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 9e9d54e4576ce5ba..a7e89567edbe8b47 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1610,16 +1610,19 @@ config SND_SOC_WM9090
>  
>  config SND_SOC_WM9705
>  	tristate
> +	depends on SND_SOC_AC97_BUS
>  	select REGMAP_AC97
>  	select AC97_BUS_COMPAT if AC97_BUS_NEW
>  
>  config SND_SOC_WM9712
>  	tristate
> +	depends on SND_SOC_AC97_BUS
>  	select REGMAP_AC97
>  	select AC97_BUS_COMPAT if AC97_BUS_NEW
>  
>  config SND_SOC_WM9713
>  	tristate
> +	depends on SND_SOC_AC97_BUS
>  	select REGMAP_AC97
>  	select AC97_BUS_COMPAT if AC97_BUS_NEW
>  
> 


-- 
~Randy

