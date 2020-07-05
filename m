Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B39C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FBB2073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593978411;
	bh=So53ayXaUDwixK9Wi70gbc/U5lG2ighsH/OMflbnE0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ktEuCZhoXmtBjEMVhQSj1VrOuaFdQ7gNJCVI2gbFRpFiQulkbN55pdHH3e/lZtHBV
	 GrtowlPLsJu8j23zUdTL1+H+E55/ku/ehFwfhlgmc9AOfcFn5pUPvsevoDD6Vg+Bmt
	 PJnuUmd7oVxHOEdulzqj58IMu4PgDeNV3KoXo90w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGETqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgGETqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:46:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E24AC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 12:46:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g2so21416180lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBFG9d/htC9G36MGx45SRMUyXh7Ve2HK0iMZdRV3qpA=;
        b=baoG88n59Iuj1CMHv/JHi7oo+HLqqNYydKxZE7jErHzvnDsB54RoZve7w28hqTs0vs
         28x97jIUa/msRTRpQ+NU0eMXL3LL0lzOjvNYGKkslxc3seDBWNKZ9DCzevUhVPt83Ubc
         x0ZXbzymytI/BZGxV7ZstVqjPuBbR0rbQLQ2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBFG9d/htC9G36MGx45SRMUyXh7Ve2HK0iMZdRV3qpA=;
        b=JV9wfw9xkM86r0C1rIXOGOytJPWVBppOqQHS3CgQkNtGNKjjQ8vTJZmzDhUz5L3uC9
         6r1QSNqu+rYyBdMdLDt+DZJTVfcjJcazRIWfI0h7ANE7MbA4TgJFSbCNhViDj6KI/xZm
         KZqODAWmhAlJj13S+g6mBVJz1VlGjwy6ER25wJzXMhRDwng1Rf4entHSkVC7E8DQ/ekh
         slycuXvRX3K/9q+CzZdYFZZAR2F+USQxXZste1BHmXeyVkN4h/tgM7IxygaJVc7cVqyT
         jsLaHbTkakDCwXbRmE27e1Yn9WwCbCfwVcjNbagaLWz2epRSCfwewUkMUvkx1CE5qbEP
         bKyQ==
X-Gm-Message-State: AOAM531QmI2FYZGIEO7n2wre4rp6KRkxGVhXTBvxRhVCEWjytkXAkMfa
        +P34XQcrBheydyXiNFJFuwCD0OtJasI=
X-Google-Smtp-Source: ABdhPJzOz9A6ZMQDxveOn/t2onnCI1nlP+I1PsB6whJkOPZj5eBuYuW+5Y0IWdJ4MLcBYZD0bCEHhg==
X-Received: by 2002:a19:815:: with SMTP id 21mr27302723lfi.119.1593978407100;
        Sun, 05 Jul 2020 12:46:47 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y13sm7378965ljd.20.2020.07.05.12.46.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 12:46:46 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id k15so21385736lfc.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 12:46:46 -0700 (PDT)
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr28181978lfn.30.1593978405760;
 Sun, 05 Jul 2020 12:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
 <159396401656.28963.9621378879403780463.tglx@nanos.tec.linutronix.de>
In-Reply-To: <159396401656.28963.9621378879403780463.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jul 2020 12:46:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgV9toS7GU3KmNpj8hCS9SeF+A0voHS8F275_mgLhL4Lw@mail.gmail.com>
Message-ID: <CAHk-=wgV9toS7GU3KmNpj8hCS9SeF+A0voHS8F275_mgLhL4Lw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.8-rc4
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 5, 2020 at 8:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>  - Disable 16 bit segments on XEN PV. It's not supported because XEN PV
>    does not implement ESPFIX64

I don't disagree with this conceptually, and I've pulled it, but
christ, that warning is over-engineered.

Seriously, it uses a mutex to protect a "set once" variable. That's just crazy.

We have "pr_info_once()", which does all of this for you. And no, it's
not thread-safe, becasue ABSOLUTELY NOBODY CARES.

If you happen to get two or more warnings because they happen on
separate CPU's at exactly the same time, nobody possibly cares.

And if you really are so anal that you care about that case, using a
mutex is still the wrong thing to do for something as simple as this.

You could literally have made it just a single atomic variable, and
that would have been simpler, faster, and be context-safe at the same
time.

So using a mutex is not only overkill, it is literally technically
_inferior_ to just about all the possible ways you can do this.

I've pulled this, but I found that code so bad as to be actually
offensive, and added a commit to remove the garbage and just use
"pr_info_once()".

And if somebody wants to guarantee the "it really can only happen once
even in theory", that person can add the code to "pr_info_once()" to
improve it to first optimistically load the value, and then use a
"cmpxchg" or whatever.

But that sounds pointless, and I'm not going to waste my time on it.

But I _did_ waste my time on removing this horrendous case of
re-implementing "pr_info_once()" horribly badly.

Because it physically hurt my eyes to look at that code.

                   Linus
