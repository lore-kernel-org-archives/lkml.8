Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB59EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B420120727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bMZEoYev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgEOTFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOTFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:05:54 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB3CC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:05:54 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 62so1896415vsi.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILTNxRMhVaU1ppwKtb504YY35g+lEq0QuWy+iVUE2z8=;
        b=bMZEoYevT52u61nJD5we/u1JaG8jzU7khHbEmIItRoRo9c67denAC2dZI5n/GtGcte
         O6CuOaJk4AYaDQX4yq+aRjJIGv63nxepgB4RHH9gODQ+rlXq7MTS7sE4DkPKkJ4+uXL+
         cADO8rOPfT+7ANv5baePtF9UpQd+3uCS40EDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILTNxRMhVaU1ppwKtb504YY35g+lEq0QuWy+iVUE2z8=;
        b=ERsRRs1tJQue/sigvg4XLsW6/U0zenunkyW+WIpq/SC7e0Ku+p5HhIKq4IkVDr9yr4
         ImXm3UQ7fPUAahibE6t4WLntAXJJDbeSKDBkegxTdTzfQe643QYJQuZ0u9b3x43sp6E1
         EntmYmO0x161fvhxWPbMwYKWolLAagj6UDvRsHFRaaa5/cuVw2NbmOnak91E9eo2DyNi
         fNL4mWbSKFV+YjaCPGOaGNBD7XfLxlg/xoyZC773quoN3n6k//1ZVpRn61hzr5oei503
         OIDYEut1p24y5IyvhPG0RkoWZBFJ/V+anyPp46NSZ92BBunjIeFpasNO1/J6Y5U/Bz0L
         lQPQ==
X-Gm-Message-State: AOAM530onulVMxSv/VTYCI1ffE8ufWLiA1l78XLvgCcZyW0rzxlG+YhZ
        phJzyyfAcKc2n6spEwI3CV2kFQUAg5U=
X-Google-Smtp-Source: ABdhPJysUzwpROWR/2ekHZFtp/osQdfbPkAOYAUDArLoHqZjvJDaXI8hGHIxLEyrXszDTxsa0dXqWg==
X-Received: by 2002:a67:ec4a:: with SMTP id z10mr3533451vso.125.1589569552869;
        Fri, 15 May 2020 12:05:52 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id s130sm807801vka.17.2020.05.15.12.05.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 12:05:52 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id v26so1900574vsa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:05:51 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr3909984vsq.109.1589569551204;
 Fri, 15 May 2020 12:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <1588329036-18732-1-git-send-email-smasetty@codeaurora.org> <1588329036-18732-2-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1588329036-18732-2-git-send-email-smasetty@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 May 2020 12:05:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXv9DYf7LWoFBvro=7Bzeb1_0bXAvRH-suzxnrCu+V2A@mail.gmail.com>
Message-ID: <CAD=FV=WXv9DYf7LWoFBvro=7Bzeb1_0bXAvRH-suzxnrCu+V2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add sc7180 compatible string
To:     Sharat Masetty <smasetty@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 1, 2020 at 3:30 AM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> This patch simply adds a new compatible string for SC7180 platform.
>
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 6515dbe..986098b 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -28,6 +28,7 @@ properties:
>            - enum:
>                - qcom,msm8996-smmu-v2
>                - qcom,msm8998-smmu-v2
> +              - qcom,sc7180-smmu-v2
>                - qcom,sdm845-smmu-v2
>            - const: qcom,smmu-v2

Is anything blocking this patch from landing now?

-Doug
