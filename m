Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FDDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC80207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590104484;
	bh=gueUxUmteEBhiEGg3TCDYKV+odG/TiexNiaL3q9Zszk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xVGf7cR66KFPD9Cod/IoiYGEYMEKLjDL7Y05lJGkJoqR4rt7XAOuSu39n+gSyTJZG
	 fBSVGE2a9dgs1dzUJAxfaaLFZXJwcyx/Hc+YqPtUiSLVNdXC6P8Job0/8GLoQdLMmZ
	 T8Xk/jGnXrWghvcupVGZCFc2aBtIx73rNjTboOhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgEUXlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgEUXlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:41:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E1C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:41:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m12so8047741ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rv+8dH0+h1qIgzONLiMgmbsnvlKVpQ/a5eVu0/0RsXM=;
        b=SUoy772rygPiyim9PFx6selqBY2GKZ7srh+XBdkJ5wUscHmEPW0UH9A6DuNDOOLH1U
         undzMTxv1/nE9988qpMGfhHMesPnrEDErZDU9ekEe9eQIcNu/3tEJ2ToU/M1Np94/fif
         /vwcjo8KCEY8GEaT2zkJdoPZsMCMmof3VsZUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rv+8dH0+h1qIgzONLiMgmbsnvlKVpQ/a5eVu0/0RsXM=;
        b=Gphtylz2iNLDOXKtMxnwwAza4Z3ShiJ/ZbMjDnLYrf66sHSzEQiySAkOPehypBM9ag
         aWK6OKRn0am9peHZTiYu7IyRcWET0WCdTVPs9GDK7w3fAvAG/smABDeoTVoWSZghxgZM
         cQpH3DzKnDFTNwfm+Nwi4vB/LhpXDXvuIrQmohJo5x2RG4yJWqCHmdxBlpyqGfhxgCfo
         XL6cZLEX0JLxP3n/okBPcnGGJDG1d69ftBADuRtgmXhZH8p7h92zTRJb3K2xX82Pwzlv
         FE1iOIrUpvE6mlD8HX1Q5erMncqImzxVU3/7yZBTJmJkeWyPK9YWcNzgun3wNcFP1X/p
         DUTA==
X-Gm-Message-State: AOAM5319jwiMMrfBOexnf5pAoTKsqdRXgf/tj2FOWAVZUOVyFsowi4Vu
        5YRcYOTqxMUKIq9zdSW+/AY6hjKIpns=
X-Google-Smtp-Source: ABdhPJzq/38Ej+2hNV0mkr0tR1ds7LXPtlRYGlFZ09RQ3EmhYKnKq3bgW2UEHSGX/eTNb210gQSwSw==
X-Received: by 2002:a2e:a201:: with SMTP id h1mr4155323ljm.294.1590104479475;
        Thu, 21 May 2020 16:41:19 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id q4sm2056166lfm.93.2020.05.21.16.41.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 16:41:18 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id b6so10472619ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:41:17 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr3919937ljo.371.1590104477569;
 Thu, 21 May 2020 16:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200521122034.2254-1-namjae.jeon@samsung.com>
 <CGME20200521173209epcas1p29a26d78a46e473308553c6b3a6d0ce83@epcas1p2.samsung.com>
 <20200521173201.GG23230@ZenIV.linux.org.uk> <004101d62fc7$7b2e5640$718b02c0$@samsung.com>
In-Reply-To: <004101d62fc7$7b2e5640$718b02c0$@samsung.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 May 2020 16:41:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3ZkjV4h0qkVASJNLmv8GSB8WWPW_E-OgMYr5f1fNjSw@mail.gmail.com>
Message-ID: <CAHk-=wh3ZkjV4h0qkVASJNLmv8GSB8WWPW_E-OgMYr5f1fNjSw@mail.gmail.com>
Subject: Re: [PATCH] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 4:28 PM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> I would really appreciate if Linus apply it directly to mainline.

v3 applied. Thanks,

               Linus
