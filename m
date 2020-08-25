Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A55C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047A9206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bdetoobb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHYWom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHYWol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:44:41 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C036C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:44:41 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b26so248088vsa.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wE4qfQuHmyZr4CJ8Qd1cx0KvW/fobP/YPU8fmNWlhK4=;
        b=bdetoobbnOd6TkMarYz51VCPb8xWTIqO8d53YkrowES32p+QtbiwhVD0DmdTd9ixp8
         QHEbnFC0mXxPw2rHU/EAFxpgyb9gU6tspXMLlKO4Y3gmr6Iq3yRUdpFCzlOMaj6QoOtz
         XBZX8G8lMVfJ9Sv3u9wNp+vauZothyhcduFHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wE4qfQuHmyZr4CJ8Qd1cx0KvW/fobP/YPU8fmNWlhK4=;
        b=EqHSe4/TWeqzlrcNQ8jFHm1+deWXVN6o7ZTV3bJg9qD+6rQ/saMQvRXfHKqowhwbLp
         FgoEpCGm7W7E5ljsft+Wy8DUPwRiv4r0JSf7STqkMzf/MahkxcpJgQGj0YkVzbhZpnI9
         MRlTRa/PWWt7OGrX/J5MInI3qWEoAjJNouAzL/bW1HKRBhjPaPfWM+/+wgoqGgks4Exx
         83our9l0bVQejnuL75J0mHvS5q3ZUSLmi0AKuNy0BFoz7MirEBI+bCXPOAMh3haAbWn7
         DJbAL2I9ZM0gdjYeQm6UYa8ZWHQIpvsJu00N+R8HBKIbPykXX8/aTKSsUFBUcs8CBnIM
         i6Dw==
X-Gm-Message-State: AOAM533z5h7Eda/jC6j4VxjfRxVEwOIN0yfs/Cy8F4hM2hD3FATTG1hK
        YiKJRHy93GyjH3lT9afjYsH3Z63eZSRgIQ==
X-Google-Smtp-Source: ABdhPJwcwnWcgypxPbdFrN3WYroQ+4uhFKuvN0PDj1bbjd15fa7+OOuvo8K3oGq4jflH5cl3DU2DEQ==
X-Received: by 2002:a05:6102:22cb:: with SMTP id a11mr5866111vsh.93.1598395480221;
        Tue, 25 Aug 2020 15:44:40 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id n62sm84244vke.12.2020.08.25.15.44.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 15:44:39 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id x17so143908uao.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:44:39 -0700 (PDT)
X-Received: by 2002:ab0:37d3:: with SMTP id e19mr6815164uav.64.1598395478681;
 Tue, 25 Aug 2020 15:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200825222748.1878927-1-robdclark@gmail.com>
In-Reply-To: <20200825222748.1878927-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Aug 2020 15:44:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVP8-vQc9T8WAa7ExC4o081oYWhEoPTfKUQNhFXHE8wg@mail.gmail.com>
Message-ID: <CAD=FV=WVP8-vQc9T8WAa7ExC4o081oYWhEoPTfKUQNhFXHE8wg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180-trogdor: add initial trogdor
 and lazor dt
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Atul Dhudase <adhudase@codeaurora.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Alexandru Stan <amstan@chromium.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 25, 2020 at 3:27 PM Rob Clark <robdclark@gmail.com> wrote:
>
> +       max98357a: audio-codec-0 {
> +               compatible = "maxim,max98357a";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&amp_en>;
> +               sdmode-gpios = <&tlmm 23 GPIO_ACTIVE_HIGH>;
> +               #sound-dai-cells = <0>;
> +       };

Even though Device Tree spec says "audio-codec", I agree that
"audio-codec-0" should be fine.  Since this is at the top level that
could be important to disambiguate if there was more than one audio
codec.


> +&wifi {
> +       status = "okay";
> +       vdd-0.8-cx-mx-supply = <&vdd_cx_wlan>;
> +       vdd-1.8-xo-supply = <&pp1800_l1c>;
> +       vdd-1.3-rfa-supply = <&pp1300_l2c>;

Sorry, I should have been clearer.  Here you should add:

vdd-3.3-ch0-supply = <&pp3300_l10c>;
vdd-3.3-ch1-supply = <&pp3300_l11c>;

...the hack that was downstream was to stick the "ch1" regulator in
the "ch0" slot since Bluetooth was already holding the "ch0" regulator
open and the "ch1" wasn't part of the bindings yet.

Once the supplies are added for WiFi feel free to add my Reviewed-by tag.

-Doug
