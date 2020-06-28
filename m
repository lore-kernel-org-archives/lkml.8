Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A505C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF4B20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593363447;
	bh=gKGcNZajPVPsnQhjiW4kXThy3p4NTGlKxXZvQXNX1Mw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XAOiE5Cn6MbDNawOaSg2ZKecE3anYWKetyu2jxuxxkXy0mhutrEEO6nTuq6CkC/tB
	 h22QMKHJkmoqgUiX507BHb1tcb2UA2XAtmVcIAaNLTstrZqKncxwerNN3S5jU1bi3M
	 9uH458T7Afc47YSiQH/5IoR5at6TWEvv9PeHEbW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgF1Q5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgF1Q5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 12:57:19 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E24EC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 09:57:19 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d21so7786282lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omBBMjl+B302Rw2JiKwkQ9zS4lNXU0ecdG4/qHP0Un8=;
        b=EUQzbA8Zrn/d30M/qaMkZYUcUZKHy4sBdYzVAkM+nv1Wn8ceTf++94Q7po+1ETadAq
         RNAi/wYEsHs94lz6LlSAXJ4fF+Wk0cXEb6QWC1ZdvRfFqu41tPzppJqAdT5tCAD5bHb1
         fcz5PamNcAvPVantPQZo1LICHNyIdp+gizV84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omBBMjl+B302Rw2JiKwkQ9zS4lNXU0ecdG4/qHP0Un8=;
        b=IpnMHaUNieayWJWeIZJTwY1nC9LJF8h6HsOp81RC4gwTCpw5/PpabNnxzOFqCyGFr6
         Pf+zRu0/+Htw/3OBxmRjEsKF/Yl90X6fuYxt+146+wrPRn/oe9ZXIO1VuOFrwjRduQ7H
         uxGRYDN4vfVH0DS8w+cP4LfKYP0DC+SnEulyT0adbqGjVBccQDwT2BXzrXjFLLeeOgIL
         yeoXHcfFmdW2gpctHTWkAxUbH90m+70ChiqgybH+yw8tncwWCgBDGjn9ixgMohWpLs65
         5T0d5fzYDTWaUFFVcAeCdP/W5RJ4Kl6g64+iOQ7gQZ2L+6/xlJwayZ12/x5+cdsD6YMY
         2G+A==
X-Gm-Message-State: AOAM530ejoPLLrYGkyBsydS2jYzJMV9/5lGk5238KaT6Qal6kOb4VxOJ
        KQgySOuOVedtdzxpklLSqahTGBqke9c=
X-Google-Smtp-Source: ABdhPJwrMne220CbKPUnO0vLbNPxPoT3P204VIxRffnTHnmm65B2yJCuIQOnV8cJnGaU+yDDP0Lg5A==
X-Received: by 2002:a05:6512:4c6:: with SMTP id w6mr4931354lfq.76.1593363437840;
        Sun, 28 Jun 2020 09:57:17 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id n25sm7983806lfe.39.2020.06.28.09.57.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 09:57:16 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id s1so15533876ljo.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 09:57:16 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr6442417ljj.312.1593363435994;
 Sun, 28 Jun 2020 09:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200628140523.GA18884@zn.tnic>
In-Reply-To: <20200628140523.GA18884@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Jun 2020 09:57:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiu9wquJ1LO53sA7=9ZCmQkRpu1-hZwwopeu8OVzt4qsg@mail.gmail.com>
Message-ID: <CAHk-=wiu9wquJ1LO53sA7=9ZCmQkRpu1-hZwwopeu8OVzt4qsg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/entry for 5.8
To:     Borislav Petkov <bp@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 7:05 AM Borislav Petkov <bp@suse.de> wrote:
>
> please pull the x86/entry urgent pile which has accumulated since the
> merge window. It is not the smallest but considering the almost complete
> entry core rewrite, the amount of fixes to follow is somewhat higher
> than usual, which is to be expected.

Tssk. This has an unnecessary merge "to resolve conflicts". I'd much
rather have seen the pull without that.

Oh well. Pulled.

             Linus
