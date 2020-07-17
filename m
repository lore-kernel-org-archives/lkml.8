Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B70DC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4097720739
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GomICRb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgGQWkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgGQWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:40:13 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7C0C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:40:13 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id j21so3347129ual.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZyZ467hIccQl/fLPtGOgJ9GVjmNV0nRkM5JSKZ0eUA=;
        b=GomICRb5nZ9AfMHvPuoZI9Nbna9nrEcMfyotbsXbKTOwiWbdxkGc31o4K3DmBKnVFs
         USNTnZSIRmtmhCioWNZiPbRNJC4rBkfzRD+++dw3AYRbKw9mQl2l4jech0vRweiL1/bj
         ck9javutd1dlNYxF5oD3KtwdU5fnN2jzWtBV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZyZ467hIccQl/fLPtGOgJ9GVjmNV0nRkM5JSKZ0eUA=;
        b=oGft5hkADvQBCQhfGBDbVVuMU+ZI72urHg6Ma95HTCE1NNAwa88tkibkZJZgB4mSjE
         nmhGsJb06CVfMUFtSyJF09VL+YeX3TNru3sghYP6b9BJX9/SIJcjCQv5RuY2BlE/3atE
         bR+YlV1objQfowqLswn2x11BP39vJkHg29vqHcEtn+Cc0zYKkv7B7rih/HzHnTQM04uj
         VnJLMYUqIEqVkGVSprTC//vy/ujYHvxTM8FZVn2edfsPo1CFidMOUrE224vltjaItG2e
         ZV4TRdckKUWKHE71OLzKvkknuWa8jDsXkdkJCWx/B+oM2pZp0kNGbgoN8rzyqbTUyngK
         61Ug==
X-Gm-Message-State: AOAM530oS+04jfWUsQaYJj4qVEP6aUOAD58E+uC/3QdeuANc2BQPH8my
        JWV7DIj3th0z74BCmGEOaDeAKehQu8I=
X-Google-Smtp-Source: ABdhPJzf8Dd34evaijJ4aeCfVBfIXOu3MH9L0f6vkYn4Xib14ux3kxKRdjoJ6vwv4Tjy2PU4N13u3Q==
X-Received: by 2002:ab0:5ea5:: with SMTP id y37mr8863910uag.71.1595025611352;
        Fri, 17 Jul 2020 15:40:11 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id f7sm1194431vso.5.2020.07.17.15.40.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 15:40:10 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id n4so3351365uae.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:40:10 -0700 (PDT)
X-Received: by 2002:ab0:150c:: with SMTP id o12mr9192504uae.90.1595025609920;
 Fri, 17 Jul 2020 15:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200716151943.2167652-1-daniel.thompson@linaro.org> <20200716151943.2167652-4-daniel.thompson@linaro.org>
In-Reply-To: <20200716151943.2167652-4-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jul 2020 15:39:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBMa4pt7Xg2sKXHdjo6tVaQWBQFtT_aoDJ+Xt1HrPD+Q@mail.gmail.com>
Message-ID: <CAD=FV=UBMa4pt7Xg2sKXHdjo6tVaQWBQFtT_aoDJ+Xt1HrPD+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kgdb: Add NOKPROBE labels on the trap handler functions
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 16, 2020 at 8:20 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kgdb honours the kprobe blocklist but doesn't place its own
> trap handling code on the list. Add labels to discourage attempting to
> use kgdb to debug itself.
>
> These changes do not make it impossible to provoke recursive trapping
> since they do not cover all the calls that can be made on kgdb's entry
> logic. However going much further whilst we are sharing the kprobe
> blocklist risks reducing the capabilities of kprobe and this would be a
> bad trade off (especially so given kgdb's users are currently conditioned
> to avoid recursive traps).
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/debug_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

I could just be missing something, but...

I understand not adding "NOKPROBE_SYMBOL" to generic kernel functions
that kgdb happens to call, but I'm not quite sure I understand why all
of the kdb / kgdb code itself shouldn't be in the blocklist.  I
certainly don't object to the functions you added to the blocklist, I
guess I'm must trying to understand why it's a bad idea to add more or
how you came up with the list of functions that you did.
