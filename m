Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90440C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D70F206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt32BAoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgC3JIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:08:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46282 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbgC3JIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:08:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id cf14so19725149edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBfZUA3Ue04SNaNjIZbI9Q9GTKiTiLsqF41qopeumkI=;
        b=dt32BAoHu9GoJYKoESUHVeABNyH6w2lRqp4VaFNbRqhLaC6j9w9egbO4jl4XaZEIx+
         8zcfAVXuYsi0EM0VrT4p2tfAnXNrRRK2FvCByoRDjyG9NmUScF0FPmjXZfE5IDFZen1+
         zvbHyUcNeuM+3LtmfPvMWFI+psRdwt4e7d/Hp+H+BwjWMX5iDTkckQzHD6HaQzineZn/
         dhBCM5nDXXR97TXcuuraV3uV5gcaJCbTWmw3h2ob/7z7BWFtZFyMBn5x5gmCnd272G50
         bUazJJrRwv/9rbSLa98jrRM1UyRqGtw/stwXwGWWsUSln9sff7FAJSnye1gsir9W9zfL
         NTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBfZUA3Ue04SNaNjIZbI9Q9GTKiTiLsqF41qopeumkI=;
        b=Vk91lQpBHr14iBCB9dcYAy9e3841af5kf+SAald3FvTXM/5eaUb1Czxxxdi+aEudoj
         wq3L+2FN0slIGwsNCtpMSASooxFgHqvag0ByhH47RRdplQ5dnoCOHDg15zFfeTIWZQK0
         2pD7yZ2hXHnDTZLHUa+H6qCxcUiPry8isPH6KLEKdJnnyl+g8Qh1RPtRFEqjnHxz36zg
         Ih6z1NFAPxFpuNBbdylQPOdaZDg6XPVG8hjlDup4csEVOMJZKw/5ch7xqHTJHzwgV2lS
         te8Erw0UqyhS0gGa8zgAoJeXIG/NwFSA/5+3STHn8fpRiR5WowZAXuMSMIee9N+T8wgZ
         UUKw==
X-Gm-Message-State: ANhLgQ3uf3E6S2IHKxMy76CZ253REHFwXNtFRXo6OL7X9BX1DiSNCvkT
        cTeUEyA34Mry8nzJtVMEhiNUoaK0bVNnwzKTq92xvw==
X-Google-Smtp-Source: ADFU+vvI5+4zWFwNRaiSUVTSAykaV3rTKvG6GrKxC8T0xaJwOzpUM715vIIVfPuIzsUyjRQDmL1jVdM1D7tN6CGWUfU=
X-Received: by 2002:a17:906:3410:: with SMTP id c16mr10254113ejb.304.1585559287665;
 Mon, 30 Mar 2020 02:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200318054442.3066726-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200318054442.3066726-1-bjorn.andersson@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 30 Mar 2020 11:11:33 +0200
Message-ID: <CAMZdPi_psRiy1FG338N1=9F+o4b=0ANLdc3UiCTB=UoMS=CH=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Reduce vdd_apc voltage
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 at 06:46, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Some msm8996 based devices are unstable when run with VDD_APC of 1.23V,
> which is listed as the maximum voltage in "Turbo" mode. Given that the
> CPU cluster is not run in "Turbo" mode, reduce this to 0.98V - the
> maximum voltage for nominal operation.
>
> Fixes: 7a2a2231ef22 ("arm64: dts: apq8096-db820c: Fix VDD core voltage")
> Cc: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Don't see any problem with that change, tested with and without
cpufreq (db820c).

Tested-by: Loic Poulain <loic.poulain@linaro.org>
