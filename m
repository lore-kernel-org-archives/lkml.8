Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B41C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C657206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583447620;
	bh=1rqxqgTgMj/NBLB1y9ou7AF6KoIDM2e6QKR6zDyOBw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B0u7sbIgze6lkqUpf91NLM9K2o4SxsFIadjuAPtUBuc2XtYWFnNDllJmptj3zwGkF
	 ZX+hTdMvF82oPAUhvqc9bmhX2/bQwSgRGH4x5o7r+QepuAx2xltEx/rfvSRaPdszPY
	 CrPIWKNR2Q+TJfHNfqilUUGD/Vkktit19hlHqM/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCEWdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgCEWdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:33:39 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92DF5208CD;
        Thu,  5 Mar 2020 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583447618;
        bh=1rqxqgTgMj/NBLB1y9ou7AF6KoIDM2e6QKR6zDyOBw4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zztcu8OAYJAFepe42VYACyqx26D1NrO9V5W8Wx+L3QZIs466qvGjoz4dNGMOaaF7i
         Oj7R4Q/UriS53mt0tOkCF4l8U7rmPzKS8LAJT4YdjBT9/AOtSOfr9Ywphf0mTkpGCd
         fmuT10v/GQMF/T137cERfF2YoV9lKcca5bFU63lM=
Received: by mail-qk1-f178.google.com with SMTP id y126so505876qke.4;
        Thu, 05 Mar 2020 14:33:38 -0800 (PST)
X-Gm-Message-State: ANhLgQ2TnB91hPwNKkkMeOvBmZu28/mxsqXTizNoB4aeHhGMgi/hy3mj
        /8kegBNpkfv3hgfYSgZnTtq2gpKbKVG5LcDEAg==
X-Google-Smtp-Source: ADFU+vszsVh5KFTV0y3boY7rxql+tjkdeF4ZIOo1DqfXHwdAwW9P939FZqt1lx4Y9ldp5KYV46Wm8ZeCzDPUPpInSDs=
X-Received: by 2002:a37:393:: with SMTP id 141mr234155qkd.393.1583447617589;
 Thu, 05 Mar 2020 14:33:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583445235.git.amit.kucheria@linaro.org> <d962c0a5328e72b3dd4a74e138b0f3bd233de373.1583445235.git.amit.kucheria@linaro.org>
In-Reply-To: <d962c0a5328e72b3dd4a74e138b0f3bd233de373.1583445235.git.amit.kucheria@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 Mar 2020 16:33:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKK6hVd+CaPCpGcGsPFu4B2Z23=V0W+jqorYUC9=8sMVQ@mail.gmail.com>
Message-ID: <CAL_JsqKK6hVd+CaPCpGcGsPFu4B2Z23=V0W+jqorYUC9=8sMVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dt: psci: Fix cpu compatible property in psci
 binding example
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 4:00 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> make -k ARCH=arm64 dt_binding_check shows the following error. Fix it.
>
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
> cpu@0: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
> cpu@0: compatible: ['arm,cortex-a53', 'arm,armv8'] is too long CHECK
> Documentation/devicetree/bindings/arm/moxart.example.dt.yaml
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
> cpu@1: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
> cpu@1: compatible: ['arm,cortex-a57', 'arm,armv8'] is too long
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, but already queued a fix for this and more from Ulf.

Rob
