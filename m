Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE40C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F089A206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl3mSN7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgAKRcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 12:32:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46205 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbgAKRcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 12:32:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so4893559qke.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NvxagxtUHEEM2utnj9FcN3UQ43b4PRjpBK1OBEnu02A=;
        b=fl3mSN7HRRbsg0j4B1wDe5VybpDyvzQXn9jyJ0wFiaJ6XdxY+qNaB6dONSCBC+jIMR
         jtkU6dYmhmRPgH0NfiQ40v/dRJlqkNW03bVa2vIAuN32WcZOUL8nn9i0ACPGjfNMIFaB
         YsWmAEY1Eit6n2IToAEVeAjfibw0DAnTzr9OzZ3meR3auhqbkdUQq/K/UJPowulB+27Y
         Dw6M2M0mFRpVXDt07W73orNVhCrbN6lovsE7jkzRocxAyqFedz3O8hvnq12USP2vnVBt
         XBn/GNLjGaWHD3v15XdVCz9KOqnMcZ59LSd+yeYvqd6XhgEBOG/JVkonomO53MrBrNhO
         /laA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvxagxtUHEEM2utnj9FcN3UQ43b4PRjpBK1OBEnu02A=;
        b=LK9Yc/Qkv0FejU74qv/dC6tYsviu5xPUwgimsebBHgfeMiZaJ5EKX1qLkbxldK1gb3
         zbxxSYfrlAEjFzsQC2aG14y3oCYkJbgSKE8tkia4AfcU0vqTxF8gVzhbHJTLl5VmJgxN
         zKQKAaFDBhHcEhg7C1Pi0crTJ7k89TaSG+qMWGtxE3tVM2q4u+dGzRL5RCEuLn8qRwbl
         Nh9Rn9PPy4Hlied0FDRPAYYjk5vzSUKxBS2Pb+qDtmt1HI6J/jvWxD+4Jt/oSDkMIReP
         QwJU+iezVOUJJ+4LmSoj0y16hRu1nBmxW6ZcsRkj/c8kXJpY/gKRAPz/nwOOIBkC61JX
         Kcrw==
X-Gm-Message-State: APjAAAXiL3lkmGXCG3hG+B0t3pS7Rt+dFU4i/tYw/6rrVDzsCUp/5r7k
        v1Za1neiR2NtO47CuwCrDQk=
X-Google-Smtp-Source: APXvYqyBDmK/b/NWdNLESxbwVJ3CSTVXB7r8Oyv7cYFvS1ucM2Rg4Os5vSuiT9vpsUsxnAwjgC4HQQ==
X-Received: by 2002:a37:658f:: with SMTP id z137mr9133361qkb.234.1578763936090;
        Sat, 11 Jan 2020 09:32:16 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s33sm2986750qtb.52.2020.01.11.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 09:32:16 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 11 Jan 2020 12:32:14 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200111173214.GB2688392@rani.riverdale.lan>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200111172047.GA2688392@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 12:20:48PM -0500, Arvind Sankar wrote:
> I'm running gentoo, but building the kernel using binutils-2.21.1
> compiled from the GNU source tarball, and gcc-4.6.4 again compiled from
> source. (It's not something I normally need but I was investigating
> something else to see what exactly happens with older toolchains.)
> 
> I used the below to compile the kernel (I added in
> readelf/objdump/objcopy just now, and it does build until the relocs
> error). The config is x86-64 defconfig with CONFIG_RETPOLINE overridden
> to n (since gcc 4.6.4 doesn't support retpoline).
> 
> make O=~/kernel64 -j LD=~/old/bin/ld AS=~/old/bin/as READELF=~/old/bin/readelf \
> 	OBJDUMP=~/old/bin/objdump OBJCOPY=~/old/bin/objcopy GCC=~/old/bin/gcc
							    ^^ that should be CC
> 

The built kernel (with this patch) does boot till userspace on qemu, so
these old versions aren't producing a completely broken kernel.
