Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E75C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F206E20674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtbCGYT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgA3QnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:43:15 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39314 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgA3QnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:43:14 -0500
Received: by mail-yb1-f195.google.com with SMTP id x18so1661215ybk.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 08:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAkoTJZXXC8pAie0MxZm+ns3OGuUhEoZUpXun7fS/so=;
        b=dtbCGYT0MciH9KjQUXOaMT+fL/nydck89BQMu27zg4gJSTrGPVCs95wVvzzLf1UG/B
         qk3t3k6OoM2clcb5ir9ftv2s3FR4nk9Y6fKs1OwUSgla8H60aeVczEOWcujPUX4Jy1E8
         SNuVaiY2MeeT5SkC5OTh+0ywWY0A9cMFMe0WxSHhTXV29i+tWexYB976nGHzYxzdkLor
         DeyAzN+PEOXSBbsWQF9sPCbs7F+0OUdTzhwYMmQYZAOLA2dRkrUsHssiIyJPRw73wLW3
         bd4jlaF39MTiNxdObDEIIAzx/j/Mo0DN9piWpXFjZkoHCLTZVp397qx5qbnr8+d3lRct
         IoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAkoTJZXXC8pAie0MxZm+ns3OGuUhEoZUpXun7fS/so=;
        b=NZn8Eb9uGjiJ4PnWJGcO9usMTTV6XDl/FrdZragARUz6m3LQ698jLWyeySN7zlA1wQ
         WC80TLLsIkJnqGMplmtFcb1WjJf2jgEOAIXDd5LErS6LwhIC1wxZ60oQ2sx8O6WkdyUP
         HgYLwQhBXxmkYcZkkbaSZqXyfAP0al54E51dEsSaqppZ9GCOS0YmQp7/PRPrM/fw/d4w
         3RhjiLM3WnNarATo5/ga7ED0RYIJZC/d9QyZCcd0CI6zHrnPMbzBwlO5kAnHOQT079yc
         /X8CgEz/4idgWFjAjlu0NLelVUN+a1dEhThmcOXHRGFna2u0f0J8WsZv5H/ht76x3buz
         0zbA==
X-Gm-Message-State: APjAAAUifHTQ0Lf6JeVqz3Q1bbVVlcimsUwpkIFe2y0HOnS3F2pgntjV
        Sbz++ipwbKISCEVtMPfmY8p3O1G7IwFDUXECUmfrPQ==
X-Google-Smtp-Source: APXvYqz7cFNhADLChzqRrZwg9cGy/NYutjxxN098GFg13g0Zji9npPS6Idi0XmbWJnvU81vfR4Z/2+GdXfpFdj/Gv2U=
X-Received: by 2002:a05:6902:6c4:: with SMTP id m4mr5008083ybt.274.1580402593410;
 Thu, 30 Jan 2020 08:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20191030184844.84219-1-edumazet@google.com> <CAMuHMdVK=dUxhJh1pjLe4bGn3V=FHJ_90oga0USRBw-wSqd8Pw@mail.gmail.com>
 <20200130162740.GA6429@lst.de>
In-Reply-To: <20200130162740.GA6429@lst.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 30 Jan 2020 08:43:02 -0800
Message-ID: <CANn89iJW24mUW9TGt8D9jHRdvd31Czf8S7XEU1_kJBThZiTwSg@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: increase HASH_SIZE
To:     Christoph Hellwig <hch@lst.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 8:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Dec 10, 2019 at 03:55:08PM +0100, Geert Uytterhoeven wrote:

>
> Can someone just send a patch to switch this to a dynamic allocation?

Yes I can do that, thanks for the reminder.
