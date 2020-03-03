Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20403C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D1B20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iEomnEKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbgCCUvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:51:23 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36547 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbgCCUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:51:23 -0500
Received: by mail-vk1-f194.google.com with SMTP id y125so17450vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oW1Q93Cz5/1oipunUTCgm+h+ggYdq5iJCZAefRCHPRY=;
        b=iEomnEKBhquBub86A4qsjvpPTMpdF9h11IVjF8WbZPa8oljG9R8502kvXGsji0Vhky
         poyBNMxKdhRoIxueWBrNGTes7A3w0xZ6kvL5XbAu/VIgLoio6OjFamH7jOBSUQRuJzfc
         W/2ygkiIEse9DzXFAlP9QSTi9Dzrc2xGd1FbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oW1Q93Cz5/1oipunUTCgm+h+ggYdq5iJCZAefRCHPRY=;
        b=BWj3nTO3XPK1NuxeYqRWOVW8CzGiWLEYf6jCcQPHri33IdI4nJnIuzLxnJllLHPS8p
         UiI+q1o7An6NsV42nuWCUt9TPcqSw7ACbWaZyBY/I0nmii6Ye9em26nnKPdDegdkRtKJ
         WDvamP5PTyzN3JynEngoQ3bwgSD7yiYWQf3M8cRqGcR13uC0Vv8z2DvaiS7xO4GNFV9d
         Cfl6rW6w0iRFet+ADJpy6/OOR6YI+uTUk/cb6DRZAKlaQbBU9GTWvDAEnXnGOlKSldH8
         f2JXK40BCWDbUiOEGG7HUTrwy1UbewjFdYVAVGl+T/vQZQ1ljSTJE9J7fWmuIsRDi4kV
         X/ZA==
X-Gm-Message-State: ANhLgQ0Oirf1TrSKdIiITJQNEXc8uqgKgoUKQ98+jsp6Ikw0UvK8pHu4
        3NM5GVRKR44+r+UpZ0AfG6ryyodDr+g=
X-Google-Smtp-Source: ADFU+vsA1amesayTjar5EGJDfnZdb7y8I/rdwmnnq8bCpo0KhzPqSwaEw3CdyBnQgRnqsFpWa7QkmA==
X-Received: by 2002:a1f:3613:: with SMTP id d19mr4075216vka.71.1583268681864;
        Tue, 03 Mar 2020 12:51:21 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id y142sm3732045vsc.7.2020.03.03.12.51.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 12:51:20 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id y204so3383008vsy.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 12:51:20 -0800 (PST)
X-Received: by 2002:a67:e342:: with SMTP id s2mr3570808vsm.198.1583268680084;
 Tue, 03 Mar 2020 12:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20200213164146.366251-1-daniel.thompson@linaro.org>
In-Reply-To: <20200213164146.366251-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 Mar 2020 12:51:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UM6eePrTE9Kpc4zfTSBpQSYXJghVP9dGAvD_25=JTfzw@mail.gmail.com>
Message-ID: <CAD=FV=UM6eePrTE9Kpc4zfTSBpQSYXJghVP9dGAvD_25=JTfzw@mail.gmail.com>
Subject: Re: [PATCH] kdb: Censor attempts to set PROMPT without ENABLE_MEM_READ
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 13, 2020 at 8:42 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently the PROMPT variable could be abused to provoke the printf()
> machinery to read outside the current stack frame. Normally this
> doesn't matter becaues md is already a much better tool for reading
> from memory.
>
> However the md command can be disabled by not setting KDB_ENABLE_MEM_READ.
> Let's also prevent PROMPT from being modified in these circumstances.
>
> Whilst adding a comment to help future code reviewers we also remove
> the #ifdef where PROMPT in consumed. There is no problem passing an
> unused (0) to snprintf when !CONFIG_SMP.
> argument
>
> Reported-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

I can't say I'm an expert on the kdb permissions model since I wasn't
really even aware of it before reading this patch, but your change
seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
