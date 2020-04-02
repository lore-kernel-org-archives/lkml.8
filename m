Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2438C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F3A206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WpUfI6vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbgDBUOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:14:14 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35585 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbgDBUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:14:14 -0400
Received: by mail-vs1-f66.google.com with SMTP id u11so3435980vsg.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2KZZSErTlqi9bcZVI97UMRwpZy818j1NzSmFXCiRoM=;
        b=WpUfI6vhm9+byBPTnviB2LfRrhJf3CrgeqRbtRVtvkct+oAdSX/g0UMVQ1LfdKfGJn
         UBkz+Sb4STInORrpcP+4kigpNzF/EBtz9K3J3VA58tw1bXwFzC/2I571PMoAN00jAFAV
         E1ocuiIC+BUv4O6SPdHywDkfCiqKOEefQp0CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2KZZSErTlqi9bcZVI97UMRwpZy818j1NzSmFXCiRoM=;
        b=m8cBlK5qmYw/f7ofHqtPaxid8l5CLrAZkvLjYIL61aAqb5VxVFLUd6jM66eAWyGTQ1
         kA9mKXmLdfRxBfS/+jv4DeXMEfcKuXEDeqDo+VWF85GQenRgakNDtj5lArxZGoPn4C/K
         IlPW+/TgoSzvkeH0vadjayoxfLDY2KYiToIwGw8Szn5E/15kozA7AVfXziHSraOZnSIw
         nbWjplu1s3ECQ4AS1o2oTzE08+SVU1g33ftFzaiFDVNVeWXcLF0o7m6jPfoTAblwl+g/
         EGZilKDyAdepMTFivWX8yf4qcRiO3GVKq6ei9rKsS7U2ChmXSD7c2vVcFEFuHhOtWDyQ
         HRMg==
X-Gm-Message-State: AGi0PuZwfg1NgmBR/QrSC7hR7zDFtCeDVWv9NNH2JKQOwsyEwQQdDXMf
        5dZ06da5eBESa0TSWETuo09hzksNLsE=
X-Google-Smtp-Source: APiQypJnzb4KJSUCJIpEmOIML+Mdh0x5Yh4WkieoRCKDVJQf/pPweanu9OMM8v1ISesfnuOqc1omxg==
X-Received: by 2002:a05:6102:2051:: with SMTP id q17mr4003456vsr.165.1585858452640;
        Thu, 02 Apr 2020 13:14:12 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id s17sm1519555vsc.27.2020.04.02.13.14.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 13:14:11 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id y138so3445087vsy.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:14:11 -0700 (PDT)
X-Received: by 2002:a05:6102:3204:: with SMTP id r4mr3631989vsf.109.1585858450535;
 Thu, 02 Apr 2020 13:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <1585660782-23416-1-git-send-email-mkshah@codeaurora.org> <1585660782-23416-8-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1585660782-23416-8-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Apr 2020 13:13:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_JJWAb9BBkhWGZJ+jUvtO3ipf-OxFRYo38YY25cA42Q@mail.gmail.com>
Message-ID: <CAD=FV=X_JJWAb9BBkhWGZJ+jUvtO3ipf-OxFRYo38YY25cA42Q@mail.gmail.com>
Subject: Re: [PATCH v15 7/7] soc: qcom: rpmh-rsc: Allow using free WAKE TCS
 for active request
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 31, 2020 at 6:21 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> When there are more than one WAKE TCS available and there is no dedicated
> ACTIVE TCS available, invalidating all WAKE TCSes and waiting for current
> transfer to complete in first WAKE TCS blocks using another free WAKE TCS
> to complete current request.
>
> Remove rpmh_rsc_invalidate() to happen from tcs_write() when WAKE TCSes
> is re-purposed to be used for Active mode. Clear only currently used
> WAKE TCS's register configuration.
>
> Mark the caches as dirty so next time when rpmh_flush() is invoked it
> can invalidate and program cached sleep and wake sets again.

Comment above is no longer right now that you've removed the place
that marks caches as dirty.


> Fixes: 2de4b8d33eab (drivers: qcom: rpmh-rsc: allow active requests from wake TCS)
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Other than the comment nit:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
