Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F28C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EF32465B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSKlPPTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgBXWRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:17:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37237 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXWRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:17:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id q4so486681pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4+q1hPU+vBxz37Lq9CoAPE294r5aS1T2lyZxNwgE7xE=;
        b=SSKlPPTCLk+ZA4hJeCNpQagaJofineoLXz01RYCuKFEzavebiZvXMe7yqp4UxCm7hR
         ebFQty2zUoBZEgZ4uXFMEWn1kJgSkOcXVzXdJ9ptz5l8HG/Z7HkrE9VdJHyBvDQfd07Z
         mpYsHoTXbnCbxN125vQht/V1PsSvLr2lSxM6P5ADJi0xOVftEOzTdjWSIGRNFCc+PlPK
         XX9OI/HDJitZM4JRHLJHXLdfBZw7430jgt9H4CprGyScaBqx8OowhuLlEVuQRUPPLLFa
         1W2V0AHXCniZb3GE1yCFYnS6gaP2y17y8w+nOPrt82XkCLyexiV37RlWT6YhqrD3NYJM
         3KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4+q1hPU+vBxz37Lq9CoAPE294r5aS1T2lyZxNwgE7xE=;
        b=RQU1NsapcP/3O5lOauZnSLtwVbGUH6DnXTXrGUIdirdhcb9gfbaTB2/Luy2pgY7GZL
         0DyGjm7A2UmD9VDIoolYV6yNSHTJT/kfw9f6NbmjYT3eB8VWwpyGAID6ArxvyLPhSXnn
         m0a076rF0wTiZYrdkqp9wve8Hx6vs6oXMBqXFRO5ulrGmRn84v6AMS5Mp6/iySqA32vg
         Bb/4U5TOw3kMsCBhXQ5agZIJuqPBhuie1vEyVhHkF40cXNf5G99CHygJFJiyUfpWZkHK
         OmOHyJpVeZBtIYrkJTRYmUvx+4092fRGqkRgVZvBzDVzDk6U7JWj7WQ+xdZgwa4C5fW8
         iTLQ==
X-Gm-Message-State: APjAAAWy1mNRmDn7GcuLDRCzKfNKWZFcv3UOV4E8KHlkFCTiSTkJpznh
        6/xFGZ0eNkmG9ghsOpfbwVY05g==
X-Google-Smtp-Source: APXvYqyJp0jJZy0SVYCYgXu6yTVkflUbMiRTojWG9+eJ5dOvf6ludw3tkwGKFpguV/1vuiPul5Y/4w==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr1411740pjz.98.1582582626875;
        Mon, 24 Feb 2020 14:17:06 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id l2sm10574403pgp.0.2020.02.24.14.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:17:06 -0800 (PST)
Date:   Mon, 24 Feb 2020 14:17:03 -0800
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200224221703.eqql5hrx4ccngwa5@google.com>
References: <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <alpine.LSU.2.21.2002241319150.12812@wotan.suse.de>
 <CAKwvOd=nCAyXtng1N-fvNYa=-NGD0yu+Rm6io9F1gs0FieatwA@mail.gmail.com>
 <20200224212828.xvxl3mklpvlrdtiw@google.com>
 <20200224214845.GC409112@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200224214845.GC409112@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-24, Arvind Sankar wrote:
>On Mon, Feb 24, 2020 at 01:28:28PM -0800, Fangrui Song wrote:
>> Hi Michael, please see my other reply on this thread: https://lkml.org/lkml/2020/2/24/47
>>
>> Synthesized sections can be matched as well. For example, SECTIONS { .pltfoo : { *(.plt) }} can rename the output section .plt to .pltfoo
>> It seems that in GNU ld, the synthesized section is associated with the
>> original object file, so it can be written as:
>>
>>    SECTIONS { .pltfoo : { a.o(.plt) }}
>>
>> In lld, you need a wildcard to match the synthesized section *(.plt)
>>
>> .rela.dyn is another example.
>>
>
>With the BFD toolchain, file matching doesn't actually seem to work at
>least for .rela.dyn. I've tried playing around with it in the past and
>if you try to use file-matching to capture relocations from a particular
>input file, it just doesn't work sensibly.

I think most things are working in GNU ld...

/* a.x */
SECTIONS {
   .rela.pltfoo : { a.o(.rela.plt) }  /* *(.rela.plt) with lld */
   .rela.dynfoo : { a.o(.rela.data) } /* *(.rela.dyn) with lld */
}

% cat <<e > a.s
  .globl foo
  foo:
    call bar
  .data
  .quad quz
e
% as a.s -o a.o
% ld.bfd -T a.x a.o -shared -o a.so
