Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558D5C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299EB2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfrmyTTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCZOp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:45:57 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40301 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbgCZOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:45:57 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so2486365pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zf3SgpTviOz3lQwF+V98hRrPph7fFIwjiGfFOD+A1SU=;
        b=XfrmyTTR0L7MXh44tl5zWiYrnemvAZkEiuBg3/oNahrmvE42MlqkKkqjjd15C4xe/D
         XhLoeujzT21hjEgZ158tUE7uMNAZOXPey3O+XlobUVICgUziI2rA7FlMcVascSWXD2vK
         F1ZOxgH+IRfCiQZ5Z6TVdydKwsjgT/au8U7Hk6QhliPgpLUUeShvzFMKh9qXRZ1wal8b
         l7Jpqo7Z9o+mvTW8HyWcd6dIyHiQuQhyGmW1fVxiIdovLrW4NISxcP7fvtXUDNvl3gp/
         jwB6ysndmLh9ePO6BzlyjKKClMY607sFQD6GyAL28Bun+Kq43zNu65zaYUgDjVwiu3hk
         Cu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zf3SgpTviOz3lQwF+V98hRrPph7fFIwjiGfFOD+A1SU=;
        b=hOk5dm0+cA1s/7WZJI2TLFVdkqc0I4VRbkzfYkZH5SL2W8TWwtErNNqP07z9mb8oTv
         tMUanC0C1MriEj/voqb1i2FHos7zoGXM0T9/1SkJ8+/R/Wl9pZUJWb/el2D3PYmEgCZX
         27Ji8zU2YgLDQq6AT+8Ibaz86FiuoYdj4f319gwiXPi7b/ihSLQfgSAufH2kLr63M61r
         RzS36Rn5kHFYvBWjKxybRimMbdaqF2Sxas+Ip7x6pFfZ2Fksfi7eDsFRkLIsQdbf6TyR
         TlqETmRNC74qe+k0jqIrVeaRmMX3JP29TzUid2vf95hTYOLSJi7Y2HcujgTKleWH2M6a
         lJ+Q==
X-Gm-Message-State: ANhLgQ0XlI2XTdew/tG9zpKMrRhui1HVfx03loISmk1OTxzeO3lv0FYx
        CzI2YIf2eJo88OkAD+JY4V3nUDVbTlzUwPDWSrMrtllG
X-Google-Smtp-Source: ADFU+vtxsH9sLh9tX9lheGQtfWCJVm0LpiX0BO9m49++P+VTw8qUFrSLHlR0DzEg9rTQmxaBMlAiYO3c2yTgGRsZDVQ=
X-Received: by 2002:a17:90a:2541:: with SMTP id j59mr376656pje.128.1585233955883;
 Thu, 26 Mar 2020 07:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200320201539.3a3a8640@canb.auug.org.au> <ca0078e2-89b5-09a7-f61e-7f2906900622@infradead.org>
 <20200324164709.ux4riz7v7uy32nlj@treble> <39035493-9d5b-9da3-10d4-0af5d1cdb32a@infradead.org>
 <20200324211303.GQ2452@worktop.programming.kicks-ass.net>
In-Reply-To: <20200324211303.GQ2452@worktop.programming.kicks-ass.net>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 26 Mar 2020 15:45:44 +0100
Message-ID: <CAAeHK+zQDFAnST_EeLGZWVEk10N0O+Ba06rv0QaxE0-BMSC94A@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 20 (objtool warnings)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:13 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 24, 2020 at 10:53:05AM -0700, Randy Dunlap wrote:
> > >> kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc()+0x89: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
> > >>
> >
> > config-r1510 is attached.
> > and kcov.o is attached.
>
> I'm thinking this is because of commit:
>
>   0d6958a70483 kcov: collect coverage from interrupts
>
> Which has:
>
> @@ -1230,6 +1230,9 @@ struct task_struct {
>
> +       bool                            kcov_softirq;
>
> @@ -145,9 +157,10 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>
> +       if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
>
> And this __ubsan_handle_load_invalid_value() is verifying a bool is 0,1.
>
> Another reason to hate on _Bool I suppose...
>
> Let me see what to do about that... :/

Sent v4 patchset with a fix.
