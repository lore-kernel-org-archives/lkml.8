Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B3C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA632070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0XaU/ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBRSD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:03:57 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44623 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:03:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id j8so4065094qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aJ1BGIDBYGzcyK8G8MxbNsnhVp8YW/urTc9MDE4QmZk=;
        b=l0XaU/uefp36+SJJxTAxnIaHsK0+EPAmXcFPMsLURbl3BQD9ZfmArypV0e3vQyWpt5
         Ky0yJzLK4yKBbpcH4pa8ECMGG62FFKlhBP58jHZtjupGfjOX/0PO+/tus06p05upcmWP
         /xUds2PjQMAPxfdc6RziMTg9cfZixdc5L5vFWd/JnCmsew9zFU9jLMuhvBNAbOkLKwlD
         xHPVNHsMCkRGyQC7gNFhu/J/bDkgu2PwT6Zrl3ZblPFMlGfTJ9OnizJyV/xyPhPEXNp1
         6OjyBxtjL06osCjx/N8bbpeUcIgStdxRn9+9bcm0VVICwHEPXMDNSLzg0Lmu15mtfA3G
         CzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJ1BGIDBYGzcyK8G8MxbNsnhVp8YW/urTc9MDE4QmZk=;
        b=P3loOgRV4xfpFptn5Z0BTBAP188D+RxuUDH/MjpsmupnVfSSwoQd60nkueoETm9wb/
         6TdGpj9vcGs5HdjWQkdh5oTz82jWQS4En4p/dJUs2xsV6dnlxZ50aeb8hik2bsTVx2Qr
         ZM2csAHjAYfl2qLcwmvwWm+Iv35RNG6g5ZGaVrgyRTjkyntVN9ZYlApg+U9lgjSQJvkN
         xkFWAg9nSI9PXE0yU8yKta0HyhqmEhNSCjp0ifDaXU2DFUcoBONRT1j9iq5EuGBu8ZZS
         D4duElmoFr1vnKsBSoS4LC6ReMsnp8uQ9GIrYw6wxeruwlqExSr2ar+rD4HewmuXSx3q
         E4Rg==
X-Gm-Message-State: APjAAAUPExXeVR7CwjsCwfJxEUIJjSJE1De8rnshsY6RdY6Oqr203pyr
        USva9pOtrfDB1+MEddHx/F0=
X-Google-Smtp-Source: APXvYqy36ybWUfZ9Ds7GUTu3rog9ZaFFe4FGMupgQOnSlEADzzRnBVP9y7VypCZs7ztvfChviv4ZPw==
X-Received: by 2002:a37:b103:: with SMTP id a3mr20208424qkf.204.1582049036041;
        Tue, 18 Feb 2020 10:03:56 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k50sm2217315qtc.90.2020.02.18.10.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:03:55 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 18 Feb 2020 13:03:54 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200218180353.GA930230@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200205162921.GA318609@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205162921.GA318609@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 11:29:21AM -0500, Arvind Sankar wrote:
> On Thu, Jan 09, 2020 at 10:02:17AM -0500, Arvind Sankar wrote:
> > Commit 5b11f1cee579 ("x86, boot: straighten out ranges to copy/zero in
> > compressed/head*.S") introduced a separate .pgtable section, splitting
> > it out from the rest of .bss. This section was added without the
> > writeable flag, marking it as read-only. This results in the linker
> > putting the .rela.dyn section (containing bogus dynamic relocations from
> > head_64.o) after the .bss and .pgtable sections.
> > 
> > When we use objcopy to convert compressed/vmlinux into a binary for the
> > bzImage, the .bss and .pgtable sections get materialized as ~176KiB of
> > zero bytes in the binary in order to place .rela.dyn at the correct
> > location.
> > 
> > Fix this by marking .pgtable as writeable. This moves the .rela.dyn
> > section earlier so that .bss and .pgtable are the last allocated
> > sections and so don't appear in bzImage.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  arch/x86/boot/compressed/head_64.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index 58a512e33d8d..6eb30f8a3ce7 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -709,7 +709,7 @@ SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
> >  /*
> >   * Space for page tables (not in .bss so not zeroed)
> >   */
> > -	.section ".pgtable","a",@nobits
> > +	.section ".pgtable","aw",@nobits
> >  	.balign 4096
> >  SYM_DATA_LOCAL(pgtable,		.fill BOOT_PGT_SIZE, 1, 0)
> >  
> > -- 
> > 2.24.1
> > 
> 
> Gentle reminder.
> 
> https://lore.kernel.org/lkml/20200109150218.16544-1-nivedita@alum.mit.edu

Ping.
