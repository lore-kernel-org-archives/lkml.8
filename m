Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24257C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038872072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ADhQPTFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgEUPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgEUPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:10:51 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736BC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:10:51 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g34so1877068uah.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ffe0xz9XMcB5mRpVbSZxAWF/UEfoDxZNXD2x44f+aIg=;
        b=ADhQPTFdZEYLsxid6o5adOvSYnvHO06MEAcMIK9vt6NakkFzT7SJoRfUfS/VVY2uBN
         sBf7Rg3UZ+KjLHtkaHd4bEORQOOVJ/qIZSn7J0HVFPd812RpgZPZxFrPxAe55+M2gl9T
         R70cOP577H7YotMi3d7OptNRcJWyVeW+oc7lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ffe0xz9XMcB5mRpVbSZxAWF/UEfoDxZNXD2x44f+aIg=;
        b=VlIdPVryliykI9XwhVpW78pLqJxkPrHqVM5JEDqKpNJ29c0QGDU6ZmUfy+vP0w0rOs
         hGiIZvhql92Ng7WHw3a4gabTE6uMZ4edAfQGZ6wHoVPZkfomFvO3ibWfdvaUnEZwPIDX
         HDrD10QUkNTn6ZbrKWxVc6YnJH5Yndj2can6zQPRfwBty7TxqtVejY7Mjv47EWrd8jXq
         mC/iVRVwJ/7qqZpbrBEEPQmMb19KMiSnioNfdXpJZV+5nHPI57CK9CNhHwhMmv+piFht
         Y0p3xmT8WywRCx6bkdBb3pKoL6s11v2wtZ5GAtd+x2lrHwDpJ+yVdv07RU2RIVzrd9BX
         6MXw==
X-Gm-Message-State: AOAM532PbYExyykmDvHRbWUnfkZ2DL0C1yDY/KSCrpsjUMVpZjvbgD4a
        cNJDdM+r42K3BuvoAHQPj37pvH1OEak=
X-Google-Smtp-Source: ABdhPJyIG6BKMswwi7dOnabT9qLnKXXBJL/N19SrC4yie/bm6OKneRjRIzbjuqVTs3QMQbuq8yBFog==
X-Received: by 2002:ab0:48ea:: with SMTP id y39mr7293333uac.21.1590073849501;
        Thu, 21 May 2020 08:10:49 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 2sm103950vsj.3.2020.05.21.08.10.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 08:10:48 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id 1so4183694vsl.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:10:47 -0700 (PDT)
X-Received: by 2002:a67:e884:: with SMTP id x4mr7424096vsn.106.1590073847105;
 Thu, 21 May 2020 08:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org> <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org> <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org> <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
 <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
 <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org> <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
 <99f07eaa-d072-f391-098e-e6f7a50a1960@linaro.org>
In-Reply-To: <99f07eaa-d072-f391-098e-e6f7a50a1960@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 May 2020 08:10:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+UES1f3reMhvPPUho5FbaZXdU-2jkRaPcbBEzDWT+WQ@mail.gmail.com>
Message-ID: <CAD=FV=W+UES1f3reMhvPPUho5FbaZXdU-2jkRaPcbBEzDWT+WQ@mail.gmail.com>
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

On Thu, May 21, 2020 at 8:01 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> On 20/05/2020 23:48, Doug Anderson wrote:
> >> Is this only applicable for corrected address space?
> > I guess I was proposing a two dts-node / two drive approach here.
> >
> > dts node #1:just covers the memory range for accessing the FEC-corrected data
> > driver #1: read-only and reads the FEC-corrected data
> >
> > dts node #2: covers the memory range that's_not_  the FEC-corrected
> > memory range.
> > driver #2: read-write.  reading reads uncorrected data
> >
> > Does that seem sane?
>
> I see your point but it does not make sense to have two node for same thing.

OK, so that sounds as if we want to go with the proposal where we
"deprecate the old driver and/or bindings and say that there really
should just be one node and one driver".

Would this be acceptable to you?

1. Officially mark the old bindings as deprecated.

2. Leave the old driver there to support the old deprecated bindings,
at least until everyone can be transferred over.  There seem to be
quite a few existing users of "qcom,qfprom" and we're supposed to make
an attempt at keeping the old device trees working, at least for a
little while.  Once everyone is transferred over we could decide to
delete the old driver.

3. We will have a totally new driver here.

4. A given device tree will _not_ be allowed to have both
"qcom,qfprom" specified and "qcom,SOC-qfprom" specified.  ...and by
"qcom,SOC-qfprom" I mean that SOC should be replaced by the SoC name,
so "qcom,sc7180-qfprom" or "qcom,sdm845-qfprom".  So once you switch
to the new node it replaces the old node.


> Isn't the raw address space reads used to for blowing and checking the
> fuses if they are blown correctly or not and software usage of these
> fuses should only be done from correct address space?
>
> the read interface to user should be always from corrected address space
> and write interface should be to raw address space.

Great.  That sounds right to me.  Presumably the driver could add some
sort of "debugfs" access to read the raw address space if needed.

-Doug
