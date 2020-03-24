Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC20DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EFF20774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585066465;
	bh=+QiXEXMAnm3fAQIcpcLK9nKpI9Dl3Rgu1TgTTIDoRVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z/9MHkXgnStnstR7Enfgn5qJzULrx+BKXTFflG9sWCJwFLgYexu6l88bS2Eh0lgCO
	 KQvCOLsDsSQIc1kZKJ/ekxLvlWpOZiMEIrqYCtU6G0xIpYcrb4dACMx/PZeEjnORCp
	 J2U8aL7PI32qY8PXxpTRArGCO+sPlYCFAzf+Ac0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgCXQOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:14:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33456 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCXQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:14:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id c20so13745944lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cV+EQz2uMh8RqjeKXm8R3NSZPSRV5ZBhvijMbinFHhs=;
        b=MZ5kH2ikYOBk3B/aSmgJFvz6FiSRFf4X14qLUgTFwMao4frxCdEMyla4j9S/rZoT3X
         sPALUof1YDQsQTFOL4MFBJK4OPCe5WtfKyvPEQS6PytlXNyT+0aO0v2QeRuvlHL8E1fC
         CcuWtrDrXFG/2UYIJGOYymrp9nX89kvbCLrUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cV+EQz2uMh8RqjeKXm8R3NSZPSRV5ZBhvijMbinFHhs=;
        b=ZYYqSLELVmiPoYED7KMC9pB5JsTyKoHkNC56dab+SB25d2qT0+O+OcVdhSpI9JwQVO
         fX5maQ/pmGWamylkyeqoDNemMYSxzlqjLN0tLVa4UOhV3alO8zVxzvUwC5yMtc8cMecj
         FhYIcXt4XVDhlUYj8BjJ/EDoyzUBjBLRFuuKhkjnfrpUsyzrhyVtpu8Wn86zkUaujLmf
         hGHrW+Q6TPfu6F+TMZq32FuRGmP1w0Jg7ab8UH0iQGau3ZlTJzZm6sEB3FUrclUTeCIu
         BwifD8koRVkTjQ2h4OEvK3ASDD3cu0Iy6VCufSTMmXPDnM2FVMTXCOEdfOO9ZDEOGRYi
         k7nA==
X-Gm-Message-State: ANhLgQ2SDmGH3q9/zHzewMNXZho4gD5I+bfu7BkzFG8IylkxjnbQZooN
        L7kvkA+nK/p5CS0lgHBoW5XO7D0Nrw8=
X-Google-Smtp-Source: ADFU+vvwvMXmu/1y5r/5O4tpWtgOuK7v+olhGJXwMlrqQcivg8bmlAx39LgMKoycNGaPuPh6YU5S1w==
X-Received: by 2002:a19:ad47:: with SMTP id s7mr17224603lfd.165.1585066461174;
        Tue, 24 Mar 2020 09:14:21 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m6sm10143789lfc.1.2020.03.24.09.14.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:14:19 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id w1so19195726ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:14:19 -0700 (PDT)
X-Received: by 2002:a2e:920c:: with SMTP id k12mr16500640ljg.209.1585066459287;
 Tue, 24 Mar 2020 09:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200324135603.483964896@infradead.org> <20200324142246.127013582@infradead.org>
In-Reply-To: <20200324142246.127013582@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 09:14:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
Message-ID: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 7:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Extend the static_call infrastructure to optimize the following common
> pattern:
>
>         if (func_ptr)
>                 func_ptr(args...)

Is there any reason why this shouldn't be the default static call pattern?

IOW, do we need the special "cond" versions at all? Couldn't we just
say that this is how static calls fundamentally work - if the function
is NULL, they are nops?

               Linus
