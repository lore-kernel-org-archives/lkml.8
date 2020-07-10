Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20ABC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0FE20657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hLQNyhsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGJXhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgGJXhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:37:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E15C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:37:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so3201891pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=M5HYE9/oTgOIRT3zwZ3pJYw3eOk8J4scLkJbJEU3a0s=;
        b=hLQNyhsfo3P3aiZPEk6EUW9Qho68hqFUIrArr6Wt7Bkc/rDv9E2zUOPgKTXqPW2llF
         hZmnnFasG39O9zPqp+uyQqrlQ0EHQegQWkMbxVqa+WkV3MUEprO6xxo07u8XOrCrM+RV
         KmIYjZ/O7NSfO3wh+ofhPRxidZ2PfxDAqGxhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=M5HYE9/oTgOIRT3zwZ3pJYw3eOk8J4scLkJbJEU3a0s=;
        b=mNat3KalLu7T5VijA2s2gAYy7VglitSdY4M8aD5xbrbdVmAYsp5aU/WWP1vpRDl6rN
         uzGx5Gu/NUPYKmFI1VL+3vD8/EOmH1dF2xgma7OpqcwDiPO4LZo6UH1Owvv7asgRY51C
         jd6bHIMlqVgy6sTxdZIAdZjswhsuomZINlwBVzVuIo/BR4qvrp87XHPJLpPxAa885+nx
         bg+tV5UqMXyfGnkD0ff64dhzarJvRybaMdDYvm1HS2vD24W7HUlq0L7Bg6WLdP2ndh8t
         6aJI4CblzckHf/JKiDxWHT5BM/Kt/RdqGFrbkETK+MGU2IXKtGzOfEER6Hf3FXIdSl0M
         ny4A==
X-Gm-Message-State: AOAM532Eg7isbWqnMviPgWLdX3YooParluQDvZnxoa72S8lgt03SzLx+
        IsVP6uLWKSHokrbPuWFw6j/TEA==
X-Google-Smtp-Source: ABdhPJxEN9sfN7LGaL7s5SBwtbiWlG5R/He18NE/GtGNMYwKECUttin0lySQUNsIHCl3WvIjhRhTRg==
X-Received: by 2002:a63:6fcd:: with SMTP id k196mr38245663pgc.251.1594424224453;
        Fri, 10 Jul 2020 16:37:04 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c1sm6384803pgi.52.2020.07.10.16.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:37:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1594351856-876-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1594351856-876-1-git-send-email-chunfeng.yun@mediatek.com>
Subject: Re: [PATCH] usb: gadget: bdc: use readl_poll_timeout() to simplify code
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
Date:   Fri, 10 Jul 2020 16:37:02 -0700
Message-ID: <159442422281.1987609.11864731950347548589@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunfeng Yun (2020-07-09 20:30:56)
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/u=
dc/bdc/bdc_core.c
> index 02a3a77..fa173de 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -32,21 +33,14 @@
>  static int poll_oip(struct bdc *bdc, int usec)

Can we change usec to unsigned? Not sure why negative time is important.

>  {
>         u32 status;
> -       /* Poll till STS!=3D OIP */
> -       while (usec) {
> -               status =3D bdc_readl(bdc->regs, BDC_BDCSC);
> -               if (BDC_CSTS(status) !=3D BDC_OIP) {
> -                       dev_dbg(bdc->dev,
> -                               "poll_oip complete status=3D%d",
> -                               BDC_CSTS(status));

This debug message was lost in the conversion. Any reason?

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
> +               (BDC_CSTS(status) !=3D BDC_OIP), 10, usec);
> +       if (ret)
> +               dev_err(bdc->dev, "Err: operation timedout BDCSC: 0x%08x\=
n", status);

Please drop "Err:" as we have kernel log levels (i.e. dev_err() used
here) for that.

> +
> +       return ret;
>  }
