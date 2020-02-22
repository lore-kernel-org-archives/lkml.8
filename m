Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540BAC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBF4206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1hFllBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgBVVBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 16:01:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52212 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgBVVBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 16:01:05 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so2309051pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 13:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=laEHxH1L9Tdj6O2OTgMojiMOqUUb6PedrFi1g5j2gKw=;
        b=Q1hFllBqSn4fR6AzHGxaLoq0TcAbiOW4B6TXVyl+M2UM3D4qQ4964Ctex/XFU1tGyK
         p4sSTdV2w4cFfCI9XEQElJygM/3XzhR8EFSUSvKz7mNzOEMB+cHMbexGgCjICFh2b9M0
         k0k5iaTF06fD26i1vgUA31A0EdTX8LJvk9iEUSgr2JYUlx9/wYBj3wVJCSkVC7YsPR6O
         Q6hbctC7OjLYEM0wXL150Y4H6JU9goQrzKhXP5WTyHmgQhnCJ15UN4Mmi21hgr+P5kCL
         8lpPKAdaUWw04SHJie6s4ltpdlFqGOi1vsnXmhNF/pRtr3ZV4ozshwJfy7NngXubhExM
         MVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=laEHxH1L9Tdj6O2OTgMojiMOqUUb6PedrFi1g5j2gKw=;
        b=DAtDUZwzs7x1S/sZ8Fpe75csTuCeUjTABNCFf9OTtvdEFBoOMSXlDQuNvWsVHi+t9+
         uiz3DZUy53ki6puXtzh7M+jCWN4ugIwrgHNEitcAklM5aYT4NNfb+fhp1Y6GnfMxIYhG
         G+Xe0xawvSoqw2l6g6sQlnHrBiG6MkV3R9H392LhMs75RjTNy6I+mUdS52l7+UCf9Ig0
         0A4f4Ua67B3aKaaR9Ic6+BG87ZB3W+cpu96xPr7AOn76BxweMm3oWGhDp8MGQN4uYOhD
         CrLVke74fqnWBnsh+pwJAGh56j4rCS0gMsINh3AQIsgyzUnWJ+r1aUdOrpRQ75MSbOng
         MTVA==
X-Gm-Message-State: APjAAAXG+jo0hZeKCRLtoOxmjScIZugI5OSGqjq6eAQ7Eux8HZsgyrLw
        AdztTzXQ1lwGVjMxcrMn/jWrYA==
X-Google-Smtp-Source: APXvYqxoMTRXvtk+LvyaNv3ILd1j6HwkVq68c8JHrJjI4QZ8TdCjLQMCRi/WdV/nRpCfwkVL6khcLw==
X-Received: by 2002:a17:902:5a0c:: with SMTP id q12mr43016059pli.301.1582405264875;
        Sat, 22 Feb 2020 13:01:04 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id 72sm7400306pfw.7.2020.02.22.13.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 13:01:04 -0800 (PST)
Date:   Sat, 22 Feb 2020 13:01:01 -0800
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/boot/compressed: Fix compressed kernel linking with
 lld
Message-ID: <20200222210101.diqw4zt6lz42ekgx@google.com>
References: <20200222164419.GB3326744@rani.riverdale.lan>
 <20200222171859.3594058-1-nivedita@alum.mit.edu>
 <20200222181413.GA22627@ubuntu-m2-xlarge-x86>
 <20200222185806.ywnqhfqmy67akfsa@google.com>
 <20200222201715.GA3674682@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200222201715.GA3674682@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-22, Arvind Sankar wrote:
>On Sat, Feb 22, 2020 at 10:58:06AM -0800, Fangrui Song wrote:
>> On 2020-02-22, Nathan Chancellor wrote:
>> >On Sat, Feb 22, 2020 at 12:18:59PM -0500, Arvind Sankar wrote:
>> >> Commit TBD ("x86/boot/compressed: Remove unnecessary sections from
>> >> bzImage") discarded unnecessary sections with *(*). While this works
>> >> fine with the bfd linker, lld tries to also discard essential sections
>> >> like .shstrtab, .symtab and .strtab, which results in the link failing
>> >> since .shstrtab is required by the ELF specification. .symtab and
>> >> .strtab are also necessary to generate the zoffset.h file for the
>> >> bzImage header.
>> >>
>> >> Since the only sizeable section that can be discarded is .eh_frame,
>> >> restrict the discard to only .eh_frame to be safe.
>> >>
>> >> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>> >> ---
>> >> Sending as a fix on top of tip/x86/boot.
>> >>
>> >>  arch/x86/boot/compressed/vmlinux.lds.S | 4 ++--
>> >>  1 file changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> >> index 12a20603d92e..469dcf800a2c 100644
>> >> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> >> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> >> @@ -74,8 +74,8 @@ SECTIONS
>> >>  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
>> >>  	_end = .;
>> >>
>> >> -	/* Discard all remaining sections */
>> >> +	/* Discard .eh_frame to save some space */
>> >>  	/DISCARD/ : {
>> >> -		*(*)
>> >> +		*(.eh_frame)
>> >>  	}
>> >>  }
>> >> --
>> >> 2.24.1
>> >>
>> >
>> >FWIW:
>> >
>> >Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>>
>> I am puzzled. Doesn't -fno-asynchronous-unwind-tables suppress
>> .eh_frame in the object files? Why are there still .eh_frame?
>>
>> Though, there is prior art: arch/s390/boot/compressed/vmlinux.lds.S also discards .eh_frame
>
>The compressed kernel doesn't use the regular flags and it seems it
>doesn't have that option. Maybe we should add it in to avoid generating
>those in the first place.
>
>The .eh_frame discard in arch/x86/kernel/vmlinux.lds.S does seem
>superfluous though.

Yes, please do that. I recommend suppressting unneeded sections at
compile time, instead of discarding them at link time.

https://github.com/torvalds/linux/commit/83a092cf95f28696ddc36c8add0cf03ac034897f
added -Wl,--orphan-handling=warn to arch/powerpc/Makefile .
x86 can follow if that is appropriate.

I don't recommend -Wl,--orphan-handling=error, which can unnecessarily
break the builds.
