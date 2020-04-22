Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1164C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4232071C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BSbkpzms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDVWqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgDVWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:46:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED0EC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:46:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so1572829pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pLTuQArcwiFXcG9uc7P3/tOH2806IqFHASRaBcIcsEY=;
        b=BSbkpzmsMrB61iVPWzBuW/+ZEnOUMyG61Cjfz/vz3GFTkoJosnfewYwwNytlJSg/r5
         7urIvRN84RRm0goUbfxHHzHPdDP8mVksMX8xC3NIi85jZ0dxMD54ig+wXJWmGJ+PTddQ
         Y/1YKuKZgP6vEwWbBfuWIfhMmf8ZfOiwR0UJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pLTuQArcwiFXcG9uc7P3/tOH2806IqFHASRaBcIcsEY=;
        b=QBJJ0H2PRqys7PFgk/jozAQ1QuLxUK6wz7nxnGWtXiuEC6V30Zc44UcHQZRoOCiton
         8/vPW6N1/ISxIRCghrShCJXO9nuUP24QyqFBgCHQVthcJOt8grO3OWmqMxohdTnLyMmm
         Zw28fnQ+qQ2x34RdOX/khxj+Fgz30dwq1AI2cjtvykJbGcNTijyhtosTpq5qUuPY9wyn
         TQ3shu/XJ5Xw4L6/f/zwtuM0/OFHjB1R4QBk8rvjPcNaOIRTJ03OpitKsbhtOn974KzJ
         W0J95vXjU3jIZx22hoijOOUA+a5f7kF0RQkDUPBifjMId/CGQYfC2264rEBu45Qgbm8v
         LkCQ==
X-Gm-Message-State: AGi0PuYb/vEHwN8z2EyPa54DHFErzH9IwJV+10nLwpJS4Lu8oPTHWX0U
        H4vfn+VIP8TwlFhXiW8wwJwYvA==
X-Google-Smtp-Source: APiQypKhDC0baxY/PgdACBGve8Req9KLYTUEXXH0x/85yLzgvD2k0uCeWYCvvSYzzEadi+NZNpZcBw==
X-Received: by 2002:a17:90a:5aa7:: with SMTP id n36mr1056873pji.45.1587595606121;
        Wed, 22 Apr 2020 15:46:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h11sm539650pfo.120.2020.04.22.15.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 15:46:45 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:46:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Yong Mao <yong.mao@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 3/3] mmc: core: fix mmc_sdio_reinit_card fail issue
Message-ID: <20200422224643.GI199755@google.com>
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
 <1586835611-13857-4-git-send-email-yong.mao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1586835611-13857-4-git-send-email-yong.mao@mediatek.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

On Tue, Apr 14, 2020 at 11:40:11AM +0800, Yong Mao wrote:
> From: yong mao <yong.mao@mediatek.com>
> 
> If SDIO device is initialized by UHS mode, it will run with 1.8v power.
> In this mode, mmc_go_idle may not make SDIO device go idle successfully
> in some special SDIO device. And then it can't be re-initialized
> successfully.
> According to the logic in sdio_reset_comm and mmc_sdio_sw_reset,
> invoking mmc_set_clock(host, host->f_min) before mmc_send_io_op_cond
> can make this SDIO device back to right state.
>

The commit message isn't very concise. Suggestion for a better
structure:

mmc: core: reset clock to minimum speed during card reinit

Some buggy (?) SDIO devices don't (consistently?) enter idle mode
through mmc_go_idle() when running in UHS mode. [add rationale why
setting the clock to minimum speed fixes this]


Also the function sdio_reset_comm() mentioned in the commit message
doesn't exist in recent kernels. And mmc_sdio_sw_reset() does not invoke
mmc_send_io_op_cond(), as the commit message appears to claim.

> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> ---
>  drivers/mmc/core/sdio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index f173cad..dc4dc63 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -850,6 +850,7 @@ static int mmc_sdio_reinit_card(struct mmc_host *host)
>  
>  	sdio_reset(host);
>  	mmc_go_idle(host);
> +	mmc_set_clock(host, host->f_min);

mmc_sdio_sw_reset() - which is mentioned as reference in the commit
message - sets the clock speed before sdio_reset(). Should this order
be followed here too?

