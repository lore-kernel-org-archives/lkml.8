Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B644FC2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9E320644
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjDqPwOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgDETvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:51:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39406 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgDETvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:51:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id v7so1000804lfg.6;
        Sun, 05 Apr 2020 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JUNKW1yiiMsZbMkEhkA3LsW+sxrtsS5x04Y/jOwxK00=;
        b=fjDqPwOT6PGwD0GJHHl8DO3Si8sZDKSBTto0Hw1lZifu9M+ykg8qYAJU1p15tHpGET
         wfMGsKCzqaDxNowBa7YecvbC8dwcTVG/PygCfy0XtscUeKnZ3amoWXWa5Xc2cTNMcgiD
         ZH5zf7UfstxZdeRa2ooeYKMTeMflzPJAcIYRPGL9cejlrQrQe8vgbKvNKN61nfoiH9yt
         nbyL0+K+hMKGUodN8B63/x0kjFOZdWAz+XDnoNMOGQlcdgQsVbE03ZHtVeOB3v/s0duu
         iZzjFsioE06rPaF7+BSEKdq5FAcaZT//Z/gfZuGmKTVqa2wyocJDgzvKXnfz5Qiu1Qpr
         djeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JUNKW1yiiMsZbMkEhkA3LsW+sxrtsS5x04Y/jOwxK00=;
        b=rzNUqYU99KiREf7zNzq5SdgPtnhGXsduNU/4CodbUMawlZD4Y/2DfBwCu+FWmRuao2
         yltFbMPsFSadjKckx6A2onTU4CsnK+JDpYdriCeANPzSBbxtPQkrB2ng/7KKSjmIK9tG
         Nc/qe7wuv16ooweNNu3Yge9n53zsUqmM01rNGpMu1gEgX9rPSCwr22t+JKe5aji84mnc
         Ku8rCmR7qeKPpmFHtGpifjEwydqdGjiUc0aNM1ZhgXgiv4sJpNGAc1o/P5bhZI00gabP
         7PCgfOtKYXltofXfSxQNIzaP9RxvKRuEZjWNpYH+moday5LasBBbXUG+9KXIoEx/EEJx
         SxQg==
X-Gm-Message-State: AGi0PuZj0j+bERsADJbLpidv8Hot5k2hHGrCRoL0J6jahsLMjew3EP4v
        LQ6DTcmzcotommJFJb2CITUaxzuw
X-Google-Smtp-Source: APiQypITj4Zai7U3TtWWd12eXC1YxutOAO/iIkd76/a8mdk2XHSlCZFLhN3Vzzh5OPcg3LUSfOOHeQ==
X-Received: by 2002:a05:6512:6cf:: with SMTP id u15mr11125210lff.98.1586116293683;
        Sun, 05 Apr 2020 12:51:33 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id j16sm8662260ljg.98.2020.04.05.12.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 12:51:33 -0700 (PDT)
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
Message-ID: <1ffd4422-89bf-ee63-d2b4-63d42b216e69@gmail.com>
Date:   Sun, 5 Apr 2020 22:51:32 +0300
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
> +/* Tegra210 VI registers accessors */
> +static void tegra_vi_write(struct tegra_vi_channel *chan, unsigned int addr,
> +			   u32 val)
> +{
> +	writel(val, chan->vi->iomem + addr);
> +}
> +
> +static u32 tegra_vi_read(struct tegra_vi_channel *chan, unsigned int addr)
> +{
> +	return readl(chan->vi->iomem + addr);
> +}
...

Perhaps all reads and writes should be relaxed?
