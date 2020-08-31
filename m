Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF49C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11312071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RatiUEcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHaBlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgHaBlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:41:39 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58314C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 18:41:39 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so4343276ioe.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 18:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsWEUhGlgiDJAF54NYaVAeB30fuO9F/oKoWOkrplvy4=;
        b=RatiUEcn1JdMBKse7zsRoAozxhkJ+S36q73xagPuL/s3DLl229e4YWhUTZSFM5MfK8
         YXB4pvb5XpLYf0pXWMsKfjUkbmHzgAWQjSE965hNOleXV/6MyJPGbske87EqOGl1p6NM
         D+XvsOhXOWy4UddUmSclNWaJCmJMyOUDbZYtIeZn9Ah9MRjJPG6WRlnUVHrFyPFbxvZ/
         ky5lmX6+7LLZwAuJPjWEWiVH1KmMQVYYSZEDSFTnX2gF2CxsUNHX+d25r4kruiaI+SPb
         e+r15KPAc+Ls0kF6bXbfOroHorVGbFWBwDW3l4uokD0A7h4ndJmAFswdCy0KetMXzmn4
         PPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsWEUhGlgiDJAF54NYaVAeB30fuO9F/oKoWOkrplvy4=;
        b=afffIe9P6BqYG/7yqiP5KQzeNGOoT8ql5d+0PX+15hcjjdRYaFS/teMjlfcqim3kFn
         HX4bYaWoCrBhXGbumH8TbOFQ5gNR2RDp9DoODR/BX88DZnPe0QB73G/YfoF7kMiixKfS
         2upVMk9H/nk2exBzLEN+XRU1xQ/1Y+Oor2YWmDX1Qq6Oz2iGdLlEeTnLQYpDylMu75MJ
         42PnesC+iMKficvA5jcuZfD7vQxXgle3M7REZfMq8OcqaTUyfQ4XVhPVJzBW3BZm2nXO
         Pz1pd5KaxpII9kDpJFkQqIeptMhmWWIhlHDlMxYv5n0dmYlU3lpTDwe+HkTS4ASj9wpt
         aCTQ==
X-Gm-Message-State: AOAM533ODG1+ColCQ03OpuMeCsqfAH2nKJNLr8MErdly1nwPHFNuHdwG
        yRUp8N49q084AI1pVlifOLpyTl6Uu4SF/OWkLwWlDiSI7D0=
X-Google-Smtp-Source: ABdhPJyw64e5xJ/to+Ocus2wchEaS8D9C6LYCJtdOBiVIs3bq8Y0GkrK+zdLV5wpFvWX7G7ozFqTAVjTxJiz2C+7kp8=
X-Received: by 2002:a5d:80c9:: with SMTP id h9mr7017725ior.73.1598838093426;
 Sun, 30 Aug 2020 18:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200817234033.442511-1-leobras.c@gmail.com> <20200817234033.442511-2-leobras.c@gmail.com>
 <6232948f-033d-8322-e656-544f12c5f784@ozlabs.ru> <31e913d842693b6e107cb2b8e51fd45118b1bd2c.camel@gmail.com>
 <1e77a3d9-dff9-f58b-45be-77be7cbea41a@ozlabs.ru> <93037398c7afaabc0411890998f3f29f741c8aff.camel@gmail.com>
 <aaaf993a-d233-f5be-b809-5911a6a9872d@ozlabs.ru>
In-Reply-To: <aaaf993a-d233-f5be-b809-5911a6a9872d@ozlabs.ru>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 31 Aug 2020 11:41:22 +1000
Message-ID: <CAOSf1CG49ztvNoG43hcSHyLB9UY6Nc8maY_q6nvQmiyFQOAp3A@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] powerpc/pseries/iommu: Replace hard-coded page shift
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:08 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> On 29/08/2020 05:55, Leonardo Bras wrote:
> > On Fri, 2020-08-28 at 12:27 +1000, Alexey Kardashevskiy wrote:
> >>
> >> On 28/08/2020 01:32, Leonardo Bras wrote:
> >>> Hello Alexey, thank you for this feedback!
> >>>
> >>> On Sat, 2020-08-22 at 19:33 +1000, Alexey Kardashevskiy wrote:
> >>>>> +#define TCE_RPN_BITS             52              /* Bits 0-51 represent RPN on TCE */
> >>>>
> >>>> Ditch this one and use MAX_PHYSMEM_BITS instead? I am pretty sure this
> >>>> is the actual limit.
> >>>
> >>> I understand this MAX_PHYSMEM_BITS(51) comes from the maximum physical memory addressable in the machine. IIUC, it means we can access physical address up to (1ul << MAX_PHYSMEM_BITS).
> >>>
> >>> This 52 comes from PAPR "Table 9. TCE Definition" which defines bits
> >>> 0-51 as the RPN. By looking at code, I understand that it means we may input any address < (1ul << 52) to TCE.
> >>>
> >>> In practice, MAX_PHYSMEM_BITS should be enough as of today, because I suppose we can't ever pass a physical page address over
> >>> (1ul << 51), and TCE accepts up to (1ul << 52).
> >>> But if we ever increase MAX_PHYSMEM_BITS, it doesn't necessarily means that TCE_RPN_BITS will also be increased, so I think they are independent values.
> >>>
> >>> Does it make sense? Please let me know if I am missing something.
> >>
> >> The underlying hardware is PHB3/4 about which the IODA2 Version 2.4
> >> 6Apr2012.pdf spec says:
> >>
> >> "The number of most significant RPN bits implemented in the TCE is
> >> dependent on the max size of System Memory to be supported by the platform".
> >>
> >> IODA3 is the same on this matter.
> >>
> >> This is MAX_PHYSMEM_BITS and PHB itself does not have any other limits
> >> on top of that. So the only real limit comes from MAX_PHYSMEM_BITS and
> >> where TCE_RPN_BITS comes from exactly - I have no idea.
> >
> > Well, I created this TCE_RPN_BITS = 52 because the previous mask was a
> > hardcoded 40-bit mask (0xfffffffffful), for hard-coded 12-bit (4k)
> > pagesize, and on PAPR+/LoPAR also defines TCE as having bits 0-51
> > described as RPN, as described before.
> >
> > IODA3 Revision 3.0_prd1 (OpenPowerFoundation), Figure 3.4 and 3.5.
> > shows system memory mapping into a TCE, and the TCE also has bits 0-51
> > for the RPN (52 bits). "Table 3.6. TCE Definition" also shows it.
> >> In fact, by the looks of those figures, the RPN_MASK should always be a
> > 52-bit mask, and RPN = (page >> tceshift) & RPN_MASK.
>
> I suspect the mask is there in the first place for extra protection
> against too big addresses going to the TCE table (or/and for virtial vs
> physical addresses). Using 52bit mask makes no sense for anything, you
> could just drop the mask and let c compiler deal with 64bit "uint" as it
> is basically a 4K page address anywhere in the 64bit space. Thanks,

Assuming 4K pages you need 52 RPN bits to cover the whole 64bit
physical address space. The IODA3 spec does explicitly say the upper
bits are optional and the implementation only needs to support enough
to cover up to the physical address limit, which is 56bits of P9 /
PHB4. If you want to validate that the address will fit inside of
MAX_PHYSMEM_BITS then fine, but I think that should be done as a
WARN_ON or similar rather than just silently masking off the bits.
