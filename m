Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA73C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EE722522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j+C/3LDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgA1XO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:14:59 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33132 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1XO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:14:59 -0500
Received: by mail-vs1-f67.google.com with SMTP id n27so9304413vsa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 15:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yutVdDwIR4aezSyKn/ZRy2+avDSPVz6Dc1tmaTc/rqI=;
        b=j+C/3LDHcYl8BE4EB7d97f0mZ+rasBVKKKN0BY/5xOyCQdi5RwuOrZA1313VnNaowe
         yNF6OH1FHk6BlunCMyPyKC3umpj1YvV/RDHB60Kn49xtD1wal+e4t/YgpDBTtrMxuPil
         rJgebze0QNMYuD+7U8Agzj5tX6UVEXoQob93Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yutVdDwIR4aezSyKn/ZRy2+avDSPVz6Dc1tmaTc/rqI=;
        b=TWMbXtMeF3kezq6bx/skeFn92gdehh/9ExmLAu2SCEMAXhJclryV3z0VdIBSHPXlvp
         aHYhDqExQZah2i1KGocD7qopct4E4TYqEON4jVCrf8yjYZIZ9mBBjSUq695DiFzyV0kf
         hiLE5QaCHdpPmNAUR776y5cQMgQQt56zvN54ZHCmK4QFbLRlyPq5rH53dhBJKqTNQsu9
         076x33HMeuiGCXoIolAUkE0W3rnfAfKKDpmERJQ8IUImhNSwKkz9hQW/5NYQQ/d/QxRN
         bok1Ouk8Fo+SH8ig42CuJCUcXiuFzaRlee6wfOH0LfMblFVpioxN93YBJeXmyL6NtZ7F
         otSQ==
X-Gm-Message-State: APjAAAW4cPZ/wBG9wxFu249sKCpo+p2PPO7dJC0osWemHC7LfRH8wj3v
        JENl93kUrSCwh9KQ/eNCA2nmupiwBC4=
X-Google-Smtp-Source: APXvYqwgbKYGLdOAZHducXIcB2diGrvUNXq3/HafnO05JwXjm/edZ6PpG8ypnMsrntrU5G3lIU+Iuw==
X-Received: by 2002:a67:2701:: with SMTP id n1mr15943344vsn.103.1580253297982;
        Tue, 28 Jan 2020 15:14:57 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id i66sm16892vkh.28.2020.01.28.15.14.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 15:14:57 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id b79so9264984vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 15:14:57 -0800 (PST)
X-Received: by 2002:a67:fa1a:: with SMTP id i26mr2943374vsq.169.1580253297061;
 Tue, 28 Jan 2020 15:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20200128221457.12467-1-linux@roeck-us.net>
In-Reply-To: <20200128221457.12467-1-linux@roeck-us.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Jan 2020 15:14:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wg2MZ56fsCk+TvRSSeZVz5eM4cwugK=HN6imm5wfGgiw@mail.gmail.com>
Message-ID: <CAD=FV=Wg2MZ56fsCk+TvRSSeZVz5eM4cwugK=HN6imm5wfGgiw@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: abort and release host after error
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 28, 2020 at 2:15 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With commit 216b44000ada ("brcmfmac: Fix use after free in
> brcmf_sdio_readframes()") applied, we see locking timeouts in
> brcmf_sdio_watchdog_thread().
>
> brcmfmac: brcmf_escan_timeout: timer expired
> INFO: task brcmf_wdog/mmc1:621 blocked for more than 120 seconds.
> Not tainted 4.19.94-07984-g24ff99a0f713 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> brcmf_wdog/mmc1 D    0   621      2 0x00000000 last_sleep: 2440793077.  last_runnable: 2440766827
> [<c0aa1e60>] (__schedule) from [<c0aa2100>] (schedule+0x98/0xc4)
> [<c0aa2100>] (schedule) from [<c0853830>] (__mmc_claim_host+0x154/0x274)
> [<c0853830>] (__mmc_claim_host) from [<bf10c5b8>] (brcmf_sdio_watchdog_thread+0x1b0/0x1f8 [brcmfmac])
> [<bf10c5b8>] (brcmf_sdio_watchdog_thread [brcmfmac]) from [<c02570b8>] (kthread+0x178/0x180)
>
> In addition to restarting or exiting the loop, it is also necessary to
> abort the command and to release the host.
>
> Fixes: 216b44000ada ("brcmfmac: Fix use after free in brcmf_sdio_readframes()")
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index f9df95bc7fa1..2e1c23c7269d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -1938,6 +1938,8 @@ static uint brcmf_sdio_readframes(struct brcmf_sdio *bus, uint maxframes)
>                         if (brcmf_sdio_hdparse(bus, bus->rxhdr, &rd_new,
>                                                BRCMF_SDIO_FT_NORMAL)) {
>                                 rd->len = 0;
> +                               brcmf_sdio_rxfail(bus, true, true);
> +                               sdio_release_host(bus->sdiodev->func1);

I don't know much about this driver so I don't personally know if
"true, true" is the correct thing to pass to brcmf_sdio_rxfail(), but
it seems plausible.  Definitely the fix to call sdio_release_host() is
sane.

Thus, unless someone knows for sure that brcmf_sdio_rxfail()'s
parameters should be different:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
