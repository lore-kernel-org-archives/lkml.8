Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ABDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02EA20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyTfejrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgGJEig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 00:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgGJEif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 00:38:35 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801E2C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 21:38:35 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o5so4679335iow.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 21:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPuF3Odhd0M6Xzie5Qwbk0S7FxZlhTnogIYmSKAEvRI=;
        b=NyTfejrdEh520jNNkmxYw9np2vQVLwefZ3NzJbKcatI0R6q0p9O2vU+xnLAswuO5aT
         8LrEuhdQYmZGUaEUAruLcUqAm8TDuhqXOG3FyHu7cSeMUwI+PKTUSVo4XuACsFxnlzfi
         duotsQ3AtZBO1Q6Vo+x8XAWbExJhfE67QF/feTv/1KY7OEx7HO+2zAUPer3uknBeoGXz
         RAjavVDa/uPEy/9sA284GmiF59arah2IK3JQWIc4Vfqv/L3EeTIR70dp5T4jZGJtaJSH
         LYbbQx6uDrK3xKqbEEL6aFx/8zyDcqV00bf7Db97Ve+etXOVGV2iahdAfzL9kS/9eHJO
         Pv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPuF3Odhd0M6Xzie5Qwbk0S7FxZlhTnogIYmSKAEvRI=;
        b=EnvDhkfS9dZt3Oor8HJqjhsfQvp8IKgTckJGEmoOd4w9nbnpbrpx2qWHWryxLoP0Qe
         OaI3oUaosDCYRstAI9thcFy52zCuUvsrOxWYS8A9hLMia9ldQlfAyuKBk/9L8TxVzhLB
         J8U75mA5iYTw8JGNmDUmLClLxqCS1bUdJSuYrpyRtNzgiT/F8rjmXeiCEecMrXicvA6o
         HFnnFEgROlMAOcyYghWDT2qXlaton+FXxpRxVJXg7uD6hH1oBOmgq2GGMy0qZoc9CM1W
         AZiwBU4I+xtHPSfl6bHrZmhrdZ6k+n8INbwqhHvTA8ciXez0Qy2wB7T19MqSQX0bZ2uJ
         FHRQ==
X-Gm-Message-State: AOAM531txNey2/QEVjN2QqgVOZp9LmZi3DPCydFm7dhB1s0RwfO3o9qs
        yYLqg6fpTNGJd6YzsCypK1eBqedOqCzVRaYxFQ==
X-Google-Smtp-Source: ABdhPJzawpBciSchVGqlGgXF4tk6PCA+mmhUC23OE46RXfLaW9jH/kxant30VNujcuAnQ821fsq4izGV0ZsBTbugkTY=
X-Received: by 2002:a02:840e:: with SMTP id k14mr12602675jah.133.1594355914964;
 Thu, 09 Jul 2020 21:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <20200530221127.459704-3-brgerst@gmail.com>
 <20200709103024.GO597537@hirez.programming.kicks-ass.net>
In-Reply-To: <20200709103024.GO597537@hirez.programming.kicks-ass.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 10 Jul 2020 00:38:23 -0400
Message-ID: <CAMzpN2i3TPxpf5ktaQgb5EmB9wd84V+J5U6=_MuihtXx1-cp+A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] x86/percpu: Clean up percpu_to_op()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 6:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, May 30, 2020 at 06:11:19PM -0400, Brian Gerst wrote:
> > +     if (0) {                                                        \
> > +             typeof(_var) pto_tmp__;                                 \
> > +             pto_tmp__ = (_val);                                     \
> > +             (void)pto_tmp__;                                        \
> > +     }                                                               \
>
> This is repeated at least once more; and it looks very similar to
> __typecheck() and typecheck() but is yet another variant afaict.

The problem with typecheck() is that it will complain about a mismatch
between unsigned long and u64 (defined as unsigned long long) even
though both are 64-bits wide on x86-64.  Cleaning that mess up is
beyond the scope of this series, so I kept the existing checks.

--
Brian Gerst
