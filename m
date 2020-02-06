Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90FDC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B1321775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPHy2zld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBFRgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:36:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43859 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFRgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:36:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so6961771ljm.10;
        Thu, 06 Feb 2020 09:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=99COUShDb8aW8HJQ86DZUh+rAFpSeu/Mbihks46FJLY=;
        b=BPHy2zldSziVYVCUKXNFslpdpUmxMJCyizD6jhE/aCDcuC7x8UUBKGA/UK5pLK3LkS
         HlkYo10eHEbI9t6ikDq/9rbtORbcWJgipP5cvfETYPSn7ubHJ60AiYykp9WWHie0ZMr5
         L9HMghLYgv2Vnm0KvHUWZSGer4Pa69mbVQf7/4lM/EC1ycQHInmiHU3QBgeftthoZbgH
         tX2q2U1qaRiXNcmBQDCwUBeuI9P6xcyV6k8QFQcrQQXNkRm826iczGsJBUMrjrMmnyjq
         cDzHUrE1Zeu17OyMjX1Lm/wFrlS/2E85GyXSQ6V5NWpswbqpLgOMVomJQR4JHrUy1gOh
         OegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99COUShDb8aW8HJQ86DZUh+rAFpSeu/Mbihks46FJLY=;
        b=otMzgU7Rf7uBuKYOVpyrDWwfIuuAmJz7d4O3ToRuWMIL+ePqln4LggXmeE3Y782j4O
         YO3eLnemPXf+D7DtmQTTlqGVoNHxxwY+mtoij7OrvP9r8LCMcTYg1uGi/qCnwUVtYLJJ
         dS9zvQbuGRAf7Tse/EFKfdM3l1EZ2NaA3XQoDQnuCFtt3hq4/3TR5ft65Rz1UbTc91M7
         FEFIrQWjwfxysYFJULRZsHX81bsqh0fzGUcL4mv7UOH4ARegVlAe7VnTauu2G8Z47Goc
         nCL9ey+kaJm0BGPIVKEu6sMURN30clnM1LooEeTfPkKAdtuFmPs5GQqsiSm2ORT8ku1J
         741w==
X-Gm-Message-State: APjAAAWjidqjnpTPyPo4f8U0Ln95O7nTtmBnalbDCayipu7ldRZNv78H
        ZLHW8ujmD3R+pxcBe5vAqRc=
X-Google-Smtp-Source: APXvYqy8VlPo21S7t8VY9LztJyOrQWk44mVu443sV8IZkmAYtKR96arFx6ZYroi+0UqGtHS0U0bKvg==
X-Received: by 2002:a2e:761a:: with SMTP id r26mr2776605ljc.135.1581010566382;
        Thu, 06 Feb 2020 09:36:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u9sm364lji.49.2020.02.06.09.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 09:36:05 -0800 (PST)
Subject: Re: [PATCH v2 0/9] add ASoC components for AHUB
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fcab0af1-fe84-6028-701b-ab101feaa8de@gmail.com>
Date:   Thu, 6 Feb 2020 20:36:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2020 13:33, Sameer Pujar пишет:
...
>  sound/soc/tegra/Kconfig                            |  56 ++

Probably won't hurt to enable the new drivers in the
arch/arm64/configs/defconfig?
