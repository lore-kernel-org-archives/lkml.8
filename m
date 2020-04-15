Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA9C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC522076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hnpn48tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898323AbgDOSSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2898314AbgDOSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:18:06 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691EFC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:18:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x10so4893597oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+ZZFuyvAGx15OCpTEM+HGMe+mPfNmHZelQOeY0afag=;
        b=Hnpn48trJ+pEJ8Gx9gTZSqcZ3GMKFAtEaAlXmEU7pwY/+UiCYFa6o0Nwx3Z5vxgiww
         f8pCKPB05fXNtf2KHFSBYpqFuZTiQuW84ny4lr/1+B+M+6rhCvIB1LPlyceYAQ/2PEtF
         vF840W4pk5ViWkA8OR4YCd6C/2gU4NQwwyfNsR0EL+W2D2EM+mct9OeUjTZQrkzMMYwK
         dy0T8tlnpMs0T6t6DzYc2KmehVF9dwP7TReYgNVQc+fl1rlpbT2Rygxl/w28u8m3lwtQ
         aBCvqf0mCy17725htH120y2NarFxUy+u4p04kOXEkIb8zsGj2h5gBEOsm3E+s1r2lu7m
         IEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+ZZFuyvAGx15OCpTEM+HGMe+mPfNmHZelQOeY0afag=;
        b=A83SYyUW2w6jJtPd5leJTHOtiXrSweWecexzPC1XrwTHqErW3Zi1NNe/H3N35ZnENB
         uCvA0iEJi6dEW1iintKC7D1FTMYsvKfuTMSqdARsaYx9xL4g3xyVmiasTvII5SnawC1a
         R6D+d2biYCvKHk4E8E1vDnEODoW8TNndLwDzBlGQfAw47dlVqBqryORB58kueKOgRhLz
         Yerbh1YTuwGV0gh+H6FT+z4uTBnI79ldPAuybigG9R+bdTt60oBYNKMuXTcic3Xontpi
         G1mXcW1Gd0KoOPTl/WtxmGX5JSE6WZ2r+IwqzNau+0c5+XEcUhJwmNXIC2IHzNEgC/wG
         NgnA==
X-Gm-Message-State: AGi0PuZdho7xtSIVjZAfbVd1aBvOm6vmNBaGqDbudLTM2DYHBs+xFl9R
        R0t9phD0wYfLzEbAsMoasZlI+b64GThbcESLk0aSsA==
X-Google-Smtp-Source: APiQypL529Dw1VCTlBHpHz2I0B4lncn4v1muAbDXOCO0tuyCL5m+hlK6r9rHGBxY6Jsr3Efp00yl9suDRlZVdwmk5yc=
X-Received: by 2002:a54:481a:: with SMTP id j26mr391989oij.172.1586974685361;
 Wed, 15 Apr 2020 11:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200415150550.28156-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200415150550.28156-1-nsaenzjulienne@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 15 Apr 2020 11:17:29 -0700
Message-ID: <CAGETcx-=E-6sg=B2Rr+V51eCxiBjNWPnOvvq6K=o9Sr-qLDvOg@mail.gmail.com>
Subject: Re: [PATCH 0/4] of: property: fw_devlink misc fixes
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 8:06 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> As I'm interested in using this feature to fine-tune Raspberry Pi 4's

You've made my day! Finally another user outside of Android. :) If
this does improve the boot time, I'd be super interested to see the
numbers.

> device probe dependencies, I tried to get the board to boot with
> fw_devlink=on. As of today's linux-next the board won't boot with that
> option. I tried to address the underlying issues.

I'll review the patches. Apologies in advance if my explanations
aren't thorough. A bit swamped right now.

-Saravana
