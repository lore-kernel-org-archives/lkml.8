Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF38C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E132071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Okfa0myw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391156AbgEYQB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388211AbgEYQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:01:58 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984B9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:01:58 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 18so17724117iln.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndTklb7/SAZk4bUIoOKID+ziy4QQzei1SxmS+QITaNQ=;
        b=Okfa0myw3gWvHcsvCG+LrNu8vo8bECwM1NcFblymMQAiGT7+y9eHEr8NC5z6+N8JzK
         mzlw3h7rltmPg5jkXMl04Me9kIbZlJYjsG8Urh65mRdyktu03LLIpv77czeeIpVw8Sru
         x6DqR6REiEic6JH/kXXTOsijnyICa34jR95UnPtu86+3N8w52mTLttUjUQRtPFCY/AZA
         vG6P/pea15LJdJxDU3EvCTPMiuu5DCbxndnPe4cnBnNZF2ZxKEZ4qbok33u/ix0NGgf/
         NluPSBy63jZnk1Nbp5nADhjP36FybTKqPGJNjjHqjN3ow+fOetbQDP+cAHrBoMqBGVCR
         wFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndTklb7/SAZk4bUIoOKID+ziy4QQzei1SxmS+QITaNQ=;
        b=T8gGZL1J6JtU/Dgt6Fq8nWSzMpHJ+ZMnVZD3aOze/zNwS8CfF5OXnYdy4nBqTNMDLp
         yyvNlDr5axqr+kpPDo6ukT8eFNkrHRul9i/xSqjEGFocdi6w56/5HnroQr5l1bcDZPBf
         iN1Uvg8CB0pQyCnLevwKARVHCHO3xjTgZoP0AyzK55n2YQN01ss0tqlBzUNz+IkKFqZg
         szoZHREiQw4RTw7rTIzF9rRBfcdmR7rU159GB6sweWau8IAIntTvQeyIk/3HG+ag07Gs
         Ypp5wInUZnnGltWJcaBmrgeE3hyOIAjH8jtc1tIai9Zhm9yYTFcTiSWjU6j7bEfkwfLG
         q5pQ==
X-Gm-Message-State: AOAM53305rgUQpmu2Ad4OVTdQiAJHM7ObPtEMItx14Qy8IX+S/gp8uO+
        sIBgy6t8s9Un53eobpTwdjLKWagfm0Tf6S6Q/6nOcg==
X-Google-Smtp-Source: ABdhPJzdCyCnVR8DkEpN7qEDDAtmWOw4EM3xPxchVD4sgi/TBYuoYYkIjzb27DvgzVuornpYLqRjO0idnxc4E75ZQnI=
X-Received: by 2002:a92:89cf:: with SMTP id w76mr24457702ilk.57.1590422517999;
 Mon, 25 May 2020 09:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590171891.git.saiprakash.ranjan@codeaurora.org> <ccfe8a5ede0523436508e31085322ccdab8f972a.1590171891.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <ccfe8a5ede0523436508e31085322ccdab8f972a.1590171891.git.saiprakash.ranjan@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 25 May 2020 10:01:47 -0600
Message-ID: <CANLsYkwhjbyspLjbnp4XYCcRNFUkBs46QjWYBTza1scGDtNSmQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] dt-bindings: arm: coresight: Add optional property
 to replicators
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 at 12:37, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add an optional boolean property "qcom,replicator-loses-context" to
> identify replicators which loses context when AMBA clocks are removed
> in certain configurable replicator designs.
>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +
>  Graph bindings for Coresight
>  -------------------------------
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
