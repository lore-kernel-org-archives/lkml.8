Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF56C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0301206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4ucfsHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgFKRGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgFKRGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:06:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211CC08C5C1;
        Thu, 11 Jun 2020 10:06:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t18so6950487wru.6;
        Thu, 11 Jun 2020 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bYgWi0CbWr9efRoOcUkQ73nl3LMm75dhUsrAfK12w9c=;
        b=L4ucfsHByk+H8noH4FkTy0DyUzdKksJJZ14rVZuYiN4HFJEoSxIP5E+zpiQG5kFdJd
         Zu7asOJHLHmY2g1UhmwFqhuk6m6KDfifvQ9Rz4piCsFWAm0L5LtXDvG6xOh1FZ+2fVcq
         /Hlv7ID0RB2itcIOTkCw2Yux7a8Nsdlfe28tg7ClSNep1B/SlNmlL+eikKYl1VsdywLw
         qtz8khSiUF0eM/rGl77W0a/06ESSYk9aocIW6vaiUrnMZ6rxbm1cfBV9NuV5KGj+m9FU
         4gUR5MWQLTTL4h+K260EGllw5MlpQoWXxQjrtonMwTZ5Vg5pXGgQUbs+m+LJlU/3U5kt
         QcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bYgWi0CbWr9efRoOcUkQ73nl3LMm75dhUsrAfK12w9c=;
        b=GwRJMx8jW+KkOGHSKmJCVYg9tgo2CMK6vllLcmy7QSP7URND/S2N59+yQBi2Jiu+Db
         10vxyhf0wjtw7tpDmOLJq2wKE2v8eS2wGPc7PGaaeJBK5EEKtPUGHid+JHvckzONwguJ
         7YpHRN4GWNd/HzTTXuAhIP/MUo9ZVYZ9BDi26kwFRBr6opVobcJ0YJEHyPDj98DGPQvL
         i9KTH0BcNNLGc6tJ5JSwoWPF9G0ltUABa5eusW3xM/AZYRjr0xCw1ES4jnpQoBiCb1S7
         GF1/kPz34hidnDUZTGGepBEAKaQ3XtOI6QVu8JCs2lWW3B10krXDmPQ2cB+twtIWgDEp
         P2lA==
X-Gm-Message-State: AOAM532JvJhSud86NEVvOYkW07EbYXCulRMIHy3gJgbPjFRbeJ34iXW8
        +D39l4VYdX75CTla5LYwVGY=
X-Google-Smtp-Source: ABdhPJy1a2J0AjcDmA7VUeN6Mlwj09mw76s/Xu2UJ9v3l2MXyfQvCZjqdZlWsEA17q03XTAetCA7pQ==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr10846341wrt.185.1591895206092;
        Thu, 11 Jun 2020 10:06:46 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id f11sm5897611wrj.2.2020.06.11.10.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 10:06:45 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] clk: bcm: Add BCM2711 DVP driver
To:     Maxime Ripard <maxime@cerno.tech>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech>
 <bb60d97fc76b61c2eabef5a02ebd664c0f57ede0.1591867332.git-series.maxime@cerno.tech>
 <e9e83c60-ef4c-8806-bcdb-a09702bf7559@i2se.com>
 <20200611165233.dmwxuz5lhxxbh7fb@gilmour.lan>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c05ef3b1-ee1a-e4f4-c6de-a23cbe6d8670@gmail.com>
Date:   Thu, 11 Jun 2020 10:06:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611165233.dmwxuz5lhxxbh7fb@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/2020 9:52 AM, Maxime Ripard wrote:
> Hi Stefan,
> 
> On Thu, Jun 11, 2020 at 05:50:30PM +0200, Stefan Wahren wrote:
>>> diff --git a/drivers/clk/bcm/clk-bcm2711-dvp.c b/drivers/clk/bcm/clk-bcm2711-dvp.c
>>> new file mode 100644
>>> index 000000000000..84dbc886e303
>>> --- /dev/null
>>> +++ b/drivers/clk/bcm/clk-bcm2711-dvp.c
>>> @@ -0,0 +1,120 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +// Copyright 2020 Cerno
>>> +
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/reset-controller.h>
>>> +#include <linux/reset/reset-simple.h>
>>> +
>>> +#define DVP_HT_RPI_SW_INIT	0x04
>>> +#define DVP_HT_RPI_MISC_CONFIG	0x08
>>
>> sorry for not noticing this before. Are these defines specific to the
>> Raspberry Pi, because of RPI?
> 
> I'm not entirely sure to be honest. It's the names that the register
> have, but it's not clear to me if it's something specific to the RPi
> itself, or it just means something else entirely.

My understanding is that this is a wrapper that was done specifically
for the Raspberry Pi usage of that IP block, which is why it has PI in
the name, so this looks good correct, and this does match the internal
register database name.
-- 
Florian
