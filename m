Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D7C20825
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbgEVXCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:02:12 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43890 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbgEVXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:02:11 -0400
Received: by mail-il1-f195.google.com with SMTP id l20so12356698ilj.10;
        Fri, 22 May 2020 16:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/nTM//7FB1PAbN/moZIfyohRFuX/F3Z6XuMSd7PjCw=;
        b=A1C9+WsZPdd9i60EaAeVkNFAWtxxNKbZbE32kVpP7DnEIB46M88eQ7b2AftqFL6m5Z
         s1+kb1eqEf3qZhp61I+SGvZ9FjvuOI+XaAxSJxExrAdicH9+5BRvB2fxYE/jxhaOY/+M
         OyFSQvGDTQMMIiYIw0O33phRVLx9sS9Zt7YygrEEl/2y02E6OvllUhDk3G3iqcbMuyEo
         JZ0yt+6ObdxJ/cVkWPHW5ksMZnvhIkjU95Fsl3PyD3g43v9fRwexG0e2Hjck0NYEp1gi
         pT3sEfaNmOHHf9+zizpG0PJidE/xJb6BUuSuRM45s3X/XP3t7s/QH+nnczWgzg2h0dv5
         8PEA==
X-Gm-Message-State: AOAM530JBNoM60PxcWPdaL37FTtSf2WiBXOm/qtwCfcdaXAScySgCyLZ
        ZefR72plirKiqK/rNsuMEeqwILtEjSI=
X-Google-Smtp-Source: ABdhPJwYRCX6lT2c+xy+02DIHWNUuEeX6ytF4C5N+UtEhlbh+z4YHcpyyAD/hSAPT8FfQfvOraSugQ==
X-Received: by 2002:a92:9c52:: with SMTP id h79mr7665854ili.252.1590188530978;
        Fri, 22 May 2020 16:02:10 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id v70sm5563101ilk.84.2020.05.22.16.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 16:02:10 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id m6so12383260ilq.7;
        Fri, 22 May 2020 16:02:09 -0700 (PDT)
X-Received: by 2002:a92:5cc1:: with SMTP id d62mr15036209ilg.95.1590188529711;
 Fri, 22 May 2020 16:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200327161349.284679-1-colin.king@canonical.com>
In-Reply-To: <20200327161349.284679-1-colin.king@canonical.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 18:01:44 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ4KrnSsG2PxgXxe-+c5DQsUNQjw3f9Xq-kxP3+xAaQcQ@mail.gmail.com>
Message-ID: <CADRPPNQ4KrnSsG2PxgXxe-+c5DQsUNQjw3f9Xq-kxP3+xAaQcQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: clean up an indentation issue
To:     Colin King <colin.king@canonical.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:15 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a statement that not indented correctly, remove the
> extraneous space.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next.  Thanks.

> ---
>  drivers/soc/fsl/qe/ucc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
> index d6c93970df4d..cac0fb7693a0 100644
> --- a/drivers/soc/fsl/qe/ucc.c
> +++ b/drivers/soc/fsl/qe/ucc.c
> @@ -519,7 +519,7 @@ int ucc_set_tdm_rxtx_clk(u32 tdm_num, enum qe_clock clock,
>         int clock_bits;
>         u32 shift;
>         struct qe_mux __iomem *qe_mux_reg;
> -        __be32 __iomem *cmxs1cr;
> +       __be32 __iomem *cmxs1cr;
>
>         qe_mux_reg = &qe_immr->qmx;
>
> --
> 2.25.1
>
