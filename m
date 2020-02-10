Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E2C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D0F20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TH0vCFNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJRzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:55:36 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35462 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgBJRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:55:35 -0500
Received: by mail-vs1-f68.google.com with SMTP id x123so4742787vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siKHOuO8wOb9sw6P22vlsxiKOGFhLZkeTDhUG0eBw1U=;
        b=TH0vCFNjQCF7itW9+Z6ZYFb493fIZyD8YVn4iSK9fy1/KDtpK9dmmj5bVy6JE2ilET
         kjwJPnFS/rOWJ7+jJzyyoiPCUJV+1GpGlAMyPz6u/zxhXBymGsTgm+bsdoWkcDBaToiZ
         7+3z8uxOlnEAnw8r3bdd1mP4fIBTimHEgdSH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siKHOuO8wOb9sw6P22vlsxiKOGFhLZkeTDhUG0eBw1U=;
        b=OAbuJP9QR8KPumRAQHdJbbG8N50m4p82lt74caGSqbD3PNJOxIggcRX30Xd1FX23eQ
         zrauLdZjD6JSWkpip6TgZf3TINtmHVxUCqNeu6KhTIBHOcmsEv9FZ+hy42g/0E7kpJbQ
         PsoKrn2VcSA+RZ6ygRWM6Gx5dB3yGAgjfw34Ez7tFI3gaXy6c3NGmn1JtZM7wSv4ku/5
         trkDpJPynVEbAtrd2hzSX2f+jtTjcBHm3S7yvPAOQb5WSLbuSA/xj3XxHnsHWQriEA2e
         ML11wFxu1rcKPCZ71GtThhJm/5njsNMlH5x0VNvblPbbayo2vVs26gr10axHA9cb0s1c
         emcA==
X-Gm-Message-State: APjAAAWSwO/BtHMKI73I7Ca7NUoa2WMeVEAfELJDNde4V1KwaB6fmzMx
        b/nPqRX7nvEavJ7O79ipV0xsP79gizY=
X-Google-Smtp-Source: APXvYqzJ5g+sK/QhjgRtVL9R68ZgyrR0aFXhTo0oP3wlrDHf6zFphbULSMwXyj3RsaQe3boLbc05Og==
X-Received: by 2002:a05:6102:21da:: with SMTP id r26mr6960851vsg.210.1581357334432;
        Mon, 10 Feb 2020 09:55:34 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 111sm253322uae.17.2020.02.10.09.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 09:55:33 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id g13so2798838uab.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:55:32 -0800 (PST)
X-Received: by 2002:a9f:300a:: with SMTP id h10mr1454266uab.91.1581357332297;
 Mon, 10 Feb 2020 09:55:32 -0800 (PST)
MIME-Version: 1.0
References: <1581307266-26989-1-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1581307266-26989-1-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 10 Feb 2020 09:55:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X-URWfbe8vNqtjHZPo6Rokwkede8oSagJu1KiD18a8EQ@mail.gmail.com>
Message-ID: <CAD=FV=X-URWfbe8vNqtjHZPo6Rokwkede8oSagJu1KiD18a8EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clk: qcom: Add support for GPU GX GDSCR
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
> In the cases where the GPU SW requires to use the GX GDSCR add
> support for the same.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  include/dt-bindings/clock/qcom,gpucc-sc7180.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I already added my tag to this exact same patch in:

https://lore.kernel.org/linux-arm-msm/CAD=FV=VeMaKq3KR=t7dbG+VyVs5DS=gHasSdJQSqNQreTUoZig@mail.gmail.com/

Please make sure to carry forward tags unless something major has
changed.  In any case, re-adding my tag:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
