Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C63C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DE420774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DHSb/7qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbgFWOsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732798AbgFWOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:48:46 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A996C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:48:46 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id y7so320077vkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEabnoTzMSMmcitY1/kUEpPMigRk7eTjdULYpM76Ya0=;
        b=DHSb/7qblyoC5f9D++LorPl3ez8L+VQhZKYnVxUQ9dLG2QiycB4kbSeK6pXj88TjQz
         QD3h3IvFfIXvU2jIAt0tjkC6PMYXNql5yUzFG36LH05yzBs/z623O0R5YrGgwT7Osv00
         Vqdknz0xMDz/A0AbHhPKiBKgL/zlLArpB/LwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEabnoTzMSMmcitY1/kUEpPMigRk7eTjdULYpM76Ya0=;
        b=uIZDqubkeEGPUL+UOp3pzretyiHmNMLd5kpgAyQa6/mHWMztHk+JuFm6FZV4jNtgyn
         FPOokzl9Ebq6GqgaP0g5b+rWHxDgj7BU48wEW28Xr2hW8c4doW9k+TQ7aDuCYbj499At
         OX/E/Loisu9lNM2oB0x/SIX/ANKDdqppgikVpvRazlRsIaoN96CVjZma1n3TBGzDAnav
         st+aehglBnmy/1KC76+QgTzyZR5KwwQy5362SzbK/USPfpf+suR2SOcizMVFjb8daVSY
         qJk5mkj+CQWGWgxm6X7APPNsJ0EPNsunH7+LLPrcR0oquoC3nBF0CSGrxMEPHhHTDW42
         2m5g==
X-Gm-Message-State: AOAM532Yu9m6CjcKoxirD66nWhDO5BG3MVs5v0OU7FTp42qDnLj43QtP
        yUmO8gvvL6o588zIcbGyt/xubDCqxKI=
X-Google-Smtp-Source: ABdhPJymP0IwJpFlHTSnI7oJwwZFfLUxmExNWsbrX769Sw3L/SrVFBsTxEPDxYEGhhzetoiM3oX6Bg==
X-Received: by 2002:a1f:4355:: with SMTP id q82mr5412733vka.69.1592923725637;
        Tue, 23 Jun 2020 07:48:45 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id s19sm2649712vke.14.2020.06.23.07.48.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 07:48:44 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a10so6890610uan.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:48:44 -0700 (PDT)
X-Received: by 2002:a9f:3b1c:: with SMTP id i28mr13926131uah.22.1592923723861;
 Tue, 23 Jun 2020 07:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200617145116.247432-1-dianders@chromium.org>
 <20200617074930.v3.3.I68222d0b5966f652f29dd3a73ab33551a6e3b7e0@changeid> <20200623133559.GD2783@bug>
In-Reply-To: <20200623133559.GD2783@bug>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Jun 2020 07:48:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Up9MfQju_5Pvqqe1kU1ebZrmWK-qWvA_-zm8K74wkKNg@mail.gmail.com>
Message-ID: <CAD=FV=Up9MfQju_5Pvqqe1kU1ebZrmWK-qWvA_-zm8K74wkKNg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] nvmem: qfprom: Add fuse blowing support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, dhavalp@codeaurora.org,
        mturney@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        sparate@codeaurora.org, mkurumel@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 23, 2020 at 6:36 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > This patch adds support for blowing fuses to the qfprom driver if the
> > required properties are defined in the device tree.
>
> Should we have this in kernel?
>
> If so, should we make it harder to use, like passing module parameter
> enabling this kind of support or something? Kconfig option as most users
> will not need this so this should be compiled out?
>
>                                                                         Pavel

It's definitely a good question.  I'm curious: who are you trying to
protect these fuses from?  A bumbling user or a malicious bit of code.

For a bumbling user we presumably just need something that makes it
not quite so easy to blow the fuses.  Passing a module parameter isn't
a bad idea.  Would the module parameter only take effect if provided
when the module was loaded, or could it be switched on later via
sysfs?

For a malicious bit of code: the only real protection is to have the
bootloader protect these, or to blow the fuses which disable future
fuses from being blown (the access permission fuses).  Otherwise
malicious code could always just code up its own driver to bypass any
protections.

NOTE: if we already have protection from malicious code by having the
bootloader configure protections, I wonder if we still need additional
protections against a bumbling user?


-Doug
