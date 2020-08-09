Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21351C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 08:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F9E206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 08:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvIFeFiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHIIsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 04:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgHIIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 04:48:49 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D9C061A28
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 01:48:49 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id i129so2820771vsi.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKI56+bDaX14CCr0kM6K85vrY7pTEhw0ASbGvetXsUY=;
        b=PvIFeFiDyWS1xZmw3w/29x+ATXIEqrfaERQ5aQWzR1x+gOyXFF4sJIJVlcjSljlZde
         TPAKbtYU83qY38G65Xda9O3mLX3FJT4pL5VLgi1TiPcSAUOhwHcL2cv3Pv2LEKtHhj7c
         3vLOBdUjtzzXf7tu/Q+vkDVU4uIcHTT35/2v+xB/FwJqqJPhMK30zAlYOvS/BlNH84Zr
         Qm/dQeVmm6H+1U3qbm7x2KMcyETgSpgr9rxRurDfc4fLjHZ7K9okCeNAEylzNwRET+Dq
         deaEeF6M/eX73zVSUg+7iTfbhM1tUkEnzVNsTY5Jclv0ye0YvFuRr3k1rLLWmKw2I433
         sPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKI56+bDaX14CCr0kM6K85vrY7pTEhw0ASbGvetXsUY=;
        b=OjunLBUcypAR78BjxMydG+Bd1m3cCL5M4efdysfEzxvXT047xPhOoXB6FNqoQuxt7w
         /ahwtcyhEfEQbMi6tvvmKqL8O2Y1pbAcZWDOV0OugqpKG1Z+NbRXs6Snrq/DxNxe1ABh
         ov4h2jcZ3UreQGcFiGimQvEIbDe4fR2DWCLpXPF1ANI0xFqZye2xZomWZ78KGbNW+AS3
         B7zHNlGSCjHBfPUD/+Sqg1z09uDsqbkHlv5h7MubWZOmXD+jei3iRzyeJSzbSZzNE7Z7
         n0jfmAnPhv8hxfHqqQUqLLQyrY8MoXu1Xp90X5j1ReSgF1gyqODuhp7DEdJ22yll2RcU
         Dnsw==
X-Gm-Message-State: AOAM532PeWRSHKuafGLDY2w+iTNJ72326JS8wK7Sl7puSasx/hsySn0y
        xAx+Enr4yP2AD9wffAHg+WsOiGHLxIk=
X-Google-Smtp-Source: ABdhPJwYCImXBw+l45sghWioi/Rx9zJyNkY2Ik0cCW6g4IwQIr0B7734rsF+GILgMAQkCpI6ABwK5w==
X-Received: by 2002:a67:6982:: with SMTP id e124mr16478893vsc.192.1596962926944;
        Sun, 09 Aug 2020 01:48:46 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id o17sm2538673vsq.20.2020.08.09.01.48.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 01:48:45 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id a21so2803455vsh.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 01:48:44 -0700 (PDT)
X-Received: by 2002:a67:fdc4:: with SMTP id l4mr16028144vsq.51.1596962924152;
 Sun, 09 Aug 2020 01:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200808175251.582781-1-xie.he.0141@gmail.com>
In-Reply-To: <20200808175251.582781-1-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 9 Aug 2020 10:48:07 +0200
X-Gmail-Original-Message-ID: <CA+FuTSfxWhq0pxEGPtOMjFUB7-4Vax6XMGsLL++28LwSOU5b3g@mail.gmail.com>
Message-ID: <CA+FuTSfxWhq0pxEGPtOMjFUB7-4Vax6XMGsLL++28LwSOU5b3g@mail.gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 8, 2020 at 7:53 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> The underlying Ethernet device may request necessary tailroom to be
> allocated by setting needed_tailroom. This driver should also set
> needed_tailroom to request the tailroom needed by the underlying
> Ethernet device to be allocated.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  drivers/net/wan/lapbether.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> index 1ea15f2123ed..cc297ea9c6ec 100644
> --- a/drivers/net/wan/lapbether.c
> +++ b/drivers/net/wan/lapbether.c
> @@ -340,6 +340,7 @@ static int lapbeth_new_device(struct net_device *dev)
>          */
>         ndev->needed_headroom = -1 + 3 + 2 + dev->hard_header_len
>                                            + dev->needed_headroom;
> +       ndev->needed_tailroom = dev->needed_tailroom;

Does this solve an actual observed bug?

In many ways lapbeth is similar to tunnel devices. This is not common.
