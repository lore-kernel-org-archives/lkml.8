Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B05C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A78422B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSji1UKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHDT0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHDT0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:26:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 12:26:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so13923083pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9cSVspbzkWN75FyJrZtjTDhtHbzq1K9/gFpRCRTO9ZM=;
        b=VSji1UKeJ8F7kDzVe0SIvGagNVtJbAnF8ajP9sO3qGYE625gju5jROJM39oOtHhweV
         myIkhefDx3j42Gif5irc79eEGPLK9cFW130XdK9lhVSNTv38/osNPyhg8HXIdRSl1k7M
         WoO6ylLK9nelsmmKulO6datI6ZnQOqs1KzH7iDrJyfOQlEKbmiG5gxq+mHlnbuE2Xtr3
         qYIrpb3lOWJOOsLQbAoTe8tQru0ycyeII2RyPSExjtKC1TUp3wqLmY0DEKSzQ59IJRjK
         Hqcfa494k5CswBdA0cw2M5DpfHTBAdwyroUzJr7YEeLZTkmnsl2z6SFb3VHoHi63DRd8
         0sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9cSVspbzkWN75FyJrZtjTDhtHbzq1K9/gFpRCRTO9ZM=;
        b=SSX9qaQK6+kv6Cb1aBs7ZJOMCJ7EDMchcBilGGOquF9MVF1Vvssc85QXG/lOF5rHjP
         h6p0qYlGksQmPvYuTZ2UITqHo3NlffsiK8/R4+Mz1sRokKijngdldzKlSDAYfJx5YmVV
         NJavUf0+T2V636yQscnzv5SN/+pTFENQPOJXPJeI9CpMswcd4DYt7qwLokYlIYRwg1uK
         AtSSmGNdR+zrvBAXTptbBiFUEO4QqX+BjeDP+zILg3nR4zKCyyz0LRkH/R9HHR596wQD
         mPNZ6jbPHQOIgmF1qNtv5FxMqMWbhaJC6+/TvMHayvZ5t/Z3fJ58+zBjdN/5MmkljjR6
         3dsQ==
X-Gm-Message-State: AOAM5326AusyRF+Mj9k9LWcFmkupCv17Jnw+iq2pI5utVIg5ZuxOEstK
        vBtLwCNgPPktJw2AqnwnAxzNlg==
X-Google-Smtp-Source: ABdhPJxEKTeRCY/jNEJ8Z7oFtECWQZVkQt/Ko+9MnPaoNUH/uiwf5B7KDDlCDfBqNfqZJ6j/2bZqIw==
X-Received: by 2002:aa7:982e:: with SMTP id q14mr16322128pfl.299.1596569164231;
        Tue, 04 Aug 2020 12:26:04 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p5sm22574980pgi.83.2020.08.04.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 12:26:03 -0700 (PDT)
Date:   Tue, 4 Aug 2020 12:22:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: Add support for Xiaomi Poco F1
 (Beryllium)
Message-ID: <20200804192223.GD20825@builder.lan>
References: <1596297341-13549-1-git-send-email-amit.pundir@linaro.org>
 <20200804061652.GK61202@yoga>
 <CAMi1Hd1KCmoF7D06otBcxCBYEUW3Tdn_aYQ722=yRoEeZYmTPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd1KCmoF7D06otBcxCBYEUW3Tdn_aYQ722=yRoEeZYmTPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Aug 00:35 PDT 2020, Amit Pundir wrote:
> On Tue, 4 Aug 2020 at 11:46, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> > On Sat 01 Aug 08:55 PDT 2020, Amit Pundir wrote:
[..]
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-beryllium.dts
[..]
> > > +/* Reserved memory changes from downstream */
> > > +/ {
> > > +     reserved-memory {
> > > +             removed_region: memory@88f00000 {
> >
> > Do you know what these 26MB are used for? Do you think it's possible to
> > give it a more appropriate label? The size happens to be the same as
> > &adsp_mem from sdm845.dtsi, this is probably not a coincidence.
> 
> In downstream, this removed region is marked as removed-dma-pool
> compatible, https://github.com/MiCode/Xiaomi_Kernel_OpenSource/commit/b982b6dc77ac34c184abe83dd293ac08fc607ba3,
> a carved out memory region not exposed to the kernel. I honestly
> didn't know what to name this region, so I kept it as it was. I can't
> boot past the bootloader if I don't mark this region as reserved.
> 

That seems to imply that it's used for something other than ADSP, but
the size is strange.

The removed-dma-pool is a downstream construct, the important part is
no-map;

> >
> > That said, this overlaps at least &rmtfs_mem, &qseecom_mem and
> > &camera_mem, so I would expect that you have a few warnings about this
> > early in the log? Please shuffle things around to avoid this.
> 
> Sorry, I do know that it definitely overlaps with upstream &rmtfs_mem,
> but I ignored that because plan was to just boot to shell with this
> base dts. I was planning to submit a follow-up patch with downstream
> reserved memory mappings, which do not coincide with the upstream
> sdm845.dtsi mem regions you mentioned above, along with relevant
> wifi/adsp/cdsp nodes. But let me take this opportunity to submit them
> in the next version of this base dts.
> 

This problem does come up from time to time and I have a similar problem
with getting the IPA driver to probe on my SDM850 laptop, because the
sdm845.dtsi reserved-memory regions isn't accepted.

So I think we should move (most of?) the reserved-memory regions from
sdm845.dtsi into the individual device dts files - given that it
obviously differs between different devices.


I'm okay with your plan, but please add a TODO comment here describing
that this is needed to boot the device, that you know it is overlapping
with other regions and that the memory map needs more work for this
device.

Thanks,
Bjorn
