Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DABCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7751A2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+iIMnPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgHKQ2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgHKQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:28:31 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD73C06174A;
        Tue, 11 Aug 2020 09:28:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so7514950ioe.5;
        Tue, 11 Aug 2020 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fDBgAgPJiItrD+6hSK0LsKDa6G5qUYNpvmWlJZ+livU=;
        b=N+iIMnPlY09KDPF80uxFVg9q5qi0Op37UIYUfkdnaMeGCiMjrrZ4tHCTcuzNNxrwzR
         3V/VPwI2eR4hmLHuKKMjY2kpNUUEbU8V3RHdZznaOsk6aX3lrKqRr8zITxA2ni6M+8sG
         2E+1bA+zg4s505luaZoV4ZVk2P93WWrYKLnqXoMRyzcVHPeZr4cPvyaWJfHoaM/Ft2O8
         gUALYMurj8G5TOz1F8NLgU/5rxauk2NC2xMZ7Ar8NgLzgozX8IB0hwghf3tPuEWBChYU
         8jnmsZA6WYNGFCURg+CSz0GGzxrX6rUwBouM8h6YCklfMFR2lxlOc2VqNAQtlp3qlKjQ
         bodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fDBgAgPJiItrD+6hSK0LsKDa6G5qUYNpvmWlJZ+livU=;
        b=NwIUAUQzux5dso0QM9YEpcZaJQtOy7o4YIj/29VmvYK13LIyXg1LMlw0vhYeY8dLcE
         2eyOLV85Sg6WChoQeK6PswQBvhXipyBp6PWtGG5yljaPn49Efia1KttGSdwurXO9VAyG
         X4x3KT2O1XdwYHxUrnwyxIoXYPVhWDsnoU0GMDPDwjMDvBPcJ2a8taF75JxFMF6sK4kE
         V138ywzHZQVL9DMVrbaOcbL3uhiV9SoNJ9dlabGdfTvAH2Ga+nifjsQ72mqCBFi2N/34
         yB/KbzvTPAZPSzU8W9vWx1NQHIQ188dH9YkGHEhFtfVasWhe+9WAfDq9Nrys81qlnrN5
         84hA==
X-Gm-Message-State: AOAM533u9Xfwh4C8L7+LIEaiwPtx66xD6cObHkzITU6kbaEkNYK581Z1
        JNr9xWxyhAFNOynBz8AcY18RIs+lq0OpUrL55E0=
X-Google-Smtp-Source: ABdhPJxPDsGN/z193Dj+JYK+zgSTaTVDuJhQzTatW+BLKzvOy14yqmwTp1Nt5Kj9ZHjnSF0WKTcsvU3Ag2QFMbeEcGc=
X-Received: by 2002:a05:6638:130d:: with SMTP id r13mr25905992jad.89.1597163310504;
 Tue, 11 Aug 2020 09:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54@eucas1p2.samsung.com>
 <20200811112507.24418-1-s.nawrocki@samsung.com> <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
 <20200811162358.GA7169@kozik-lap>
In-Reply-To: <20200811162358.GA7169@kozik-lap>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Tue, 11 Aug 2020 18:28:18 +0200
Message-ID: <CA+Ln22Es+Mtokw91wzUaoWC2yCQHRJDEvW6=U1Rbt2H7PbDOeA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the
 PLL set_rate ops
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=E5=B9=B48=E6=9C=8811=E6=97=A5(=E7=81=AB) 18:24 Krzysztof Kozlowski <kr=
zk@kernel.org>:
>
> On Tue, Aug 11, 2020 at 02:59:07PM +0200, Tomasz Figa wrote:
> > Hi Sylwester,
> >
> > 2020=E5=B9=B48=E6=9C=8811=E6=97=A5(=E7=81=AB) 13:25 Sylwester Nawrocki =
<s.nawrocki@samsung.com>:
> > >
> > > In the .set_rate callback for some PLLs there is a loop polling state
> > > of the PLL lock bit and it may become an endless loop when something
> > > goes wrong with the PLL. For some PLLs there is already (a duplicated=
)
> > > code for polling with timeout. This patch replaces that code with
> > > the readl_relaxed_poll_timeout_atomic() macro and moves it to a commo=
n
> > > helper function, which is then used for all the PLLs. The downside
> > > of switching to the common macro is that we drop the cpu_relax() call=
.
> >
> > Tbh. I'm not sure what effect was exactly expected from cpu_relax() in
> > the functions which already had timeout handling. Could someone shed
> > some light on this?
>
> For us, it should not matter much, except:
> 1. when on A9 with ARM_ERRATA_754327, but we do not enable it on our
>    platforms,
> 2. it is a generic pattern for busy loops.
>
> On other architectures it could mean something (e.g. yield to other
> hyper-threading CPU).

Okay, thanks for confirming that it doesn't matter for us.

Now, I wonder if the readx_poll_*() helpers are supposed to take all
of those into account or on systems which would benefit from such
operations, it would be the caller's responsibility.

Best regards,
Tomasz
