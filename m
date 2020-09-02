Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A00C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D35D207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgwLkogn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIBNaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgIBN2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:28:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E62C06125F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:28:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so5229595wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIp6VDRg64f9Y6M9nC/GlDS6MEA5JCUpqgsb4/MPt3o=;
        b=mgwLkognKuIAKnWCCfSlM7yPbF2hjfW3lrpvsVtLqikNxdc1g8HRBRf+01OXL/0zM+
         Yc6BzQvEuMQRW7++14zWZOQO4knzah3KyyQ06HqnP1kT26c4eu2HhXDw6xjpsvyOBvJO
         JV7FxoqgcOsqsOECxm1Ii2GSYqR+rsZjUvyU1qhZutIEaVHRUux09hU8RfDH++383AL9
         v79u6pcKn27u3TQfCcPbGMlvG6m1i92pkA0/KxauSZpmbTRybKqnRjvFurUDQBZuHkyH
         7f8onN4/qVEYBJtFbcL/H9HKukRRV/+pArF9jLsJUlb0halFaAvNesLNJTZWkf+PxENN
         48PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIp6VDRg64f9Y6M9nC/GlDS6MEA5JCUpqgsb4/MPt3o=;
        b=Wf71/5Fbh8ReXPP1RP0w2RyJtaNDver3mUbQEc08sp7ljNvYWSI5xkJeXYoUY52pSp
         7GD4kOwg4fq1tpxdI+jbXXcDIDD0umZPLzyaCdeV7thz/Pac8t0ZHj4bSYPitvRXtKhw
         7muel1CxW78Fy+Lpr83aPHyzF7gAyN3nS4q5UHgD8++CeFnzo3s41mvbT3tUxXZkh8aQ
         wI7t5oTyR2HtwiPKXLrPHcjm5VcV/uMl+DSdA4/zanIwRki2WwtbRJIT+3IExkNxDlb4
         29XZn0DOvwWrMUKgYZoTuHzK9MIqQv6O6NaMlDgeCPQIz/JCjBjQM4nU8z0z6ZFkH8iu
         wJ+Q==
X-Gm-Message-State: AOAM531wMBmlQDKWrQObbzSId240ZLot6Zr89mBxLLPGGiQqgoqWyyxF
        Q7mmfodiuC92et0Ee+JDaTi2o85Wktsea7Nv6mAZUA==
X-Google-Smtp-Source: ABdhPJymK6Binf3WPLODjrgoJ6lBMTNu0Ae96FbxstIYyWCNWxkbX6MBAI5dCNSBkDIrRwTR22Uv4qhDZlkb5G8e5nE=
X-Received: by 2002:adf:c64d:: with SMTP id u13mr7583312wrg.114.1599053304932;
 Wed, 02 Sep 2020 06:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <1598851448-5493-1-git-send-email-amit.pundir@linaro.org>
 <CAMi1Hd3n2rfr+k09L8WO1S1Tn1s3xJencmr1q3a6e-FOgXr5Qg@mail.gmail.com> <CAMS8qEXcANkb-HoTk8zrXQEzkQO4cnFw4hj5tMp82UEVKd+eHQ@mail.gmail.com>
In-Reply-To: <CAMS8qEXcANkb-HoTk8zrXQEzkQO4cnFw4hj5tMp82UEVKd+eHQ@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 2 Sep 2020 18:57:48 +0530
Message-ID: <CAMi1Hd2ZakhXm+qNh-VMF_OndqCaQxxY3CC+UfQ6x2PyL_5sPQ@mail.gmail.com>
Subject: Re: [PATCH v6] arm64: dts: qcom: Add support for Xiaomi Poco F1 (Beryllium)
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 13:28, Konrad Dybcio <konradybcio@gmail.com> wrote:
>
> > Hi Konrad,
> >
> > I couldn't find answer to your question around missing
> > (regulatorname)-supply properties. Need help in figuring out that
> > part.
>
> When the phone boots up and RPM(H) kicks in, you should see regulators
> probing like "s1 supplied by foo". Without the *-supply stuff, you
> will likely get "supplied by regulator-dummy". This happens here [1]
> and to my knowledge it is the "eletrical wiring" for Linux, as in it
> makes Linux aware of which regulators are connected electrically to
> the same supply (so that kernel knows when the supply is on and what
> voltage it's at). For qcom platforms, this is common per-pmic (afaik,
> please check if you are able to!), so you can likely just copy-paste
> that part from msm8998-mtp.dtsi, which also uses pm(i)8998.

Thank you for the pointer. I dug around the vph_pwr fixed-regulator
node used by fellow sdm845 devices. I assume it is safe to copy it
from sdm845-mtp but I couldn't verify it in the downstream
device-tree, so I'm a bit hesitant. My main concern is that I don't
want to burn down my only device :)

I did find a few regulator nodes downstream which matches with
upstream sdm845-mtp but since I'm not using any of them in my
beryllium dts, I'm going to skip them for now.

As you pointed out, in case of regulator lookup failure Linux will
fall back to dummy regulators, which is working fine for me so far.
Also I see that vdd-*-supply properties are optional according to
Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt,
so I assume it is safe to skip them?

Regards,
Amit Pundir

>
> Konrad
