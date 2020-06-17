Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D7BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E9820897
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STIQ91+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgFQVk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgFQVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:40:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C4DC06174E;
        Wed, 17 Jun 2020 14:40:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so3962121wro.1;
        Wed, 17 Jun 2020 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=L8KQGYBNXCs44/bdoqCRORNs1kx4kRZ8Xd0B+XPcWlQ=;
        b=STIQ91+m6JuleAes4P5UdW4kW6ecexAAcwd95QzWO0ocf+lpG74ag4wecLCIYg+nsC
         zr3UqChiw7EVoYpRPzjbIXHDtdkJUhtzINvCUkp+FhuBpzs76SXLQ6i6kdKVxzAfspU6
         p6Yl71sO4l71ECbA+SyUZqaC/v+WUJWS0VizYb3DS9mXSY09VP09wQiL7siAGx4WLp8x
         Eyj3dXKKQa7/dh7OU2tnuB5EzXGcjG1Q10lXc0WM4w1Xd2IAO99Kdj/f7NbB4tG7UwPM
         NSx/D2QVGcZ/Z5VFauIAUbmihZPDIR/2o3O2XpMfd5hFEj0oyCo6e4288r0TRy9cYPAd
         oBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L8KQGYBNXCs44/bdoqCRORNs1kx4kRZ8Xd0B+XPcWlQ=;
        b=MAaLjVvQeVewAwzm6Pdk8FAd5QXddJpVok011lw/J7xAO0d4zFxjEBnm+L1DTAiw0H
         TejipUpaOIF/u68WE22gmFs8d/xajj/a9+azPdXtKnYyY/2/IbukTQ9iaghMgpmaQr22
         27/adAa+y0KuQVP++nnqJqfaSxLG97UwPJWY0Rk87VF2DVVWBNoSwbELlp/ZESlExKEK
         eSDZgU6eJtXbJisRA4tdOsB5YBwzBP+kSJmJo8bHPQu4dA6KLmDE9Gfck39auxi/r9uh
         2dTy0zpWLjHpArkd91Hq/c12/04aTasyzlr6YFFd7TSqNlkzeTiHn7X2ih0IX87oOtR/
         8qkw==
X-Gm-Message-State: AOAM5325+L4dMLxM3nZOI9LMvA+dCmiRF8skmNTSuUOQ1lZ3crtI/bhW
        OuBkQ+oWsY48eXeWF+4Pn93IMEGe
X-Google-Smtp-Source: ABdhPJzMdWex6wUFcFECN0CEWPasEMZbh90C++J8UTRk4A1GUy5WzH/OGa6jFsQFkZ2aKNlPQzROvA==
X-Received: by 2002:adf:910e:: with SMTP id j14mr1176209wrj.278.1592430055834;
        Wed, 17 Jun 2020 14:40:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y16sm910876wro.71.2020.06.17.14.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:40:55 -0700 (PDT)
Subject: Re: [PATCH 8/8] clk: bcm63xx-gate: switch to dt-bindings definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20200615090231.2932696-1-noltari@gmail.com>
 <20200615090231.2932696-9-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <80971cc7-3a69-730b-e3b0-bd963d47ed47@gmail.com>
Date:   Wed, 17 Jun 2020 14:40:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090231.2932696-9-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 2:02 AM, Álvaro Fernández Rojas wrote:
> Now that there are header files for each SoC, let's use them in the
> bcm63xx-gate controller driver.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
