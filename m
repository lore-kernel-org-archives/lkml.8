Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E7EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EECD2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db5sQB7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbgF2T2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732748AbgF2T1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01175C0307A7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:50:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b185so5075960qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wV0NHhglv/mmSSjfHCWkkJCA24T21ipzwYGTvO6LqDY=;
        b=Db5sQB7Xk+al/PTFGgxDHQDQvknnMbKWujmiJtQgsK1twOoNgXuepQFf7nPjIL/MhM
         6gxzlMU4mQdQ1TbdVczRfQa7bMcqL81q7LI2BMk/IroPrpxqPeNxfJisjOMaGRiidWNW
         VxVCNu2RRERHiHC6hEhxEOSGKEqiDmAudaDqjZ/cn4neAmgT3W63Fg3+4334xeBc87Eo
         flTT0MQrjooEfkvvDfjWIHWd4zMoYj4KS1NcRpDsz9sMSsg7rEd1rnxzc4xqJbEnmoWN
         YX9WVbHrlc55z2wcXSPNbcdzgTR1NOtlCkI6zbPslnv1zM/sep+BR3Qu6y7TRja5x3W9
         IapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wV0NHhglv/mmSSjfHCWkkJCA24T21ipzwYGTvO6LqDY=;
        b=ePh0AtpqoH54rxcujrT26XURVWm0y7j88N9o8FxMfH1+NR9sMuM2ZJMVAI/ezM71ml
         bCB7vaPHpEYb/lW6ThCz0BC075U0hfu0A+/xTTPYrvoCT5IS02kiZRazVYQGCpMeRNBz
         V9AUjIjJASl0CoCONMoGkBnT3UK44bcLL+/WvrKfMOkpe8Er6/6TTWVrsNiVJ51NJgo9
         uv/7mUK7zFOh3AX6omo+pNqrycCeTqaHFx/Xm+oFv26O7OtA5yv6wSJG2r+fSUyetOKz
         otuYyL3yYp60q4s4u8Ej5RoPMdd6eRpP1kQEAaxR5YD0CsjbSWWj/NrFhe0ebkxKJUmE
         jU0A==
X-Gm-Message-State: AOAM531r4ugj294R96/uoiJTuR7D6P1Bi4PdTWB82grrgpmRuumN5Plu
        dcOvUXsobdAp1/FoXzECQ7M=
X-Google-Smtp-Source: ABdhPJxDEsku21LzfkhtACcUxnBOVh4h3bm1w3nt9oAtFRMKsrAXWFrA18GrCQxqAQMK7Xgqh7oCbw==
X-Received: by 2002:a05:620a:1282:: with SMTP id w2mr15014742qki.196.1593445814064;
        Mon, 29 Jun 2020 08:50:14 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b22sm162685qka.43.2020.06.29.08.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:50:13 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 29 Jun 2020 11:50:11 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] x86/boot/compressed: Move .got.plt entries out of
 the .got section
Message-ID: <20200629155011.GA900899@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-2-nivedita@alum.mit.edu>
 <202006290846.5A5C76A4D7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202006290846.5A5C76A4D7@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 08:48:05AM -0700, Kees Cook wrote:
> On Mon, Jun 29, 2020 at 10:09:22AM -0400, Arvind Sankar wrote:
> 
> This is also being done on arm64, and the section was specified slightly
> differently (with INFO) which maybe should be done here too?

I was actually just about to email you to ask what that INFO is for :)
What does it do?

> 
>        .got.plt (INFO) : { *(.got.plt) }
>        ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, ".got.plt not empty")
> 
> Otherwise, yes, looks good.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> > +
> >  	.data :	{
> >  		_data = . ;
> >  		*(.data)
> > @@ -77,3 +80,9 @@ SECTIONS
> >  
> >  	DISCARDS
> >  }
> > +
> > +#ifdef CONFIG_X86_64
> > +ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> > +#else
> > +ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > +#endif
> > -- 
> > 2.26.2
> > 
> 
> -- 
> Kees Cook
