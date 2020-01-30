Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C5C20674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqifi7oY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgA3RZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:25:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38912 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgA3RZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:25:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so4669018edb.6;
        Thu, 30 Jan 2020 09:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JBuUU9YguZE61sauS+J8SEajdxsJ22GtHtPHR00xnwQ=;
        b=eqifi7oYW1I8KdEzjX6tWdUWANaC17b2wO7MTt/xGmTrtO614Uv4fXmLjJhh8p4F/J
         yp3t7zsJsVXEmZ5fwhUARkHzPFSQHBbnRB0BS1rzj+9rvYy5FGxcJmA/2JWFq/+W3fSB
         3vZl6mzptsIkh+HGnSMIagSOdKxQY1GFS5n1BMNL5wRx4xjPnS2nVL5ESTkLLd1zovoO
         Dl28aHpApC9Ks09aRj3Jrr3KK1GJnK7mKyqI5ECEXWnHM/vTAZmtbdj9y6huxdybyvYU
         MwFZcTN+xsHcCxpUeAtuc/Gk+6aO61iknKqiHOK8ZEfiguWLRaDxE9WwPGCu+ehMNUbn
         mwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBuUU9YguZE61sauS+J8SEajdxsJ22GtHtPHR00xnwQ=;
        b=dJ6hw3WhUiCIKGscLHRLT6IHtlIMX/O48yNYpJl6SdJZQhP+vVfnf2yjC8E3V92yaP
         EUzx3Jc/yhbXnyzAS6qO+hSWEUoE0u2hRkLictqFskfh+c1XJ3P5RSt2rQO/ttoZ/x7i
         9l83rYqSjbgAfKyj4HjiLlC5mNohkQTztnQRKHSMNjQyt7KnYH1+mL0GkUruA0zlqhCq
         62l2x8j4N83hFXwtfJx3X35Kl9AvydbIrwAV0hlhAjkdTU7OrZWqzwWSd5uDTtT3QUaR
         2BcL3GONYOJbr+xezekPpQnk2Gdyuh08oqKzAcCTzeTjNZ5V07Ld+/PC+6x5BB+xj4K4
         wQgA==
X-Gm-Message-State: APjAAAWjlw6yTD5Q/xD5PJKhGXRwpNyUHwFbXyzhrV9wWulUB5hKTgzU
        shPwSf2nhT/5WjvnT4tCOkc=
X-Google-Smtp-Source: APXvYqxgK0mJxO0cesg5dzA/VHClKjIV8UvSjUK/BmBRNn0pMgmfqfF4AHyys5c+xx6GizIFk2gDIg==
X-Received: by 2002:a17:906:4a12:: with SMTP id w18mr5231796eju.321.1580405131582;
        Thu, 30 Jan 2020 09:25:31 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id ks2sm597103ejb.82.2020.01.30.09.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 09:25:31 -0800 (PST)
Subject: Re: [PATCH v2 5/9] ASoC: tegra: add Tegra210 based AHUB driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-6-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <160bb2ca-89bb-0ecf-a334-0fac591b439a@gmail.com>
Date:   Thu, 30 Jan 2020 20:25:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1580380422-3431-6-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2020 13:33, Sameer Pujar пишет:
...
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>

> +#include <sound/soc.h>

> +#include "tegra210_ahub.h"

Nit: I'd separate the per-directory includes with a blank line, like it
done by the most of existing drivers, for consistency.
