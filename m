Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAC4C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DBB20708
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThIIrlsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEGNQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbgEGNQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:16:43 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E949C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 06:16:41 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id f7so1472059vkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaEpYa065ypq35Huryl6ZF1r6VEE/Q7MGgbAu3JxSwc=;
        b=ThIIrlsUJAwhILFtB9W6ItdrMa51xrL79/VcpF9V+fVwinQVuierFP9YGkui0E51AG
         MNBHQbKmN8BblzRTnkoChsCjmAGWLXCniUBKIAiC08+XNh4ukMUOQ1VUz7NJ1nz8ULK6
         0OuGzBWj1TUygr93F+Ts39jQIWDbwUCA0oigDafhNXTHG4xua/Jo4ajv/YJmQ9LkjFyM
         vKrL/YLtz2Qeo1m3Zjj8B0lOkUHTVEdU5ysKAk31NZjrv3Fa60YrxPjDfivsG5OXII/p
         CkJibs3Okh5v1+t8YP7PffYMi2hhnu/osVW8YoMQTbZEEsxTGqSFSBErV7tv7KRB7dIA
         ml0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaEpYa065ypq35Huryl6ZF1r6VEE/Q7MGgbAu3JxSwc=;
        b=GiiUxiu6k829hDCjcuX8KL2UsWNf9/qJEc/UYzdTA68pkOsY8ofLCtI6FSYhNkH0g4
         K5sD+2Wl1+85ItUGYFaneY2dEUV+d+cdoQUY0MiJvl8dsbm2mkG6G6l+KpLSTVDNfAa6
         7TZ4CjrZH6ZJ44gY/mXEnscBUNUADJMsMVsBVFiKIxuYgkf7xKQrQSwHU3lx9DHssj8l
         JU4t1Z+Cacr8l3nys/ir5kjIazWEjikIuMnmuUBUCx/CacxAcIvXH4+zNlFYfnDQRFrJ
         PHzIlr8fyfbzDIE8n1dP1h2CAPopbvUgUiZcQ2cuoXKgkSW41iZ679H4hMxdOYYxL5cf
         DBdQ==
X-Gm-Message-State: AGi0PuZpk7oEpwZbBx47yBXrr6rdXFi0BZworJU0yY9yPv3OBqU0O1P8
        j/0N1GrVGXO08jGxF7tHwijK+KzuCEKTRRFD4MNlMg==
X-Google-Smtp-Source: APiQypJ4tIZJqJGnORdByIJMHksJoo4U9LRFZ7eBQfYTSIzwh1Y7Uf/Jj5ZiYmcJvB//fjCenraX3JJb7xbs7uWkt3k=
X-Received: by 2002:a1f:4845:: with SMTP id v66mr1168633vka.43.1588857400648;
 Thu, 07 May 2020 06:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <1588854050-19161-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1588854050-19161-1-git-send-email-zou_wei@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 May 2020 15:16:04 +0200
Message-ID: <CAPDyKFosTSvhKWb51XmNy5R6ynnj2B+k2qrOJGU4Cdkxb7A3-A@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-pci-gli: Make sdhci_pci_gli_resume static
To:     Samuel Zou <zou_wei@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 at 14:14, Samuel Zou <zou_wei@huawei.com> wrote:
>
> Fix the following sparse warning:
>
> drivers/mmc/host/sdhci-pci-gli.c:343:5: warning:
> symbol 'sdhci_pci_gli_resume' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>

This actually fixes a commit that I on my fixes branch, which is also
targeted for stable.

Therefore, I decided to squash this into the offending commit and
adding your sob tag, with a note about what you fixed.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index bdb6336..fd76aa6 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -340,7 +340,7 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> -int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> +static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
>  {
>         struct sdhci_pci_slot *slot = chip->slots[0];
>
> --
> 2.6.2
>
