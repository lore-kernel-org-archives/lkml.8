Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F965C47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E93721775
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589072303;
	bh=xElFffTe1uvvpbUq7F0EyMi+sB7dx2cZ9bOB8OErMQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xcnr5PXm4d4UVuhLvLl7qTV96MCL1OFCyyopfGRteLWY8/VIjeavbF2weySxmfG8K
	 KY/guYfAoea2f7BBKJVxyljpGlXnXgY9BDS0ZMzLjgvLMuaIyk324eR1hC8c4XffXc
	 giJ+sOEDY4gCZhz6nyWqq8iNUeD3hIUvwEebMk04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEJA6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 20:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEJA6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:58:17 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7DC05BD09
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 17:58:15 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 8so1748767lfp.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkZLcTT9RBY1m/QfLNMtrzusV0je4e07ARSIXoWJWAs=;
        b=d/2jdVrvgvUG1UThwodilkmvnh6my87EM5v+b/nlwmeKZnUZXYHkZAIUuMw3tlQv+1
         q/ha6tP9/sPPm8KxNNtA2UNJcsiCwaT0kATyI1wURIHH2V5stXNXYcwwkUyQkiH3EkZG
         c464fO9/sbq6hmzNqCDH3RO5ythUdJ6Kr0pe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkZLcTT9RBY1m/QfLNMtrzusV0je4e07ARSIXoWJWAs=;
        b=kAPKR8+36m1eBMwEonMafUpaQarV5V46XUZ3AduKCvFm7Yx+WLHI3BdyAuhNu6lN3t
         28wZbfugq5h2oR2HBk8/GEhjSro9wFFf+lIWY6LSObrnKzbryVCRdFAn8Ytl9ZA9MEC9
         eLit8t/QVlHVuCEIt4Htk4587yvHvuG/fcg9lxSWxRbBMafX3QjulCoe7KllO8uZBq4B
         SEX0zxVQPtlaHBAUCzGcCvD70qsRf9e/r/Ew1L078k6LFB13b+7YgIDgfuMmJnMfBDML
         rV6KGIHs1O7Dy5YBzfv3KLW0QmQ8CK1Mv9ZZb5zpfZy2kgJQ077wn3yfqsWNFwCpVU2P
         e1OQ==
X-Gm-Message-State: AOAM533lIfqDiAfs/AOklHX5/p8pXCleY8nS7QFrrDCkoi08hw9O4h13
        vZjx7vgAykxLt6mi2pXmNd1kmKA+O/o=
X-Google-Smtp-Source: ABdhPJyZpgkSyRENgL3DAM9W6zUBTEKJdI2jfrPPcLiL5DspPIHJvn8h94+/RhxB+bp3WEfM9i5gpw==
X-Received: by 2002:ac2:4c83:: with SMTP id d3mr6522786lfl.92.1589072293623;
        Sat, 09 May 2020 17:58:13 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 68sm5664455lfn.41.2020.05.09.17.58.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 17:58:12 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id w20so5652839ljj.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 17:58:12 -0700 (PDT)
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr5900390ljj.241.1589072292121;
 Sat, 09 May 2020 17:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200509234124.GM23230@ZenIV.linux.org.uk> <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-5-viro@ZenIV.linux.org.uk> <b67a5f6e-0192-f350-e797-455fe570ce93@i-love.sakura.ne.jp>
In-Reply-To: <b67a5f6e-0192-f350-e797-455fe570ce93@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 17:57:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqyW2ow6yO+yz_0v4aKd162Lwtr24c5nKjZRG-2vW8PA@mail.gmail.com>
Message-ID: <CAHk-=wgqyW2ow6yO+yz_0v4aKd162Lwtr24c5nKjZRG-2vW8PA@mail.gmail.com>
Subject: Re: [PATCH 05/20] tomoyo_write_control(): get rid of pointless access_ok()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 5:51 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I think that this access_ok() check helps reducing partial writes (either
> "whole amount was processed" or "not processed at all" unless -ENOMEM).

No it doesn't.

"access_ok()" only checks the range being a valid user address range.

It doesn't actually help at all if the worry is "what if we take a
page fault in the middle".  Because it simply doesn't check those
kinds of things.

Now, if somebody passes actual invalid ranges (ie kernel addresses or
other crazy stuff), they only have themselves to blame. The invalid
range will be noticed when actually doing the user copy, and then
you'll get EFAULT there. But there's no point in trying to figure that
out early - it's only adding overhead, and it doesn't help any normal
case.

                  Linus
