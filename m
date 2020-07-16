Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80B720791
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WBRwXuL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGPBGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPBGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:06:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFABC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:06:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o22so3841441pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=e2rVUlKuuIkQy85IOtUCVSZFDO7sfvuCwv9FBlIGudc=;
        b=WBRwXuL1J49aFDX6OowkdQp60wkBLDyNji+VnP+47luf3SDgodM5CwOA/KeRQyBiK/
         Ds76Qrv97EixHLwWaFyaLiwTYTLZejCwlFlXIoUV0aQV3W6LmFuXJ0T9YbB3FvLVWKvL
         v9EEQ8v7wIiTl2OmiIYvZKqXM71Q7RR3K0iF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=e2rVUlKuuIkQy85IOtUCVSZFDO7sfvuCwv9FBlIGudc=;
        b=abbwR2P4ONXGuBzDx0ViVdsZKp+bQBicR5EAqcPyljMwsH3Og06tU35Cg93DkCW2k5
         P3sbUUhJXF4ES5lQI5RMBObEUhYoWaWMld1IFghc7aG/7NY0VMUnBX9ntJk2ox2vuXSE
         C/Tn64K19W7VGS7yNxSM4NO8nLb3crLmtKIUUhh2TTwAWYSeOl7ReyGACJVlFkGl8p0M
         nNcpfZkg7ogpx6PVzD2ETl7nI3wtCAYgBZHxdSwnVvKfj82LuXRz4Xs3/v0eqtQH0W8e
         IVL5vSUYV6yAGAHfq5f55oKT0NVe2FsLHCgNpT0opco1+dnF6EBmqHl31R02eWUEOY/1
         oWsA==
X-Gm-Message-State: AOAM531W5I0x4u+WwZxYNSJqB5Ai+dr1U2D5dOHOBjkq8HWJtVqFfsOC
        GN6+614cpAXcl9g9He/Ig6eoYA==
X-Google-Smtp-Source: ABdhPJwDuXNH1tttabpe1OV+jVg8VPDxCAe+DQNCQJLCDygr1r24B/9SZizwmtIKi2LthbUBcxYHIA==
X-Received: by 2002:a17:902:8d8b:: with SMTP id v11mr1626798plo.221.1594861572552;
        Wed, 15 Jul 2020 18:06:12 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j19sm3134274pjy.40.2020.07.15.18.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 18:06:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1594622881-6563-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1594622881-6563-1-git-send-email-chunfeng.yun@mediatek.com>
Subject: Re: [v3 PATCH] usb: gadget: bdc: use readl_poll_timeout() to simplify code
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Date:   Wed, 15 Jul 2020 18:06:10 -0700
Message-ID: <159486157046.1987609.11356860908068064534@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunfeng Yun (2020-07-12 23:48:01)
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/u=
dc/bdc/bdc_core.c
> index 02a3a77..d567e20 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -29,24 +30,19 @@
>  #include "bdc_dbg.h"
> =20
>  /* Poll till controller status is not OIP */
> -static int poll_oip(struct bdc *bdc, int usec)
> +static int poll_oip(struct bdc *bdc, u32 usec)
>  {
>         u32 status;
> -       /* Poll till STS!=3D OIP */
> -       while (usec) {
> -               status =3D bdc_readl(bdc->regs, BDC_BDCSC);
> -               if (BDC_CSTS(status) !=3D BDC_OIP) {
> -                       dev_dbg(bdc->dev,
> -                               "poll_oip complete status=3D%d",
> -                               BDC_CSTS(status));
> -                       return 0;
> -               }
> -               udelay(10);
> -               usec -=3D 10;
> -       }
> -       dev_err(bdc->dev, "Err: operation timedout BDCSC: 0x%08x\n", stat=
us);
> +       int ret;
> =20
> -       return -ETIMEDOUT;
> +       ret =3D readl_poll_timeout(bdc->regs + BDC_BDCSC, status,
> +                                (BDC_CSTS(status) !=3D BDC_OIP), 10, use=
c);
> +       if (ret)
> +               dev_err(bdc->dev, "operation timedout BDCSC: 0x%08x\n", s=
tatus);
> +       else
> +               dev_dbg(bdc->dev, "%s complete status=3D%d", __func__, BD=
C_CSTS(status));

Different than before but OK.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
