Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2D0C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6A024676
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581536322;
	bh=bZ497GYT+ndCYLdpdwqFuwrp/rBBGcXi1SH7Zwj3UIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fo59mpHm1TLDu3Jw9k2HfawgXx946E/rWmsOOa8fMzIXjFWe9XLzhHEWeEvY3Ulc5
	 KkGz/NwcdyOA5k0U+5jdC1K6KUBU9bzoCk6Spcphh1wi3lCAGmSKpTFimRjaaQYRpv
	 owMfSeM7cav9WML+ColILr0DlPV52ZpDqeDVBlo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgBLTil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:38:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47095 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgBLTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:38:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id z26so2420169lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VIVJ6ANZNwBCwjgFThVMTCailc9/69GGrp4L4rWNwm4=;
        b=hdHh1wCknTiwBSThElO35g/BIz9H/CXTPpcMPEmkD7NNxb1ozOciv/jVLwmHAP9+xH
         SE22Kf5VT7lrVTGDE6xKzIb7CnH8V5I894iDrLLlIPUmUHSvXb1WnFbkAngWq15Gx57/
         9dgUML7Oux8tp2Z0WsoLZEhj9ZVcf6LEbzN6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIVJ6ANZNwBCwjgFThVMTCailc9/69GGrp4L4rWNwm4=;
        b=fSkArxRAQq0Uyl7lIsl/8A4mfmCB1DFztEqmeKyGnm7njhlwvdQ/7FaWNEUBMkXuOd
         Pnwb0WrQwSwfw/cM4waObHq3wyC1c4xDivVVu1Nd/q30tS6q2PCJjoOQQ7VvhmjVurRo
         nwGDrWlfU1xiT9VzVSYDRYC+ZVyaRAdrImiBpKqEai8f2jQoMiKbkITtN33Cn6+FRkC9
         UTy0cobt4H/FzlIN1c1dBH8+DFZC/feEbRGu+Ah2F4kqnBqM0X6JtgFLR3oBINlw/ke9
         +3Iw/vqQkuQKeAdZwx94BU7P+1ufnrcWgYTATelR74sL9mozWWDioqCwu2yzVPBUySIF
         xqqA==
X-Gm-Message-State: APjAAAWkgnumpEWQN4YgalaKsSmPXfTi78PkpfdB3Wr2pXTLKYD0cd0o
        lbpze+paNsLzM+O/zhkkyMaZo6MJTdg=
X-Google-Smtp-Source: APXvYqyzL81bD7Q4OrxUcBVOqe/xNg2s3jHkRHwS5HWgL3U4NRMSfiCTI+HthBxBpjaTaxSvSHzZ7g==
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr7559227lfq.176.1581536317657;
        Wed, 12 Feb 2020 11:38:37 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e17sm54990ljg.101.2020.02.12.11.38.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 11:38:36 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id z26so2420094lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:38:36 -0800 (PST)
X-Received: by 2002:a19:4849:: with SMTP id v70mr7590327lfa.30.1581536316181;
 Wed, 12 Feb 2020 11:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20200212164714.7733-1-pbonzini@redhat.com> <CAHk-=wh6KEgPz_7TFqSgg3T29SrCBU+h64t=BWyCKwJOrk3RLQ@mail.gmail.com>
 <b90a886e-b320-43d3-b2b6-7032aac57abe@redhat.com>
In-Reply-To: <b90a886e-b320-43d3-b2b6-7032aac57abe@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 11:38:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8eYt9b8SrP0+L=obHWKU0=vXj8BxBNZ3DYd=6wZTKqw@mail.gmail.com>
Message-ID: <CAHk-=wh8eYt9b8SrP0+L=obHWKU0=vXj8BxBNZ3DYd=6wZTKqw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc2
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> > So this clearly never even got a _whiff_ of build-testing.
>
> Oh come on.

Seriously - if you don't even _look_ at the warnings the build
generates, then it hasn't been build-tested.

I don't want to hear "Oh come on". I'm 100% serious.

Build-testing is not just "building". It's the "testing" of the build
too. You clearly never did _any_ testing of the build, since the build
had huge warnings.

Without the checking of the result, "build-testing" is just
"building", and completely irrelevant.

If you have problems seeing the warnings, add a "-Werror" to your scripts.

I do not want to see a _single_ warning in the kernel build. Yes, we
have one in the samples code, and even that annoys the hell out of me.

And exactly because we don't have any warnings in the default build,
it should be really really easy to check for new ones - it's not like
you have to wade through pages of warnings to see if any of them are
your new ones.

So no "Oh come on". You did *zero* testing of this crap, and you need
to own that fact instead of making excuses about it.

                   Linus
