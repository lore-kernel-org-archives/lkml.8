Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53C0C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0CC20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kRqauqv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgAQXyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:54:36 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42953 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbgAQXyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:54:36 -0500
Received: by mail-ua1-f67.google.com with SMTP id u17so9604157uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 15:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8NH+1a7F0WHIbRqp4rgZ//dPF83s70QZVUublxQDJk=;
        b=kRqauqv0A8IJZAnyv/N+3xLExXjs4/9vSzOBDDgFPTLxjwCoi5V2OvsBTILHRr5vCN
         aIQ1emXkFTxcYZvD49A44J5vujNjZb1lKdhrsljJEk/+IPYGQvgyuhPgiu6Nww9oc0Nh
         Phel0bF23O4QoXZ2j4pca1GgKWaMFNdLBmXWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8NH+1a7F0WHIbRqp4rgZ//dPF83s70QZVUublxQDJk=;
        b=gQbI2G67aWu/mUAL2e0ihd4CP3hd+9xs94bI6JHOK1/AuRgpqo4G1idx/NcwymAC0g
         5BzSQOqUVxuiGC2g5pxTudUBJPoN/03u1O1PEJpVuGV21P60aQeZDeSybQWuIeDKoGoQ
         L+fIN3GD2gQaxmpWVLUdwYLQHvqCQBB+7c1yM9dc/krN+XDNlqWGWV4WuocTdRaYfGEl
         AzfNL2zcrzvj90k1kpF/Rm8tddff1nmak33r8xfpG0MPjwhIqPQDom+udqHrPxJjJwRo
         EphU8ZnBEm09mMcIZNaxzIdiuCUdZh6zlXRTSLDdbXmeb0d+snpDkImDoxCN53miTfDk
         FXsg==
X-Gm-Message-State: APjAAAW6vLFJjjEm3LqbFXrWfjYb+KrnGJJCqrWsZMpA7bRTXY1Dvh0l
        YlOxw5ebhfBxLb2/3XwVss4GlZZPbhA=
X-Google-Smtp-Source: APXvYqzxkdyzI10HmKLzg9D/GhXeLLYXR3hT4oW3XO9NMYmTuVpxs5PXHADysRyKXQBaKUCC8VFnnA==
X-Received: by 2002:ab0:4aca:: with SMTP id t10mr23463653uae.89.1579305274272;
        Fri, 17 Jan 2020 15:54:34 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id g26sm7822008vkl.16.2020.01.17.15.54.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 15:54:33 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id c7so9577915uaf.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 15:54:33 -0800 (PST)
X-Received: by 2002:ab0:2006:: with SMTP id v6mr24170327uak.22.1579305272950;
 Fri, 17 Jan 2020 15:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20200117155001.v2.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid>
In-Reply-To: <20200117155001.v2.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jan 2020 15:54:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wg3gpLXz1+xxL_6Ki404+oXyma6NB33eps_Gs8R4LX4Q@mail.gmail.com>
Message-ID: <CAD=FV=Wg3gpLXz1+xxL_6Ki404+oXyma6NB33eps_Gs8R4LX4Q@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: timer: Use non-empty ranges in example
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 17, 2020 at 3:50 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> On many arm64 qcom device trees, running `make dtbs_check` yells:
>
>   timer@17c20000: #size-cells:0:0: 1 was expected
>
> It appears that someone was trying to assert the fact that sub-nodes
> describing frames would never have a size that's more than 32-bits
> big.  That does indeed appear to be true for all cases I could find.
>
> Currently many arm64 qcom device tree files have a #address-cells and
> about in commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase
> address and size cells for soc").  That means the only way we can
> shrink them down is to use a non-empty ranges.
>
> Since forever it has said in "writing-bindings.txt" to "DO use
> non-empty 'ranges' to limit the size of child buses/devices".  I guess
> we should start listening to it.
>
> I believe (but am not certain) that this also means that we should use
> "ranges" to simplify the "reg" of our sub devices by specifying an
> offset.  Let's update the example in the bindings to make this
> obvious.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> See:
>   https://lore.kernel.org/r/20191212113540.7.Ia9bd3fca24ad34a5faaf1c3e58095c74b38abca1@changeid
>
> ...for the patch that sparked this change.
>
> Changes in v2:
> - Fixed my typo 0xf0000000 => 0xf0001000
>
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> index b3f0fe96ff0d..b92d958d7541 100644
> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> @@ -99,22 +99,22 @@ examples:
>        compatible = "arm,armv7-timer-mem";
>        #address-cells = <1>;
>        #size-cells = <1>;
> -      ranges;
> +      ranges = <0 0xf0001000 0x1000>;
>        reg = <0xf0000000 0x1000>;
>        clock-frequency = <50000000>;
>
> -      frame@f0001000 {
> +      frame@0 {
>          frame-number = <0>;
>          interrupts = <0 13 0x8>,
>                 <0 14 0x8>;
> -        reg = <0xf0001000 0x1000>,
> -              <0xf0002000 0x1000>;
> +        reg = <0x0000 0x1000>,
> +              <0x1000 0x1000>;
>        };
>
>        frame@f0003000 {
>          frame-number = <1>;
>          interrupts = <0 15 0x8>;
> -        reg = <0xf0003000 0x1000>;
> +        reg = <0x2000 0x1000>;

Wow, how many stupid mistakes can I make in one small change?  :(  I
forgot to change the node name.  v3 is now at:

https://lore.kernel.org/r/20200117155303.v3.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid

-Doug
