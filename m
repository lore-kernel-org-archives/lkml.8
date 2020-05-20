Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F644C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2579120873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lk2pKb+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgETWsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgETWsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:48:17 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CABC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:48:17 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id v23so1194411vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47LWty0h4lFiVFN17MSJUE+uaQH/Kp+4z/ot0VIo9pg=;
        b=Lk2pKb+1a/iz6NJQA6L1mx1V04sa3fommdf5Ng9euSWqmIv3ljCRIHh25CIUVCynMp
         4opGi0a8VG4L6kakNxcjbuKsRpZMI4tYjOCkSjfygKBv+aOJiatcnonG4QcAnW7C11YT
         cHLtL1uLlJcwVCuJkFnspzzIw1rpGrJn9jsRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47LWty0h4lFiVFN17MSJUE+uaQH/Kp+4z/ot0VIo9pg=;
        b=BuheDBwH4H1LKJO2dTsnq8SOA7lBl+kyzgMPqyTJ5fenQqT/kK1KyPL/cgR8fqsLlG
         iAUqgyvCJwxAPvukEj/bHkmy1r1MyEEEqGhw/GD/1uhIJBFiNYO/Bn79SBzxn0R4b2do
         x8hEQJefIKKOP4coaXOqpptXLlqqIjfkwgWHcW9joTF2sOvEEtAtuoGnC+9SpoFS7052
         Pxf7mF2Dnl3sJD2Xo9ElzRiHCytBmpDx/ubUrcLgkuUfuLMdxKf6IQ5jO+8P1VIMDHCs
         QN3+TnLIJVOS6iwd35ILX7p/jGwtCTM3vYywTvzruQ4JvOaBNklbuYECFecPVv/kckjD
         /ehg==
X-Gm-Message-State: AOAM533TnVgE0VwC/zOGy4szxdS0TLnRHidlG28QRzfPJJtAjFJOfYHp
        LG/przqlClGs6RKLyheqlnn+zpL5oQw=
X-Google-Smtp-Source: ABdhPJxgS2cOc0GhdoEb9Y0SBsZHNAYR0zi8hpRZloHInRTUpYl+QzJNrA8OhAuiIa4s1fPY//Li6w==
X-Received: by 2002:a1f:9716:: with SMTP id z22mr5590804vkd.55.1590014895584;
        Wed, 20 May 2020 15:48:15 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id o9sm613542vko.18.2020.05.20.15.48.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 15:48:14 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id i5so1892789uaq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:48:13 -0700 (PDT)
X-Received: by 2002:a9f:230a:: with SMTP id 10mr3392329uae.0.1590014893375;
 Wed, 20 May 2020 15:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org> <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org> <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org> <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
 <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com> <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org>
In-Reply-To: <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 May 2020 15:48:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
Message-ID: <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
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

On Wed, May 20, 2020 at 7:35 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> On 18/05/2020 19:31, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, May 18, 2020 at 3:45 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >> On 18/05/2020 11:39, Ravi Kumar Bokka (Temp) wrote:
> >>>
> >>> Based on the compatible, do i need to separate probe function for
> >>> qfprom-efuse and maintain separate nvmem object to register nvmem
> >>> framework. Is this what you are suggesting to implementing this in to
> >>> one existing driver?
> >>
> >> Yes for same driver we should add new compatible string and add support
> >> to this in existing qfprom driver.
> >> Ideally we should allocate nvmem_config object at probe with different
> >> parameters based on compatible string.
> >
> > I wish I had better documentation for exactly what was in the SoC
> > instead of the heavily redacted stuff Qualcomm provides.  Really the
> > answer here is: how do you best describe the hardware?  OK, so I just
> > spent the past hour or so trying to patch together all the bits and
> > fragments that Qualcomm provided me.  Just like a scavenger hunt!
> > Fun!  The best I can patch together is that there is a single QFPROM
> > with these ranges:
> >
> > 0x00780000 - 0x007800FF
> > QFPROM HW registers, range 1/2
> >
> > 0x00780120 - 0x007808FF
> > QFPROM "raw" space
> >
>
> so this is the only region is the QFPROM fuses can be programmed!
>
> > 0x00782000 - 0x007820FF
> > QFPROM HW registers, range 2/2
> >
> > 0x00784120 - 0x007848FF
> > QFPROM "corrected" space
>
> Is this some kind of FEC corrected regions?

Yes.


> > 0x00786000 - 0x00786FFF
> > QFPROM memory range that I don't really understand and maybe we don't
> > worry about right now?
>
> >
> > Did I get that right?  If so, is there a prize for winning the scavenger hunt?
> >
> > ---
> >
> > If so then, IMO, it wouldn't be insane to actually keep it as two
> > drivers and two device tree nodes, as you've done.  I'd defer to
> > Srinivas and Rob Herring, though.  The existing driver would be a
> > read-only driver and provide access to the "corrected" versions of all
> > the registers.  Its node would have "#address-cells = <1>" and
> > "#size-cells = <1>" because it's expected that other drivers might
> > need to refer to data stored here.
> >
> > Your new driver would be read-write and provide access to the "raw"
> > values.  A read from your new driver would not necessarily equal a
> > read from the old driver if the FEC (forward error correction) kicked
>
> Is this only applicable for corrected address space?

I guess I was proposing a two dts-node / two drive approach here.

dts node #1:just covers the memory range for accessing the FEC-corrected data
driver #1: read-only and reads the FEC-corrected data

dts node #2: covers the memory range that's _not_ the FEC-corrected
memory range.
driver #2: read-write.  reading reads uncorrected data

Does that seem sane?


> > in.  Other drivers should never refer to the non-corrected values so
> > you wouldn't have "#address-cells" and "#size-cells".  The only way to
> > really read or write it would be through sysfs.
> >
> > It would be super important to document what's happening, of course.
> > ...and ideally name them to make it clearer too.
> >
> > ---
> >
> > Another alternative (if Srinivas and/or Rob H prefer it) would be to
> > deprecate the old driver and/or bindings and say that there really
> > should just be one node and one driver.  In that case you'd replace
> > the old node with:
> >
> > qfprom@780000 {
> >    compatible = "qcom,sc7180-qfprom-efuse";
>
> May be "qcom,sc7180-qfprom"
>
>
> >    reg = <0 0x00780000 0 0x6fff>;
> >    #address-cells = <1>;
> >    #size-cells = <1>;
> >
> >    clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
> >    clock-names = "sec";
> >
> >    qusb2p_hstx_trim: hstx-trim-primary@25b {
> >      reg = <0x25b 0x1>;
> >      bits = <1 3>;
> >    };
> > };
> >
> > You'd use the of_match_table solution to figure out the relevant
> > offsets (0x120, 0x2000, 0x4120, 0x6000) for sc7180 and this new driver
> > would be responsible for being able to read the corrected values and
>
>
> Encompassing these offsets in driver as part of the register defines
> itself should be a good start!
>
> It will also be nice to understand how similar this thing is with w.rt
> other Qcom SoCs?

At least sdm845 is about the same.  I cross-referenced docs I had with
sc7180 and sdm845 and that's how I came up with my model for how this
works.


> > also for programming.  In this case I'm not sure how (assuming it's
> > valuable) you'd provide read access to the uncorrected data.
> I will leave this question to the author of the driver.
>
> --srini
>
> >
> >
> > -Doug
> >
