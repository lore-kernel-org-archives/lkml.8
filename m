Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E946C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5373D22314
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsrlKaUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbgAMBpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 20:45:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38861 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgAMBpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 20:45:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so6972723wrh.5;
        Sun, 12 Jan 2020 17:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znJUBdsKtgEwaqOljiJ5EK/1WMSAL9tXrpMQjheFjHs=;
        b=IsrlKaUQ30FPFeUfmzEnivEsohh548kKdNxG4LU2anUO1HksC6D6K7pmSZokMFC6gK
         GQR+Dab0mjjrscxb+RNcIBhpJavvfoopbcEUaMAB95TcFeWpUfdkRWCzCDl/7KAbNAVe
         /BhdzEAPGIf2FDVLo5YDNnEfDGHFaPfKMFj+wWWyy0zzQGSRnSChbVKX7YL8tXYbu1EU
         3iIqcwh87j5OOysOcs1KGKKxMIFH/ieTF9i1cTrut1D1pQP5mGBujavxP2pxWxUmz8e8
         kqEyOelKx/8Bubzn3mqh0BXnCH4FAJ5GVi72+Wce+nRiP93wd0NDsxWjbf6E7bGZq4SM
         Iz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znJUBdsKtgEwaqOljiJ5EK/1WMSAL9tXrpMQjheFjHs=;
        b=G5lqQbRal07wqiKjCh8IVvzBD//sRiLyBk/bQWVFKrl9xkVrm/FETNuBzv+tf5fWAc
         x1mPujQDzTOHATsJU5bgZJyzpUYo4Y5Gm6Vuv5O6oHWjKiTmrSqbz3f7W/Hq6Y5fIEot
         9QEyTHO4hxEvOXnPwdeOVZSGBf64R9xOq6HJzxgcT7Jd6sPfbgXaopdTKtwcS2fQTqB2
         KNgOgfsh7bj3Z8npCz5CjDq5jo2fVFeTaPd10uixFQdbIt/6KP6ib57UM2Ur44k8Vori
         w4G1PVyV/nCjI0bt/UhAhABQUpuFZjkZNJZTkid+IFanKfsJKFP2aWDek9I/NcOaizWo
         3vXQ==
X-Gm-Message-State: APjAAAUPkDyLzl6EaQi9LDWz9W5LnG2SMyPjccjaPMwATUbzFnzyIcMR
        G8GjCrXuoRnXV7XeUEInHzH1gkKv/AxlIn2fgRM=
X-Google-Smtp-Source: APXvYqxEkdvBQ9aEz55XkTJia5J/yxixfzNCbd2z1PzezHPGyfdv+shkuWFIdWmXEf6iRgjHh6jgGG5kuQj4cy2uKzM=
X-Received: by 2002:a5d:6748:: with SMTP id l8mr15805825wrw.188.1578879898836;
 Sun, 12 Jan 2020 17:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20200110063755.19804-1-zhang.lyra@gmail.com> <20200110063755.19804-3-zhang.lyra@gmail.com>
 <CAOesGMjNkVpTOhSrLUKjNZnKFk55DTgg29QzVBEFVh3Z=Ra+cQ@mail.gmail.com>
In-Reply-To: <CAOesGMjNkVpTOhSrLUKjNZnKFk55DTgg29QzVBEFVh3Z=Ra+cQ@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 13 Jan 2020 09:44:21 +0800
Message-ID: <CAAfSe-tx+S_tc1y0c5wobQy2xygNr01b3LOqQ4FQtHoDNhHNeA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: Add Unisoc's SC9863A SoC support
To:     Olof Johansson <olof@lixom.net>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2020 at 01:41, Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Thu, Jan 9, 2020 at 10:38 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Add basic DT to support Unisoc's SC9863A, with this patch,
> > the board sp9863a-1h10 can run into console.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> You reposting a patch that we have already applied, and there's also
> no changelog for it in the description.

Oh, I have to explain a bit.

I was expecting an email which inform me that the patch was got merged.
That's the reason I resent this patchset.

About the changelog, this new patchset actually had a cover-letter[1]
in which I documented a little changes (which was not important now).

Thanks for your help,
Chunyan

[1] https://lkml.org/lkml/2020/1/10/36
>
> If you need to change the contents to fix something, you need to send
> a patch for the delta by now, with the usual expectations of
> explaining why the fix is needed, etc.
>
>
> Thanks,
>
> -Olof
