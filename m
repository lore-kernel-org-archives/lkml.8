Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F308CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85892074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EHpAeSv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgF3Wc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgF3WcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:32:25 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:32:25 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id s20so4826270vsq.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oX8IEcCQ042Y8Jh028safSbu4eOF6OaEoT6uY1IVW+w=;
        b=EHpAeSv7pNUbvTVcX9DVF1wwyqwBTF9dIfFVsfzDuxUAJ4guzmbP2dnLrvSho6kywo
         N+YgkqHOlOEaM9Zg8LI1vN5A0tm+d8HB9Pa6TVCDMfvb561Rm1MLkCBYyd2Hkm9RuSly
         wFpg/m1xHweCeYTfTDUTpRuuRWWAB2GYlv0kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oX8IEcCQ042Y8Jh028safSbu4eOF6OaEoT6uY1IVW+w=;
        b=NkmGiftF/rhYnbsPc/gsn40He1F8Zwdt0GhpTNKvGSj45UiTMVrTpsZAezq4Jt6e6r
         fH41fr3NNmejrU70phom0gRzmovvLZWYGkdLtEv86vTc4Jme97QmqFtlssjngy9hnqB0
         Tm96fC21EWyJojANcjDmcu9T9vu8B9Dk6cny1oBGqv/ZN8uFEFDWiFF7hA8VCnFOaBJ6
         sbYJYKoY2HBaJZYSbRGqc6967LlFnuyOUtXRntl1Wm81INcpCu+of73jx9lVRPmfOZzG
         q639v1MYHYOU7FKo7PwmT4V64Ypg/OFoMG/PZWL84gxAyuyAv5LJkXuvhrR67cLATbcW
         HQLA==
X-Gm-Message-State: AOAM5327yloWHxaT6tR7e5SvWWIL6fTIRl7B2rxEl8Uwet4OyPo3cmRn
        lX0Vwjwg5DPEY6ZH7W4eAsjfM94Cuu4=
X-Google-Smtp-Source: ABdhPJxbEOK5pk8ZugNLH4ntxQSvfQFtOhnKiUna85ogry8/SnZMKZiyu/6It8GkyFxCEVZPMb/C3Q==
X-Received: by 2002:a05:6102:20a:: with SMTP id z10mr8928231vsp.213.1593556344213;
        Tue, 30 Jun 2020 15:32:24 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id f133sm647548vke.23.2020.06.30.15.32.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 15:32:23 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id q15so6847955uap.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:32:23 -0700 (PDT)
X-Received: by 2002:ab0:2408:: with SMTP id f8mr8448016uan.91.1593556342676;
 Tue, 30 Jun 2020 15:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFA6WYNpCG2xPERd=NeKf+EthbX+1R4iieOL52kWnBp8y_+Nbw@mail.gmail.com>
 <20200630082922.28672-1-cengiz@kernel.wtf>
In-Reply-To: <20200630082922.28672-1-cengiz@kernel.wtf>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Jun 2020 15:32:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbMfwAQ+M7oMksd0dv9xjkQrGhU8hVNahn7+vxTuhT6A@mail.gmail.com>
Message-ID: <CAD=FV=XbMfwAQ+M7oMksd0dv9xjkQrGhU8hVNahn7+vxTuhT6A@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: remove unnecessary null check of dbg_io_ops
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 30, 2020 at 1:30 AM Cengiz Can <cengiz@kernel.wtf> wrote:
>
> `kdb_msg_write` operates on a global `struct kgdb_io *` called
> `dbg_io_ops`.
>
> It's initialized in `debug_core.c` and checked throughout the debug
> flow.
>
> There's a null check in `kdb_msg_write` which triggers static analyzers
> and gives the (almost entirely wrong) impression that it can be null.
>
> Coverity scanner caught this as CID 1465042.
>
> I have removed the unnecessary null check and eliminated false-positive
> forward null dereference warning.
>
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  kernel/debug/kdb/kdb_io.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
