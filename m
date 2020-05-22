Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC0DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63252065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgEVVy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:54:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38925 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:54:58 -0400
Received: by mail-io1-f65.google.com with SMTP id q129so3894951iod.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n091YDxaErv8oWkQMHbQBobP632/VWNstnpimxg6/X8=;
        b=q1TpJR7ZYfyCTVpHbpsssRfE4Qv69DbEbvRvOReVVHvOoWohdETBVcwqUFL0uQYOBv
         9WdvFyhDBh4DZPG+hrWiJO2JFbjDnTCOUOyzEcijkhezFVj0F2QKrpJaJhgsfvqqWuaP
         JL2QZ1Qyi1KcVRh8iypjZi9VklNS4KkkpzgMhH6R3rxtZMINSBjVHUXowVjXk3qCraJ5
         9UwH+9Y/R5Ra0S65dgthN9S6zRxL7DLMsTQLJXj7+GX+hcWjiL/q9fuJuOyjhOcVzSWE
         CFlH+T5a2I6O5MCgC//+QuAGQWKlftxJ/WQh7uBNn6Hgz44EJ3DhiaOwURXhkigNd6nT
         d7BQ==
X-Gm-Message-State: AOAM533CWsM7QVTPYTVfOC6sS+GU1RB9sEWBkHQQGRXgBHP8E702GL1E
        ArHN+/Q3MenRAfB0J6WFY6d+NdIvndY=
X-Google-Smtp-Source: ABdhPJyqauV6jJ1yDHKJm5zRvxCbQChSTpHHLaGS/5W3Lw1LeLf3MY3u0Kc2icTWG0lyHRsHPKsIqQ==
X-Received: by 2002:a6b:7009:: with SMTP id l9mr4837888ioc.158.1590184497226;
        Fri, 22 May 2020 14:54:57 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id t18sm5417892ili.24.2020.05.22.14.54.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 14:54:56 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id j3so12161071ilk.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:54:56 -0700 (PDT)
X-Received: by 2002:a92:5cc1:: with SMTP id d62mr14815529ilg.95.1590184496349;
 Fri, 22 May 2020 14:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200508140846.47608-1-yuehaibing@huawei.com>
In-Reply-To: <20200508140846.47608-1-yuehaibing@huawei.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 16:54:33 -0500
X-Gmail-Original-Message-ID: <CADRPPNS2Rp=_NEH8Kst=jG7Dj+z=rm=T7Nbs5_PO8nr4w4w5EQ@mail.gmail.com>
Message-ID: <CADRPPNS2Rp=_NEH8Kst=jG7Dj+z=rm=T7Nbs5_PO8nr4w4w5EQ@mail.gmail.com>
Subject: Re: [PATCH -next] soc: fsl: qbman: Remove unused inline function qm_eqcr_get_ci_stashing
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Roy Pledge <roy.pledge@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 9:11 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> There's no callers in-tree anymore.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next.  Thanks.

Regards,
Leo
> ---
>  drivers/soc/fsl/qbman/qman.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 1e164e03410a..9888a7061873 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -449,11 +449,6 @@ static inline int qm_eqcr_init(struct qm_portal *portal,
>         return 0;
>  }
>
> -static inline unsigned int qm_eqcr_get_ci_stashing(struct qm_portal *portal)
> -{
> -       return (qm_in(portal, QM_REG_CFG) >> 28) & 0x7;
> -}
> -
>  static inline void qm_eqcr_finish(struct qm_portal *portal)
>  {
>         struct qm_eqcr *eqcr = &portal->eqcr;
> --
> 2.17.1
>
>
