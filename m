Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D511C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DE724656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582312783;
	bh=6f9lYdnJe9KYcpTY5q/+JDf+8eEEbcDguNteOooTnzI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KdmBlis5WotmAp1wnVszQy308XvV08rDEWyppQHFw1uPkE0NK6nv6MjuovB0LsJ1Q
	 tNyGiuAPbY7bqMykAiyo63Qz2jxNZ3JjQNeL6FAnalut/bBGZeKPPQOt+/uAnpgLUN
	 +MDPGrAmiUthyi9CugCJloPowRzUAXfICV6DKHyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgBUTTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:19:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45586 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgBUTTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:19:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id z5so2249961lfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFUjPnLNK/wofno2JMZpXV7vXMx2oIijpSJUiltCnRQ=;
        b=B3G2KKEUhlVgVK344fmGjze/ZrUx1gRELcUjzX2MZk6dt5sHBy9TVpnr6DOZcTqRzr
         2b4WojyPXm2dR1cT/troSmXekZ+1QzSmhIlwp+EKOYuEQbWpMFC3phurjv1HKDUFX9Bk
         Um8J439MwjhswJRC48fABzZqJqvUhocgFGCf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFUjPnLNK/wofno2JMZpXV7vXMx2oIijpSJUiltCnRQ=;
        b=ipFstfwyCEzTEnDi+Y8iXYHxwfXAfmfxj7F/LA2CK/Rw21W8UpF/i97huJyx432SU1
         35xV3tuEpe5l5pmPiWA9S9XyGJUkG3FAgyThsrKePuC1w2DJck8xHRWEQJW9tZdQq7hi
         JSl4t9+axfRlDnd2U+KgfaUfHd+qcqWZ9G+dK8surN03Z3JP0lmP1WE5+wDohZpYT80g
         hD/vRMAlJ6DCYUjtbm53VpSLc1bCPcy0D7S0PZe1swZrMFZD32qOz2o/b5Sj8OviEQRb
         OPTnK6NBGLvUZLJnaxL/uHkbWk5FALnPY18iPqhjUAtNzQVeZ6jiK2o/qaU/yZWZ3WCP
         EHbg==
X-Gm-Message-State: APjAAAVOY17EDSMuat5Dekb3BHu0Jj9NSopl4vBVB2cV8OOvCmJR2mNl
        GVRAwWetANN6tbE7Nlz0ijJlFV4s7ok=
X-Google-Smtp-Source: APXvYqyZGm4VvflxjCMn1aQ86XeV5vieRr+X+RsX2Q16rw1J+HqJ9B1YINUfjBoX0yBNEzijidb9wQ==
X-Received: by 2002:a19:7b0a:: with SMTP id w10mr20691195lfc.90.1582312779259;
        Fri, 21 Feb 2020 11:19:39 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 23sm2167322ljw.31.2020.02.21.11.19.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 11:19:38 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id q8so3310083ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:19:38 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr22705661lja.204.1582312777962;
 Fri, 21 Feb 2020 11:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20200221111138.GX14897@hirez.programming.kicks-ass.net>
In-Reply-To: <20200221111138.GX14897@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Feb 2020 11:19:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4uO+Djqr4Jc1TnCofwxUTuXHtgkgwnVX86q06UGV6DA@mail.gmail.com>
Message-ID: <CAHk-=wi4uO+Djqr4Jc1TnCofwxUTuXHtgkgwnVX86q06UGV6DA@mail.gmail.com>
Subject: Re: [PATCH] mm/tlb: Fix use_mm() vs TLB invalidate
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 3:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> +       BUG_ON(!(tsk->flags & PF_KTHREAD));
> +       BUG_ON(tsk->mm != NULL);

Stop this craziness.

There is absolutely ZERO excuse for this kind of garbage.

Making this a BUG_ON() will just cause all the possible debugging info
to be thrown away and lost, and you often have a dead machine.

For absolutely no good reason.

Make it a WARN_ON_ONCE(). If it triggers, everything works the way it
always did, but we get notified.

Stop with the stupid crazy BUG_ON() crap already. It is actively _bad_
for debugging.

              Linus
