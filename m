Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7D6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB663207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwd0qAdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHLMBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHLMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:01:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603E8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:01:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so1752484wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uTnVX4KlkSTJGfD9l+RCsWAg2mdrZdTCdEjS+NMIBU=;
        b=iwd0qAdVsJM8Jgp9ClV2qZQrQcUXhlAiEGF3YceffEeqhpzMHeYrcYF4PlZsjjydjV
         OLiHhI5B5xGDQIrfyDZnFKoSvubfng9ZOid9lRMT1+aSJvUCUtF1PL8Sds6Dci1nljoc
         Z102eolXPqwqkz8FzxOMJwScb59RdWco//uG3BpbRtQwWUtJTZ0fAnCMjV5fQreu6Fau
         YPQRu35LW4LftnzBzt6Ohzgw74G+Z5DU7vq8XiOx8+F2o40eJgz9iswgHevVq8mxl4nz
         S/DvM7JGQu+qlj51MH/uOp7BxD4hRbmMh0B7mVIiUwbXhmV6d/lz/CzCqANTyhkBk3rw
         Ts1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uTnVX4KlkSTJGfD9l+RCsWAg2mdrZdTCdEjS+NMIBU=;
        b=UF/NVvv2SKad+jQpqq+JUWPHmY1NRXQasYwwYqPYuHf9pDHb57dD+oq0JtPslh3LXY
         3jxVj9lrUYC0RcMniGUa3HGfXH96wGEnbR2i14ZHMno7W+mry7yZHr5w+e0Z9gskvEM1
         XDMUNMDIgR+/uXKjFJtJfAbeuEiQdh+axUHBgTVcDtBXFg7cOucOqCdnjjl98tLkUAb7
         4V1HyAi8mwjVLL8FwPiG3JKNTiJkPce1FNLuPO/NJskOJCDtMqqp8sYQAFA13Bcl3fGp
         unOL3Tcbj7wTgjx+zh/RKU3UhsKnGnakPaXNKVe17tksLK5ah5UXvRP3KBloqusaFQwb
         FkKA==
X-Gm-Message-State: AOAM533ikr+v73xa4UloBlbxB+3rQc5R0NwIzKiI2VzT8/72SRH6kwBA
        p5FhL2n7qZSB1deND6xFryjhnk4Wmag0Er93sXCaZQ==
X-Google-Smtp-Source: ABdhPJxmekv2xvQc+0+1EwwsRTu6N2DfJzEWIidmJOSFCOPFGwzDEvQJ0UFPQ0Kxc6EXXkgOmtQwsqErWSRliFDxPH4=
X-Received: by 2002:adf:fc06:: with SMTP id i6mr33138098wrr.79.1597233663829;
 Wed, 12 Aug 2020 05:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <1597227730-16477-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1597227730-16477-1-git-send-email-rnayak@codeaurora.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 12 Aug 2020 17:30:27 +0530
Message-ID: <CAMi1Hd0Zx53E76+86vTDEFyKrxb31nKqJcq5q4sCvrv2L5Jx+A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Fixup OPP table for all qup devices
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>, tdas@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 at 15:52, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> This OPP table was based on the clock VDD-FMAX tables seen in
> downstream code, however it turns out the downstream clock
> driver does update these tables based on later/production
> rev of the chip and whats seen in the tables belongs to an
> early engineering rev of the SoC.
> Fix up the OPP tables such that it now matches with the
> production rev of sdm845 SoC.
>
> Fixes: 13cadb34e593 ("arm64: dts: sdm845: Add OPP table for all qup
> devices")

Fixes BT on Xiaomi Poco F1 phone running AOSP.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 2884577..eca81cf 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1093,8 +1093,8 @@
>                 qup_opp_table: qup-opp-table {
>                         compatible = "operating-points-v2";
>
> -                       opp-19200000 {
> -                               opp-hz = /bits/ 64 <19200000>;
> +                       opp-50000000 {
> +                               opp-hz = /bits/ 64 <50000000>;
>                                 required-opps = <&rpmhpd_opp_min_svs>;
>                         };
>
> @@ -1107,6 +1107,11 @@
>                                 opp-hz = /bits/ 64 <100000000>;
>                                 required-opps = <&rpmhpd_opp_svs>;
>                         };
> +
> +                       opp-128000000 {
> +                               opp-hz = /bits/ 64 <128000000>;
> +                               required-opps = <&rpmhpd_opp_nom>;
> +                       };
>                 };
>
>                 qupv3_id_0: geniqup@8c0000 {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
