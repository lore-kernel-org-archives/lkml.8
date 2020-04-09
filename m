Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9E8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4144206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtJmkLcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgDIOwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:52:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43505 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgDIOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:52:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id k28so8096003lfe.10;
        Thu, 09 Apr 2020 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ze/V2JXU5Dd6o3pQccxKMS1reN02+30rheQBo6CTvd8=;
        b=EtJmkLcKWT1VvBoekMfVi4G/IdP51lOLqGI3DCGWKvYoSJX9VTKrBV7CfBuc5fCDo+
         uKw1cbIpserHPhUs/W//5NfRkr2B1Iac8FMcQImayUXWPy/IBMA1wJ4WHZtvOBI8XGtd
         LjpQ/cco9NMOtKBsQIWtLsallphNy3kVNYKHwJ7U5SYaMeVK6CwILbQbp103mlI/l2gy
         My75x9UeDmhAx+bzfZERtqKjTOH2oZcR67OlnF+0H9OBzBudwTyYEIt0nBZqDch6WHIn
         kaVycaWjKQ+S4qRGChhI68gskphg55kBWYyKUcCGSoT021hFDuf8nOBT475Ue3sjuNQJ
         CcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ze/V2JXU5Dd6o3pQccxKMS1reN02+30rheQBo6CTvd8=;
        b=iebuAhm18WUx4AGJdjVdkG0XUNFXxjQcdGZ1xnBAFllbEtFeNC22h2BXWo6Uvv0p5Y
         DTBel7u75VNtqTJU4PWMKvhovQISRuCig9BQd9KaMZmJ4ISGU2+XW+3xSOn6o6oxHq1G
         4s9oTnuXhQQLcYXr0bysDfQ36bgfNpGXtiZ1UwyduABsrkA2ykWU9Bpo/PxVeKAKWIck
         qL6d0XDwFl5ly0KoyZf5EXbW/R/JVCHjn0kGyw4Ad1b1AdsmOQJJiMaBiEgoCnjC277G
         NeyOGMotgiZuCYxVPVal/YhkuCkVWz0DrBgvUau6ugFoOQovX7Xt1DuKlZ7n+l7ogfu/
         6OmA==
X-Gm-Message-State: AGi0PuaG9TV6+g6Rk1LGNl2m/Gjpx1Tk76Il+smxzJThsMkv1yU21syT
        2WANygNDtwYa9jh2I4gGLmd9sRfw
X-Google-Smtp-Source: APiQypKEJgsBG72cT7T421h/LiCZlt01kMa/HHAJAkrMz6hTbZ3iGPgQpuFAJHbdjXE3AzP9I6kzuw==
X-Received: by 2002:ac2:4c34:: with SMTP id u20mr8073483lfq.40.1586443931852;
        Thu, 09 Apr 2020 07:52:11 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id v17sm3353142lfe.34.2020.04.09.07.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 07:52:11 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] Support headset on Tegra boards that use WM8903
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200330204011.18465-1-digetx@gmail.com>
Message-ID: <5c9c995a-a571-e543-e680-30739cb1561c@gmail.com>
Date:   Thu, 9 Apr 2020 17:52:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200330204011.18465-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.03.2020 23:40, Dmitry Osipenko пишет:
> Hello,
> 
> Some devices have a 4-pin jack instead of a 3-pin and currently the
> WM8903 configuration is hardcoded to the case of 3-pin jack in the
> Tegra's ASoC driver. A new device-tree property is required in order
> to convey that hardware has a 4-pin jack, and thus, microphone's
> detection needs to be done in a different way.
> 
> In particular this is needed for Acer A500 tablet device that has
> a 4-pin headset jack, otherwise userspace sees headset instead of
> headphones and internal microphone isn't enabled by ALSA UCM rule
> when it should be. Please review and apply, thanks in advance.
> 
> Dmitry Osipenko (2):
>   dt-bindings: sound: tegra-wm8903: Document new nvidia,headset property
>   ASoC: tegra: tegra_wm8903: Support nvidia,headset property
> 
>  .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt | 1 +
>  sound/soc/tegra/tegra_wm8903.c                              | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Jon / Stephen, are you okay with this patchset? Could you please ack it?
Thanks in advance.
