Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62EFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F80D20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hcFygYI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgEUV3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUV27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:28:59 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3FC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:28:59 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id z3so2076452vka.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klWE6h3lUd9mKmrJLuN9Cee1MvLWP3xiEOXA4+1HHJ8=;
        b=hcFygYI8RY1iIh5T/zvT2OHvQhYK0TNutxUaGtYcUpu1q0gBWYaZsVH5CFkqjtZQnf
         cEuQx4Dj+gkL6Bo/sZ8zeUZJ5jEdi0ZwBYwPDnJNpQDVCWJQ866dilnLFUMTwoasuIQU
         K4rtbgkL8YCEvaVkfnM145wnweQk2iTbUsTaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klWE6h3lUd9mKmrJLuN9Cee1MvLWP3xiEOXA4+1HHJ8=;
        b=Y7HezqIzhBNzYkFsKTHtt+Unzwq9ht9cBdixPWa0U3/7xXXVaLjhVWkDnmpLDRcDUz
         ZSeZeXz0DAiPJQZFhVv0/6nIpsJTN8ooHxEWX0jfl0JJP781UNWAIN/DMQK7wgIExDpr
         MqeRvZt50qVtiT21P++CE4T7zD8VcEwIqjpwC5jxGEZcb/FcMPeskvsq3YGaYERP7gMD
         pprPsIY+4EBMQdkrZGUR7Qw3dvpJiYXsbQ8iv2GaQscmUWXUI8el7V/PX0WttVQB5Mni
         tRkhAqv/V2z2agBRGwU4ekvDM/k0dSQoNOlmSXe/ukBWCDvH/pd/Mak2xQlxgC0tDTdt
         NGfA==
X-Gm-Message-State: AOAM532CrerKBybSWo4MjnhmSk6RVX/0Y30u6ePMbJOOCsCVWQj+BTRx
        mpQr3coVoOfn3jesd6h7X0SnQjZNgsc=
X-Google-Smtp-Source: ABdhPJyOsYin4KIkWcp/TjCCHffl8n8AuZX9tsH3y/yl59CQq4XX+Vgxfqui09Q96pp/ZRGymARdnw==
X-Received: by 2002:a1f:388f:: with SMTP id f137mr9618994vka.39.1590096538048;
        Thu, 21 May 2020 14:28:58 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id u75sm542238uau.19.2020.05.21.14.28.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 14:28:56 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id b28so2898612vsa.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:28:55 -0700 (PDT)
X-Received: by 2002:a67:e884:: with SMTP id x4mr8847497vsn.106.1590096535014;
 Thu, 21 May 2020 14:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org> <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org> <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org> <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
 <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
 <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org> <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
 <99f07eaa-d072-f391-098e-e6f7a50a1960@linaro.org> <CAD=FV=W+UES1f3reMhvPPUho5FbaZXdU-2jkRaPcbBEzDWT+WQ@mail.gmail.com>
 <9ecb5790-47fe-583b-6fc3-8f4f3ce7860e@linaro.org>
In-Reply-To: <9ecb5790-47fe-583b-6fc3-8f4f3ce7860e@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 May 2020 14:28:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbbUkeSwvcverBS8t6BCHuw3UT0_KYfx9LFGqmZyY2hA@mail.gmail.com>
Message-ID: <CAD=FV=XbbUkeSwvcverBS8t6BCHuw3UT0_KYfx9LFGqmZyY2hA@mail.gmail.com>
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

On Thu, May 21, 2020 at 8:56 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> On 21/05/2020 16:10, Doug Anderson wrote:
> >> On 20/05/2020 23:48, Doug Anderson wrote:
> >>>> Is this only applicable for corrected address space?
> >>> I guess I was proposing a two dts-node / two drive approach here.
> >>>
> >>> dts node #1:just covers the memory range for accessing the FEC-corrected data
> >>> driver #1: read-only and reads the FEC-corrected data
> >>>
> >>> dts node #2: covers the memory range that's_not_  the FEC-corrected
> >>> memory range.
> >>> driver #2: read-write.  reading reads uncorrected data
> >>>
> >>> Does that seem sane?
> >> I see your point but it does not make sense to have two node for same thing.
> > OK, so that sounds as if we want to go with the proposal where we
> > "deprecate the old driver and/or bindings and say that there really
> > should just be one node and one driver".
> >
> > Would this be acceptable to you?
> >
> > 1. Officially mark the old bindings as deprecated.
>
> Possibly Yes for some reasons below!
>
> >
> > 2. Leave the old driver there to support the old deprecated bindings,
> > at least until everyone can be transferred over.  There seem to be
> > quite a few existing users of "qcom,qfprom" and we're supposed to make
> > an attempt at keeping the old device trees working, at least for a
> > little while.  Once everyone is transferred over we could decide to
> > delete the old driver.
> we could consider "qcom,qfrom" to be only passing corrected address
> space. Till we transition users to new bindings!
>
> >
> Yes.
>
> > 3. We will have a totally new driver here.
> No, we should still be using the same driver. But the exiting driver
> seems to incorrect and is need of fixing.
>
> Having a look at the memory map for old SoCs like msm8996 and msm8916
> shows that memory map that was passed to qfprom driver is corrected
> address space. Writes will not obviously work!
>
> This should also be true with sdm845 or sc7180
>
> That needs to be fixed first!

OK, so to summarize:

1. We will have one driver: "drivers/nvmem/qfprom.c"

2. If the driver detects that its reg is pointing to the corrected
address space then it should operate in read-only mode.  Maybe it can
do this based on the compatible string being just "qcom,qfprom" or
maybe it can do this based on the size of the "reg".

3. If that driver sees a newer compatible string (one that includes
the SoC name in it) it will assume that its "reg" points to the start
of qfprom space.

4. We should post patches to transition all old dts files away from
the deprecated bindings.


> > 4. A given device tree will_not_  be allowed to have both
> > "qcom,qfprom" specified and "qcom,SOC-qfprom" specified.  ...and by
> > "qcom,SOC-qfprom" I mean that SOC should be replaced by the SoC name,
> > so "qcom,sc7180-qfprom" or "qcom,sdm845-qfprom".  So once you switch
> > to the new node it replaces the old node.
>
> Secondly, this IP is clearly an integral part of Secure Control Block,
> which clearly has versioning information.
>
> Versioning information should be part of compatible string in msm8996 it
> should be "qcom,qfprom-5.1.0"
> for msm8916 it should be "qcom,qfprom-4.0.0" this translates to
> "qcom,qfprom-<MAJOR-NUMBER>-<MINOR-NUMBER>-<STEP>"

I don't know much about this versioning info, but I'm curious: can we
read it from the chip?  If so then it actually _doesn't_ need to be in
the compatible string, I think.  Device tree shouldn't include things
that can be probed.  So if this can be probed then maybe we could have
the compatible as:

compatible = "qcom,msm8996-qfprom", "qcom,qfprom"

...where the SoC is there just in case we need it but we'd expect to
just match on "qcom,qfprom" and then probe.


If this can't be probed then having the version info is nice, so then
I guess you'd have the compatible string:

compatible = "qcom,msm8996-qfprom", "qcom,qfprom-5.1.0"

...where (again) you'd have the SoC specific string there just in case
but you'd expect that you could just use the generic string.


Does that sound right?


> Thirdly we should be able to have common read for all these as they tend
> to just read from corrected address space.
>
> Offsets to corrected address space seems to always constant across SoCs too.
>
> platform specific device tree nodes should also be able to specify
> "read-only" property to not allow writes on to this raw area.

Yeah, I was thinking we probably wanted a read-only property.  That
sounds sane to me.


-Doug
