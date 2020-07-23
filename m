Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8159EC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 556232065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JgzoCfL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGWUdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:33:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B8EC0619DC;
        Thu, 23 Jul 2020 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1ZUj6zO5sTd4n4tA7q1C5S6zXUszTaQPDC8S97euy/U=; b=JgzoCfL2jGsTn8kMwYIkWwcXlK
        mRPdEM1uzW57Adq3DnpueVvSYSf080Bz0vGrDPEBk2EKk6vRHbg7sADY1ZJDNZCbnCv7SR0SXdVk8
        c7+8itVbfrSZWwYIYyJzj4GpuU2JTIISmkb8g+Aid+HPMReA+IEC2ybjPks/8jQNUhEEgSII/jZVS
        lqZ1/cr15xqVajLQOaw5nUFiaQxCeAa09CcrQbgBzWNwQ5hJn8kTQ+GRMV/qF0kK1awmw6YPIuhwL
        sFJYxwd9qVI61mG3nad2Bp/qq38/fK47/MBWxm1htn2lj7DioDd5+2l6M33DEAsPSgP9vF4x5aTlv
        TBmOBmGg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyhu5-0002mD-33; Thu, 23 Jul 2020 20:33:21 +0000
Subject: Re: [PATCH] ASoC: tegra: Fix build error due to 64-by-32 division
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        geert@linux-m68k.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1595492011-2411-1-git-send-email-spujar@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <18d56fcb-29b1-fbc9-f9cd-7706f65c678d@infradead.org>
Date:   Thu, 23 Jul 2020 13:33:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595492011-2411-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 1:13 AM, Sameer Pujar wrote:
> Build errors are seen on 32-bit platforms because of a plain 64-by-32
> division. For example, following build erros were reported.
> 
> "ERROR: modpost: "__udivdi3" [sound/soc/tegra/snd-soc-tegra210-dmic.ko]
>  undefined!"
> "ERROR: modpost: "__divdi3" [sound/soc/tegra/snd-soc-tegra210-dmic.ko]
>  undefined!"
> 
> This can be fixed by using div_u64() helper from 'math64.h' header.
> 
> Fixes: 8c8ff982e9e2 ("ASoC: tegra: Add Tegra210 based DMIC driver")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/tegra/tegra210_dmic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/tegra/tegra210_dmic.c b/sound/soc/tegra/tegra210_dmic.c
> index ff6fd65..d682414 100644
> --- a/sound/soc/tegra/tegra210_dmic.c
> +++ b/sound/soc/tegra/tegra210_dmic.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/device.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -129,7 +130,7 @@ static int tegra210_dmic_hw_params(struct snd_pcm_substream *substream,
>  	 * Boost Gain Volume control has 100x factor.
>  	 */
>  	if (dmic->boost_gain)
> -		gain_q23 = (gain_q23 * dmic->boost_gain) / 100;
> +		gain_q23 = div_u64(gain_q23 * dmic->boost_gain, 100);
>  
>  	regmap_write(dmic->regmap, TEGRA210_DMIC_LP_FILTER_GAIN,
>  		     (unsigned int)gain_q23);
> 

Yes, that fixes the division problem. Thanks.
Acked-by: Randy Dunlap <rdunlap@infradead.org>


Now I get these warnings:

  CC [M]  sound/soc/tegra/tegra210_dmic.o
../sound/soc/tegra/tegra210_dmic.c:55:12: warning: ‘tegra210_dmic_runtime_resume’ defined but not used [-Wunused-function]
 static int tegra210_dmic_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
../sound/soc/tegra/tegra210_dmic.c:43:12: warning: ‘tegra210_dmic_runtime_suspend’ defined but not used [-Wunused-function]
 static int tegra210_dmic_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
