Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96630207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBBi7vxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgGBFGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGBFGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:06:54 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9313CC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 22:06:54 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q74so3952928iod.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 22:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHlP2C5MB7l2fajuE903TxpGs1g7Wi3a1RfzRhYtEuI=;
        b=jBBi7vxBC7RWTmctSA+IZrsShvsX9YysgBXFu9liiBn5bj5H4DblMpwMy2YadSfPFl
         27ip1UPrOFS9Dpdns45mVs/5kPh3b8IlLIUfnssW3G5Ks6JWsc5wtSHd/isr9dL5FFq8
         oFsHpI6HSDLCllKy8uXK6HXTV4OgWkwftxEgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHlP2C5MB7l2fajuE903TxpGs1g7Wi3a1RfzRhYtEuI=;
        b=uAiay0JpI/+e0bMpyF+hABbpWHaCpJGfOHQXJ5lFdoQhr+tjSSwQe1VyvFffz7dcrm
         qA7HpjLC3os6/+z/fz0d33o+RrabGHQf7STSfVTxv6V3n/7kWE5z4wIuESSBBMyGDBIi
         VaAHtVEa6kTLTsXqTVhW0Nq8c0zZCcW1KfuA1R9bHqKGNFBI0BsSn3IoCnIK0krfpd5O
         2zkzRE6E8fxZZkeUpOKoItm9p0vFEM90hvubd8SvLsCALuKQk5P6M0jcNhRMdbRzDBiL
         9RIpYbd5btlG5kXL1bucM6lPv45JKjcjo6fW/BpiDlZWV13GTJkGSs561jZT778nKlyT
         XbRg==
X-Gm-Message-State: AOAM532DZ+ICy8JtKfJO98pYQIgRYBwcr69tG959k7jLJnqytwZBpQR+
        nhBY5qYEMEucV7hp0pnJ0BVoOcLv71bJluDwkomKiw==
X-Google-Smtp-Source: ABdhPJzThdIk4eeEV5zJzUTuMvga/K6xZM+uqxGNHJG9uByFPu83fN1aHPWab8+wAEhw33YzK0OQTyMPmNMCIqMkpqc=
X-Received: by 2002:a5d:8f01:: with SMTP id f1mr5811436iof.20.1593666413937;
 Wed, 01 Jul 2020 22:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200625101757.101775-1-enric.balletbo@collabora.com> <20200625101757.101775-5-enric.balletbo@collabora.com>
In-Reply-To: <20200625101757.101775-5-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 2 Jul 2020 13:06:28 +0800
Message-ID: <CAJMQK-gs7+PxJmYYayLD+uo6wter7D=BU+-Zi4sEDiokohHQqg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] arm64: dts: mt8183: Fix unit name warnings
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        erwanaliasr1@gmail.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 6:18 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Remove the unit address from the DT nodes that doesn't have a reg
> property. This fixes the following unit name warnings:
>
>   Warning (unit_address_vs_reg): /cpus/idle-states/cluster-sleep@0: node has a unit name, but no reg or ranges property
>   Warning (unit_address_vs_reg): /cpus/idle-states/cluster-sleep@1: node has a unit name, but no reg or ranges property
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>
> Changes in v2:
> - Replace cluster-sleepX for cluster-sleep-x (Matthias Brugger)
>
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 00137ec61164d..6c00ffa275202 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -168,7 +168,7 @@ CPU_SLEEP: cpu-sleep {
>                                 min-residency-us = <800>;
>                         };
>
> -                       CLUSTER_SLEEP0: cluster-sleep@0 {
> +                       CLUSTER_SLEEP0: cluster-sleep-0 {
>                                 compatible = "arm,idle-state";
>                                 local-timer-stop;
>                                 arm,psci-suspend-param = <0x01010001>;
> @@ -176,7 +176,7 @@ CLUSTER_SLEEP0: cluster-sleep@0 {
>                                 exit-latency-us = <400>;
>                                 min-residency-us = <1000>;
>                         };
> -                       CLUSTER_SLEEP1: cluster-sleep@1 {
> +                       CLUSTER_SLEEP1: cluster-sleep-1 {
>                                 compatible = "arm,idle-state";
>                                 local-timer-stop;
>                                 arm,psci-suspend-param = <0x01010001>;
> --
> 2.27.0
>
