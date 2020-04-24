Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4AFC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060B921569
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/ufMybt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgDXSXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:23:40 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3F2C09B048;
        Fri, 24 Apr 2020 11:23:40 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z90so8697935qtd.10;
        Fri, 24 Apr 2020 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hlnTK6gfjpKzSfgdt+AIUDCtkzrhtUOwY7cenPzETQQ=;
        b=T/ufMybtL7Dfd0xLVkue1BThy+vfuAZ/1YffMRjM43gu+YAvAP+i18xJG+5isWh9wZ
         yafJxrU2f+kr6eFO4Sh9TzdmNfmkawInhCA5G4g/ujyicsdB7PCh9Wp8xxKwOI0VdlhE
         SpU0yAPFn5g4UAlqUPz9WRp9614oLXWsIcH4G+5mN/dNQNuYTy92eKQ5wFWv7Ox4yzvX
         Sk1Z4x/HEitnH0/ihZ5y7oHYBdU9XNf9CBHeZ/i8bka5KvVSmoEL4lj7oKLMgZCJOuyu
         0HX/uPGUodNEfJBIo7MCQEx7MJaTwOb7VrRsRSNYBh997PfrDAiHLgXcFBdBHUghxEUq
         c39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hlnTK6gfjpKzSfgdt+AIUDCtkzrhtUOwY7cenPzETQQ=;
        b=p/H5zBwW9Yki9qv6kl3kxxsrwExsOBugob2TGCSVIPNLGv4zgBA3KNmVedjJXB/eU8
         uB5HQoWtmKvRe0tuwJz4NKu0PwS/rUaOBLnnnnFDmvHF6m7QouQYpL8y9Qa9joAl7r7p
         vl7kiRKkAYTq0mwwAzp75zIv4s2u9mHxFoMyvFzJPLWYdkyG0/U2Hjm7215DF+cYm45v
         EXWBP+8vYRLPIWAGsaSjI35bo8+XpEW2bMfGDA3vaXS/AIIh0YTKV8j/+PSBsY5lxDwJ
         FCkTh34ZI5ewGP87OlucIsIQfm/xv2QEwyqdXrvH0im/MqiobNknFL/p/IQ9D0P0h+Nr
         ENVQ==
X-Gm-Message-State: AGi0PuZAlsImlTFcfTwlKMCekmF/qm0BU4/mGcDYpZ+BBUrQhEhCI3X3
        kiYIkcnk1gxxoQZn4bCFrvY=
X-Google-Smtp-Source: APiQypKBrcu7p5JpivCIP2X8XHodvRnxs9lVsHBOweEmoqVon7lYUtDngHz3LLcUgyL/LvoVLhZIyQ==
X-Received: by 2002:ac8:44c1:: with SMTP id b1mr8446962qto.156.1587752619569;
        Fri, 24 Apr 2020 11:23:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v23sm4135729qkv.55.2020.04.24.11.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 11:23:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93E7F409A3; Fri, 24 Apr 2020 15:23:36 -0300 (-03)
Date:   Fri, 24 Apr 2020 15:23:36 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf symbol: Fix kernel symbol address display
Message-ID: <20200424182336.GO19437@kernel.org>
References: <20200415070744.59919-1-tmricht@linux.ibm.com>
 <20200420204617.GA23638@kernel.org>
 <475a5c86-2be3-4f12-56f3-7bd6587e8ec3@linux.ibm.com>
 <20200424150631.GN19437@kernel.org>
 <db6de799-564a-273e-99ad-40817f2b970a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db6de799-564a-273e-99ad-40817f2b970a@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 24, 2020 at 08:01:22PM +0200, Thomas Richter escreveu:
> On 4/24/20 5:06 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Apr 24, 2020 at 02:37:01PM +0200, Thomas Richter escreveu:
> >> On 4/20/20 10:46 PM, Arnaldo Carvalho de Melo wrote:
> >>> Em Wed, Apr 15, 2020 at 09:07:44AM +0200, Thomas Richter escreveu:
> >>>> Running commands
> >>>>
> >>>>    ./perf record -e rb0000 -- find .
> >>>>    ./perf report -v
> >>>
> >>> Or when pressing 'V' in the TUI.
> >>>  
> >>>> reveals symbol names and its addresses. There is a mismatch between
> >>>
> >>> Yeah, an address that at some point was put there to help with debugging
> >>> the symbol resolution, IIRC how it looked like when looking at
> >>>
> >>>   readelf -sW vmlinux
> >>>
> >>> Or any other DSO, for instance, for a glibc symbol here:
> >>>
> >>> Using 'perf report -s pid,dso,sym' then pressing 'V':
> >>>
> >>>    1.55%    20325:perf  /usr/lib64/libc-2.30.so   0x161825   B [.] __strlen_avx2
> >>>
> >>> [acme@five perf]$ readelf -sW /usr/lib64/libc-2.30.so | grep strlen_avx2
> >>>  24371: 0000000000161810   414 FUNC    LOCAL  DEFAULT   15 __strlen_avx2
> >>> [acme@five perf]$ 
> >>>
> >>> Can you check if doing in /lib/modules/.../build/vmlinux produces what
> >>> appears when 'V' is in place?
> >>>
> >>> And perhaps we can also show the DSO offset and the rip as it gets laid
> >>> out in memory in the end? So we have all the informations?
> >>>
> >>> - Arnaldo
> >>>
> >>
> >> Arnaldo,
> >>
> >> having verified this also works in the TUI mode using 'V', are you going to pick
> >> this patch?
> > 
> > That would be a change in behaviour, the original intent was to show the
> > value one would get from the ELF symbol table, isn't that the case?
> > 
> 
> I think there is a misunderstanding.
> 
> Your example above refers to libc, which shows the addresses
> correctly (on x86 and s390). I was refering to the kernel dso.
> The issue only shows up on the kernel DSO (vmlinux and kallsyms)
> 
> When I use the -v option (or 'V' in TUI) I get this
> 
>   3.55%  find /lib/modules/.../build/vmlinux  0xf11ec  v [k] check_chain_key
>                                               ^^^^^^^
> This address is not correct as compared to readelf on vmlinux file:
> 
> [root@m35lp76 linux]# readelf -sW vmlinux| fgrep check_chain_key
>  20698: 00000000001f0c70   486 FUNC    LOCAL  DEFAULT    1 check_chain_key
> [root@m35lp76 linux]# 
> 
> The problem are the mapping functions with are applied for the kernel DSO.
> In dso__process_kernel_symbol() the mapping is adjusted (around line 903)
> and  function hist_entry_iter_add() saves the modified address in the
> struct hist_entry->ip. This address is used from now on and printed.
> 
> Let me know and I will double check this and rework the commit message
> as it was not good enough.

Yeah, this may be me not understanding something right, I saw this was a
corner case, that only happens in debug mode (ok, better provide good
info here...), so I haven't devoted more than cursory attention to this
and may be making a bad judgement, so I thought that since this doesn't
seems urgent, better leave it to when I manage to have solid time to
devote to this or someone else looks at this.

Sorry, but these have been difficult time for everybody, and I fear, for
me, I have to prioritise all the time.

- Arnaldo
 
> Thanks.
> 
> 
> > That is why I asked if you would think that providing the information
> > you want, which is matching to what is in kallsyms, would be
> > interesting, which I think it is, but how? showing the vmlinux offset
> > somehow?
> >  
> 
> -- 
> Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Matthias Hartmann
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

-- 

- Arnaldo
