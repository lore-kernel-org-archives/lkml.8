Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E66C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 19:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6730A20657
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 19:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHWK6PzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgEQToe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 15:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgEQToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 15:44:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFC7C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 12:44:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x10so3293458plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rw0Ndp5myB1Bal+4CE0r9ds1UFnKxD+e83Qnd9thPnk=;
        b=QHWK6PzJdVPz0KmIlJJX4OWjlMiwz4IWqykFFE2pzYfO4QmMR8AsntikrP2YKf/QfL
         l+XW9WPR+ygSdwWIV+7KxE4ESG+a4YkoCmeOc+gK34Fui3OcLWfb1ND5FoAnuwc0IZ77
         MULqVr2QyTgXVjntml+MZd7xkIUutd/15IrwLX16ItCysckS+ckMYOvYG+MFVshxn2PR
         StnMhQEHjZX77tm5vsGmTNGySXtDE/6z6/5tCbIg2GA/V8NE+fX2syRtICAG8Nzo0Pwp
         ECBERfYXwbQ7oW51xi53lNMy6N/Ub/0e+jBXsTmoQUqI38ri39WnS5L+Exr5fuhwWpo3
         9/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rw0Ndp5myB1Bal+4CE0r9ds1UFnKxD+e83Qnd9thPnk=;
        b=k89NKa/I0OGUTA1Z1I8oEB91RGX0jq+lqWMLkJJuU/GJB37V+reeMataRDrnqL20r7
         H2d/7IYDd8KjiysEiY0OuYrd9vVxn+AZ5AwCg2ck5Trc/lDvG2n6Yk+ZeysNmp0FaX84
         KmUoYdOb0GbQ4qV5ucoIP9eO9rw19Ca7gfi/GGyFqopOtHPlrutstrUOSL/gFJo3Ez5i
         dMHp5/NcMLA7UoPFVWKDEgVgTXIKbZJ5VBzgwAS8EJyOjGKv6K0f17tIYPIivWoBhidS
         CyGXgZyO96RVGVWyQ5Gzx+UxqDNrGoXmiygxvmAJx8YN6mj6JXBrYzrCkupRUnSnWGor
         DmSQ==
X-Gm-Message-State: AOAM533N0Ly5wIiTwmBIS7I4kBKHIERMiWkv7qWQwcKuSq6Ef9sFKZkI
        byt+H1u4c1n9OCHhOCnU4JN1mw==
X-Google-Smtp-Source: ABdhPJxgdUvgYcCcWFyGBXL7R1zLEEfWrD5l+m//ZcdTo7zw1brGKnM19RzxrRav+KUdT7Nn/qt8Wg==
X-Received: by 2002:a17:90b:1004:: with SMTP id gm4mr16090867pjb.35.1589744673401;
        Sun, 17 May 2020 12:44:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id s102sm6669508pjb.57.2020.05.17.12.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:44:32 -0700 (PDT)
Date:   Sun, 17 May 2020 12:44:29 -0700
From:   Fangrui Song <maskray@google.com>
To:     Dmitry Golovin <dima@golovin.in>
Cc:     Borislav Petkov <bp@alien8.de>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: allow a relocatable kernel to be linked with
 lld
Message-ID: <20200517194429.scwhfr4l4bv4h3ux@google.com>
References: <20200501084215.242-1-dima@golovin.in>
 <20200515185051.GC19017@zn.tnic>
 <602331589572661@mail.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <602331589572661@mail.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-16, Dmitry Golovin wrote:
>15.05.2020, 21:50, "Borislav Petkov" <bp@alien8.de>:
>>
>> I need more info here about which segment is read-only?
>>
>> Is this something LLD does by default or what's happening?
>>
>
>Probably should have quoted the original error message:
>
>    ld.lld: error: can't create dynamic relocation R_386_32 against
>    symbol: _bss in readonly segment; recompile object files with -fPIC
>    or pass '-Wl,-z,notext' to allow text relocations in the output

Do we know where do these R_386_32 come from?

When linking in -shared mode, the linker assumes the image is a shared
object and has undetermined image base at runtime. An absolute
relocation needs a text relocation (a relocation against a readonly
segment).

When neither -z notext nor -z text is specified, GNU ld is in an
indefinite state where it will enable text relocations (DT_TEXTREL
DF_TEXTREL) on demand. It is not considered a good practice for
userspace applications to do this.

Of course the kernel is different....... I know little about the kernel,
but if there is a way to make the sections containing R_386_32
relocations writable (SHF_WRITE), that will be a better solution to me.
In LLD, -z notext is like making every section SHF_WRITE.

>>
>> IOW, don't be afraid to be more verbose in the commit message. :)
>>
>
>Tried both BFD and LLD for linking to understand the difference more and
>rewrite the commit message, and came to the conclusion that the patch is
>wrong. I will submit v2 when I figure out the correct solution.
>
>Regards,
>Dmitry
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/602331589572661%40mail.yandex.ru.
