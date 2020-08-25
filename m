Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3D2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB96920706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rh/jUyId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgHYJit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgHYJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:38:43 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2106C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:38:42 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id s29so3526917uae.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gWftRufV4NK6rIXKQL8vsvZfEemfLSR6mtXtwRZFzQ=;
        b=rh/jUyIdqBpxrftU7bsFkeDWmPi0O1o0znXb5JJoLfyzd2AuwzQ3SCf8kqQxkxDptR
         YtOYN+hqUP9aLBUYZOihy7ayRVUAanhRbLc6b90QTJ1Y7jm4vQMfgsYKEz5NU5ENQKtG
         5XkQs4MohtrnOz0LgPlLE7bblPwsJrGADpKT0xCTt6Gcq+Mv8yW8HkNAAW7E5fRjTC0/
         N8xCjtaIh6wf9XQz2oP2eF1Eg0VYqqH/uwRxT635Ra684LOIPSnVuQYVws6mS+fRhlPU
         tV94mLS6wG4ELRMzjiPZ/2SgyEWB8rDbDx3wE0lKxS8wehQ8lk7725zPeSvnVqoIGI8y
         Jgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gWftRufV4NK6rIXKQL8vsvZfEemfLSR6mtXtwRZFzQ=;
        b=K+E3rEu23ovu8Ak6IVyRivm6rxtpEUf1sc7AIgQJB76dZMeah0l4P1uu2KZjvDfhnb
         mXeBQaZbSYFob/3xzL93pCtzzrgcy3fy5lRaUC+F3kDSOyKbTaanP/vXnOb9S5pRonfC
         Cxu/3QDO6n9sQit9KW6C19mxeQ3j+aIF0DfTdNwanJ5HX1EWFTzfn8bYlfe0o7HO0AcB
         5vDGevVJa5bRpWjQpKucliaDuR2/YwiE7j1DZL5fpHRtLzMNTST5szyVRwZGAMuN2wO5
         rjlsXk2VjICJ5EwtrtqSoUcyn9alQrVlrO0fo30mZ8BwF/4SQmW7MS0MJcK5aAwhqnig
         W4kA==
X-Gm-Message-State: AOAM5337WESXrb2e5KoceMjsV03dlI9+a5s7nK8JwvPs6XgE3+yvWf+V
        Nj2p7Py4vXzL/HPFXAbP5/03wCxKqQWtMhKYxCQuXg==
X-Google-Smtp-Source: ABdhPJzMmCKvJlBmLpXAm8S2BTBSrUskkCWdbQ5/m7WmoIXptfO9SSZImSgVTm+LyNloXbnyCeyilszNaD3qHCnRoyY=
X-Received: by 2002:ab0:3114:: with SMTP id e20mr4720974ual.104.1598348321741;
 Tue, 25 Aug 2020 02:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <aef586778921c93377ec2f31c86e151b6e93f6c7.1598257520.git.michal.simek@xilinx.com>
In-Reply-To: <aef586778921c93377ec2f31c86e151b6e93f6c7.1598257520.git.michal.simek@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Aug 2020 11:38:05 +0200
Message-ID: <CAPDyKFooWoUR4-=JWY16xw7qZKG5DGhQw8u6OQ4n42_VjkfgJQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Add missing description for clk_in/out_sd1
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Manish Narani <manish.narani@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 at 10:25, Michal Simek <michal.simek@xilinx.com> wrote:
>
> The commit a8fdb80f4d47 ("arm64: zynqmp: Add ZynqMP SDHCI compatible
> string") added clock-output-names for both SDHCIs before DT binding yaml
> conversion. But only clk_in/out_sd0 clock names have been covered by
> DT binding which ends up with dt yaml checking warnings as:
> From schema: .../Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> ... mmc@ff170000: clock-output-names:0: 'clk_out_sd0' was expected
> ... mmc@ff170000: clock-output-names:1: 'clk_in_sd0' was expected
>
> Fixes: 16ecd8f33c6e ("dt-bindings: mmc: convert arasan sdhci bindings to yaml")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml          | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 5887c917d480..58fe9d02a781 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -30,9 +30,13 @@ allOf:
>      then:
>        properties:
>          clock-output-names:
> -          items:
> -            - const: clk_out_sd0
> -            - const: clk_in_sd0
> +          oneOf:
> +            - items:
> +              - const: clk_out_sd0
> +              - const: clk_in_sd0
> +            - items:
> +              - const: clk_out_sd1
> +              - const: clk_in_sd1
>
>  properties:
>    compatible:
> --
> 2.28.0
>
