Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48ECC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8D1207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598130948;
	bh=C0APGw5O96NJiDVShoAe5dfW9W+XYLbqskxtwlBv1aE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D2bnlbYmkWmLcyDqTZQiZFE4Uy2IK32ZDWliBweaxmJg+naNvpzFrAELBDT4pcyg5
	 mM8ZJPOPzswEsFUJCrtFF3nH/4ZTNo59G6hdT8mZcZLY64VRLhrzoLTaiZIkexPO5Z
	 4eSSX6f3P1iN1PCbW2Q8V5mcrQHyfq1qcWnFQQP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgHVVPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 17:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgHVVPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 17:15:43 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31266C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 14:15:43 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so7130726ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQ1VHHFNzEpZ1EMHBpKzmWH6fJ7+QYWkioKmOH/oB6g=;
        b=NZZaHKQm1zDcEZ5S+gxOSlhIaTKUyw4L+YXdNay32LhUOjThUGzLN0SSv1vts24S2t
         W5zB2naqupRAsX+iFjttrJtQx/j9MAkNJ59zdQ7yW4ZZ/g5OxL0tHvgnyVkE7WAp7AEc
         g8hcrhmoT1r5styIwvbi7w4MPL+5KwfdUzl0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQ1VHHFNzEpZ1EMHBpKzmWH6fJ7+QYWkioKmOH/oB6g=;
        b=FTgCfcrgYxP2qCtAE0h7WJra7DWbbgKQFUC4KboLUUmkQFrJELB50me9gFlDKrQ1VA
         d5q/2VVSGaqA08wiDcjpvQO/hVSOEDOV+y5acnG6+IXdZA58hZ3KsWqVNdYVRQND5+JH
         Y16GI5YEefCEG0VbTDhI+p5DCt1AUh3VvhCYSUzaf7avLjGYjVctaH9fQkHFqbTFoVRp
         iWOw8LeRSyn2o3oSXj2Ibmb4Ma6oTV+xf3Dumf8zBC0f0+nZQA+Hw3pdV3ZITI7GqWPK
         Dy5WzBFoKIFUAmjwssM1eUr2CZxyLDsyUAO7QbNNQNiv3jd7b7wrLwJy1bBcqFfrvslL
         H/JQ==
X-Gm-Message-State: AOAM533cJdFjaNtRHTbvl31bemaKek7s9QA8T6jStkhkgK3hmgEzXn0T
        cXFwpX0EZZXkmM9EnhFjKluwgHDu2Ul7/Q==
X-Google-Smtp-Source: ABdhPJy4CyEFk5iVgjYIkJ5GzGQVejlUMULl1iJGSBplSg0cCv79l3o3UPWoK69ex9wmIKh0Wwo/zQ==
X-Received: by 2002:a17:906:4c97:: with SMTP id q23mr9027942eju.11.1598130941156;
        Sat, 22 Aug 2020 14:15:41 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id dr21sm4239607ejc.112.2020.08.22.14.15.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 14:15:40 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id bo3so7130693ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 14:15:40 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr4047721lfc.152.1598130525569;
 Sat, 22 Aug 2020 14:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <87h7t6tpye.fsf@nanos.tec.linutronix.de> <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan> <875z9dioll.fsf@nanos.tec.linutronix.de>
 <20200820130641.GA536306@rani.riverdale.lan> <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan> <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de> <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org> <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
 <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com> <CANiq72=3iOh5Z_rboZf-_GUpBE2LUUv3yPKOVNN_XmaNswdNSw@mail.gmail.com>
In-Reply-To: <CANiq72=3iOh5Z_rboZf-_GUpBE2LUUv3yPKOVNN_XmaNswdNSw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Aug 2020 14:08:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaVW4FQjdwaicLFE4kiqr18rk6V50CuU-ziUPyRFjHrg@mail.gmail.com>
Message-ID: <CAHk-=whaVW4FQjdwaicLFE4kiqr18rk6V50CuU-ziUPyRFjHrg@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 11:17 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> However, the important question is whether those users/companies care
> about running the latest kernels. Many of those definitely do not want
> to touch their kernel either. For those that do, there are several
> longterms to pick from that still support 4.9, as well as other
> workarounds.
>
> Thus I am usually in favor of raising the minimum whenever new hacks
> are required to be added. On the other hand, we already raised the
> version twice this year and it is not clear to me what is the minimum
> version we would need to go for to ensure this does not bite us.

Yeah. The good news is that I haven't seen a lot of pushback on the
gcc version updates so far. I was expecting some complaints. I haven't
seen a single one.

That may be because people did end up finding it very onerous and
complained internally on channels I haven't seen, but it might also be
indicative of us having perhaps been a bit too timid about compiler
version updates.

However, in this case, can we just leave that old "__force_order" hack
alone, and to work around the clang thing, just make a dummy
definition of it anyway.

Alternatively, just use the memory clobber. We use memory clobbers
elsewhere in inline asms to make sure they are serialized, it's not
normally a huge problem. Both clang and gcc should be smart enough to
know that a memory clobber doesn't matter for things like local
variables etc that might be on stack but have never had their address
taken.

Or are there other cases than that particular __force_order thing that
people now worry about?

             Linus
