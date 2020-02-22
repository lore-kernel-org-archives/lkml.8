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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335CAC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0381E2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIIzMWrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgBVHVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:21:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45340 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgBVHVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 02:21:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so2137064pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 23:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bv75KEUd02gxsaskLabjo9rQm7ohDzez9MAAHQVvNPs=;
        b=nIIzMWrQ61vFJCdvVuu1EpE3KLUcD56k/uHQiNswwZveACfL6p0dGFnY/z2GPmi/II
         4Zy7NrmsPWBiOE0tHx5jI9Ngt6UmHyU9ssMtIueOUEQYydYZ3EVjPzuJ+A3Gp6eN1Qle
         rZjrZufPr4kmfFcSUpiIVxukT/AItZehjG3ozd+vaV5zeMEfUp9BhqtPFgA6l6UbtxE9
         gUv9aZmqzqAa7v3T2RRqrjcmj/d2Q0/kg6h1RrAs5zf+hWnlpkMavbVyb2S+B3deVJf1
         X1dxOp5e03jeZ2EU72DrkIXuOpVmLOI4pS/7b5w+yguBuRkBgpdxHPwJsOdMde4s9Jo2
         dikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bv75KEUd02gxsaskLabjo9rQm7ohDzez9MAAHQVvNPs=;
        b=h6LdJq69jV+udJHem37XTk5OAOjQrI50R7fhYUf40upCug6Fe9sFsVaAecWL1RFaKf
         D6YYUHXHDXBeByElUlv7GBrT99J+t+iX1JRVH4diTFKOnE1KcGXcPg5DuN5EV8LRHuG6
         +nfC+t69LIni8E8NnrSnxgB2JJi32nOxfRtwwTRaJdBScM5c2qYmeQ3DgrxrlswQA9cq
         lAy3dY4YcPc4tMuoHKxcVT0jZgD/1Y+pVv/jUqlxlM9lZ/iSnyR0oDNFfNQ7TYV2UCp1
         gBxAUQatYbQ5TDIW2CuwEzdRkoEWgOTkVcjMvgUh1INSiY0KroSjfylFT0UrRJZz8w4n
         D5Wg==
X-Gm-Message-State: APjAAAXK3WTACm2y10jH/TX2EIml9UdCS0DqwRgtvHfzqT7B1CKwswVL
        JMS3sDnprYnHqRTAa8+hf7JVNw==
X-Google-Smtp-Source: APXvYqyreADcEN9a6bMD66OJPc8mb/Gg2NN93hRmYUYHbl3JZzHSDyOlbmdP64hdViGpt+A5gaav0Q==
X-Received: by 2002:a05:6a00:2c1:: with SMTP id b1mr42205921pft.80.1582356107845;
        Fri, 21 Feb 2020 23:21:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id n2sm5024772pfq.50.2020.02.21.23.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 23:21:47 -0800 (PST)
Date:   Fri, 21 Feb 2020 23:21:44 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222072144.asqaxlv364s6ezbv@google.com>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-22, Nathan Chancellor wrote:
>On Sat, Feb 22, 2020 at 07:55:21AM +0100, Borislav Petkov wrote:
>> On Fri, Feb 21, 2020 at 10:08:45PM -0700, Nathan Chancellor wrote:
>> > On Thu, Jan 09, 2020 at 10:02:18AM -0500, Arvind Sankar wrote:
>> > > Discarding the sections that are unused in the compressed kernel saves
>> > > about 10 KiB on 32-bit and 6 KiB on 64-bit, mostly from .eh_frame.
>> > >
>> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>> > > ---
>> > >  arch/x86/boot/compressed/vmlinux.lds.S | 5 +++++
>> > >  1 file changed, 5 insertions(+)
>> > >
>> > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> > > index 508cfa6828c5..12a20603d92e 100644
>> > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> > > @@ -73,4 +73,9 @@ SECTIONS
>> > >  #endif
>> > >  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
>> > >  	_end = .;
>> > > +
>> > > +	/* Discard all remaining sections */
>> > > +	/DISCARD/ : {
>> > > +		*(*)
>> > > +	}
>> > >  }
>> > > --
>> > > 2.24.1
>> > >
>> >
>> > This patch breaks linking with ld.lld:
>> >
>> > $ make -j$(nproc) -s CC=clang LD=ld.lld O=out.x86_64 distclean defconfig bzImage
>> > ld.lld: error: discarding .shstrtab section is not allowed
>>
>> Well, why is it not allowed? And why isn't the GNU linker complaining?
>
>No idea, unfortunately I am not a linker expert and the patch that
>changes this in lld does not really explain why it adds this
>restriction:
>
>https://github.com/llvm/llvm-project/commit/1e799942b37d04f30b73f6a9e792d551dadafeea
>
>CC'ing Fangrui as I don't know George's email and he is usually
>responsive to ld.lld issues/questions.
>
>Cheers,
>Nathan

In GNU ld, it seems that .shstrtab .symtab and .strtab are special
cased. Neither the input section description *(.shstrtab) nor *(*)
discards .shstrtab . I feel that this is a weird case (probably even a bug)
that lld should not implement.

In GNU ld, the following is not useful, while lld will discard the
synthesized .strtab as requested:

   /DISCARD/ : { *(.strtab) }

I think it is better making the intention (retaining .shstrtab)
explicit, by adding a .shstrtab beside /DISCARD/ :

   SECTIONS {
     ...
     .shstrtab : { *(.shstrtab) }
     /DISCARD/ : { *(*) }
   }
