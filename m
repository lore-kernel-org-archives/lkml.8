Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08B3206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e0nXZ01G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgFBDh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 23:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBDh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 23:37:57 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 20:37:56 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a68so1218478vsd.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 20:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Tu35wMUvVaUbJZZGmEqYD6hl6BjE9qoHA2F4LLuwpc=;
        b=e0nXZ01G9yqKOkxkRH/jBSACUc09CJtCCX4fdvqm/EU8DnLD75VaMN4adRxzPObMIe
         PFN2dMI9s/CCAjPncFv8ziDpLR5xr/RG+MLjLWinktrMEYX9z/M3kyeOyB/ywBapzCZF
         8Bk72OHQ+Yyji3hqPHvrZf8pF5YEaM0Runqus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Tu35wMUvVaUbJZZGmEqYD6hl6BjE9qoHA2F4LLuwpc=;
        b=jo1GLsuQjPngZKdeB03g8ADymAVp9Bvf1tot7u/q51750YbUo0c/WoSQuUEFjMCoOM
         wT/luZUOEYQx82pIcF+s99zzrrQxMBvHh4pEAT8e5Ab/Gk7S56m9YR3vahJq+hSNq5TD
         HKM7u8w7aOYlqrf6V02DESahYj3gH4lcd1t/RJRisOxQqJLQIT4iRj18d4uYK4cLmj+x
         +0cvyUf4LwdQc7XL2EvbFWFxc/T4WMwtTGLsNOb9cBzwNlwBNfxIAZShtHVaROXV2+bj
         M2bRFlL7eRFv/YB8/KNL1JFWCmDrv9XW5RrUhSa5+M1+v1oZcjnSrZpofuW9dw2MTyYL
         V2yg==
X-Gm-Message-State: AOAM530igRJTYjvzEixtPuaz3r44evOXJAlnnM9m4JtpRCJWgpWjgzxJ
        etLvKvJ4Dt/RqW2zr7MuiOj1udwFsCA=
X-Google-Smtp-Source: ABdhPJycPTewZeuOoDuQZTTwOOAL/v4RtXohYR3Z1OHRJWXidqmjsqpR43VW0DF7vNG9nI7DYtU73A==
X-Received: by 2002:a67:7c94:: with SMTP id x142mr6461298vsc.192.1591069075336;
        Mon, 01 Jun 2020 20:37:55 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id f138sm246984vke.54.2020.06.01.20.37.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 20:37:54 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id d8so741829uam.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 20:37:54 -0700 (PDT)
X-Received: by 2002:ab0:1684:: with SMTP id e4mr15730387uaf.22.1591069073999;
 Mon, 01 Jun 2020 20:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <1588314480-22409-1-git-send-email-mansur@codeaurora.org>
In-Reply-To: <1588314480-22409-1-git-send-email-mansur@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Jun 2020 20:37:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vt8je1AtT8id-rPC3JToF_7uGKpC-uDuSpzCkwi3e4Sw@mail.gmail.com>
Message-ID: <CAD=FV=Vt8je1AtT8id-rPC3JToF_7uGKpC-uDuSpzCkwi3e4Sw@mail.gmail.com>
Subject: Re: [PATCH V2] venus: fix multiple encoder crash
To:     Mansur Alisha Shaik <mansur@codeaurora.org>
Cc:     stanimir.varbanov@linaro.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 30, 2020 at 11:28 PM Mansur Alisha Shaik
<mansur@codeaurora.org> wrote:
>
> Currently we are considering the instances which are available
> in core->inst list for load calculation in min_loaded_core()
> function, but this is incorrect because by the time we call
> decide_core() for second instance, the third instance not
> filled yet codec_freq_data pointer.
>
> Solve this by considering the instances whose session has started.
>
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
> Changes in V2:
> - As per Alex and Jeffrey comments, elaborated problem
>   and addressed review comments.
>
>  drivers/media/platform/qcom/venus/pm_helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)

This fixes the same crash I reported here:

https://lore.kernel.org/r/20200601150314.RFC.1.I1e40623bbe8fa43ff1415fc273cba66503b9b048@changeid

Thus:

Fixes: eff82f79c562 ("media: venus: introduce core selection")
Tested-by: Douglas Anderson <dianders@chromium.org>

I still have the same reservations I expressed in the patch I posed
about whether this is truly safe from a locking point of view, but
certainly it puts us in a better state than we are today.

-Doug
