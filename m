Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48896C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B3206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590340863;
	bh=DqE1UVbxqtvvo9lmIPOTIwxWjEHUJrZOcnIhYYy3mv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BQAdZEHEs/kOZHej2Oc/UMxleuv1L5I+rOSMtLVbO/M+Rml/TdLE08TuiOYyrmxGU
	 xhxLMMEIVlmpEMutxpvyscjz4apb8HlmKK1O6CCtORvds4OjvL5ozrT0dlIq21ABEs
	 4CezAt3PfpvOiq47DtVUrP8cz3t8B8YJHU/hpeUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgEXRVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbgEXRVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:21:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FE7C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:21:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h188so9282519lfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aCjUz30Co8OAaC+F3+nt0BF0y7Y9AvEW+q7XB2zskk=;
        b=E2iJ5D2ZzTFp3uRgYV/U0UxrNYQBE76KzJW3+MEj0ix+OLrVNoUqRednrg9LKmlvy8
         0PN392K8TN/4eP+OB1RnUEs0cqGT0RX8l3q9+N2YE/HSb6soY9XA5IsTWitunuBtorqI
         oGmNLRGRnRpz/miPWiVDsKxsXFezOJ2TLcBNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aCjUz30Co8OAaC+F3+nt0BF0y7Y9AvEW+q7XB2zskk=;
        b=mkS27lOuag8iLVnao++6qGWKkWOYOWCxRUnvUyGTLILUCkU96gkRTOayPAiKK3pxJf
         TAl+0rnOpA7G7hfY8fA0/nj2OUcEm1yj32fcUBW8cRT5Dq16qgWYaLYBH3nUZ/0tSDUL
         L1Qfo4WiVqsnzyXAK2bAW2ILwJWpCO05QnMiHwuKaF7B2Ycbv9cF4Htt/EK3pNjIuytF
         isRSPOLMyOYVISMNqd6mWTpZRcLPGkNce0CJrQ13uUeCGOEOIpgob7E8i50WpYuvSdgy
         I1QLKdM6BidDz83uePsi9G3cF/w/RhHx9QroPNZXEih/ZvOb4Yew/70Djsln09X77qrK
         azQA==
X-Gm-Message-State: AOAM530Xx/7KeJhG92ls6VAlH5xAxEEus2zYgHVqgp3WXmQ03QyrOKhS
        j6O7NqTqE01EH3kumEBMcJ4KONRp6zo=
X-Google-Smtp-Source: ABdhPJzjkvA2PTLPB30QI3fpMQGw39UHgBCo7yjGK/MpewEVYd17GFyCive97KdZaJrH8bigYtcEcw==
X-Received: by 2002:ac2:54ba:: with SMTP id w26mr12531321lfk.54.1590340859807;
        Sun, 24 May 2020 10:20:59 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id o14sm8060ljj.135.2020.05.24.10.20.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 10:20:58 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id v16so18381032ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:20:58 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr9786776ljc.314.1590340858466;
 Sun, 24 May 2020 10:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <159033288117.21635.13199705716119914103.tglx@nanos.tec.linutronix.de>
 <159033288238.21635.76261789367356025.tglx@nanos.tec.linutronix.de>
In-Reply-To: <159033288238.21635.76261789367356025.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 May 2020 10:20:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkwxJZDjgrqqugzsW++5Oo43DvFL1z8Ei=+0FZuQ84uQ@mail.gmail.com>
Message-ID: <CAHk-=wjkwxJZDjgrqqugzsW++5Oo43DvFL1z8Ei=+0FZuQ84uQ@mail.gmail.com>
Subject: Re: [GIT pull] sched/urgent for v5.7-rc7
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 8:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>    [..] overlooked a corner case where the first iteration terminates
>    do a entiry being on rq which makes the list management incomplete [..]

You had some kind of mini-stroke while writing that explanation. I
tried to fix it up as best I could.

              Linus
