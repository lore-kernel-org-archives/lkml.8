Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F54C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6D320724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598222124;
	bh=6VQZdghfN6q6iI6P+KXsnoA2sExjXc9b4l8qA5bdqYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Up/deEUMduJShBldMZm2yjxRW+HNuaaU3EQ/UVAyA8oq16YU9P+TgWk/iTwWuLSpc
	 XFC5WVwbV8Zm620x7L2Pg3nAWOzPbOW7UXitB4bcnIjXW58sAm+ToIslSTAQDinfme
	 LZQoJN33IA1xIemQ8izc61dMgwSoTRHH5qG8cT4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHWWfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgHWWfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:35:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE880C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:35:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u23so1063906lfl.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzmjYlqLP9grVXNztevfVLPLQlQaBdUV4HiAd6F1C34=;
        b=ECVBP6C/LjzqKwJkBSH/DooTnPJkl5JrIH+r6QornOMrWW5ij1JyOTe7pTgAbUfsRd
         VhexgNDqmiy7yRJ/pbjbmgADVFq2zMCdfcNPRKIkb2eN82kz9RtdPWDp9X2UMHWz2gd+
         EEiVciU3Eix467UOu8CfezJIXuykAnEMLHVlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzmjYlqLP9grVXNztevfVLPLQlQaBdUV4HiAd6F1C34=;
        b=gU4PexNSYJxRgg7RSji8dQUgG/nyDex+UueDYRREb8sKVobz3y6mwXT37+jv33hlOD
         hzahSDm80+ePB+i5E7pVKwlx0/9ltLmfItE7PsIipv72p5FD28B4lN6+adjX1IIXqhIX
         iaXjRHCP64U0+fz4g9EGjy5gAt0pFjEblS5f2d6baCCCm0wHMRGV+l9a1zxwHcwCR41+
         GU/nsGZH/MfDyjERZ3AWPSHFvw7CJWbTH7qGXJ1ctdP5oDfDVzvrztRbrGOCoC1Hthzn
         wTyJSZAO9oHBLX2FM5wjem3PnlwAAL/2Mu46lFVmhJnrsjfoIWV3FsfNeV3/hxv+cy4+
         nDVA==
X-Gm-Message-State: AOAM532AqvhmyDC7zwaOtR2EWP6AmzTGrVLGJkXLr3R7KTZpweBmvCm+
        UqyuzQBhV5PxWkdZAiJb0cFr76m6GAgwUA==
X-Google-Smtp-Source: ABdhPJxrkcFREkKbWFoIvI1hsKVSo3bC3NHkxcg/GNE3e9LmHR+KyT13O2r213HIR1GSeKqtl2YB7A==
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr1260302lfq.182.1598222119856;
        Sun, 23 Aug 2020 15:35:19 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j66sm1841745lfd.74.2020.08.23.15.35.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 15:35:19 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c8so3452607lfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:35:18 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr1240827lfc.152.1598222118541;
 Sun, 23 Aug 2020 15:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <159817113401.5783.14776307451257171431.tglx@nanos>
 <159817113762.5783.6214320432160748743.tglx@nanos> <CAHk-=wiQQRS1f0qMwVVWKd6YHJ9K3bUK4BR2zoeGeCWRpTM3aw@mail.gmail.com>
 <CALCETrUSE6cTgaa9LWK=JgKhJt4vgGz42uPJEkk6XZWA9dOkvg@mail.gmail.com>
In-Reply-To: <CALCETrUSE6cTgaa9LWK=JgKhJt4vgGz42uPJEkk6XZWA9dOkvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Aug 2020 15:35:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjkMOgAP_fHL_+p5Gw6fwDm3tOa6_DTuVTJkaTJVTr+A@mail.gmail.com>
Message-ID: <CAHk-=whjkMOgAP_fHL_+p5Gw6fwDm3tOa6_DTuVTJkaTJVTr+A@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 3:27 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Every interrupt is going to load the CS and SS descriptor cache lines.

Yeah, but this isn't even sharing the same GDT cache line. Those two
are at least in the same cacheline, and hey, that is forced upon us by
the architecture, so we don't have any choice.

But I guess this lsl thing only triggers on the paranoid entry, so
it's just NMI, DB and MCE.. Or?

             Linus
