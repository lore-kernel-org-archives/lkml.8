Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20558C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA40320739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvGWUWWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCTFWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:22:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42267 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgCTFWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 01:22:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id a2so4862812otq.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuqZitG28D6cu+nd1SoE8yFkR4mBbbKOsK5vySIs4Co=;
        b=KvGWUWWCVjsfFVfFVYH7c3tKNsW/IY+5HGc7nakHOAlEV5sW7f/4PLYkyuf+DSodXq
         yTnv6usL0PGvC4OK9knxg8sPSmVzPgVNWOY1Q7qZwYgi++ycRSc3y2a/OOka335ncGJ/
         VPgA0JrCW1lZaZjrZ5m8BArT4aeePxbVtjKknm2ZOIqJLNEAH8AWRJQh4B2TZT0RdNEl
         dL3dihtxzoDE9EarNGSBJwm4wm9RDr5eJxDbU27sOBqP619YBGhdXEooliZGVE2qHf0W
         uRXDqrA9kLPc/LGiVHb3kVTiv69hA+kgci3Q6z9gKs/eZjILlNgajrd6KRzcFsqV2Uyu
         nXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuqZitG28D6cu+nd1SoE8yFkR4mBbbKOsK5vySIs4Co=;
        b=iwY4bT59WPpdTWKLjoJhdiGwY72Ir14ZGeLmO/mhHN7QAGOlOJ1gOweSNwKjreqRbV
         ZD25ZRqLFjYMxwdjZ9TQ4EWHHiDbv/aFiWxALO2tBmW9z+3AAgRWGgsGJi51EaUHP/X+
         ojoq2v7chuZrtlZMKbV4eRhrCa+ugOH8jiLc962U962zCt8DYDQQlz9eJ7mNwO5EG46+
         gU0vHE2Msm0Xf1ujvWQzB9gxWUKi5T5Y5pzkNNK1WJU2FMippA7EO1y1FwwupGiAeyfh
         DATIYzcyAHOloQuRvqB4NZCk/U2DnXalPD/LHvn6gTFJyJVF0FI0Mk8k63l2KOGRrSJ9
         CGMw==
X-Gm-Message-State: ANhLgQ2gaW9CPicK/wlo3IQRYn+1G60upUnjUxzF+xl2pLaY0jXwbo7p
        BstfMH20R4kwTYTahBJQwFZ2c5HSIiqe4X9MJiOtXQ==
X-Google-Smtp-Source: ADFU+vuMyCXVoQ7R8+fFsv9qWGJSaeB7mpdOKQvS3drwo7aFOvb7Qtflc+a81WJcHEP/B2afBHA0c5bvj5kBtXFpbA0=
X-Received: by 2002:a9d:3b09:: with SMTP id z9mr5469806otb.195.1584681762685;
 Thu, 19 Mar 2020 22:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200319194954.39853-1-john.stultz@linaro.org>
In-Reply-To: <20200319194954.39853-1-john.stultz@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 19 Mar 2020 22:22:06 -0700
Message-ID: <CAGETcx-q-BY8o17bKWU79iEgfZagSDn9-fwJQ5FzdcOnwbXQHA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: qcom: rpmpd: Allow RPMPD driver to be loaded as a module
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 12:50 PM John Stultz <john.stultz@linaro.org> wrote:
>
> This patch allow the rpmpd driver to be loaded as a permenent
> module. Meaning it can be loaded from a module, but then cannot
> be unloaded.
>
> Ideally, it would include a remove hook and related logic, but
> apparently the genpd code isn't able to track usage and cleaning
> things up? (See: https://lkml.org/lkml/2019/1/24/38)
>
> So making it a permenent module at least improves things slightly
> over requiring it to be a built in driver.
>
> Feedback would be appreciated!
>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Fix MODULE_LICENSE to be GPL v2 as suggested by Bjorn
> * Leave initcall as core_initcall, since that switches to module_initcall
>   only when built as a module, also suggested by Bjorn
> * Add module tags taken from Rajendra's earlier patch
> ---
>  drivers/soc/qcom/Kconfig | 4 ++--
>  drivers/soc/qcom/rpmpd.c | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index d0a73e76d563..af774555b9d2 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -123,8 +123,8 @@ config QCOM_RPMHPD
>           for the voltage rail.
>
>  config QCOM_RPMPD
> -       bool "Qualcomm RPM Power domain driver"
> -       depends on QCOM_SMD_RPM=y
> +       tristate "Qualcomm RPM Power domain driver"
> +       depends on QCOM_SMD_RPM
>         help
>           QCOM RPM Power domain driver to support power-domains with
>           performance states. The driver communicates a performance state
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index 2b1834c5609a..22fe94c03e79 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -5,6 +5,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
> +#include <linux/module.h>
>  #include <linux/pm_domain.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -226,6 +227,7 @@ static const struct of_device_id rpmpd_match_table[] = {
>         { .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
>         { }
>  };
> +MODULE_DEVICE_TABLE(of, rpmpd_match_table);
>
>  static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
>  {
> @@ -422,3 +424,7 @@ static int __init rpmpd_init(void)
>         return platform_driver_register(&rpmpd_driver);
>  }
>  core_initcall(rpmpd_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPM Power Domain Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qcom-rpmpd");
> --
> 2.17.1
>

I think making it a permanent module is still very useful and a good first step.

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana
