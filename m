Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7AFC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F289C2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhJ9poWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCQQAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:00:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38182 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgCQQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:00:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so4656428wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i3/HhLR/O0/CbHZXM0VcSB7U8Xi1Wft1dlRFMRO02HY=;
        b=bhJ9poWFWMl3+oFEzoqGdFvuBFpm4liZ2xa75YGFftjCp27P/Rq5S9JgCJRzJeRhFp
         ET2jcWzJwcmzndjTjjgo4I3sJMcKP+zOFfJHkcmviLpx6GFMub044cfodyeDzvBTr5rz
         QdrlvCdm3eeXDmrKrYARcYEsRegY7+N/81F2BDIkvGaOUXh+IY+1mzKNynCPCRccwVWO
         p9wZAVHWeEtV8zdWfRvvT54cIDi65FYaftfEROjVkUCwMBrrLFZ3jnkcn40bfP8wrEy5
         bBmK5VKsrEKR0a4bhnsKqu8+qk/Tp35ox/MPtgBJghewi5xBETXjkq8jPZi6yKH4U4Wm
         9Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i3/HhLR/O0/CbHZXM0VcSB7U8Xi1Wft1dlRFMRO02HY=;
        b=sQ5tLAcuqSVxMkmGHSGI8S89iyFYtJTdadV/gCthZbmlE/ddbJmFKJXsZXptbZKeYt
         Qq2MJArPddWRg4Xs5pTpXZ9DMRtDtJjbzAACRoAXf0jEdWHuf/yw7fGds4ZdXxHKCBds
         DpXVlQ+DspvNoc/hU5YO5rmOKsrC7Wf/fFYVMYi6ewJzgF2Ruhm4coQOTpYVJXxa/oRx
         fknjSi/hkrWWwL44Dq/2p0jpRBlwwoDWmAmUwGVFIZK+vqZ2l+ctom9a8lZdKIlsgWmx
         /8aSYzK2whk/pGQIW4iqh/zbdYZrX6ZdeIr4HfzTM5C8S6RhbvrOWHMpj4DsCmPKRMSe
         +aOg==
X-Gm-Message-State: ANhLgQ3GfrMnaY7MLpedE6//C1nirpikWu0Ba6rK6fRaQBIpz3ibDlUb
        rlp2mLnz10cmlEdLXWsRjZw=
X-Google-Smtp-Source: ADFU+vvpUZPkVKlGLkpmFLSH2ItwqGs0OIwlevrD4d2kPESi8laXU73YjAy22NfvrT4WFKHOjIAkXw==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr6946877wro.386.1584460807500;
        Tue, 17 Mar 2020 09:00:07 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:e00d:142c:5e21:c280])
        by smtp.gmail.com with ESMTPSA id a13sm5194418wrh.80.2020.03.17.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 09:00:06 -0700 (PDT)
Date:   Tue, 17 Mar 2020 17:00:05 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 16/46] powerpc/mm: Allocate static page tables for
 fixmap
Message-ID: <20200317160005.imgtv3w62op4nm2t@ltop.local>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
 <d4bd46fe0103f8a8cb7e5affb2a7fcc3185be24e.1584360344.git.christophe.leroy@c-s.fr>
 <b9c92137-f757-1e6a-bca9-5c522e1083c5@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c92137-f757-1e6a-bca9-5c522e1083c5@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:38:46PM +0100, Christophe Leroy wrote:
> > diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> > index f62de06e3d07..9934659cb871 100644
> > --- a/arch/powerpc/mm/pgtable_32.c
> > +++ b/arch/powerpc/mm/pgtable_32.c
> > @@ -29,11 +29,27 @@
> >   #include <asm/fixmap.h>
> >   #include <asm/setup.h>
> >   #include <asm/sections.h>
> > +#include <asm/early_ioremap.h>
> >   #include <mm/mmu_decl.h>
> >   extern char etext[], _stext[], _sinittext[], _einittext[];
> > +static u8 early_fixmap_pagetable[FIXMAP_PTE_SIZE] __page_aligned_data;
> 
> Sparse reports this as a variable size array. This is definitely not. Gcc
> properly sees it is an 8k table (2 pages).

Yes, thing is that FIXMAP_PTE_SIZE is not that constant since it uses
__builtin_ffs() (via PTE_SHIFT / PTE_T_LOG2).
Nevertheless, since Sparse v0.6.1 (released in October) accepts these
in constant expressions, like GCC does.

-- Luc
