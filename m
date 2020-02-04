Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE64C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA5220674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 18:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WeRebeBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBDSWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:22:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46582 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgBDSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 13:22:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id x14so19608076ljd.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDmc7rJKH3PB8BRLa4LSMdik+WscauM3bJQAO66d9eA=;
        b=WeRebeBVSEUt28wl435zQEX1/6tiqV9monpU/7Ej5fqLhT4R41NF8WtVIPn3kCpd2W
         wbcN2Sjxu4ENSsuskkDYKK9U80zRpDL4LUYH/tlUOhVyLqB1KATrcbuAqPq0Al5qoWvp
         rMHMlBCss0WzMtE8Lymhfpn15/d3thD2oJEIZmNP8MDzdV8YSMDGPweIJImQWGcV8Ga/
         j/IbkkAP1Fj9pbuFBAyq/t9v6EySeBAPmFRUvTPRYghB8ovJFADomNk5+wvaaAHEWM0S
         hpqdASOKeTOzzB6JZ+53/Eq07SOogb68gbxVJW6udAD0KmS978l/cAwWllNpHbBrJLcc
         ldEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDmc7rJKH3PB8BRLa4LSMdik+WscauM3bJQAO66d9eA=;
        b=MimoEktQwf7ISp//qO9wghQOY9qnZyKuqOpPhgnngkbfBLe5D0EnLf3n4K7905eaWd
         WaX+Cp84+BItp4veDRIfr6n7awKPI3coHl7NXtpIt5qoAXP1e8ebZeGmaaQuKppDu7SP
         mRCJfpirfzgW4PWs69bPer0GXQMql62SgUnKi0hGUdElXb8GEClkXsquD2OmSWCXnPXf
         KJWPbcyyJ1b4FUwYQcC4S3sX2gnxHv0S1RHOy2TgJ10aq5UMP4hB/kgxeaSRZUqUtcEY
         VvH1St3LTqxR4JMgXZkg3nIgI3qNanGw6A8yzcOekh7QIZJKohn2JDL5BXhCOdtRg+88
         OXYA==
X-Gm-Message-State: APjAAAWKRWxEOTIug7nqOHUdlN9VSLFi/gUu10/dKhi8QuLnk/mM6eu9
        DyuGBrkIr4Gxd+5l9PBG9Cn5AgJp2MSeskegE53qhg==
X-Google-Smtp-Source: APXvYqxET1q8n/qQ6aY0jYO8nGz1OvZdbUcpn8bnrFqAZJyuuJYIXotPvLB+pBHSS5AiqYMW6+TjrlGJYozegKXPWGc=
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr18353599ljg.3.1580840527698;
 Tue, 04 Feb 2020 10:22:07 -0800 (PST)
MIME-Version: 1.0
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org> <1578630784-962-6-git-send-email-daidavid1@codeaurora.org>
In-Reply-To: <1578630784-962-6-git-send-email-daidavid1@codeaurora.org>
From:   Evan Green <evgreen@google.com>
Date:   Tue, 4 Feb 2020 10:21:31 -0800
Message-ID: <CAE=gft6--=zhxfR9G=S0g-5c9YdpvaFWz9dcgV7zJQAzcreZjg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] interconnect: qcom: sdm845: Split qnodes into
 their respective NoCs
To:     David Dai <daidavid1@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org,
        Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 8:33 PM David Dai <daidavid1@codeaurora.org> wrote:
>
> In order to better represent the hardware and its different Network-On-Chip
> devices, split the sdm845 provider driver into NoC specific providers.
> Remove duplicate functionality already provided by the icc rpmh and
> bcm voter drivers to calculate and commit bandwidth requests to hardware.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  drivers/interconnect/qcom/sdm845.c             | 1132 ++++++++++--------------
>  include/dt-bindings/interconnect/qcom,sdm845.h |  263 +++---
>  2 files changed, 609 insertions(+), 786 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index f078cf0..8145612 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -5,283 +5,285 @@
>   */
>
>  #include <asm/div64.h>

You don't need this header anymore, right?

> -#include <dt-bindings/interconnect/qcom,sdm845.h>
>  #include <linux/device.h>
>  #include <linux/interconnect.h>
>  #include <linux/interconnect-provider.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> -#include <linux/of_platform.h>
> -#include <linux/platform_device.h>
>  #include <linux/sort.h>

..or this one.
