Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DCEC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB1B20730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="3TcYGnYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgDHAkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:40:20 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34299 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgDHAkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:40:20 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 1cff259c
        for <linux-kernel@vger.kernel.org>;
        Wed, 8 Apr 2020 00:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=pVZbz2BQiRw2Mi3KrA8/Yoa+8c8=; b=3TcYGn
        Yj01O9WWE/XKUXtg4fDPrqV69tp2+JqTx4aclm3f7Q46GJY//9rcpEoQYPOrMPEs
        drxICokhgcw03fi/N93H+fnRqF60Pw9tZOfw91moZCYnS+h/DVrLMrVYwqUY5h2J
        KcHrfHEgb2+So579x6808LkgeC1SO47sPFYOmEQeWKulCmDJF3ituSwsLFs7Rz6y
        fKlTepo+50ybdmQfTqYvrVAjKYMP76uR5SX4hMVI3TccA9MfTgBM/AZpF76+XGVf
        25VyWRylR6eC/Sh8eYIOhskkPxE1Sc087qrux8s5yk+he4mJcdPtDhzhwlQq8OoZ
        M2uVtWOhuOzeeweg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 56d6b9a8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 8 Apr 2020 00:31:19 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id o11so878509ilq.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 17:40:18 -0700 (PDT)
X-Gm-Message-State: AGi0Pua4iegLbb5jdVUCADN60JOMdllHg5bTGAgkPMSO8pR6otay2wJ8
        19OEez9xReLnDjRtN+XMypPz1lAUEKIgaKsu/QU=
X-Google-Smtp-Source: APiQypKf0JHKHozVl5Ekm5/yscJCcYicF7LPFAQcfWzPigdyRdaNvh62EnA/SB13ZFPsDX4AC1SNpbWwZzYtTjPd4Ts=
X-Received: by 2002:a92:798f:: with SMTP id u137mr5578644ilc.231.1586306418050;
 Tue, 07 Apr 2020 17:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200328000422.98978-1-Jason@zx2c4.com> <158538232569.25292.15795048542441478192@build.alporthouse.com>
In-Reply-To: <158538232569.25292.15795048542441478192@build.alporthouse.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Apr 2020 18:40:07 -0600
X-Gmail-Original-Message-ID: <CAHmME9rQQjMY3+CxmUO3Yp+hHaOyfyORrPbBV5jBqVEZFXwecg@mail.gmail.com>
Message-ID: <CAHmME9rQQjMY3+CxmUO3Yp+hHaOyfyORrPbBV5jBqVEZFXwecg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: check to see if the FPU is available before
 using it
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 1:59 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Jason A. Donenfeld (2020-03-28 00:04:22)
> > It's not safe to just grab the FPU willy nilly without first checking to
> > see if it's available. This patch adds the usual call to may_use_simd()
> > and falls back to boring memcpy if it's not available.
>
> These instructions do not use the fpu, nor are these registers aliased
> over the fpu stack. This description and the may_use_simd() do not
> look like they express the right granularity as to which simd state are
> included

Most of the time when discussing vector instructions in the kernel
with x86, "FPU" is used to denote the whole shebang, because of
similar XSAVE semantics and requirements with actual floating point
instructions and SIMD instructions. So when I say "grab the FPU", I'm
really referring to the act of messing with any registers that aren't
saved and restored by default during context switch and need the
explicit marking for XSAVE to come in -- the kernel_fpu_begin/end
calls that you already have.

With regards to the granularity here, you are in fact touching xmm
registers. That means you need kernel_fpu_begin/end, which you
correctly have. However, it also means that before using those, you
should check to see if that's okay by using the may_use_simd()
instruction.

Now you may claim that at the moment
may_use_simd()-->irq_fpu_usable()-->(!in_interrupt() ||
interrupted_user_mode() || interrupted_kernel_fpu_idle()) always holds
true, and you're a keen follower of the (recently changed) kernel fpu
x86 semantics in case those conditions change, and that your driver is
so strictly written that you know exactly the context this fancy
memcpy will run in, always, and you'll never deviate from it, and
therefore it's okay to depart from the rules and omit the check and
safe fallback code. But c'mon - i915 is complex, and mixed context
bugs abound, and the rules for using those registers might in fact
change without you noticing.

So why not apply this to have a safe fallback for when the numerous
assumptions no longer hold? (If you're extra worried I suppose you
could make it a `if (WARN_ON(!may_use_simd()))` instead or something,
but that seems like a bit much.)

> Look at caller, return the error and let them decide if they can avoid
> the read from WC, which quite often they can. And no, this is not done
> from interrupt context, we would be crucified if we did.

Ahh, now, reading this comment here I realize maybe I've misunderstood
you. Do you mean to say that checking for may_use_simd() is a thing
that you'd like to do after all, but you don't like it falling back to
slow memcpy. Instead, you'd like for the code to return an error
value, and then caller can just optionally skip the memcpy under some
complicated driver circumstances?

Jason
