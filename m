Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD6FC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25F9206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Al2hllyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgEFMdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbgEFMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:33:31 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E881C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 05:33:31 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id s11so862437vsm.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/H9a8fdUQMIeGLl1QzKMQEwsBfgzt/5wa51opjojDM=;
        b=Al2hllyDJrpnAAgUMK4kmI3Q4IvOqQLe0OVjzxqXCK2z1jqaLkiyJi5DX4ENlFPf0W
         zq3dCkbZ6StGLbPMWGN+pIeDc6ihuyLGPfl6IoTQYnyEGgNWapWnCjcQFlopRjCwChlR
         IFqp5yy9xOiagdbFvp0nSlhH/Co0b5MutNTiMGGL3JrtpH8deu748hBqo6sjdzUYTw1/
         JfRCay5/xUnGMlLQjoCnvI9Tlst1bNTeXqQ2GvhmCUOtz9WH1W3ZnCe6G9wZNli7v6JL
         wn4mGFaQ2HLDiTV9IzsjMxEJPc13Bhm292vOZNkhKSUkyMP/Xx+1eZ5TKD+A7C4oYoKd
         3CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/H9a8fdUQMIeGLl1QzKMQEwsBfgzt/5wa51opjojDM=;
        b=GgheousXal7PFhizecMvESq6dKdq9SHrXHK2GuNwFwFin1fM5qD/t8owuUSJPtchDz
         q3gWazgZpgpKXQLcVfagxJiDkyyIVFnFj92eppkWARrKuQQnH6PPgNgJRIq3prg2r2xT
         5sH5HSXpFUu0eRDwAOiezu6dPT5FroMBADZigRPc/b8qH8wYQIVgKpQb1WxQtEPQOQVP
         WntlUdzq7qaYOMF9qlAn6BdC+7x0krDHM2x74/+yuLLUCEgpRUk8fqxM8jTzVgg39JaO
         4WU0+56+vAH6s1C1jzpM8NXNNa1yAbHZp9Gt7u6Sb6VE7/xepDejCjUaJTlj8qeu37YL
         90VA==
X-Gm-Message-State: AGi0PuaGoZ9um00Jcx5Dod8XJUe0IliBWeuyM3bd1sQpsHGW78fqgumt
        +XERhKonMe3XqPC8eNqNFEY9ohjYy+L1LFHC+w1Z7A==
X-Google-Smtp-Source: APiQypIveNOAp+c/Cus1Zn/SarzWZcN4REWKyhbpRPZVcAdvDS7J0T6Lh9t3nKf/aERxl5/aNTXybAaSlEHODK+/ECQ=
X-Received: by 2002:a05:6102:2e4:: with SMTP id j4mr7021578vsj.182.1588768410246;
 Wed, 06 May 2020 05:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200504202243.5476-1-sibis@codeaurora.org> <20200504202243.5476-2-sibis@codeaurora.org>
In-Reply-To: <20200504202243.5476-2-sibis@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 6 May 2020 18:02:54 +0530
Message-ID: <CAHLCerMMxQHK2FbtfyLAzU5Vi0HTM6sR5vdb1G_2bDo4m1KbCw@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] arm64: dts: qcom: sdm845: Add SoC compatible to MTP
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 1:54 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add missing SoC compatible to SDM845 MTP board file.
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>
> v4:
>  * Picked up R-b from Matthias
>
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 023e8b04c7f65..1372fe8601f50 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -13,7 +13,7 @@
>
>  / {
>         model = "Qualcomm Technologies, Inc. SDM845 MTP";
> -       compatible = "qcom,sdm845-mtp";
> +       compatible = "qcom,sdm845-mtp", "qcom,sdm845";
>
>         aliases {
>                 serial0 = &uart9;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
