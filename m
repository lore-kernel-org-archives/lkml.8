Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E32DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4BC20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WpD4ITRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgA3UIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:08:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34456 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3UIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:08:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so2062010pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HoUQ+yE0LEnd0V4DJaBMqfms/cYBhB81pcgudu6AOqs=;
        b=WpD4ITRo93dijLN31FEvm/ZVopaujOGbmA9L1HVweIElOelDIgl6jdS+D9lBC3yPTL
         AxD0PBlvInFtwuWFYJyHyMDzHpYMUXVtL/XgqbnKY7gmrxHKN3U/SCxcFZg4mMXPbjfr
         J+9nzkmx16lYtuyZWjuJzo5xFFEduvxG1E9yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HoUQ+yE0LEnd0V4DJaBMqfms/cYBhB81pcgudu6AOqs=;
        b=o0cLGmRRKpC574IdmpZzsGy6ADUbWwBJUwZzXteMZaazvyYIGzpgMTHf1ccpJZVLOd
         zOgsQZBpZajXu2KKRAgyC2Y5nRDAtrRkN9pfbew4H40/g8l5mmSTieiM+8Lqoljf03nW
         g2Hgu6af2RQ6yoORbIlMVRiccMfzzzjjoIpw0Zjv7cRSimt8JsddGlapAyDtF+35yrhA
         zdONjpMD7mqgFZqNjElKUitHDzTnxsz8CgFxSoKQtXcfA+26wD4/MtB5rSjcwdbCqSkb
         Gp3HtdcQ2vRU80V1zHwk7ytMAO/6PeE692gMh3XQMBsjGHCkWqkxb4T7vh2RQPpPUVyK
         HkTg==
X-Gm-Message-State: APjAAAUyMFJRlbOIJ1Kh+6Q86oDCokYoH/V6GCOU94yC9Fs01Cm2m8C6
        1XRPNpbHIqGueRMhVEIW5+4fbQ==
X-Google-Smtp-Source: APXvYqybPhuB7qHu7jGKJ2xZeVYPaIIpGLPbQPGxCXOo+hLx+zRpgFSuOMCyCymtKU+jg4JLaMj7rg==
X-Received: by 2002:a63:e545:: with SMTP id z5mr6298948pgj.209.1580414889068;
        Thu, 30 Jan 2020 12:08:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z26sm7221191pgu.80.2020.01.30.12.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:08:08 -0800 (PST)
Date:   Thu, 30 Jan 2020 12:08:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 2/2] x86: Discard .note.gnu.property sections in vmlinux
Message-ID: <202001301206.13AF0512@keescook>
References: <20200124181819.4840-1-hjl.tools@gmail.com>
 <20200124181819.4840-3-hjl.tools@gmail.com>
 <202001271531.B9ACE2A@keescook>
 <CAMe9rOrVyzvaTyURc4RJJTHUXGG6uAC9KyQomxQFzWzrAN4nrg@mail.gmail.com>
 <202001301143.288B55DCC1@keescook>
 <CAMe9rOocT960KsofP9o_y49FdgY9NGix=GcYnpKLvp7RhieZNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOocT960KsofP9o_y49FdgY9NGix=GcYnpKLvp7RhieZNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 12:04:54PM -0800, H.J. Lu wrote:
> > I don't understand this. "may not be incompatible"? Is there an error
> > generated? If so, what does it look like?
> 
> When -mx86-used-note=yes is passed to assembler, with my patch, I got
> 
> [hjl@gnu-skx-1 linux]$ readelf -n vmlinux
> 
> Displaying notes found in: .notes
>   Owner                Data size Description
>   Xen                  0x00000006 Unknown note type: (0x00000006)
>    description data: 6c 69 6e 75 78 00
>   Xen                  0x00000004 Unknown note type: (0x00000007)
>    description data: 32 2e 36 00
>   Xen                  0x00000008 Unknown note type: (0x00000005)
>    description data: 78 65 6e 2d 33 2e 30 00
>   Xen                  0x00000008 Unknown note type: (0x00000003)
>    description data: 00 00 00 80 ff ff ff ff
>   Xen                  0x00000008 Unknown note type: (0x0000000f)
>    description data: 00 00 00 00 80 00 00 00
>   Xen                  0x00000008 NT_VERSION (version)
>    description data: 80 a1 ba 82 ff ff ff ff
>   Xen                  0x00000008 NT_ARCH (architecture)
>    description data: 00 10 00 81 ff ff ff ff
>   Xen                  0x00000029 Unknown note type: (0x0000000a)
>    description data: 21 77 72 69 74 61 62 6c 65 5f 70 61 67 65 5f 74
> 61 62 6c 65 73 7c 70 61 65 5f 70 67 64 69 72 5f 61 62 6f 76 65 5f 34
> 67 62
>   Xen                  0x00000004 Unknown note type: (0x00000011)
>    description data: 01 88 00 00
>   Xen                  0x00000004 Unknown note type: (0x00000009)
>    description data: 79 65 73 00
>   Xen                  0x00000008 Unknown note type: (0x00000008)
>    description data: 67 65 6e 65 72 69 63 00
>   Xen                  0x00000010 Unknown note type: (0x0000000d)
>    description data: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
>   Xen                  0x00000004 Unknown note type: (0x0000000e)
>    description data: 01 00 00 00
>   Xen                  0x00000004 Unknown note type: (0x00000010)
>    description data: 01 00 00 00
>   Xen                  0x00000008 Unknown note type: (0x0000000c)
>    description data: 00 00 00 00 00 80 ff ff
>   Xen                  0x00000008 Unknown note type: (0x00000004)
>    description data: 00 00 00 00 00 00 00 00
>   GNU                  0x00000014 NT_GNU_BUILD_ID (unique build ID bitstring)
>     Build ID: 11c73de2922f593e1b35b92ab3c70eaa1a80fa83
>   Linux                0x00000018 OPEN
>    description data: 35 2e 33 2e 39 2d 32 30 30 2e 30 2e 66 63 33 30
> 2e 78 38 36 5f 36 34 00
>   Xen                  0x00000008 Unknown note type: (0x00000012)
>    description data: 70 04 00 01 00 00 00 00
> [hjl@gnu-skx-1 linux]$
> 
> Without my patch,
> 
> [hjl@gnu-skx-1 linux]$ readelf -n vmlinux
> 
> Displaying notes found in: .notes
>   Owner                Data size Description
>   Xen                  0x00000006 Unknown note type: (0x00000006)
>    description data: 6c 69 6e 75 78 00
>   Xen                  0x00000004 Unknown note type: (0x00000007)
>    description data: 32 2e 36 00
>   xen-3.0              0x00000005 Unknown note type: (0x006e6558)
>    description data: 08 00 00 00 03
> readelf: Warning: note with invalid namesz and/or descsz found at offset 0x50
> readelf: Warning:  type: 0xffffffff, namesize: 0x006e6558, descsize:
> 0x80000000, alignment: 8
> [hjl@gnu-skx-1 linux]$

What is the source of this failure? Does readelf need updating instead?
Is the linking step producing an invalid section? It seems like
discarding the properties isn't the right solution here?

-- 
Kees Cook
