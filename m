Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71532C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F570246B2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NVHhsqaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgB0STT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:19:19 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46075 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbgB0STS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:19:18 -0500
Received: by mail-vs1-f66.google.com with SMTP id m4so223647vsa.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3+t6YZki97dJn3TmsqtMQPSzhs2LsQfL/dODOkLgZk=;
        b=NVHhsqaJ7eLhlivtVpaS7uaXQFfxcmkuZnCtRTLYV3MYZWP6G1Y2cUurEHgtMKqGWL
         9h9VrA3IcEElvTZxH7PagPPJstv+J/QUbn1Dien0pGx99FV3Fe6vKPiVttL0b19DSN1n
         9EC8fsbCRcGXL2FQoLx/HsRiFdGof4zCx51nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3+t6YZki97dJn3TmsqtMQPSzhs2LsQfL/dODOkLgZk=;
        b=rGh+fsHGCPc6LobtdByzLT09HvfDZCLwdzlOIatLAQ2YaZ+7jj3JtLP5+Ws4OUjRt5
         PfzjUFe3lvHiDbJ44syllVQ6QVd8a4ANyUbETw8MuKYGpsXKCq2NbNPVKWCHI+YsBrUF
         qSsah7qcM5bhZNPY4LrhQBtinOqhEtxhfuRZu7G7RYip+F9WFno074tBMGxN1CUpC8pN
         /wvN+2AcE08LsH76CvVnB8FmjRGvanhi8XJpxbr1K6X5T+IjX1MLTIXn05Ydt1lLVnj6
         j+VhHe7yQ+FnWi/tKUAFhu1KDSRGT0Pk1png7/VPFhzdj/V3X3Yi+T79ampzb8haiKm/
         Ayww==
X-Gm-Message-State: ANhLgQ1jZuWEXOJbZlzHTVlPjo9lKoJMUJNtsEJ8SjFqVUvvjFWcaKRD
        iW2HpLbhWbf9ftb3JuBmBIDkZ6ElOX0=
X-Google-Smtp-Source: ADFU+vt4c22BVRmmEoIS57441dtbMckH1s0am139cLNJ4gqNrlqtEjiI3DUbGjSGm68zlzUG57KWKw==
X-Received: by 2002:a67:cf46:: with SMTP id f6mr347259vsm.143.1582827557415;
        Thu, 27 Feb 2020 10:19:17 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id v65sm2210984vke.13.2020.02.27.10.19.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 10:19:17 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id y201so163892vky.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:19:16 -0800 (PST)
X-Received: by 2002:ac5:cdcd:: with SMTP id u13mr361384vkn.0.1582827555884;
 Thu, 27 Feb 2020 10:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20200227092649.v3.1.I15e0f7eff0c67a2b49d4992f9d80fc1d2fdadf63@changeid>
In-Reply-To: <20200227092649.v3.1.I15e0f7eff0c67a2b49d4992f9d80fc1d2fdadf63@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 27 Feb 2020 10:19:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UuvSt0z+B4ymCW8u+c+rHQ5kGYtOQYGF8QLex__p31xQ@mail.gmail.com>
Message-ID: <CAD=FV=UuvSt0z+B4ymCW8u+c+rHQ5kGYtOQYGF8QLex__p31xQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: sc7180: Move venus node to the correct position
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 27, 2020 at 9:26 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Per convention device nodes for SC7180 should be ordered by address.
> This is currently not the case for the venus node, move it to the
> correct position.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v3:
> - actually insert the venus node after usb@a6f8800 and not just
>   pretend to do it
>
> Changes in v2:
> - insert the venus node *after* the usb@a6f8800 node, not before
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 52 ++++++++++++++--------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
