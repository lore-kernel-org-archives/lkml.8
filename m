Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A273C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F19206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593022561;
	bh=DZ8KG/92LEfWNZur+8/Hla22ClO1oDV7z5b9x0whPJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UQjmGvNXtf6ZvB72lqdWl6NP9e3GyRO26w4H/DDu1Goxaid8TVw3a9g7BR1LKWr5m
	 57tjGFGj8t+blN+4imzjIoy8+nazGRMUCuU1MURJ0PPkRPnCpznIayqAQRNffuJvmZ
	 HzPtiKhsCuM/dA2fgESL43Jhh3VRPwOyxF/60pDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406015AbgFXSP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406007AbgFXSP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:15:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F58C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:15:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c11so1783601lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkMPqFGg3Z9t3pKSW7EQdgR0p5ZS5h1HQ2kcYfNc4oY=;
        b=I4oYR4UFlrSkS+lsSplS1Wen1OyhGJ+Bm39JW32/eY0EXQdEn6PwTVYQ8ooareybhe
         CRMemJO1LvwuBzfIU1d38zDYPuiGpr0giXIyWx7kAEQi3yTvWtxgbIsunEjMLWpnhYgm
         DEgAt2QR2CcMBG818IO+fdcDgWT2/wW9NEcZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkMPqFGg3Z9t3pKSW7EQdgR0p5ZS5h1HQ2kcYfNc4oY=;
        b=VyhTLvQDb2mWf1O7NOgDTOB7TlqRIk7s0L4vDh25g5kKQkQ4nnvI4UQ7XGKdJNnSd5
         y+XjDgYqITM3Dba1edD+nmLfLJw1nuCsB0tmNbxni7e7wg3lwLtuY9aoNzvKNVCv6Omv
         BaYalckTj9aNhilfbFPI7/JuxrWW25jO5JmxOk1IzwGzdH/ooE/KDRKY+UJq4YkMN1m/
         fi7WiuofXReZeI1HLafhNwjzIYspjO3DPKLAW2uzAxCxaR6DRZEnANtC3pdkSs9aYz8R
         45j3aPPkKiECZFmdQVKbjldNI1ti1NwdMw1+2O+nJ5Vfy5sUPXbPN9LoV9NpgfGMahEc
         nuVg==
X-Gm-Message-State: AOAM531kGPCZU4/x0IJ5/FZDiUim0mBYKYzZzoiTh0Dp9RPvaQ4+RsVT
        mIdOy1beYPdXCwt+iIBjMP+MkwSOeDY=
X-Google-Smtp-Source: ABdhPJyUf9BrWwzXP898vqyQDKi8x1w85HdJzESFEQhoFmQNkxpPx7n6i0fUaGk9CqomKSUFIXjXDQ==
X-Received: by 2002:a19:c15:: with SMTP id 21mr12278702lfm.205.1593022553246;
        Wed, 24 Jun 2020 11:15:53 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q14sm4334105ljj.110.2020.06.24.11.15.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 11:15:52 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id s9so3594846ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:15:52 -0700 (PDT)
X-Received: by 2002:a2e:9209:: with SMTP id k9mr4921683ljg.421.1593022551983;
 Wed, 24 Jun 2020 11:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 11:15:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGNzGz=Pv5UZMWuTxg=3KbLBBPPQ2T7k+295UebgKJAg@mail.gmail.com>
Message-ID: <CAHk-=wiGNzGz=Pv5UZMWuTxg=3KbLBBPPQ2T7k+295UebgKJAg@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So in *those* cases, we'd basically just do "oh, ok, we are supposed
> to use a kernel pointer" based on the setfs value.

The important part here si that we don't need to change any
interfaces, because we don't add that whole "carry the bit around with
the pointer".

I agree that that would be the nice clean interface _if_ we intended
for this to be something we care about. But we already _have_ that
interface in the "iter" code, I absolutely do not think we should
create a new one.

So that's why the (admittedly hacky) "just support the old model for
special cases" kind of approach. Make it really easy to convert some
very specific individual places that might care, and make it very
obvious what those places are.

Maybe in a year or two, there's only a couple such places, and we can
see if we can clean those up separately. But make it easy do the
transition to the new model by _not_ changing the basic logic for now.

See what I'm aiming for?

In particular, for architectures that haven't been modified, this
results in zero changes what-so-ever.

            Linus
