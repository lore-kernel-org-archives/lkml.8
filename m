Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7092FC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358F6206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 22:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jAF7dl79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgBWWAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 17:00:35 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44799 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 17:00:35 -0500
Received: by mail-yw1-f68.google.com with SMTP id t141so4352573ywc.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 14:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEv7z6kfjOWhzFJ0U6oJmvXOArxz5ZVjmjpUgwRoIf8=;
        b=jAF7dl79q0/wXBaOE+MXaj+rL4QmCUiy1BQrAY9Pg1t6LCgdtpDDs7//QZ+RFR8+sa
         FXvaTB1zX8q7xrgU1QvqhU1YncMD9zHbG6G5NQFMFqw4O9o+I/alBs4f1JpSdvnRhNoB
         C3brQnZsUKLdY885UJcYHp26WELQ8I8pnNQ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEv7z6kfjOWhzFJ0U6oJmvXOArxz5ZVjmjpUgwRoIf8=;
        b=niktMy5j27Zi4PA97PW0uCFW57s1Xux6K8pY9rWWW9vgu763PYB2T6xRKlAEL5dzsv
         bF2ZzvN7vK7IlLQLKrgQV7ADQ73kXD7FFBjOIWWsigl145mox+wVFwgPx22LTX3fgA3U
         ONZkaRhHYjav3CW6OhZbp9GCjZLkqs+mPFl2jxquBw1NGJquaLolyHSYMahJeFpBYbkg
         9WLsPFj56/ZrtcKvPnFN9sfkUvdMleebhkapYb8gPTyd5VpLjgcT3PK75Q3jbS0tlemi
         BwR/8cUYzc2NlpBfitlLkvjguMh77YJe/zZdthC6VC91AdZM/uGb2QlfSvrS8FqQHOk1
         LI/g==
X-Gm-Message-State: APjAAAVCar0ddG2+VAmYmG3cUeYkJynyuBS1S9vADia4+E6jXM1vPH2C
        xEkERc24LVH0B1Qnqg8PLVUZnP46Yss=
X-Google-Smtp-Source: APXvYqzgpJ6jKtTA4mnBKg80mHPt0TE/IensxVJ2W3hjvlXkxtWHCBkw0VPd7sl1UV2QXFrbFmH3uw==
X-Received: by 2002:a0d:edc1:: with SMTP id w184mr1494108ywe.204.1582495232529;
        Sun, 23 Feb 2020 14:00:32 -0800 (PST)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id 207sm4323110ywq.100.2020.02.23.14.00.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2020 14:00:30 -0800 (PST)
Received: by mail-yw1-f43.google.com with SMTP id i126so4364971ywe.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 14:00:30 -0800 (PST)
X-Received: by 2002:a81:3888:: with SMTP id f130mr36072275ywa.138.1582495229594;
 Sun, 23 Feb 2020 14:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20200222164419.GB3326744@rani.riverdale.lan> <20200222171859.3594058-1-nivedita@alum.mit.edu>
 <20200222181413.GA22627@ubuntu-m2-xlarge-x86> <20200222185806.ywnqhfqmy67akfsa@google.com>
 <20200222201715.GA3674682@rani.riverdale.lan> <20200222210101.diqw4zt6lz42ekgx@google.com>
In-Reply-To: <20200222210101.diqw4zt6lz42ekgx@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 23 Feb 2020 14:00:15 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJQRnPQDq6ZLrtCB-i0A_+AifY2me-BinuKz7LJU8=ePQ@mail.gmail.com>
Message-ID: <CAGXu5jJQRnPQDq6ZLrtCB-i0A_+AifY2me-BinuKz7LJU8=ePQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/compressed: Fix compressed kernel linking with lld
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com, Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 1:01 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> https://github.com/torvalds/linux/commit/83a092cf95f28696ddc36c8add0cf03ac034897f
> added -Wl,--orphan-handling=warn to arch/powerpc/Makefile .
> x86 can follow if that is appropriate.

I've been playing with a series to do this, here:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/x86-arm

There's some work to be done still...

-- 
Kees Cook
