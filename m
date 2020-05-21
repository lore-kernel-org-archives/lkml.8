Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0910EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6A320671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqHa/17E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgEUQLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgEUQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:11:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7590EC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:11:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id yc10so9428401ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBNlt0Cc3AKR340fcGvb6vXpN125/gl2y4oSYwBgYK0=;
        b=EqHa/17El0o6+Cu7eVf9sBrousgorP3QI3woImwqEWxv2FlS1YMl0oWDWoMFWPQK40
         F1eK2G603VsFrbARn7L+LdCeCnZZjnv9adHzokplCljNOHRS0wDAxMLv2/Kj5QGnWIKS
         9PnHf5/ND0RwTHSvyNRhsktdDxYB5uHMYb9idIJK6d9G4J6ns9a97pDrJThGL18zLcHz
         74IKUUSt/mTHYN/LHdd+cPd64e/aotSDY9aENkAoJ+tvM5jXQ4UTVczUjLua0/xaihPy
         MnFs6ew02036GA11XX6SQY3oxW5cjB5bFdrfNzc3UijzQnHsuByLe1koRo3kVArRPYNN
         hHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBNlt0Cc3AKR340fcGvb6vXpN125/gl2y4oSYwBgYK0=;
        b=kpPXKq13FFU0aYXpnjEoM9FYBsrAN87CXhHkAyKyRJsgXO9+UUhf38LmEoZvnVfG7Q
         AVSIkMIeDwjTq/vvjV2vG/7P60GcLgnCpdp5YiZpxCK8hD+vRG4KBVxWBlfStOTwWsUC
         aEYcuQYww+PHF9UYMx++Ivce6w6WXSXYQCa4WVODjuKcB7ZbAoK5Y6pPs1bqIghgHVfj
         8lLFWY0ov5c+uPy2Ca/z43IwPNoBbXkn6yeZU/Sm6TchenNZ+1sfwT/FfZnJ8rBxSd+P
         ZiI1JJ5RgD/cNmY9IAxbavVao/rNRAY30O8H7G7MJuncJtLmTwhKboTrmlKTEqct1jEa
         j18Q==
X-Gm-Message-State: AOAM532htLfMKZVbQ9LyjwBUZIdaBYsVNz3yufqz6rv7iDlkALf0iDBK
        rsbfKrgd8IX7es1/F6zydAdJb7rWDTo3KdFH7vKorQ==
X-Google-Smtp-Source: ABdhPJxGrPCh+N0iQi99b+JXuuxuPOhEPM0HGvOFC+mP3Ce2ExXyPoAYxVlLGSL8ct75JzzbIKg6G+CDqC/Q3sJu8u0=
X-Received: by 2002:a17:906:6094:: with SMTP id t20mr4534291ejj.359.1590077503013;
 Thu, 21 May 2020 09:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589894597.git.saiprakash.ranjan@codeaurora.org> <c9d7748393ece489f9c8510925c2ddb1608db5b0.1589894597.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <c9d7748393ece489f9c8510925c2ddb1608db5b0.1589894597.git.saiprakash.ranjan@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 21 May 2020 17:11:32 +0100
Message-ID: <CAJ9a7VjnchycwGPVDpyRMFyLXddcivKct8wfhYgOVmyOnAMbSA@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] dt-bindings: arm: coresight: Add optional property
 to replicators
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 at 14:37, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add an optional boolean property "qcom,replicator-loses-context" to
> identify replicators which loses context when AMBA clocks are removed
> in certain configurable replicator designs.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 846f6daae71b..b598a5f0037d 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -121,6 +121,12 @@ its hardware characteristcs.
>         * interrupts : Exactly one SPI may be listed for reporting the address
>           error
>
> +* Optional property for configurable replicators:
> +
> +       * qcom,replicator-loses-context: boolean. Indicates that the replicator
> +         will lose register context when AMBA clock is removed which is observed
> +         in some replicator designs.
> +
>  Graph bindings for Coresight
>  -------------------------------
>

Reviewed-by Mike Leach <mike.leach@linaro.org>

> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
