Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D659C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723132068F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582329463;
	bh=k+ULUmbuorxQI96yAjJm2ErkhZotLfYw5CcVTXDtYLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=07bcoUDnmYnVx4QH9jJZ/xDFHRcdgfar9UrLQcFf5FEpiNiZp9GhVSF0fIYQhPs8A
	 sKTf0M7+rjvXGMOVbHKAjOMcQdkvprolDj1Gkx+WsCgogMHJtlmCtSrkUUzP7hUyWV
	 Bi3dYZV4ZUUC6vQL48ryvfI5q11EjJoPMQRf/q9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgBUX5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:57:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39337 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUX5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:57:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id o15so3984954ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 15:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiG7pot6Y3vUQfXaE6EUO4Bu3OsHuA7R3tN5RSakjwg=;
        b=QO4Pn5apGPQaqsXMunZJXeak/y7+lxUjlyZKKwvgp/5FkLGq2dunBWlfMqDp6DR1Qo
         CNKPXP6AerT4mmZgD3dH3/tgPmvt/KInFN3PbivTiTmLnn4WgEw+3dGIcgQ6DLX5PnVo
         Ig3fufIr+k8nUB688CUzfLf2gICEFtcJVHakY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiG7pot6Y3vUQfXaE6EUO4Bu3OsHuA7R3tN5RSakjwg=;
        b=ftYToW1sVFUK6UQ81hYmSGAs9JO+j/BogvNL0prwyiYgNUGOTmrbM1Eyld7N6vhF5G
         oTezibx8zh0e395EpzpFtbKNbpv2MXZqap/CJBUA+48Le2G9pqkSCCKX3dOCv7VniOXh
         rB7VmmMYlqVtQCuzLW4Gp+G79ji5jRtMsFIEk7tRjwwAr6HEMW6BpLqA6/U/keCLhd7h
         Ci8xleNr2MXdsZfrFL5WyB5pN9ABarZZzTycgGlQgy1AKZQR4ToRF1DtCHJY29Rhug5b
         JOj8S5F+N4vQYSB0pzlpbIHCtt45cSSiMd2cWmqYUdpE00zs1hKKFq+FV09DOzIpgc0H
         u3Cg==
X-Gm-Message-State: APjAAAUmlss+w1ndoKyRb/sRp6E+aOpybkrJuVqoMpo4ycnQCCV0C2kA
        XmfdA+5KcS5qrkxOicWOV5p/N/B0VZ8=
X-Google-Smtp-Source: APXvYqzo58wS1PlB8e77hW8DPhiq70xqlZMX5sEZKck+iF4eAKZ4zwZ8Fl2+ujIFZY1JYjwss6BsVw==
X-Received: by 2002:a2e:8e84:: with SMTP id z4mr22526088ljk.207.1582329458605;
        Fri, 21 Feb 2020 15:57:38 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id n13sm2423210lji.91.2020.02.21.15.57.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 15:57:37 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id x14so3935850ljd.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 15:57:37 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr2760083ljj.265.1582329456973;
 Fri, 21 Feb 2020 15:57:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wi4uO+Djqr4Jc1TnCofwxUTuXHtgkgwnVX86q06UGV6DA@mail.gmail.com>
 <6A09F721-0AD9-4B86-AB3E-563A1CF5ABDE@amacapital.net> <202002211506.2151CA26@keescook>
In-Reply-To: <202002211506.2151CA26@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Feb 2020 15:57:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjL-4=YfvQb_pLhK5oH1QL2j-JCt-Z+S-r86-H__Vow0w@mail.gmail.com>
Message-ID: <CAHk-=wjL-4=YfvQb_pLhK5oH1QL2j-JCt-Z+S-r86-H__Vow0w@mail.gmail.com>
Subject: Re: [PATCH] mm/tlb: Fix use_mm() vs TLB invalidate
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 3:10 PM Kees Cook <keescook@chromium.org> wrote:
>
> Why not just fail after the WARN -- I wrote the patch for the (very few)
> callers to handle the errors, clean up, and carry on.

Can it actually fail? Or is this all just "let's add new error
conditions that make the code harder to read because they make no
actual sense"?

It's not clear that it's worth handling "cannot happen" situations. It
might be worth warning about them (that's questionable too, but at
least there's an argument that you "verify that it can't happen").

But having the error condition of a "cannot happen" situation then
percolate down and make other code more complex seems to be only a
downside.

It's not even security or "avoid data corruption" at that point. At
the point where you start adding more complexity for things that
aren't supposed to be possible in the first place, you're only going
to cause bugs.

Maybe not immediately. But "illegible code" ends up being "buggy code"
a decade later.

               Linus
