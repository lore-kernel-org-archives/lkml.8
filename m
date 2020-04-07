Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DDBC2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449E32072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl548G7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDGCDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:03:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40542 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGCDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:03:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so173934wmf.5;
        Mon, 06 Apr 2020 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4n/J3MD77MxiLHy8VOoOmdg1HtSTufB5sajCoCYZW70=;
        b=nl548G7AgQAC8gF8Hu9Icp4hSsVdQopBDujfjcJT8fZoRMkEsUV/BzMadfirav5bHO
         KDUb9tmeasOKkgmuSlHrtTxXO2eYQrMUMqJ6q9kvIfWxKXJfUkWWumdU2VXhiFU9/1aX
         lzDRSrHPwgUph+F55DGHmTse5owYCal3LHpamfHVgd1NZ5k43SjJpm8otHT3Sg0Olg9u
         AL+2cS5qAVCqdtkcElOAv/y9iQrzy8ta9MckwyGAuuuQNmll3Qx3N+RN21LSgchI6wJ8
         l08LlXK4Ru1hwzdjnxoesY4s1DQDFqkxxVuorGCQKy3tNbnn7VPvfROzQZ/dZ67jRi51
         1ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4n/J3MD77MxiLHy8VOoOmdg1HtSTufB5sajCoCYZW70=;
        b=hW2WpY2kzeO1VHXGIACeUeii2otQ6R23LuV6zx+RViNOKtWqDuVP8840JHwLjlOcy4
         bTPBxck6Bl1FB+gvGG/NJnmyiYXthZWaDUMT4ojWLJoaUYmgSmjRSQDgvDMw0joH0TkZ
         5+h7/AqjJ7RjTimWdf7IFPIUnHBWiERKeevm+qCeVPtwbkCmiX6RQ6kTb1872F7A0Xp1
         tISe1vbsLUaGlfmoNNSoo/DHmaqg5bubFB5oK8UlrV+Q4xe1cmzrgcdXrETGK7vLBwjv
         fYjrzbgLT0Fl33aCU//qyVL6K5KYP6KDXR0+cb+kczQe04TmvDNUGaD9AWbmNnNfmlt5
         BLqg==
X-Gm-Message-State: AGi0PubqVZBj7bmsPu65UC7WCRito9eeqoCTFMMOSblU9bqo05OcWScK
        A6odvX8DLg2MjJZy1hRyvwcQDhxwSYuEP9Em9MVqPY0E
X-Google-Smtp-Source: APiQypIVvYVwZrEB5vj9VltS3ujWER9Wp29x2h8ZX+yEUk7xkAhvwrmOoj24YEocGp6cZ8CKYYP8rbKDL/+Ls+AE8ao=
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr2100496wmf.166.1586224995132;
 Mon, 06 Apr 2020 19:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200331104532.12698-1-chunyan.zhang@unisoc.com> <158605608663.158626.7732167785990086489@swboyd.mtv.corp.google.com>
In-Reply-To: <158605608663.158626.7732167785990086489@swboyd.mtv.corp.google.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 7 Apr 2020 10:02:38 +0800
Message-ID: <CAAfSe-u1VNDiY0MXGwrUqsNLBiai8zivxoPiyLnkJMZ7hcX+Eg@mail.gmail.com>
Subject: Re: [PATCH] clk: sprd: don't gate uart console clock
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Apr 2020 at 11:08, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chunyan Zhang (2020-03-31 03:45:32)
> > Don't gate uart1_eb which provides console clock, gating that clock would
> > make serial stop working if serial driver didn't enable that explicitly.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
>
> Do you have a Fixes: tag?

I didn't leave a Fixed tag since that commit [1] will be merged into v5.7-rc1

[1] https://www.spinics.net/lists/linux-clk/msg46430.html
