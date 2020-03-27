Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D29C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6472083E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G7WCrgsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgC0SWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:22:45 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38614 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0SWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:22:44 -0400
Received: by mail-vs1-f66.google.com with SMTP id x206so6834824vsx.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMqfnFJfOBNCe0ahBd62eMY+XQaeL21j8Kfs+r5ufSA=;
        b=G7WCrgscZMeRk0ftZqju+5xPkj8WyWt0QH3xSwv9B6HzbWbeum1U4B64GLxHjdb9Qt
         SG2/j74SA5xNvA3oZy3EIZDIkGC3tvKLMwcsJVmo/w88jkaO/mufMSy/6mKQG5xd+3yt
         r1mtAyJ6LsEE3cGbfLXKlEvld8VsPvVFft+PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMqfnFJfOBNCe0ahBd62eMY+XQaeL21j8Kfs+r5ufSA=;
        b=fZvMCdn9T/qtEJQKsh3Qpc16DuoJYdr1wzFgPqeimOlQz4SJXyGwu5DhB/rnQkYYST
         O3qe48NrDP8Uq8504gtZF+4YAevR+7Mmu8BOdsQVDpBx+q5dz+rxt8QDXDhBXlPACZQL
         Js73GCd/ctE4+sYcvtOVUVHbgeKbOaY36etC/3i/9uVdg8gF2a+8MMAtB/AxlTPqI3pc
         YpQD35/YqYA3mn+tBxAAGSI5LTGUPx1R8FtyOw5y5a1tok1VSyRMwrjGcg5tMhF1+VBa
         Z+d8X6UhX1n9su2COcSLIeya/M4lfZphxehmFoOR4VlM8GojJYhrezAA9XMEI9AhB+iC
         yP0A==
X-Gm-Message-State: AGi0PubuFac5SaJOLJcxoM/pPGPj2RScjd3eaKgLSONpiO2xF1MiAa9y
        javxekq+ex/5cT6QwR9yppiSilouhZ0=
X-Google-Smtp-Source: APiQypKH/LZAiM+fejS+ZiWs3cY2WyP290YUj510duNtYT+rcgIyP1WUE6DUXafVMpzStgX8ZiSgTQ==
X-Received: by 2002:a67:f24d:: with SMTP id y13mr283643vsm.72.1585333363239;
        Fri, 27 Mar 2020 11:22:43 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id o39sm3165433uad.6.2020.03.27.11.22.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 11:22:42 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id r7so3923617vsg.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 11:22:42 -0700 (PDT)
X-Received: by 2002:a67:7c02:: with SMTP id x2mr277589vsc.45.1585333361883;
 Fri, 27 Mar 2020 11:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <1585244270-637-1-git-send-email-mkshah@codeaurora.org>
 <1585244270-637-5-git-send-email-mkshah@codeaurora.org> <CAD=FV=UQAbqitmYR7=5+AAL8pqy2imzEWf8BTkBoD6mthAwpKw@mail.gmail.com>
 <7bd2c923-4003-a1c4-610f-548e79a94d35@codeaurora.org>
In-Reply-To: <7bd2c923-4003-a1c4-610f-548e79a94d35@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 27 Mar 2020 11:22:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEH_A4SvyX0uv9Z_n+z9_SYcdm2LfsLRK7qALEiOyHqQ@mail.gmail.com>
Message-ID: <CAD=FV=WEH_A4SvyX0uv9Z_n+z9_SYcdm2LfsLRK7qALEiOyHqQ@mail.gmail.com>
Subject: Re: [PATCH v14 4/6] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
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

On Fri, Mar 27, 2020 at 4:00 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
>   * @ctrlr: controller making request to flush cached data
>   *
> - * Return: -EBUSY if the controller is busy, probably waiting on a response
> - * to a RPMH request sent earlier.
> + * Return: 0 on success, error number otherwise.
>   *
> - * This function is always called from the sleep code from the last CPU
> - * that is powering down the entire system. Since no other RPMH API would be
> - * executing at this time, it is safe to run lockless.
> + * This function can either be called from sleep code on the last CPU
> + * (thus no spinlock needed) or with the ctrlr->cache_lock already held.
>
> Now you can remove the "or with the ctrlr->cache_lock already held"
> since it's no longer true.
>
> It can be true for other RSCs, so i kept as it is.

I don't really understand this.  The cache_lock is only a concept in
"rpmh.c".  How could another RSC grab the cache lock?  If nothing
else, can you remove this comment until support for those other RSCs
are added and we can evaluate then?

-Doug
