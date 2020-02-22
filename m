Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F10C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5CB206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LOr6ninH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgBVS6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:58:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47056 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVS6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:58:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so3050884pfp.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 10:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=euAwmf9ZhKSh37U9bkj0mMT6F/SgMII2G3vEqdzGF+E=;
        b=LOr6ninHef6EqwLrCnhGqXf8avbYzlLKURAE+lq3h/R9/U2FLomgbcvSelltYM8q20
         6YE4sduH4cyP8TaFXw0doD0t8Xxi+TEQQFdwu40eGlND0v3d/dK6G4Y+wsz9Dp3B+sUL
         MKnIQ1P/hOE2jopPzo0y5vM7UlULyBIqKltSwfK13JqAnMXWsyZ05GUjr6OpmH3/3aX/
         BlC8MuWnUj8ADf3aV8bY43/LVNXL74o4RXSI9LgJt5DuEt11zu0lKDlmw5lmnMTmRQvn
         YvkwCHhbBBzC4EHP/gsjzo9uTukADuV+PHNC06ndCo/SVuu15d7HgjFkIggeyO467QKX
         3NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=euAwmf9ZhKSh37U9bkj0mMT6F/SgMII2G3vEqdzGF+E=;
        b=ulGGaW8C3XaWBQqNpAgDxx4z4ZJS5vjr+hgcS9BW9hAE1kr2SOoWf6hVHc8ZCQ3frk
         u8hR8S02+FbrKrZsVR8cFnO/pitTngNQL27i/B3eTlffXJBiP0uQCdjEqd6yV4/O9Ofp
         uP7cV8bY5p+jHj+ffzqcTgT1kBprw5mUdM5KepPt0HsbrL+xHG0xiWQdYETRfTkfsyrP
         9ly+ysdB1j0U4bEB6kISdQ7FqjWYZSSjquTEjkOfzfeHeJFMes0CRMbWEuR0q/xbcaaR
         lcPx5UKoe2dU4CF5X8WgEtDSJVutyDbPoakGwdcIrtmVhKNZllPROiQHYcLj4HwUmWl3
         f8lw==
X-Gm-Message-State: APjAAAUokJeoGRXAqjdDdLaNy9j9dzTpKIB41KpQB68NuCvBC35jMWax
        NP4wLEXOanz1T4hCXB3J+0xNMA==
X-Google-Smtp-Source: APXvYqygas/dxK1EVtQA7DXEn1HcH6FBvhHP+BJJNnhP2oSpzCNCyRzeAR16wqUW9M35Ib6O8/B9ig==
X-Received: by 2002:a63:7453:: with SMTP id e19mr16713707pgn.50.1582397891896;
        Sat, 22 Feb 2020 10:58:11 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id f43sm6640138pje.23.2020.02.22.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 10:58:10 -0800 (PST)
Date:   Sat, 22 Feb 2020 10:58:06 -0800
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
Message-ID: <20200222185806.ywnqhfqmy67akfsa@google.com>
References: <20200222164419.GB3326744@rani.riverdale.lan>
 <20200222171859.3594058-1-nivedita@alum.mit.edu>
 <20200222181413.GA22627@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200222181413.GA22627@ubuntu-m2-xlarge-x86>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-22, Nathan Chancellor wrote:
>On Sat, Feb 22, 2020 at 12:18:59PM -0500, Arvind Sankar wrote:
>> Commit TBD ("x86/boot/compressed: Remove unnecessary sections from
>> bzImage") discarded unnecessary sections with *(*). While this works
>> fine with the bfd linker, lld tries to also discard essential sections
>> like .shstrtab, .symtab and .strtab, which results in the link failing
>> since .shstrtab is required by the ELF specification. .symtab and
>> .strtab are also necessary to generate the zoffset.h file for the
>> bzImage header.
>>
>> Since the only sizeable section that can be discarded is .eh_frame,
>> restrict the discard to only .eh_frame to be safe.
>>
>> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>> ---
>> Sending as a fix on top of tip/x86/boot.
>>
>>  arch/x86/boot/compressed/vmlinux.lds.S | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> index 12a20603d92e..469dcf800a2c 100644
>> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> @@ -74,8 +74,8 @@ SECTIONS
>>  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
>>  	_end = .;
>>
>> -	/* Discard all remaining sections */
>> +	/* Discard .eh_frame to save some space */
>>  	/DISCARD/ : {
>> -		*(*)
>> +		*(.eh_frame)
>>  	}
>>  }
>> --
>> 2.24.1
>>
>
>FWIW:
>
>Tested-by: Nathan Chancellor <natechancellor@gmail.com>

I am puzzled. Doesn't -fno-asynchronous-unwind-tables suppress
.eh_frame in the object files? Why are there still .eh_frame?

Though, there is prior art: arch/s390/boot/compressed/vmlinux.lds.S also discards .eh_frame
