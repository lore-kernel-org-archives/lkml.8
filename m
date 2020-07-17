Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9A6C433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217C2207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595007861;
	bh=8KhGhYBxnfryGaCJ4USJbgh0ERjIkpbE+Ah2Ia0FzVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=veStGVg1JaXAdvuQwBTkQgQ+zqkfe6dATQILzDCP/rC7NlV0K+n/cujpkAzQPEC41
	 9BNY6S68rr0gxmFc8cWCfPs9sFdXylx6Rhw/Mhcyh1Nz1TmXApTcDx1zr9MXuq7836
	 lx2Hvn48CqYcQiI/dzwgSiA12oobruSQ1ULbmXCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGQRoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgGQRoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:44:15 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A6D22B4E;
        Fri, 17 Jul 2020 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595007854;
        bh=8KhGhYBxnfryGaCJ4USJbgh0ERjIkpbE+Ah2Ia0FzVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W0nYfbVjzCONNpiGooYEWPPFRXkLlokkcPhl3A1lZqCJ+5OOenlOxseUiU6mMCB/A
         znN2y7Yk4Pb6bptYEZ5CEyHi/0plSim+pZbDtv7Pp1w2uzJFDz38fLej6XM2nNTPi5
         6RI7Y2NKe9s7mXZxbDZ655w3wevWqwVCFlCfXq14=
Received: by mail-ot1-f46.google.com with SMTP id t18so7451299otq.5;
        Fri, 17 Jul 2020 10:44:14 -0700 (PDT)
X-Gm-Message-State: AOAM5314oTvqHBMMiHtgGYsaLvgZnSIboHW7R91gY80GST5N1g80yOBp
        Gf6CZtI9dbPUnejvDefO1ukVwuB5HBdG/VpaWA==
X-Google-Smtp-Source: ABdhPJzmF19p2CWPSseEsvbYzrAu3m4cEXKROdnW9Mwivlqz1HHyHd8Lvx2gzO5P1fA1g1DlI6dgjzgfnM6jDjbbmBQ=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr9977843ots.192.1595007853870;
 Fri, 17 Jul 2020 10:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200702191322.2639681-1-helen.koike@collabora.com> <20200702191322.2639681-5-helen.koike@collabora.com>
In-Reply-To: <20200702191322.2639681-5-helen.koike@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Jul 2020 11:44:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYHY85_JhpGKwTOSP99uCER9VEf-gp3g4nFhN4ktCO3w@mail.gmail.com>
Message-ID: <CAL_JsqLYHY85_JhpGKwTOSP99uCER9VEf-gp3g4nFhN4ktCO3w@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] media: staging: dt-bindings: rkisp1: fix "no reg"
 error in parent node
To:     Helen Koike <helen.koike@collabora.com>
Cc:     devicetree@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Collabora Kernel ML <kernel@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>, karthik.poduval@gmail.com,
        Johan Jonker <jbx6244@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 1:13 PM Helen Koike <helen.koike@collabora.com> wrote:
>
> Fix the following error found with make ARCH=arm64 dt_binding_check:
>
> Documentation/devicetree/bindings/media/rockchip-isp1.example.dts:24.27-101.11:
> Warning (unit_address_vs_reg): /example-0/parent@0: node has a unit name, but no reg or ranges property
>
> Reported-by: Johan Jonker <jbx6244@gmail.com>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> ---
>
> V3:
> - this is a new patch in the series
> ---
>  .../Documentation/devicetree/bindings/media/rockchip-isp1.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.yaml b/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> index e5b9c0574e352..4d111ef2e89c7 100644
> --- a/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> +++ b/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> @@ -126,6 +126,7 @@ examples:
>      #include <dt-bindings/power/rk3399-power.h>
>
>      parent0: parent@0 {
> +        reg = <0 0>;

Just drop the unit-address.

>          #address-cells = <2>;
>          #size-cells = <2>;
>
> --
> 2.26.0
>
