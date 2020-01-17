Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77956C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3D62083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMYDVK3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgAQQr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:47:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39791 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQQr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:47:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so11938944pga.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0X6p9xbHrIlzrHh63asXC+Mr9ezNFig8K8mnlw/VU0=;
        b=CMYDVK3o15a/HLUEwZvdlzwRDAHR11DvP7YGjjZFLjxpRPH9kwENk08LX0uEzCGkOD
         lTru8dUdToIiA4eSbzG50gCCsQKvKxHA6VlmgjLs2ZsdmaKvY1i9BdjF4aKeZIxXBpF9
         NQl7L5svUZaNyz/v96UNHPclw2e8ji1Pu/Xmnvo6ncClATMcQ2pSYyN+1m8dcQq5Yl75
         qpst28HMwgbX1e8UyK2ZDQzRKxQjPU/bF8pGmpA3zKdiShJ1ksvshyVc7a5I06celg8N
         zPI+BQBRbox2vCUX84yW0VxyPzVm6ZWOCDe7OT43LvdcVJqZiH71MJ8hA+vfA+Xt2A7W
         wFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0X6p9xbHrIlzrHh63asXC+Mr9ezNFig8K8mnlw/VU0=;
        b=sBj7QkE9m4dH4IxJj1Kqg5QnsqFbvrxN7Lc0e97OuURc/TlkS+9PUQzImWVINciq2b
         Ua20++8+BF1rDXIjqboyzlB0aQ513sSVSIbevDkZ07Y0drwM3OUwF621ELnZYBl4n1IJ
         rXfPi4OeItWT3OeejVJKhnBU3MGlgQbKO3o0djNjBfgnbx77WY6utCYXTixpbRmq0IJy
         A0uP6dIbmeX+WCXiBBWcBTn1aWM2SkzTy07R1+MpnYv/jscOB+wM23hQymCyXOpVBGMI
         fDK0JJBEZPbgBdj8g6UGRRfDow8iD99i0+SKDFGZgvrXKsud+1XMgsaR2U9R/QFFa453
         TiRw==
X-Gm-Message-State: APjAAAWb0WqJHvQlNuR3iIEZXf+q7IyKOX+pu3ZMCl9zNVY5asde/lc3
        5S3S9NFMENdZirk2SnGg59TKYTy2G1vUwDI+K8HYig==
X-Google-Smtp-Source: APXvYqzf1H4OJi9a5ulljQv3WaQlU3fRZ0ZEAcTUWyDTmvAqhBxj9PMrU7ySmf6NRhw9tQh/UG1oa39cDJV/rCiAQIM=
X-Received: by 2002:a63:f24b:: with SMTP id d11mr45395104pgk.381.1579279675422;
 Fri, 17 Jan 2020 08:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20191022132522.GA12072@embeddedor> <20200113231413.GA23583@ubuntu-x2-xlarge-x86>
 <a729415d-1304-9722-2433-129bd2255188@xs4all.nl>
In-Reply-To: <a729415d-1304-9722-2433-129bd2255188@xs4all.nl>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Jan 2020 08:47:43 -0800
Message-ID: <CAKwvOdne74KKV4s+voH1_+4iL_2T2efJTSiw5b6MW2=egiMN1Q@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: adv748x: Fix unsafe macros
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:25 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 1/14/20 12:14 AM, Nathan Chancellor wrote:
> > On Tue, Oct 22, 2019 at 08:25:22AM -0500, Gustavo A. R. Silva wrote:
> >> Enclose multiple macro parameters in parentheses in order to
> >> make such macros safer and fix the Clang warning below:
> >>
> >> drivers/media/i2c/adv748x/adv748x-afe.c:452:12: warning: operator '?:'
> >> has lower precedence than '|'; '|' will be evaluated first
> >> [-Wbitwise-conditional-parentheses]
> >>
> >> ret = sdp_clrset(state, ADV748X_SDP_FRP, ADV748X_SDP_FRP_MASK, enable
> >> ? ctrl->val - 1 : 0);
> >>
> >> Fixes: 3e89586a64df ("media: i2c: adv748x: add adv748x driver")
> >> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com
> >
> > It doesn't look like this was picked up? I still see this warning on
> > 5.5-rc6 and next-20200113.
>
> It's been picked up some time ago and will appear in 5.6.

https://git.linuxtv.org/media_tree.git/commit/?id=0d962e061abcf1b9105f88fb850158b5887fbca3

-- 
Thanks,
~Nick Desaulniers
