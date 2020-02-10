Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E458C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3967A2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuoXF5sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgBJRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:49:40 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44619 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgBJRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:49:40 -0500
Received: by mail-vs1-f65.google.com with SMTP id p6so4696778vsj.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jOz9D1OkZvcqdZyOY6mXklx7SmskxabXR6YSkl7lkk=;
        b=iuoXF5spBCzwt9gZYU5z+rgSWG1JCXbT6h0ByYtuED8LuMAd4/HGkib5WlZgt/7i9U
         7q05cz0GAK+hsLGFfuBUWQOTZ6i768GlleT//AR3gkC9LMA5HftOnVNnkMt3hLJ0AlKH
         rzAePrzCeuNvsClhAXqPjLWeBysoVkh6BwyBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jOz9D1OkZvcqdZyOY6mXklx7SmskxabXR6YSkl7lkk=;
        b=ZtGNW1wUPodGEgDBoTXC3TveCh0zaquvXIhKh12KZxFGyltED49l9C4sIZrGq4DWXs
         FPUPC1ljv3GXaVI/X1Q/vaOkx8Ih2UZLYa0GYvH//mbFEYxk+yHmtTI9w5NGA8/sQwF/
         +0uhPNsZcu4ZWrW9dqxIVJ71QEeaA3cCNXBOEecs2QxbxgpN0BiKoByxIVCb6+h2C9Dq
         ZGhp2QcfhG9Gs4m+1YA6DfDPe4xXyYwwfXhduPMlrv5saRnkTXwDf/076wBt2jwKnt4z
         NwvsFTDyIW7mpbwPu/fbqQGyDjgMWNHJijBMHNbQGBjq1VI5p+1hlFh3f4XHFY5A9vsy
         4uNA==
X-Gm-Message-State: APjAAAWiQjjwPBx+WwnEiz5FACp3CSS5UYza1dUYjOJv/6tv71qRBtap
        yR2Q0sTq0/5DCnDCImDKgiArVV2wgTc=
X-Google-Smtp-Source: APXvYqz0csCefgBzYPK3p/0RSkztAm18o3XDx8h+5951f8gnY5n/A9hHT7cPBrp5qeA5zk9aC2mMbw==
X-Received: by 2002:a67:db97:: with SMTP id f23mr7444885vsk.100.1581356977476;
        Mon, 10 Feb 2020 09:49:37 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id s21sm253852uao.11.2020.02.10.09.49.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 09:49:36 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id t12so4680810vso.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:49:36 -0800 (PST)
X-Received: by 2002:a67:e342:: with SMTP id s2mr7152359vsm.198.1581356975599;
 Mon, 10 Feb 2020 09:49:35 -0800 (PST)
MIME-Version: 1.0
References: <1581307266-26989-1-git-send-email-tdas@codeaurora.org> <1581307266-26989-2-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1581307266-26989-2-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 10 Feb 2020 09:49:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VqRAVZ19gSbtxbmdRCBbPRr+CMxWVR29diWtfX5mL3jw@mail.gmail.com>
Message-ID: <CAD=FV=VqRAVZ19gSbtxbmdRCBbPRr+CMxWVR29diWtfX5mL3jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: qcom: gpucc: Add support for GX GDSC for SC7180
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 9, 2020 at 8:01 PM Taniya Das <tdas@codeaurora.org> wrote:
>
> Most of the time the CPU should not be touching the GX domain on the
> GPU except for a very special use case when the CPU needs to force the
> GX headswitch off. Add the GX domain for that use case.  As part of
> this add a dummy enable function for the GX gdsc to simulate success
> so that the pm_runtime reference counting is correct.  This matches
> what was done in sdm845 in commit 85a3d920d30a ("clk: qcom: Add a
> dummy enable function for GX gdsc").
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

For future reference, if you have someone's tag in your commit message
it's nice to CC them on the email.


> ---
>  drivers/clk/qcom/gpucc-sc7180.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/clk/qcom/gpucc-sc7180.c b/drivers/clk/qcom/gpucc-sc7180.c
> index a96c0b9..7b656b6 100644
> --- a/drivers/clk/qcom/gpucc-sc7180.c
> +++ b/drivers/clk/qcom/gpucc-sc7180.c
> @@ -170,8 +170,45 @@ static struct gdsc cx_gdsc = {
>         .flags = VOTABLE,
>  };
>
> +/*
> + * On SC7180 the GPU GX domain is *almost* entirely controlled by the GMU
> + * running in the CX domain so the CPU doesn't need to know anything about the
> + * GX domain EXCEPT....
> + *
> + * Hardware constraints dictate that the GX be powered down before the CX. If
> + * the GMU crashes it could leave the GX on. In order to successfully bring back
> + * the device the CPU needs to disable the GX headswitch. There being no sane
> + * way to reach in and touch that register from deep inside the GPU driver we
> + * need to set up the infrastructure to be able to ensure that the GPU can
> + * ensure that the GX is off during this super special case. We do this by
> + * defining a GX gdsc with a dummy enable function and a "default" disable
> + * function.
> + *
> + * This allows us to attach with genpd_dev_pm_attach_by_name() in the GPU
> + * driver. During power up, nothing will happen from the CPU (and the GMU will
> + * power up normally but during power down this will ensure that the GX domain
> + * is *really* off - this gives us a semi standard way of doing what we need.
> + */
> +static int gx_gdsc_enable(struct generic_pm_domain *domain)
> +{
> +       /* Do nothing but give genpd the impression that we were successful */
> +       return 0;
> +}
> +
> +static struct gdsc gx_gdsc = {
> +       .gdscr = 0x100c,
> +       .clamp_io_ctrl = 0x1508,
> +       .pd = {
> +               .name = "gx_gdsc",
> +               .power_on = gx_gdsc_enable,
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +       .flags = CLAMP_IO,

In my previous reply [1], I asked about these flags and if it was
intentional that they were different from sdm845.  I did see a private
response, but no public one.  In the future note that it's good to
reply publicly so everyone understands what happened.  In this case, I
was told "the GDSC's on 845 and SC7180 are different and hence the
change in flags is expected".  That answers my question and thus I'm
fine with my tag being here.  It also looks like you took my other
review feedback on v1, which is nice.


-Doug


[1] https://lore.kernel.org/r/CAD=FV=V6yM7UJwu0ZLPCqmDgV9FS4=g+wcLg0TV51b72zvWT9Q@mail.gmail.com
