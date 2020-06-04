Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B158C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C91B2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdaSh4Tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgFDQXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgFDQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:23:12 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9A8C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 09:23:12 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id g3so6616024ilq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/GRXkiutQ0OiMBz/RDf/VErChPNVnMHFHfioHFyETw=;
        b=VdaSh4TffgpMA22mnujk+jfEP9ISHVNNmKYoHTDHZjOYV9dkuA6O8hcaYaRAQt2Dwn
         n3bEn0gpLoOO64aRDk19rC2g5dDxkBGA+YtzmCN3HWyyK5cRl53nOB+1rIAA+X86OZFz
         wgLWDODj1HuoZTrOFidSdu3/MSBPaocv/mnV7UuhWLREHXjGGF1d0hUFgIcn+XvyEkR7
         eKWYCclOtQMHG9oFEcEzJjuI37WFgVdVIWpSuraW034yLL9n2hugtahUIxblLG675MzG
         pGfsVTH2NHLAkPYaW2TLCxW7ZRTRBV1TFPkqXRtXkh77FOjUPWM6Y+hLpSO/kPxCMT+1
         HWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/GRXkiutQ0OiMBz/RDf/VErChPNVnMHFHfioHFyETw=;
        b=WEhAKjJGa6ArhD/cQPvtjVUClzYZVWrB+JmbXDnwjJSXdxM+H4lxHwEaOzPHxKsBxg
         4PSnftjpjP5Qj5n6OWaQSIk3ckJgVgR+r31Ly34EBUXJP56qloJY3zGNPTl7iNjptOkJ
         5tTOtP4GYNWHGeMd1GaH2z+vj/VRCwvWr4d5bWe54LPLA8kAwB2wNwntYD386bY+CZw/
         bqf221JbHvoIDc0xVze0fqag9/Qap0xk3nBzY3PFcpclsF001iCgoSaDgxs+Ip3sTW9p
         /SLHyRdpKsjFzKL/aXpwQswLfiEjXgBdUEOJ4Ab5J/xEU3vEjg/2xa/eFKQ45gomG0oV
         HTzg==
X-Gm-Message-State: AOAM533m0UcNTpH0oT3pgnmKnp94td56qLMMzVlCEtE/cmZTwIhBlgrm
        MxNYQT/yTEUrGPLn1ZkRpNcLdvoYwB2CUDIxk8bSO31Zupc=
X-Google-Smtp-Source: ABdhPJwRIle7DTqSdHm9ye9kZyCUQC5nRCg5793eo+4tSVcfiLbB9sQMEQBVf+pKMyeDaTgXCOiWtoQQTM3gR1AcbaY=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr4584771iln.90.1591287791978;
 Thu, 04 Jun 2020 09:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
 <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
 <CAOkhzLV+suVNAoyiaHKOkbwP-KKgTLEa7S8kp8+GSTLm_-wWFw@mail.gmail.com>
 <CAKb7UvgWMsLSHCayzdY7UYMVTjN3OHbH2WhKd-BP46K=r4Ra8A@mail.gmail.com>
 <CAOkhzLXZVNdpgwV=iiO0TEvLp3Hx28Zk8iYzwy5BvJ1pWi4QxQ@mail.gmail.com> <CAKb7UviB22HxSJ6j4ts=fU=J24Hh69NCBw4uHC5vsi902Pp6bA@mail.gmail.com>
In-Reply-To: <CAKb7UviB22HxSJ6j4ts=fU=J24Hh69NCBw4uHC5vsi902Pp6bA@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Thu, 4 Jun 2020 18:23:00 +0200
Message-ID: <CAOkhzLV3zpzh4dKOxYUT6a_-kQQyxBxexY0MML4t4LZLK8dOpw@mail.gmail.com>
Subject: Re: [Nouveau] NVIDIA GP107 (137000a1) - acr: failed to load firmware
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 6:13 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:

> Not sure why you bother asking questions when you're just going to
> dump nouveau anyways. This is the second time I've answered your
> questions on this very topic, I think it'll be the last too.

Actually, what I will try next is emerging
"x11-drivers/xf86-video-nouveau" Version-1.0.15-r1. It that works for
Nvidia, I guess it will also work for Nouveau. ;)

I would have preferred to have it all in the Kernel but that does not
seem possible.

Best
Zeno
