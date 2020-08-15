Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1DCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A08F2053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597528980;
	bh=3nTJx/6hfF5807Pg0yDml13kvJO0wZyW6oDlBFPbwFo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fxA8zAf6qbesb3K+9wYfNDDGzJclZrzArTrST2ufrUeGchHx8gKbSrtd/Vd3Oc3Fw
	 qp+K+VZkqUcId+sFNM/kh+TDfZjh3s2gMOtgT0b9coWWWflvWWZTnWqEd8uYKvyrFh
	 KVbc3vfYiOBQTPDW0NKHtGYgVERtVq0Pu8yrEiHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgHOWC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgHOVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039CEC06136A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:06:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so11902477ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RootNd+uaIchwNuSjJ92KshSOxN5xr+c7UxFHHSLXrA=;
        b=Rc/RXDOQJRu669+aRSylsloBjpy+Tv0xBR5VmuM+1kM7tD+64LA8AJReywNJdxUlep
         dw15OB9ijcVZo4KncX20axh8A7Ur5PNpcsEphZxCAi3qIjMGKs+KUtpEvkSGzhaXrqgb
         RwltEjb8UtxJu63+neyepOK1JgvhkTg3f5goY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RootNd+uaIchwNuSjJ92KshSOxN5xr+c7UxFHHSLXrA=;
        b=bBqsgxnISNVUnOfM9KktUSY+jr/umFXUDe0Z25J9enV6N0RDEjZnKMYxxE1w6Wd/oR
         hsnoOh+BGP9eNtK3Y6NrdqpXg4GZFrs0Fdq0Tx8CwP+k96Oky7kY30osDDBWhHz6IAvf
         DqCjZ2G570LqW/HNGDqQyGIe2Dsd+hT4geVOc66cmq4imMdxqAXPE0gD9vxnplZhbs2j
         uQuJzO2UHioEjaGj26vgwD+aLAon7y0g9oJYfDDYZmnXSQK3Hkmnc0AWdKjcBUIo6KOY
         oNWlNjTZg62cBZ3OftRaV6TKGLdqBU9M7Hx1n4kkDFIRHtEbFbTcKamrQyYa9NA159Tl
         CW8g==
X-Gm-Message-State: AOAM532/6DsRLq8DVML0qiWmpL5XmLNHkh8LdZXO/AqB4Ps+anUzEtcF
        yd8wGChgrpSf1tMQ8egIkRTTJcLIC19Ekw==
X-Google-Smtp-Source: ABdhPJyT8xTWl6LZtTb/7eNBshdSdDSdNSKC36u4Q2BJ63vJJNxAwV0H9mpcterf59yhAf3xdERMhQ==
X-Received: by 2002:a2e:6808:: with SMTP id c8mr2767662lja.13.1597460762166;
        Fri, 14 Aug 2020 20:06:02 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id l20sm2111070ljb.28.2020.08.14.20.06.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 20:06:01 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y2so2904562ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:06:00 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr2375763ljh.70.1597460760539;
 Fri, 14 Aug 2020 20:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com> <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com>
In-Reply-To: <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 20:05:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
Message-ID: <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
Subject: Re: [PATCH] genksyms: keywords: Use __restrict not _restrict
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 7:14 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> What's KAO? Urban dictionary has no entry. :^P

It goes back to 2003 and the original keywords.gperf file, see

   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=46bd1da672d66ccd8a639d3c1f8a166048cca608

from the BK history conversion.

It might be Kai Germaschewski's tagger name?

              Linus
