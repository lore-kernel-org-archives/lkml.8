Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F3EC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 20:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418FF206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 20:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F53zer16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBVURT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:17:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33518 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgBVURT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 15:17:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so5299254qkm.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 12:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/ySdKTZFlFCT4Win5U1jB4XU2Vrkoz7ZLdDWOfcGHA=;
        b=F53zer16nQMz28VvlSk6jANwD4MQI/lAVH31QS062jUTSPs5LhKMEHsMhmQ28aLSca
         7Dot+DR3XCREZlRBZaFqog/U8E0J1bB8jNwjElz3xNzHssOYXREDXWY2ARaYDifJ7J1j
         U6ebjFjikomqd4X+SafP0OOkihJE7eYal/XAgmqZ+GUn5OYsACW/FVytvAiV2wkB+oln
         GvlJAQ+t/al8gQ8+02RrTRalz2rkMSBM+coCpwwHtpN3VpRLcxMnZ/APKhPLPxeGVrUh
         wKL2QEVRdq33RexuXFgD3d7y6HZQl+op4ugK3685RuRu3SAGoh7vviSEEJURHHJuUpWv
         rdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/ySdKTZFlFCT4Win5U1jB4XU2Vrkoz7ZLdDWOfcGHA=;
        b=jCG5a4raH6UUA/91kxSOFiwsR0MIiH+a/BsLy4HG2F3cSP8O4wK6fl0ekXpxW7EQPi
         PMzw0ZI7nO85gOGa2IfBT49O1d5PvdgPWHcnHPGFuBppQrMzjV5JDp2RpxyX4mvMQUz9
         G0r97zrJBCHQzaK23uqfqQQI46DzDXp1r9imrfpLooA3OKCDY7b3JJoC4Fjj0vUoQuxq
         /IWtGTU/rgHqLaHL9hALYodf2+srnOKUj9TUAkXhXZQ+qcCTM3Ofz4hOh8GnDJiiNXN5
         Vsnkl6QbZLAgCyYiox9PnT/JteMcOKweXRLHLgoj3/Kc2ZD5rhGw2JmL7OgIs3yc4zhA
         4wKw==
X-Gm-Message-State: APjAAAUkQTLdIhziOaPNFTibgGrL0gsriSqTndspFFxm0NMTKsX2MGIJ
        mFddQs+PZsoI0Gw00/+nweAzFTZMMoZEgQ==
X-Google-Smtp-Source: APXvYqzBfl+lNu+4spgHUoEKU79bhEkIvU8+ri9pSpR6EL0GHrkgSO0qhcw/dHZXWNt5jKciSWBaaw==
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr39777273qkf.480.1582402638244;
        Sat, 22 Feb 2020 12:17:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w60sm3543568qte.39.2020.02.22.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 12:17:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 22 Feb 2020 15:17:16 -0500
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/boot/compressed: Fix compressed kernel linking with
 lld
Message-ID: <20200222201715.GA3674682@rani.riverdale.lan>
References: <20200222164419.GB3326744@rani.riverdale.lan>
 <20200222171859.3594058-1-nivedita@alum.mit.edu>
 <20200222181413.GA22627@ubuntu-m2-xlarge-x86>
 <20200222185806.ywnqhfqmy67akfsa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222185806.ywnqhfqmy67akfsa@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 10:58:06AM -0800, Fangrui Song wrote:
> On 2020-02-22, Nathan Chancellor wrote:
> >On Sat, Feb 22, 2020 at 12:18:59PM -0500, Arvind Sankar wrote:
> >> Commit TBD ("x86/boot/compressed: Remove unnecessary sections from
> >> bzImage") discarded unnecessary sections with *(*). While this works
> >> fine with the bfd linker, lld tries to also discard essential sections
> >> like .shstrtab, .symtab and .strtab, which results in the link failing
> >> since .shstrtab is required by the ELF specification. .symtab and
> >> .strtab are also necessary to generate the zoffset.h file for the
> >> bzImage header.
> >>
> >> Since the only sizeable section that can be discarded is .eh_frame,
> >> restrict the discard to only .eh_frame to be safe.
> >>
> >> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >> ---
> >> Sending as a fix on top of tip/x86/boot.
> >>
> >>  arch/x86/boot/compressed/vmlinux.lds.S | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> >> index 12a20603d92e..469dcf800a2c 100644
> >> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> >> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> >> @@ -74,8 +74,8 @@ SECTIONS
> >>  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
> >>  	_end = .;
> >>
> >> -	/* Discard all remaining sections */
> >> +	/* Discard .eh_frame to save some space */
> >>  	/DISCARD/ : {
> >> -		*(*)
> >> +		*(.eh_frame)
> >>  	}
> >>  }
> >> --
> >> 2.24.1
> >>
> >
> >FWIW:
> >
> >Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> I am puzzled. Doesn't -fno-asynchronous-unwind-tables suppress
> .eh_frame in the object files? Why are there still .eh_frame?
> 
> Though, there is prior art: arch/s390/boot/compressed/vmlinux.lds.S also discards .eh_frame

The compressed kernel doesn't use the regular flags and it seems it
doesn't have that option. Maybe we should add it in to avoid generating
those in the first place.

The .eh_frame discard in arch/x86/kernel/vmlinux.lds.S does seem
superfluous though.
