Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D49C2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2C82064E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZLQrV0nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgEMOfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388857AbgEMOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:35:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD2C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:35:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n17so14388054ejh.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlqVC8u4P9PNkoT8l8vMpZfu06Dmj3nts225WoeRAJA=;
        b=ZLQrV0nneosBHj+7xCc5egcsUtP65O31+mSG+ARmurEXovdMccDV3mFX15VNW2ByBl
         QO4llNH+5o4bhlXHKGm0KbtQIJ3+Z1GRZSWSE/M5qV65RflL1tf78xgJe7A4rE8M2qJW
         ntHk1Z/Jd+55anPZ9E0wqcCyq8rnGIdyrGqTGORajq8YkayNJ1XuO7h7NgQSoAkFP2kL
         53h0HrwXoZrsg4DB33/bqlCSIQpB1aGOnaVpTfwGrZn5FWoDCoYsCyy0fvL07HZwXNkI
         zWPvp6MiCgszDsuRdhpk8HEMAcRwTIKiMTPgV4iJvA0Jsw7VqEDejipUKNQjiekb3m9P
         cGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlqVC8u4P9PNkoT8l8vMpZfu06Dmj3nts225WoeRAJA=;
        b=eQ3889xW7kKR+HbGzmR6XDBXHK48kyRXVcARgAgfpLbtMta2NNVpKZa3WhWjsp9LxF
         L2Z1q3i/AT2aXe4pCbcelG+djVm/y25VhU99439a0jOuu8umpfH8D3bg0B3vxGPCzAu/
         px3h69ZSSVs6GKadEzxmfOkoCcFVxrdbDEHKZCyYiGxerX57AB9F9PyhA+oW4f6PsQ1e
         cUrnotZfRg0UOC5r1+ZGm2ntjXhjrN+TCW2oMgn7EZrxKaqM4TsOOLk0ghNNgvm08F9a
         eR9B3M0Aobxjyci8nfsBxJCFQSh7XDc3Z2pQuyzT3g1wP12vA6ZzTi9X3EGWXiBm1HRm
         y/Vw==
X-Gm-Message-State: AGi0Pua/KAsAukF754IA2+dXCOGGmR+91W8caYHocPTJvO4ioD1XzlL7
        2yX0rqaynrWpcD2oPQeDE38TIPvd1isUPQGlBeDU1w==
X-Google-Smtp-Source: APiQypKK6WVF7jNOMbzOYGstLdxFuP03Og914DSw6UgaUl3VURf6RhYpE2KLwj09JfmwrN8oLKW+BCRRSdYt8gBuuKw=
X-Received: by 2002:a17:906:404d:: with SMTP id y13mr23435201ejj.43.1589380552850;
 Wed, 13 May 2020 07:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200506211523.15077-1-keescook@chromium.org> <20200512131655.GE17734@linux-b0ei>
 <CA+CK2bBMUxxuTBicQ7ihKpN3jK94mMjcNCXhnAXUaODce09Wmw@mail.gmail.com>
 <20200512155207.GF17734@linux-b0ei> <202005121111.6BECC45@keescook>
 <20200513073448.GG7340@linux-b0ei> <202005130045.EF013D12E@keescook>
In-Reply-To: <202005130045.EF013D12E@keescook>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 13 May 2020 10:35:16 -0400
Message-ID: <CA+CK2bAPv5u1ih5y9t5FUnTyximtFCtDYXJCpuyjOyHNOkRdqw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] allow ramoops to collect all kmesg_dump events
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   + reason: panic, oops, emergency, shutdown    (ordered by severity)
> >   + handling: restart, halt, poweroff
> >
> > Or we might just replace KMSG_DUMP_RESTART, KMSG_DUMP_HALT,
> > KMSG_DUMP_POWEROFF with a single KMSG_DUMP_SHUTDOWN.
> >
> > Then the max reason variable would make sense.
>
> That would work for me, yeah. Pavel, is that enough granularity for you?
>

Yes, I like the second approach: where we combine all shutdown type
events into a single type.
max_reason will have 4 levels:

   KMSG_DUMP_PANIC,
   KMSG_DUMP_OOPS,
   KMSG_DUMP_EMERG,
   KMSG_DUMP_SHUTDOWN,

If needed it is possible to determine from dmesg logs what kind of
shutdown was taken, because there is a message logged right before
every kmsg_dump() for these events:

249   if (!cmd)
250   pr_emerg("Restarting system\n");
251   else
252   pr_emerg("Restarting system with command '%s'\n", cmd);
253   kmsg_dump(KMSG_DUMP_RESTART);

276   pr_emerg("System halted\n");
277   kmsg_dump(KMSG_DUMP_HALT);

294   pr_emerg("Power down\n");
295   kmsg_dump(KMSG_DUMP_POWEROFF);

Kees, I will submit a new series with these changes soon.

Thank you,
Pasha
