Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD00C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B192086A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tfz-net.20150623.gappssmtp.com header.i=@tfz-net.20150623.gappssmtp.com header.b="o9F59WuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgHVUxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgHVUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:53:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410A7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:53:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so4889095wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clh+fL1VRaAXvS7YPj75sxOdd6h5p+Cc2IiViY3r6sw=;
        b=o9F59WuZdNDmx5QsBTy7KpMnsvdroC0zSVfzYTHIzall8m0Ei9+MIncUySVYglsOOw
         ZURRs+MstyOjREksAjD6v9W/KF2mgN+EXOVtrRP1GT4aqHo5z+YpQtzdnlHTZVDG5sIP
         qThvmWqpuPpMY3Czodue0yUYpbaIj52FVGaI/PRY4eKq9JJZv5zXHKP0mklc+R/cMakU
         iNLskVDEPxC6whnJb4CZ0wDh67aNsDSKbQhDbiNyzk+syvqX/TbL0WV/8mZKe1EbnB7A
         4UanKTPVZ//IjNn+K+8hxbwVuoPnOvk1n+dG+o3Jh0V8zm8yzkA/5D8cDn2mTMZTPkwq
         w5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clh+fL1VRaAXvS7YPj75sxOdd6h5p+Cc2IiViY3r6sw=;
        b=UDak9uPktsor2hYApiw9ECcowUO1YGKphAqh+3lKlvQWxpCZ5wa5E+VRiHgq+B/kyS
         XdfiLk1Xmj7uWpgjosRj1/Tilxa/gmp+ub8y0N34hWNNRMwX6ECYyDvGdxhZtbYmTgYc
         wQcBY1KlY+ynBMaVVbEiBnMng8pX7rgvVmSt2Cxh/aC/+IwkkSSqUUPNtJdLedBTbF3s
         tO4B94EJgwWQ895Lf96jsRXdCVMe9sOQyOr0/YbsP/ugix3f9VlYi/7gCjQtaRy22nVS
         S6G6DghahNhEKok5jPQk5uh13Ah/lBxXhPvMZ/fvHQjpK7N7QGnpq44+mApSKzCBm5Qb
         cP/w==
X-Gm-Message-State: AOAM531Oyx56Ah58ftuUftBtAI+xNUlqIfcBfKwQgfCUclnUsehHvNst
        JN9vYp3xCfJNh54/dB06DCMe7ELXL4Fhy9Rl4u4E3A==
X-Google-Smtp-Source: ABdhPJxGqq6utU8WqyfsZRBRrqDRcWC5FsWAIIX2J53U6LHls3YyZw7V8x8SbvK3eDFeVayMc9q9UJvF/bVFc5pN+so=
X-Received: by 2002:a7b:c308:: with SMTP id k8mr9402961wmj.90.1598129594749;
 Sat, 22 Aug 2020 13:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200815182344.7469-1-kalou@tfz.net> <20200822032827.6386-1-kalou@tfz.net>
 <20200822032827.6386-2-kalou@tfz.net> <20200822.123650.1479943925913245500.davem@davemloft.net>
 <CAGbU3_nRMbe8Syo3OHw6B4LXUheGiXXcLcaEQe0EAFTAB7xgng@mail.gmail.com> <CAGbU3_=ZywUOP1CKNQ6=P99SgX28_0iXSs81yP=vGFKv7JyMcQ@mail.gmail.com>
In-Reply-To: <CAGbU3_=ZywUOP1CKNQ6=P99SgX28_0iXSs81yP=vGFKv7JyMcQ@mail.gmail.com>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Sat, 22 Aug 2020 13:53:03 -0700
Message-ID: <CAGbU3_krnjbeKnm6Zyn-tqYCHVZFBkB+oCP-UF_kVOGz=zkKFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: socket: implement SO_DESCRIPTION
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 1:19 PM Pascal Bouchareine <kalou@tfz.net> wrote:
>
> On Sat, Aug 22, 2020 at 12:59 PM Pascal Bouchareine <kalou@tfz.net> wrote:
>
> > Would it make sense to also make UDIAG_SHOW_NAME use sk_description?
> > (And keep the existing change - setsockopt + show_fd_info via
> > /proc/.../fdinfo/..)
>
>
> Ah,very wrong example - to be more precise, I suppose that'd be adding
> a couple idiag_ext for sk_description and pid if possible instead

About the pid part -
On top of multiple pids to scan for a given socket, there's also the
security provided by /proc - I'm not sure what inet_diag does for that
So maybe users calling it will need to scan /proc for a long time anyway...

Or is that doable?
