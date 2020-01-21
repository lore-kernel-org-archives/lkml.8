Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0DCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D5D2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Re6wdTRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAUXpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:45:17 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41741 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgAUXpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:45:16 -0500
Received: by mail-vs1-f65.google.com with SMTP id k188so3073911vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRAe+xGDFcOTmGCrTfwa2NqjUz3R2uVFPbvdZzef6UE=;
        b=Re6wdTRSvrog3KEeDoQaq8tkcUhE6wqspwFJ7DYwfKMRVorCNibjBxIWyPjS/wVMEI
         vrQ2k2a1Hhv02uzMdaxBDezYRoPbwI4ZcIzvWb/+M2l7IU+Jm1Rj0hi+si+YAb7zmKpt
         Wju7ivg0E8jcliqwAzl+TTa9HE5r3msGMyepQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRAe+xGDFcOTmGCrTfwa2NqjUz3R2uVFPbvdZzef6UE=;
        b=UpNzIHwqI6E7yJxIfb5EjUxRDCorVd3avc0Rs138GCcecegPb46fSd+ibl5xNkeUF9
         5dDjORVcyVt7J4PRmxQWw/yzmbfIQJzQ+V57smp/I7rTEGMlR84XMmlhKD+/5tT2GwHO
         lYZroEbN4hXoCJoM5+WkEoNiFebcqTiumVjEWpBT+N3/Ba0N3puc4ge+Iw2ZEhOUxgJh
         ibzOJL04yGFNZuI24sbTvZCa+O6mFGWMBEzBlNPsDW5hZiXsCyz9EomJQnF0uhcMAfzB
         TzgjYKGT8iOYGZAEI5wskiaAZsUSL3xs5TIBuglbeYSyQl3uZGJCQL2o8exMmRspA76C
         1Img==
X-Gm-Message-State: APjAAAU0rSu21y4QD0Pa8kuJST96QnpB9pNfe8wS/uytK9oxyxaKtiSJ
        TLdQtp3xk45nw5EFDXlKzQ2nEd862nk=
X-Google-Smtp-Source: APXvYqwozvqpAmTQqy3cCI0ERKw49zNAXL9gTxj+O0liXBnIceqTKKwl5ik6rjmlE++Tw65ucAFSow==
X-Received: by 2002:a67:ec88:: with SMTP id h8mr955974vsp.65.1579650315353;
        Tue, 21 Jan 2020 15:45:15 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id d3sm11186375vkd.24.2020.01.21.15.45.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 15:45:14 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id t12so3058261vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:45:14 -0800 (PST)
X-Received: by 2002:a67:8704:: with SMTP id j4mr1006872vsd.106.1579650314364;
 Tue, 21 Jan 2020 15:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20200121194811.145644-1-swboyd@chromium.org> <20200121194811.145644-3-swboyd@chromium.org>
In-Reply-To: <20200121194811.145644-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Jan 2020 15:45:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XLK8g67O_dfPXVd0JxQY4_srwghmyA0bzy6fZPuTdHhg@mail.gmail.com>
Message-ID: <CAD=FV=XLK8g67O_dfPXVd0JxQY4_srwghmyA0bzy6fZPuTdHhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] alarmtimer: Use wakeup source from alarmtimer
 platform device
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 21, 2020 at 11:48 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Use the wakeup source that can be associated with the 'alarmtimer'
> platform device instead of registering another one by hand.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  kernel/time/alarmtimer.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Seems like a good idea to me.  With the same caveat that I'm no expert
in this part of the code:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
