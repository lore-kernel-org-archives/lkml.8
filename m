Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0976DC35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF33206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bviH1RPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBVQoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:44:23 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45579 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgBVQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:44:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id d9so3620040qte.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=davRPrnHp93f1Lv0/YKPaOSAs3H7scM60qBahhAvztc=;
        b=bviH1RPWtioE2KaAVd6bH4iA541Q4p7D8OL/hVwNV1nEkOx8u6ZqZVK3RuhBeGVvIP
         zRnCZNpibC9hURy6jgLOACsx+6IMjQesJAUCmZh8JXAoC47V7c+BkZMmd8/yLIy3D8pM
         /kZdEV/dloJqeqvVd3i1sdKqGhTydCGtEoIFwp9sjNJR+FeUomdo261bQSh/AawPxQwG
         fpmB/1JBnbQaHAc/C5LGMw2rF8j2YdtFDSaT7rwQYdjzgVh6ac2IWpXNRJDXraloTQ2K
         YnPCKAsNtOlZsehOmP6CoWD2qtqWD6gJoMfuqWiLXZ0K4hVy29fnmNsGfZXynJUg9cRv
         XvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=davRPrnHp93f1Lv0/YKPaOSAs3H7scM60qBahhAvztc=;
        b=EFJkp0O2VdJB/HZEE1d0gHh2mrW62JNDNLN4k51FUU+Yz4u2OOgH7vbgwDhJhcCcQw
         vnnCQD6xYXxTMAjrh2pXEh/+mK3as/xijXFSP39o02/a5RxKbqbEuc4ODi64hK0ee9I4
         +Gx2AFEdxnRz+IXZW6G3ULHDC6PPQPJbPbvCmdre6ENFG1RxzUFFOlPSDpAjh6S+4Duf
         5Xt5/EUCDothigak6+1ctFNkr+KE4a93kOQnvJ0JjPkJAzQFZu7dXMO7QBBFKdL3Gqm3
         UwUM2uvom/hF7auKp90U0pjg9mELU4XSUgtPz+9iIsUL0eVIIfkfsjZo/4bw3u3u/2rR
         Mhqw==
X-Gm-Message-State: APjAAAWAOubp+5vZ30QGwnoRbZQMME5HWUtZBomJeb7nf9Clcg9VyaK6
        2fV4iYzx1QqkxZW2QcMfwy4=
X-Google-Smtp-Source: APXvYqxRoijrZVVJNjRz2/DB9ALnt6oFd7StwkqoNnUDtUiq4LaD99Lk/YEy2kePQehnE60VXKNo0w==
X-Received: by 2002:ac8:6b4f:: with SMTP id x15mr37560537qts.152.1582389862273;
        Sat, 22 Feb 2020 08:44:22 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x41sm3345118qtj.52.2020.02.22.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 08:44:21 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 22 Feb 2020 11:44:20 -0500
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Fangrui Song <maskray@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222164419.GB3326744@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074242.GA17358@ubuntu-m2-xlarge-x86>
 <20200222153747.GA3234293@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222153747.GA3234293@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 10:37:47AM -0500, Arvind Sankar wrote:
> On Sat, Feb 22, 2020 at 12:42:42AM -0700, Nathan Chancellor wrote:
> > 
> > Thanks for the clarity. With your suggestion (diff below), I see the
> > following error:
> > 
> > arch/x86/boot/compressed/vmlinux: no symbols
> > ld.lld: error: undefined symbol: ZO_input_data
> > >>> referenced by arch/x86/boot/header.o:(.header+0x59)
> > 
> > ld.lld: error: undefined symbol: ZO_z_input_len
> > >>> referenced by arch/x86/boot/header.o:(.header+0x5D)
> > make[3]: *** [../arch/x86/boot/Makefile:108: arch/x86/boot/setup.elf]
> > 
> > It seems like the section still isn't being added?
> > 
> > Cheers,
> > Nathan
> 
> It seems like lld also doesn't treat .symtab as special and is
> discarding it, but that one is actually essential to be able to build
> the bzImage.
> 
> The sections that GNU ld ends up discarding via that *(*) directive are
> .dynsym, .dynstr, .gnu.hash, .eh_frame, .rela.dyn, .comment and
> .dynamic.
> 
> Out of these, only .eh_frame has any significant size, and that's what
> we discard in the other linker scripts (in kernel/vmlinux.lds.S and
> boot/setup.ld).
> 
> It looks like it would be safest to just do
> 	/DISCARD/ : {
> 		*(.eh_frame)
> 	}
> instead. If you can double-check that that works with lld, I can send
> out a new version.
> 
> Thanks and sorry for the breakage.

Tested with lld and it seems fine with that change.

Boris, should I send the fix as a diff to the current patch in tip, or
as a fresh one that can replace it?

Thanks.
