Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC8BC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C76206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598207381;
	bh=Q5lAfsOR/yXaoTu2V37qoU727zs0q0xcsWilUMi1ym8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lOdNSsqkp6+ObtHhHqlIKoSrJL20A0S/VQFtAB0hjcYjbLltJgfriY/w7FAMtD9ks
	 IHwLuH9kAQ+lh11f+G+OlXGTq2dci0HzzZFme9CwK1qwlfURybQqX5MT2z3LtO3TLn
	 tltEMU561QxaTVbAo44NWSE2z2yG5YTLXZyx57zA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgHWS3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgHWS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:29:38 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD11C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 11:29:38 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j15so3285460lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHk5+HSAFC+jjGgUfsn/DiAWwVfB+xggNk4myYiynqM=;
        b=e2s5FLZ6W3u1S/iHDXGLXYG/l20kOPs4DNLKq2+DhJK63yKuPfPmqefQqZ6VjcMvxX
         b2a35fCPBNcV6r82vyIHG0mQykNuPF8DRzMbUAQ2fO2MeazVH+HQNk9/3rW422QX7QeI
         +sOlMOZdwd5KyvukZmfO8W4w4NFf2jsmqfUzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHk5+HSAFC+jjGgUfsn/DiAWwVfB+xggNk4myYiynqM=;
        b=illi+BbztE7xV9y5qBzqPkQinp5avZXOdCeYjrbegNop3fTEm0KGmmJrYcJCdzM87I
         wNbG33pRJ9mUwLoWVyii7lrNrdHeMHHdXSLKansRUJnhVTKIzKuRyO+RXPgf11dhG+L8
         Y8WypRX8K4NKGjk3TpluhlaaUbz0yO2m3Ij29orXBj+JZwcnsZPppAWIpWzkw5o1H2AA
         LNW64osXwH8QUvKrx1tyENdnd7hVgvoTyYYnV3MWzKrRynD7enPgJ/Rz7RGPtWLQI2WG
         ghD8yn0LRX74AvRaOpSAS6+D8tXUsymRdWk2zZnzYU4jNq5WVXbig6z45K5CEBzuYWLo
         PVXw==
X-Gm-Message-State: AOAM533dcQFfau5BPLuQN0Cqz3hfFmQN1cm0InrFmFvYmLkkxU19KV7H
        Nu1HxO/0t20J7bpi5sAqshPQA0X0pvO4eA==
X-Google-Smtp-Source: ABdhPJyMbkipzKHokcYyi46SRi5EYhbMHAw+0uspT3FUckugO7PkwfW9MRSky8z4J23KkCpK2JF5UA==
X-Received: by 2002:a19:c189:: with SMTP id r131mr948413lff.186.1598207376265;
        Sun, 23 Aug 2020 11:29:36 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e14sm1720882ljl.96.2020.08.23.11.29.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 11:29:35 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 145so424358lfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 11:29:35 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr972794lfp.10.1598207374771;
 Sun, 23 Aug 2020 11:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <159817113401.5783.14776307451257171431.tglx@nanos> <159817113762.5783.6214320432160748743.tglx@nanos>
In-Reply-To: <159817113762.5783.6214320432160748743.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Aug 2020 11:29:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQQRS1f0qMwVVWKd6YHJ9K3bUK4BR2zoeGeCWRpTM3aw@mail.gmail.com>
Message-ID: <CAHk-=wiQQRS1f0qMwVVWKd6YHJ9K3bUK4BR2zoeGeCWRpTM3aw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 1:26 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Remove the RDPID optimization, which is not even
> backed by numbers from the paranoid entry path instead.

Ugh, that's sad. I'd expect the LSL to be quite a bit slower than the
RDPID on raw hardware, since LSL has to go out to the GDT.

And I don't think we need the GDT for anything else normally, so it's
not even going to be cached.

Oh well.

                   Linus
