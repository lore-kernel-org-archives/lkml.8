Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5A0206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSeSQ6MX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbgF2VGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389594AbgF2VGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:06:05 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1EEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:06:05 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p20so18218034ejd.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rq20rSFORtIjkkFfsOodF7/loWbxXzOkNkZ9gABTDVk=;
        b=hSeSQ6MXm37ABAafBYuGpCCIr8kzQpA01Oj4bpo9DYXwgHyCcg19o4AUzS7jbrRpOb
         poip2fESmXOCp/ZkLkaX/AJQpBJjL6sJ3/SlvJ5aTkzPmT1Er5IU6xCDTrQolyn+Thn4
         tHjLsD8QwjcV2LDXb91H1JhLeVqtTsKm7TI9BYDJg5Gmyu9Cb6lHNC7itlELEVXFzgtN
         Ju5AQMT76MVnJUKayU0eDHaHJdX858w6maZfMarJWghToy7BZ8J2hSLH4QaHGa4sr9uR
         Ca63WFIXQ0U93GCk6rCcjTaNS+Uyi0UuIxbVHT5jSUMHH4HmDU/KtBIEEdndNFhQZ7lp
         tC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rq20rSFORtIjkkFfsOodF7/loWbxXzOkNkZ9gABTDVk=;
        b=liYmMja3IJ904r1u8mxHwYxcjbYRPluhSMl32/G/80AabNHlirxtNC5cDsctMF+nXl
         N3wVy8Csu0MjRmFIlLi8K7WMa9rVkGlD6AKW4W9c+A454M3LlFSDWN4PGkIsLtd4rl4H
         9UGVV4wVVjg8liQao/zZ+WSsnUXIIv/R/+4wn/tueeF/nz1FOpwnPCMYQZsapmLUh69c
         tedchdFnIlMvkEWlwv9E39LO4HDxR9HTkbd8csy/ONuB4Gf60xYUsDKeVfL9uFecVIOc
         1EP1a6UzS84Haz5zn6KzDR08dztDsMqstnz/87+zlmlDRBnAYei3rmH3E/IHj3WJwEDC
         XQVQ==
X-Gm-Message-State: AOAM532JvrkYV3kglhSEFIsZYugMyjcj6Ww9ZVa6Wa8tny+98n7x4vvI
        LvbPyyhTIaAVTcZfDFytnD29a3Zfpvb9Kf+lshtrQA==
X-Google-Smtp-Source: ABdhPJxn+9mxEDJtgIvUOIFg6YNIcgYeyPSSi16cAgmgoim/yZIjeZYVXiGU2P080VBLtQrUENC5fJqF3cyMzFh4uw4=
X-Received: by 2002:a17:906:8316:: with SMTP id j22mr15258617ejx.97.1593464763819;
 Mon, 29 Jun 2020 14:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200629163851.2130450-1-pmalani@chromium.org> <20200629163851.2130450-2-pmalani@chromium.org>
In-Reply-To: <20200629163851.2130450-2-pmalani@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 29 Jun 2020 14:05:52 -0700
Message-ID: <CABXOdTfax0f_W=H7042uBMcNgNTV6R-QOR7af4YnvSfaJ9Wn_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] platform/chrome: cros_ec_typec: Add PM support
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 9:39 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Define basic suspend resume functions for cros-ec-typec. On suspend, we
> simply ensure that any pending port update work is completed, and on
> resume, we re-poll the port state to account for any
> changes/disconnections that might have occurred during suspend.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - Remove superfluous DEV_PM_OPS #define.
>
> Changes in v2:
> - Remove #ifdef-ery, add __maybe_unused tag to functions.
>
>  drivers/platform/chrome/cros_ec_typec.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0beb62bf5adf..d5ac691de68b 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -722,11 +722,35 @@ static int cros_typec_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> +static int __maybe_unused cros_typec_suspend(struct device *dev)
> +{
> +       struct cros_typec_data *typec = dev_get_drvdata(dev);
> +
> +       cancel_work_sync(&typec->port_work);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused cros_typec_resume(struct device *dev)
> +{
> +       struct cros_typec_data *typec = dev_get_drvdata(dev);
> +
> +       /* Refresh port state. */
> +       schedule_work(&typec->port_work);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops cros_typec_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(cros_typec_suspend, cros_typec_resume)
> +};
> +
>  static struct platform_driver cros_typec_driver = {
>         .driver = {
>                 .name = DRV_NAME,
>                 .acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
>                 .of_match_table = of_match_ptr(cros_typec_of_match),
> +               .pm = &cros_typec_pm_ops,
>         },
>         .probe = cros_typec_probe,
>  };
> --
> 2.27.0.212.ge8ba1cc988-goog
>
