Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B269EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB102065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="miOjzMgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgERSbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgERSbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:31:37 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0060C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:31:36 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id v192so2676100vkd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQzH3Ik7R7bKVK+hgXPw/UmcsoI9rlOtwmNtQ860cnE=;
        b=miOjzMgcOpfbeSMWq3Gx1DdS6+h1XPq9+vmLz16SB2L+HvrXn0Vvre3nKBF4+Fu4IU
         AEMmp2MZ456ArLT88Kgs/axf2lPMVyWQ6S6E/h77iNThxTM28XLkjiCB/5mTXxOiDHke
         j+4HcCT4TuvKliY7nsOyI4RRrVQCxmcP5rKM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQzH3Ik7R7bKVK+hgXPw/UmcsoI9rlOtwmNtQ860cnE=;
        b=rY8yMOfXkLKd7Q/LuS+E9lN7TnEIyneeGsKcGU4xjXGZvw2qX7q+30cigtnkIu+4Rr
         c+NuzJObunrijI4HAqW5c39qjG3NUbw0knzSEzi7Ex4KaWLHbL5CeAX/0sv5nM9apncZ
         XaX2rwdBbbrS/IYfL6ogtEH5ZGO4O+Ocet2TwSJcQ57W6ZX+qGH6yVBEQB65SF/AgeIE
         VBkt3TlOcprHlS16Ys9GM8i5oPtp3ra8H7SAGGy0zzDLijdZ0ldWRZj3KfqkUjzA3WY9
         ZAF/Vv5rTmjS1vTkeBbK5El5qii5ppYRBC3XGdeyejiW7oZO4BZESWlcRNKF2VWlZdJD
         Y3VQ==
X-Gm-Message-State: AOAM531G/CDTLvUb7GUkgHLKlKyw4vwcfkrFpwRt7dGgxPcOA6R68JP2
        w5MJ+xLkkTFeYNeORVWY9oscMaJDDY8=
X-Google-Smtp-Source: ABdhPJyzAsxvNeXz6HUyRzfv7coMSwjVqqpVj5QHq823EF1Du2vpiCBQv0qzzJA8Fq8rpl4H0eOJNA==
X-Received: by 2002:a1f:3415:: with SMTP id b21mr4931022vka.50.1589826695360;
        Mon, 18 May 2020 11:31:35 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id t141sm3373083vke.26.2020.05.18.11.31.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 11:31:34 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id 62so6220665vsi.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:31:34 -0700 (PDT)
X-Received: by 2002:a67:d199:: with SMTP id w25mr5344534vsi.169.1589826693613;
 Mon, 18 May 2020 11:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org> <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org> <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org> <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
In-Reply-To: <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 May 2020 11:31:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
Message-ID: <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 18, 2020 at 3:45 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> On 18/05/2020 11:39, Ravi Kumar Bokka (Temp) wrote:
> >
> > Based on the compatible, do i need to separate probe function for
> > qfprom-efuse and maintain separate nvmem object to register nvmem
> > framework. Is this what you are suggesting to implementing this in to
> > one existing driver?
>
> Yes for same driver we should add new compatible string and add support
> to this in existing qfprom driver.
> Ideally we should allocate nvmem_config object at probe with different
> parameters based on compatible string.

I wish I had better documentation for exactly what was in the SoC
instead of the heavily redacted stuff Qualcomm provides.  Really the
answer here is: how do you best describe the hardware?  OK, so I just
spent the past hour or so trying to patch together all the bits and
fragments that Qualcomm provided me.  Just like a scavenger hunt!
Fun!  The best I can patch together is that there is a single QFPROM
with these ranges:

0x00780000 - 0x007800FF
QFPROM HW registers, range 1/2

0x00780120 - 0x007808FF
QFPROM "raw" space

0x00782000 - 0x007820FF
QFPROM HW registers, range 2/2

0x00784120 - 0x007848FF
QFPROM "corrected" space

0x00786000 - 0x00786FFF
QFPROM memory range that I don't really understand and maybe we don't
worry about right now?

Did I get that right?  If so, is there a prize for winning the scavenger hunt?

---

If so then, IMO, it wouldn't be insane to actually keep it as two
drivers and two device tree nodes, as you've done.  I'd defer to
Srinivas and Rob Herring, though.  The existing driver would be a
read-only driver and provide access to the "corrected" versions of all
the registers.  Its node would have "#address-cells = <1>" and
"#size-cells = <1>" because it's expected that other drivers might
need to refer to data stored here.

Your new driver would be read-write and provide access to the "raw"
values.  A read from your new driver would not necessarily equal a
read from the old driver if the FEC (forward error correction) kicked
in.  Other drivers should never refer to the non-corrected values so
you wouldn't have "#address-cells" and "#size-cells".  The only way to
really read or write it would be through sysfs.

It would be super important to document what's happening, of course.
...and ideally name them to make it clearer too.

---

Another alternative (if Srinivas and/or Rob H prefer it) would be to
deprecate the old driver and/or bindings and say that there really
should just be one node and one driver.  In that case you'd replace
the old node with:

qfprom@780000 {
  compatible = "qcom,sc7180-qfprom-efuse";
  reg = <0 0x00780000 0 0x6fff>;
  #address-cells = <1>;
  #size-cells = <1>;

  clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
  clock-names = "sec";

  qusb2p_hstx_trim: hstx-trim-primary@25b {
    reg = <0x25b 0x1>;
    bits = <1 3>;
  };
};

You'd use the of_match_table solution to figure out the relevant
offsets (0x120, 0x2000, 0x4120, 0x6000) for sc7180 and this new driver
would be responsible for being able to read the corrected values and
also for programming.  In this case I'm not sure how (assuming it's
valuable) you'd provide read access to the uncorrected data.


-Doug
