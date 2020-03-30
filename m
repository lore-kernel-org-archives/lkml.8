Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69836C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2FD206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585605798;
	bh=J+BQH4zDxPwVnwLMbgKfxndmOXXPBuy9LYtIMiVYFeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jCs9JehQLAhHrGhJojRwlPMQ4Rzjzq5xuYivjIbKgrQJV5K3S3MYynxHimv1kUmVg
	 y5ohOp3wpABPDTclIEzlvLHobaFrS23IhIGZZoq+i4i2hL74UHZOgHvXDYEd8koOvU
	 99Ar+kkfEajRZmEW/pf4BOm5ByGvl9FEV1tMBTk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgC3WDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:03:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36378 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730818AbgC3WDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:03:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id g12so19905533ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UILNYd+wc5Om9SHaEy7I98AnjGolTLk1pejQ9jaM4to=;
        b=LeIM44GHtM/UuFN4/dDoAV3aDlgJx2PnG5YEVkgJmb/EybPWc/vPEYo4iKZWbh6s9l
         tzm9q6jzXp7LXcyTBI/JzL++naZV53lAsuvAWwsjJS/VDGmT4TtW57UPt9My1GoJFUjo
         ZzGvmq/4diqXEOt4uIZb2kx8MvrrQkYyiZtQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UILNYd+wc5Om9SHaEy7I98AnjGolTLk1pejQ9jaM4to=;
        b=muoXuotbBBbCh1ws6uOybC9QWSs519/2+9ogJsEmYnYLj8Y3HFcHPUUm6FUTVzl2Qm
         OTniTmJvtNYsJTLb+W5sqO9kVeeF/g+N42wj/XRSd9XOIIxoThcJSnlCPJiYbQqc27bp
         G16eL6qR4DpC6r4vnNJZJqOyse35fAnaxWaOF0S8YWKe4jDs8fIAXSIlqORU9TguDz42
         2ejzPhsmwdRORV0h3FSvsWzKu5uJWcg5hcjVactUUeVsfVq7GRzs1UP8IYxHEeT7R+UJ
         FQWrR5gZgFvFQOtD3Bk7Bmu/CKC88bYyQajklhVWhgNSpPLgWDnHpxUg3O1CuMVaaPZJ
         +u/A==
X-Gm-Message-State: AGi0PuZ9vQxkJ88Q1PER74Qx9aYV54MMyNQ3dmM+zB1N11wbgkNFxJ67
        W7TkXaHgdGXEyTFd8UCEC1OuCRVhBXA=
X-Google-Smtp-Source: APiQypLi7z3WTxmoeOO2QPUIIhV2YfOstvIL4df5V+0uDmnqQzJCLDEUHdbfPGzOGTUvmxGLVUpplA==
X-Received: by 2002:a2e:b8c1:: with SMTP id s1mr8672182ljp.0.1585605794851;
        Mon, 30 Mar 2020 15:03:14 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k4sm4851172lfo.47.2020.03.30.15.03.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 15:03:13 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h6so9805318lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:03:13 -0700 (PDT)
X-Received: by 2002:ac2:46d3:: with SMTP id p19mr3516628lfo.125.1585605792996;
 Mon, 30 Mar 2020 15:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200330123732.GH4792@sirena.org.uk>
In-Reply-To: <20200330123732.GH4792@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Mar 2020 15:02:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS7BSueNOs=GZ0Eic-3jfpBHbt9Bm5Rk0BYVFRVLyTEQ@mail.gmail.com>
Message-ID: <CAHk-=wiS7BSueNOs=GZ0Eic-3jfpBHbt9Bm5Rk0BYVFRVLyTEQ@mail.gmail.com>
Subject: Re: [GIT PULL] regulator and spi updates for v5.7
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 5:37 AM Mark Brown <broonie@kernel.org> wrote:
>
> At one point in the release cycle I managed to fat finger things and
> apply some SPI fixes onto a regulator branch and merge that into the
> SPI tree, then pull in a change shared with the MTD tree moving the
> Mediatek quadspi driver over to become the Mediatek spi-nor driver in
> the SPI tree.
>
> This has made a mess which I only just noticed while preparing this
> and I can't see a sensible way to unpick things due to other
> subsequent merge commits especially the pull from MTD so it looks like
> the most sensible thing to do is give up and combine the two pull
> requests.
>
> I hope this is OK. Sorry about this, I've changed some bits of
> workflow which should hopefully help me spot such issues earlier in
> future.

No problem - and thanks for the explanation. These things happen,

          Linus
