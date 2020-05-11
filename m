Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36910C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7C120735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvCTwObS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgEKLv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727019AbgEKLvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:51:25 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04A4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:51:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m13so7270502otf.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeHRpybSf1hZUCecDPTXMsxHP/0MCclV9yk5G+Y9ElM=;
        b=FvCTwObSUK/MSdWWjp6LdXPWvXftuK25+1iJJPGIDFcuzADJ1lqKsneCun9PQlUILM
         IbHxRU/2/UxYvP86NguZ6KvjiOasgPyzGxY+Wl/0kttIzOpE0s/lCVm7xk0H20W/xuwR
         5fMs/5LZRiZ7F53MqB3Eyakhbw3Xe/Xc2eOSVenLMLbvMUdE8sa2B8SB4geRaRjMMvPW
         BT9ihGf+3XwjsG/o62/6vsF8MyqF60zAy93GRzu/pQAH/SbZeInVVMY1gqk6oZAgbUmF
         36d0FVFknNDNXbJ3LwO76AZHx5FpSR7essMlz83xi3MGSyEPQZPavQ7E6NvJsheFFrIS
         eSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeHRpybSf1hZUCecDPTXMsxHP/0MCclV9yk5G+Y9ElM=;
        b=LkRK/mX3ZEORU2pLb0GG8wyoKqHjVWeId24ZhdjuRQyXD+/pJ8yNFSTJRoOToetEsd
         goerErbj4KV8vd3Coi0sQTd6Y7omcIM24UrSEQUs/4SKC+Ls/LX5ZSo6OKhazzqxofm+
         N9Oh+mzVwR2HSJaGSO8CS50/GQtTdBwDymwysDnNLWZLesy/kCwsEoMGVjpnqY0YmScF
         nwk0t4y1tVOFPyxrp5EOKtEG+vGiGEBg7CZzRVEtlKw5br0x7zjSR2hRAphXTKZeS++u
         SeysXn85wmhyT+Ijb9emnokhcS0yTzBpZ0Ys+IR8W8X9ua9iJn6Y3bSreVfaQf3oBPYO
         F6cA==
X-Gm-Message-State: AGi0PuZLSAbYWCzFzpimdMYHR/D5yK3YdKUORtKw7+Il2ypkmHWaZUk+
        /DNXBgQmjCoqB6EmVfz7jVbc+mXOlm4OLMFwcHM=
X-Google-Smtp-Source: APiQypKe8DbCslhOawkFJNWKH2byflMD0hHrGXS+wW3bBQQ2xV7wcWU40RYmF45OSY/L3pWRXRLWwJ7rkCiyCwlq2sA=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr11948575otm.145.1589197884912;
 Mon, 11 May 2020 04:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200510111015.20134-1-oshpigelman@habana.ai>
In-Reply-To: <20200510111015.20134-1-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 11 May 2020 14:50:40 +0300
Message-ID: <CAFCwf10ufEaTEDuyKJ+m4tdvk3n4g3dxW94LWsRqoO-zcDw0Tg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: check if CoreSight is supported
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 2:10 PM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> Coresight is not supported on simulator, therefore add a boolean for
> checking that (currently used by un-upstreamed code).
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/goya/goya.c  | 1 +
>  drivers/misc/habanalabs/habanalabs.h | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index b3e2354aaca2..fb2ff82e0db5 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -751,6 +751,7 @@ static int goya_sw_init(struct hl_device *hdev)
>         }
>
>         spin_lock_init(&goya->hw_queues_lock);
> +       hdev->supports_coresight = true;
>
>         return 0;
>
> diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
> index a68df32094f1..cfb306daa8d4 100644
> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -1415,6 +1415,7 @@ struct hl_device_idle_busy_ts {
>   * @cdev_sysfs_created: were char devices and sysfs nodes created.
>   * @stop_on_err: true if engines should stop on error.
>   * @supports_sync_stream: is sync stream supported.
> + * @supports_coresight: is CoreSight supported.
>   */
>  struct hl_device {
>         struct pci_dev                  *pdev;
> @@ -1498,6 +1499,7 @@ struct hl_device {
>         u8                              cdev_sysfs_created;
>         u8                              stop_on_err;
>         u8                              supports_sync_stream;
> +       u8                              supports_coresight;
>
>         /* Parameters for bring-up */
>         u8                              mmu_enable;
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
