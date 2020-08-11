Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11674C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01D5205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aediAnXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHKVR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKVRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:17:25 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B867C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:17:25 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q13so21418vsn.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6METftXhKSKa4OJt8K+q8U+3V8Jq6aEorQMb99jfW0=;
        b=aediAnXzrsIsrvtUll1amabGwpepmtJ394qjWBNHZ0ZsjYESbfEhdOR9crzTm+iKoc
         C2znHUO5M7sdH7rb0Pkd1Ha0SusGVyHpnQlM7KjFQM0Ioa70gSeSag84l4BXHv84HhOb
         i+vQZuMhUFtXeL04J/JHVzYQlobEA10bxYqVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6METftXhKSKa4OJt8K+q8U+3V8Jq6aEorQMb99jfW0=;
        b=bIPsPV9Qbk/UXoe+x9dkkdbsLMMGG68pRdDtMO7j/e1IEv/0COTIp8ZpX0c80djguN
         YrFEDwidHaZrF3W+t6d2bx8LxtNj/4wjqK37nPyK1Zi9Zyzg06BpX6uiSqRmbLwUaoV6
         RJHsz5ZB5niLJ6HE2amvAoRHF3Cwq0TY29da8sA0pEt9SofpY5+DeREZRyu2XVKP4/Tk
         4YYKuQvjrcAsmPsN1Yc6/YyZtpCHkTm5oZkFun1Q2EfVAkgG4JnKwEbujX1G/ozAIvvX
         phouCkk8w67Ur2EtthCgukVhewAHwIJjE/SJSAaZ8CQBeeic01PS2VY/FFizL7nDEfFs
         CGjw==
X-Gm-Message-State: AOAM532Yk3M0Kw1OxyKSsGPQmYYaco1OaYQv9DJfo9CSp0dH7zC2U59J
        qsbAnyFHlVxFif5ZbY/iUc3rZ0DmIcc=
X-Google-Smtp-Source: ABdhPJzJ8uZxeyBy5dRHJMhT8vZvQfYCG2oGY7kEpQGLzgtgybQtEdxSFyqAnvEmhhINrPtTbvPX1A==
X-Received: by 2002:a67:f44f:: with SMTP id r15mr23774663vsn.42.1597180643796;
        Tue, 11 Aug 2020 14:17:23 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id y6sm29119vke.35.2020.08.11.14.17.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:17:22 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id y8so25642vsq.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:17:22 -0700 (PDT)
X-Received: by 2002:a67:fd67:: with SMTP id h7mr23572394vsa.121.1597180642357;
 Tue, 11 Aug 2020 14:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200811190252.10559-1-sibis@codeaurora.org>
In-Reply-To: <20200811190252.10559-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 14:17:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VtPX19o-tdyPBT=07AgbT7kWKhjpuU4d22SQ5D0r=jog@mail.gmail.com>
Message-ID: <CAD=FV=VtPX19o-tdyPBT=07AgbT7kWKhjpuU4d22SQ5D0r=jog@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Brown, Len" <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 11, 2020 at 12:03 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> This is for power domains which needs to stay powered on for suspend
> but can be powered on/off as part of runtime PM. This flag is aimed at
> power domains coupled to remote processors which enter suspend states
> independent to that of the application processor. Such power domains
> are turned off only on remote processor crash/shutdown.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/base/power/domain.c | 3 ++-
>  include/linux/pm_domain.h   | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

Seems sane to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
