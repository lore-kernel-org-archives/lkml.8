Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B43C2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B11206F8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5RYFQBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgDEUzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:55:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39010 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgDEUzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:55:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id v7so1080297lfg.6;
        Sun, 05 Apr 2020 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BjsKuMlhS1rf8i63JMOPA6xr54aKBFEA8cKP0kV2uPk=;
        b=H5RYFQBY0SdOt8q9y+/hozVq2N3qSPdm2w/ShYkN5VTg0WUiLxBTNcTm/I0zXT1oDp
         oMXeDnsXGaY8LGiW/fNNbOoJbro6xbLCM9eS/I35vfYa7xvlEEiT48Wvvo1aYJIDCAGC
         j0MhEyS+vdM31ZkhTjoTQFmpdHVXLf0xUHw9lBhxom1/gb95DrbRdXJqnU/Yiw6kLpwG
         /Xjy/WfUvPGvBEoE8Ssddj0sa3zk3pXdnqS9Zxk33bst4KpFSpit/S0Wb1/itDsOtBiK
         37MZ86Y7kV5fE02JgTX3HUWgg9fT/aqiykyq2WmrAN/X+qjW4iVYxuDiAcrF9YViz5LO
         qEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BjsKuMlhS1rf8i63JMOPA6xr54aKBFEA8cKP0kV2uPk=;
        b=TLtY6KN06FWq5ylp8vQZOVsRFlBEXa6puqFI6K9GqyShdusT2GG5Xjma6miUZ7TPyU
         ZI1KonLgQXNMPWDc0di0tpttdvhhI3SBcR2/s4alUZiHVs6ampbwLXMCfc55gK6WqqiG
         6okjRUxWSZSqWN0yyhB1ElJwnKUK3z0xcYumAduoOM+bRXA1Fdh1xJf7Mu0YBUGBfNoS
         dS18gJKhp8LTBtpRhqGPUa7s+7ifBfimAqguzvEHJ0udf4Le8SrTbYZKj4ZU41Rftd4v
         N++vygOgshQ53nusoss1PP9eJhBPqPkJL42AFX5dCPhKw6L3qvTlJoPIUwICdxOkhxnq
         ZJRQ==
X-Gm-Message-State: AGi0PuYaZ3I5EkTc3iryCYQxY7IRnGYPjGcjLPcPrKSOZONv3FE3E0WA
        UFiqOB9YPrC4CrzcBj00OaXFNPie
X-Google-Smtp-Source: APiQypIhXCNGedZ1eDIGLErDObEveBbek+ynHQrkIXnUHd+RB6ANFTKbOnQGPqLITUWNFb0Do9RGUA==
X-Received: by 2002:ac2:50d9:: with SMTP id h25mr7008222lfm.80.1586120098487;
        Sun, 05 Apr 2020 13:54:58 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id 6sm10379058lft.83.2020.04.05.13.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 13:54:57 -0700 (PDT)
Subject: Re: [RFC PATCH v6 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
 <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9caa1e22-d81e-8513-0f43-ee9ffc671fb0@gmail.com>
Date:   Sun, 5 Apr 2020 23:54:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.04.2020 04:25, Sowjanya Komatineni пишет:
...
> +config VIDEO_TEGRA
> +	tristate "NVIDIA Tegra VI driver"
> +	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)

Why COMPILE_TEST depends on ARM?
