Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40830 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730007AbgCKPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:35:08 -0400
Received: by mail-ua1-f67.google.com with SMTP id t20so875693uao.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <1583323250-23596-1-git-send-email-vbadigan@codeaurora.org> <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 11 Mar 2020 16:34:31 +0100
Message-ID: <CAPDyKFov_MwTjXarivgJ7+D_Oa1cgma3t1pDGQ8gkmeNJn4jDQ@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: cqhci: Update cqhci memory ioresource name
To: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Doug Anderson <dianders@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 4 Mar 2020 at 14:25, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Update cqhci memory ioresource name from cqhci_mem to cqhci since
> suffix _mem is redundant.
>
> Only sdhci-msm driver is making use of this resource as of now.
> No other vendor's driver is using it. So this update shouldn't affect
> any other vendor's cqhci functionality.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Corresponding binding change:
> https://lore.kernel.org/linux-arm-msm/1582545470-11530-1-git-send-email-vbadigan@codeaurora.org/
>
> Changes sicne V1:
>         - Updated commit text expalining this change affects *only*
>           qcom cqhci functionality.
>
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index e2ea2c4..e24b8ff 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -1077,7 +1077,7 @@ struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev)
>
>         /* check and setup CMDQ interface */
>         cqhci_memres = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -                                                  "cqhci_mem");
> +                                                  "cqhci");
>         if (!cqhci_memres) {
>                 dev_dbg(&pdev->dev, "CMDQ not supported\n");
>                 return ERR_PTR(-EINVAL);
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

