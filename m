Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EAAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7392068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAuOnM4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgFBMGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgFBMGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:06:19 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EDCC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:06:17 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 1so1848185vsl.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 05:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8TLwbbwpigYbLnnsmu2/tqlSQ4fjBU1I+APno1oETk=;
        b=rAuOnM4pnXKCbe7wrzaoRdTKnyJBeTd0qTlYB470WMcq3DPvaQWUPhFzMfBkCpt5VZ
         eqX0bC/o4hoV08wZE2N3bjOaORbaid/b50ftvLPKRzHvqtl3ZWD+0cqyurIAB+8rxgg9
         FLe+HWZGMaaoWYbpzC52HrGXjBJaRJT22su4XEsrUFmIlBSdpNQJRm8EB9ECCYGrQS/c
         gsM2UIRsj39DnQ0mEFwFHCykOFhoWolqR3jk7Q1id5fDp9/o+8D31UpPdbEiqQYX2+WQ
         iJlFk6Df2wlvnhfBOihX+7DHWobBPr1bpvJFHIRKi7BDNoYG1cN5d/+HJbUUj8viqZJQ
         uuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8TLwbbwpigYbLnnsmu2/tqlSQ4fjBU1I+APno1oETk=;
        b=B3ticL8VJ6KmPU/9hDtUkPQTbRVwFfKoXiH7cc82YQBIMZtEYCcXWISjNE0b07dWdt
         xXgyGYeqbyNAhYcunqi+STotv9J6wTQUNziUPZ6P2uJhXGAbckWDxJOMCnoLfckqRmln
         DI36OvZrmPcfm+nFHpwchX6LfVST4lwdIRafHNfCdEmpNmVje53tCRSThWX6YklomhQD
         kmdVRdhBHVmlo/IydspI0IxBCRDQc/CZMQTzIlu18kUpZmXQf1ObNaV+rt8j+GB2mpYz
         5ecspIzxyxV7CSdCm4pZDmPoFCu9rxY23i1zPARm1ps7k/a2QzRyFsEYaj2QB8nH7kdO
         PSWA==
X-Gm-Message-State: AOAM530Pyq78hBRo8vyv0wFwOY25X+2jhvjIZxzDVX9443o/9lZ5Qq+A
        f7wTQzIE2zbZGi7gRQDi8L7p0kNaDs3TKdX4chvbBQ==
X-Google-Smtp-Source: ABdhPJyYvO6EGUQzrkJXaKKQ2X1NWP8QbEKUI3/Bv4Zylahw5KDfo6vhcEr8o85kUFivcskLi7AfeWGuKQUXa0BPBk4=
X-Received: by 2002:a67:8983:: with SMTP id l125mr7213160vsd.34.1591099576761;
 Tue, 02 Jun 2020 05:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200602134402.24c19488@canb.auug.org.au>
In-Reply-To: <20200602134402.24c19488@canb.auug.org.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Jun 2020 14:05:39 +0200
Message-ID: <CAPDyKFqjm3Egbv9nj8wR_q5onpJT=jSh-MvKn+VuJGX_ifG9TA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the mmc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linus <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Linus

On Tue, 2 Jun 2020 at 05:44, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the mmc tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c: In function 'brcmf_sdiod_probe':
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c:915:7: error: 'SDIO_DEVICE_ID_CYPRESS_4373' undeclared (first use in this function); did you mean 'SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373'?
>   915 |  case SDIO_DEVICE_ID_CYPRESS_4373:
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c:915:7: note: each undeclared identifier is reported only once for each function it appears in
>
> Caused by commit
>
>   1eb911258805 ("mmc: sdio: Fix Cypress SDIO IDs macros in common include file")
>
> interacting with commit
>
>   2a7621ded321 ("brcmfmac: set F2 blocksize for 4373")
>
> from the net-next tree.
>
> I have applied the following merge fix patch.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 2 Jun 2020 13:41:04 +1000
> Subject: [PATCH] mmc: sdio: merge fix for "brcmfmac: set F2 blocksize for
>  4373"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks Stephen for fixing and reporting about this!

Looks like the fix is rather trivial, so I assume Linus can
cherry-pick your patch, while merging my pull request for mmc for
v5.8. In any case, I will monitor the process and send a fix on top,
if needed.

Kind regards
Uffe

> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index e718bd466830..46346cb3bc84 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -912,7 +912,7 @@ static int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
>                 goto out;
>         }
>         switch (sdiodev->func2->device) {
> -       case SDIO_DEVICE_ID_CYPRESS_4373:
> +       case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
>                 f2_blksz = SDIO_4373_FUNC2_BLOCKSIZE;
>                 break;
>         case SDIO_DEVICE_ID_BROADCOM_4359:
> --
> 2.26.2
>
> --
> Cheers,
> Stephen Rothwell
