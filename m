Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A204C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089BE20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597644533;
	bh=jkDy2M4HrHeMvMWNxZN8BboPzsYViMAXDP5YYtRj88U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XEBu1zd6hJE0ZgBihCHAXrb6s+WdiWwfrtd217sVeMoBchw2VlEglJQn7l0uTN9+I
	 LQrw7ICiHLwNaqgqSPxKR9zchIV4K6wgBJcjmuDkUOqhK2kxc2HdM54fHOLX3JVbc5
	 bJsmLFCATJx/DXxMH0hOs2VGYBybGLKggkMRjEHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgHQGIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 02:08:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgHQGIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 02:08:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so13699777wrc.7;
        Sun, 16 Aug 2020 23:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lNHNVgf2Zq0mPKET3cpuT7A8ZQmxysEPxjfsk3SXqU=;
        b=L4QDFTN866nOtYmzkvQSfwW/9n0sBWllYyo0c0Dg5denrACQ45CwVrfE+RPHxkBNZY
         CnaIME1hATcOPQtH/I20wrx0xSPbB/zaK5uiBAAEA4S2nKY9izAUSU+dp+VPBWWDiSjp
         tYnHpfq83d5F2J5i/RrJE6PPhE6BvYe0FIRX25cR3ctBVlaaENVZzjp73gUcEby5wXBJ
         qJKDuuBH4Vo9kcA14gNQoQ2JnjkqwQTZG366wkdJHirOYOeaCOreEpNAEIC9m+QjyI86
         WHnjTPizKvwA7GmmyCfVq398JjXts+eszc0PtELl5uUe056qTith3/JlNv1roSmTGACU
         3IzQ==
X-Gm-Message-State: AOAM532A1LnZ8WhyuvFqGJ/7uv6v00lsTXZucgid41uaCtKykC3ngFzS
        IsTUpNKkr7VzALEbhKQb5Wm6nwJIyHh6pdS1ryo=
X-Google-Smtp-Source: ABdhPJzJXTUT1UYlIYgRbMpn7HcBUPZpvH/Ec368Rq7Dadpw9jTRShu4vXorR3Lv03qOpofD68plZ5MEse+lOLFHX9E=
X-Received: by 2002:adf:e94c:: with SMTP id m12mr13657505wrn.109.1597644525957;
 Sun, 16 Aug 2020 23:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200817031249.36795-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200817031249.36795-3-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20200817031249.36795-3-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Felipe Balbi <balbi@kernel.org>
Date:   Mon, 17 Aug 2020 09:08:35 +0300
Message-ID: <CAH8TKc8giWkY8oNMKG97PYov0iN8f6TrA+PAsceSV0uwkO+qjQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] phy: Add USB3 PHY support for Intel LGM SoC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>, vkoul@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Aug 17, 2020 at 6:13 AM Ramuthevar,Vadivel MuruganX
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index c27408e4daae..90030ff299eb 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +PDX-License-Identifier: GPL-2.0

you didn't try to compile your patch

-- 
balbi
