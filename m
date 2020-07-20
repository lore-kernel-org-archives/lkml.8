Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086BFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D670D22B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595278109;
	bh=o6BQyHbft3qjSk3/T0223cPoY4KQnxQFYBMyPrjgc9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VGzq0daOIQSL2Ij5f1iMwo0JrrNDKbc4uBVBVEcZaTDpUQU0C87HwhT+EAgMp/Ffn
	 oBpMz5aYgV+ly9x9S4DNi8cSa1CK+XFKIVnizfAltl0aBHZHaRL4RcOUgBIu3EL+02
	 SMlz3G3HHXZbPE757quBGBCrvhjm3l0QyhYGoKFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgGTUs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgGTUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:48:27 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF68C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:48:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k17so10469226lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQdjJ5njxoYFooAMx1qtZDrD/m9cfIZBr1mE7cczSYM=;
        b=byBwyBpGsfgo8f5UXUqmN4qNfwvv1aowlbZzEiP1na9+FoiWPYz/BgA1DpTD23tGvM
         xgTWM3PCy5/xGDE2+AuqVj2hr1lUlaQ7ZrEyWV1ZOpHFmN+fXGWfLpBtNXv6BT8tnRBI
         +ziOVm3cPAdpWS0oXnnB8BvJJApoINnHwLRMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQdjJ5njxoYFooAMx1qtZDrD/m9cfIZBr1mE7cczSYM=;
        b=O+OYyIyTCLrG2f1bhbH4Jfd+0WDcWZK85ap/BHfv5tHWjWR+22ITAL1LlilgMcJAMK
         nnPdUFQQCJiuphmKVhQG/Px/C34zrRTKJsJghjUK1ej4qBKqSQS4SbTOj7nC5SmYZqGn
         l/SoGxQOpZlfKVN9Be0CJ4dFCiERfT7I8rE+93EgDims/huvVQIH2GYsLew/ofUdB8JM
         dwGQPa6zM0VDoh5lD8HvI6UDttH/L0UbTy6AnW4gtXkDG8ehfFvCxMhjPyY4bMEeqjv2
         wIQ2ywLVznRi6zqHFe3DiqTXeLE9xLZ7/U2Ule2LZYff5wza8CtBZbUT37WtnI2ji0WY
         XFbw==
X-Gm-Message-State: AOAM531/M70MG37fkatLoymYiVHu1rDl/+ISA1+OFyNq7Ss07Oe3FWHg
        KtOdwZ11JQDMy/qzwO2wlW0/4dMOhUQ=
X-Google-Smtp-Source: ABdhPJyiZKR5YEnC7PpwTE7QsY4w6DuHklf+BIAqRm4Gj5Ae4PrAgAD0wvfTIO+SHJU127Q0Icxy4A==
X-Received: by 2002:a19:4183:: with SMTP id o125mr3705384lfa.181.1595278104928;
        Mon, 20 Jul 2020 13:48:24 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m6sm3421239ljc.134.2020.07.20.13.48.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 13:48:23 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id b25so21707355ljp.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:48:23 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr9803673ljn.421.1595278103367;
 Mon, 20 Jul 2020 13:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUGO0__SEZ7YvuQzfSdaWfTnCHW=73-3W4X=Vz51wHd+w@mail.gmail.com>
In-Reply-To: <CA+icZUUGO0__SEZ7YvuQzfSdaWfTnCHW=73-3W4X=Vz51wHd+w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jul 2020 13:48:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiR+uHUyp3=Nf1aiNjmg0ZekaQJupLRguFNZ=MreuGhfg@mail.gmail.com>
Message-ID: <CAHk-=wiR+uHUyp3=Nf1aiNjmg0ZekaQJupLRguFNZ=MreuGhfg@mail.gmail.com>
Subject: Re: Linux 5.8-rc6
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 8:47 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> I wonder why there is a time gap between tagging v5.8-rc6 in [1]
> (first) and [2] (15-16mins later).
> Can you explain that?

Usually I push to github and kernel.org at the same time.

But every once in a while, my OTP token for kernel.org expires, and
then I have to get my OPT token generator and update it and push
again.

So sometimes github ends up getting my pushes earlier, simply because
it doesn't have quite the same kind of strict security checks.

            Linus
