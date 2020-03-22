Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C39EC4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 18:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11C820753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i9/EM43p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCVSbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 14:31:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45721 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVSbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 14:31:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so9334882wrw.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=t345tliBlqINDa8PSXt4lv98Z6uPV9ApDsTwoyUh4K8=;
        b=i9/EM43pwbkPODkA43IfFBziz7mD/e2iF6QmH9MXMkV9EccK1pkaR3rkTuF8/B8fI7
         4Z+8vCAC/lxmreMsVBxcXHtkQ9nDEPc49qfT9K2JQY2ad7+kBpmT5zUEWR+uF0t//LPC
         8AhdL3pPEdMamUDWdUXITgMN3Kpky5dMfJZvQTsEnkWoszljOc5ILpGVgBirodYJ9l+c
         uU9HINVEpKOEBNXi4PYSkyex0Yo70OrXvUFy4UhVMXU7WiWG/KgfsHEo9jhtREw26K3n
         oLY8u9EJG854eFvPSh/uvdoQKzyg9kgriDehTs5l9MhzrLrteW1u1wzrONNFlpBjPT6a
         /j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=t345tliBlqINDa8PSXt4lv98Z6uPV9ApDsTwoyUh4K8=;
        b=OdHBg5+Rk0QmBz3E3NtwqU19tRijJhm5pQS1Iria1dDUccXGSUUdv7NeswEwL7PvjG
         79xJJ1rZ/82iTIkMgplXTcQEmkHrDSYvYwYMIFwn1eKTlogvwfjbfu+d5xQzVeip3Kmy
         VdhrxfpSuJZHMi3E6MUYB8kGvycVb6DcPHKSQXuuxzDUlG6PQogMFjkZ9q/08Uc+gyEf
         ES1Gkmxuvbv7L51q06cmgVdV2OClrE64NxWgABmoU0280slOzuRS1Oydr597UNX5c7bn
         JC79HUbmobMONJvK/yLG4pUsQQV9n9D2g+Qfpwqt+pP6JgwR83hNGNRUiUHR0eV98qec
         Vngg==
X-Gm-Message-State: ANhLgQ1OC1kE70ZpFkwDd0Xwjted7aY/5i+BYRr3Tlr5tYrL5GRIMyQJ
        0YRW41U/ulQpbBqwulMdj14Bvg==
X-Google-Smtp-Source: ADFU+vtYl2tirhzygQLImaRvVxGsLaQ7qwRGlxRLIFaQgG6POo2NZlaxl4e7Zub8wnLdztr8JVbVyw==
X-Received: by 2002:adf:b31d:: with SMTP id j29mr10790210wrd.218.1584901893310;
        Sun, 22 Mar 2020 11:31:33 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id s1sm19915958wrp.41.2020.03.22.11.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 11:31:32 -0700 (PDT)
References: <20200316023411.1263-1-sashal@kernel.org> <20200316023411.1263-8-sashal@kernel.org> <1ja74gg0v8.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH AUTOSEL 5.4 08/35] ASoC: meson: g12a: add tohdmitx reset
In-reply-to: <1ja74gg0v8.fsf@starbuckisacylon.baylibre.com>
Date:   Sun, 22 Mar 2020 19:31:31 +0100
Message-ID: <1jsgi0ckcc.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 16 Mar 2020 at 09:28, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Mon 16 Mar 2020 at 03:33, Sasha Levin <sashal@kernel.org> wrote:
>
>> From: Jerome Brunet <jbrunet@baylibre.com>
>>
>> [ Upstream commit 22946f37557e27697aabc8e4f62642bfe4a17fd8 ]
>>
>> Reset the g12a hdmi codec glue on probe. This ensure a sane startup state.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> Link: https://lore.kernel.org/r/20200221121146.1498427-1-jbrunet@baylibre.com
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> Hi Sasha,
>
> The tohdmitx reset property is not in the amlogic g12a DT in v5.4.
> Backporting this patch on v5.4 would break the hdmi sound, and probably
> the related sound card since the reset is not optional.
>
> Could you please drop this from v5.4 stable ?

Hi Sasha,

I just received a notification that this patch has been applied to 5.4
stable.

As explained above, it will cause a regression.
Could you please drop it from v5.4 stable ?

Thanks
Jerome

> It is ok to keep it for v5.5.
>
> Thanks
> Jerome
>
>> ---
>>  sound/soc/meson/g12a-tohdmitx.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
>> index 9cfbd343a00c8..8a0db28a6a406 100644
>> --- a/sound/soc/meson/g12a-tohdmitx.c
>> +++ b/sound/soc/meson/g12a-tohdmitx.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/module.h>
>>  #include <sound/pcm_params.h>
>>  #include <linux/regmap.h>
>> +#include <linux/reset.h>
>>  #include <sound/soc.h>
>>  #include <sound/soc-dai.h>
>>  
>> @@ -378,6 +379,11 @@ static int g12a_tohdmitx_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	void __iomem *regs;
>>  	struct regmap *map;
>> +	int ret;
>> +
>> +	ret = device_reset(dev);
>> +	if (ret)
>> +		return ret;
>>  
>>  	regs = devm_platform_ioremap_resource(pdev, 0);
>>  	if (IS_ERR(regs))

