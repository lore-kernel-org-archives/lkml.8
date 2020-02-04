Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF186C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D0220720
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580822546;
	bh=yMnNHLql3z6wp+I7xgPPSVQbbgiZVYm2n5XlCyM5Xsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tA8oyPBO9AkWEJT7kMVHjcHTczHJMunzzAgD8DqAieUToI40cRG3mWixhlcjXLOGF
	 LYIzen5fSOPczEaju1qv0kismEL+E7hWAZCXF9MmLYfP7PH1IuJ3egWab6WaMbmJzp
	 md6Gfe4pUEP6Mo744a0KVCkV3p2UajzpclsGy8fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgBDNWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:22:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44412 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBDNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:22:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so12135273lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 05:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjqi7GSV+XhVmq70nj2dDhatB3US2HpM+nzP00ivNu0=;
        b=aTzWdo88cRJl9nDZthihpz8kJSrXK19XiNrMoJ7OqgNJhxIaKBSZLjaNSNRNfoMs8o
         qPVlNdUPfRrlmv3fiLqlsuE0pOyx2+ETPWdDZ/Ro8t/33Co32nemnMovp7aN/gPcZzF2
         1VQn5jg7iwkYtzshjjZnKRhMfYPCO5PUiokWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjqi7GSV+XhVmq70nj2dDhatB3US2HpM+nzP00ivNu0=;
        b=NIKUU+idq7yl+eWTy8RtM05ayHM80nVZynMoIrUAJ/YAYLytCIe65SQvXgUFjglAQD
         gRVeJqothmVtoB+R3EuMdZaSL2XH5W6YPvTMxaog70tcycO7g5UADzy8z6Pn3GiTcgck
         CE55ygz07nzah2e3LYYcIKx/oY2+VmvHeelPTQXv4txirmnhRZbZNAz3dSihTnzo9Gax
         2j7zvW+95MYX2iCTkjRtFa6TJVvyMChFashA1ObGs/DWclWL48+YsjvIti13eJR9mErd
         +rimz3LtV77nHXM7Jpjb8FSFRIPZlmhvXzljpe8z5P1xlFSMfg1awzdJlNSoByCFPem4
         0U+w==
X-Gm-Message-State: APjAAAXpzVcyubT7xIwMorbQDNOzpNLR/ru6fE5m01tt2/y8BpC8wkzj
        RvcM7IWeuv73yt1hakgFgki5agA17NC91Q==
X-Google-Smtp-Source: APXvYqyvJf80FrhakOogTxGQ8qZ3ByErv0X6O7mSUvMCfLPI0ppkpfbLrXLhBPdLW7e/t+/2+Uvdjw==
X-Received: by 2002:a19:cb17:: with SMTP id b23mr15129436lfg.201.1580822542663;
        Tue, 04 Feb 2020 05:22:22 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r20sm10500517lfi.91.2020.02.04.05.22.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 05:22:22 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id y6so18618387lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 05:22:21 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr17655751ljb.150.1580822541351;
 Tue, 04 Feb 2020 05:22:21 -0800 (PST)
MIME-Version: 1.0
References: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
In-Reply-To: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Feb 2020 13:22:05 +0000
X-Gmail-Original-Message-ID: <CAHk-=wiFMsSnjERZno13XbTF6m3pk2beAH5R-9RGct7hXzG3ig@mail.gmail.com>
Message-ID: <CAHk-=wiFMsSnjERZno13XbTF6m3pk2beAH5R-9RGct7hXzG3ig@mail.gmail.com>
Subject: Re: [GIT PULL] arch/microblaze patches for 5.6-rc1
To:     Michal Simek <monstr@monstr.eu>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 11:08 AM Michal Simek <monstr@monstr.eu> wrote:
>
> please pull the following patches to your tree.

Ugh. I only noticed after doing a couple of other pulls that you
*just* rebased or created most of the commits in here.

Why was this done? Why are you sending me stuff that was done minutes ago?

The merge window is not for doing development. It's for asking me to
merge stuff that was ready *before* the merge window.

I've pulled it and since it's just microblaze I'm not going to do the
work to reset and re-do the other pulls I've done, but if this happens
again and I notice in time, I will stop pulling from you.

Because no, this is not acceptable.

             Linus
