Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA491C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A121D2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgq/rdcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgIAVjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgIAVi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:38:57 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E95C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 14:38:57 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so2121879qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 14:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=0wt0Kuaq0tmnkhHuwXET4PhGnm4atGZXoNq5U4y8d/M=;
        b=mgq/rdcGU4bevby5Hlt3CzlEdoPTc7IOr4f0kpKR036Ghpq41mvUUOV242Sb4pegiq
         nItSycVWuRj25AVkilg7HiVX6yWHtvNqKc/xbxvV1DVxpzy6WEV5s+Op6iI2ERv6TKd3
         elYYhmNlsAaDgytzwWaXoAZtR6uVG2I9R7IKUfAlWxHZQwNJK01PR+jSMz3WHrc/PG0p
         SfDA3/1pDqN0mFjHMNwRCoN4uzhqQyfM447D4H8D7T9zJw7xrSy97m3UyzDhMnngAqw6
         E7ZlZF5hrX/SNnYanNGI8StgNmz9T+pBsqXw9fhKB7QNn0E1oPBDwqNWdm8cXcmagOMJ
         KKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=0wt0Kuaq0tmnkhHuwXET4PhGnm4atGZXoNq5U4y8d/M=;
        b=Xsp3iIvBUV3qVHE/YLOnPXkHp8CvWLtPXpDmOjUxC/L4wCBd8mZPIinhKen0NehUnC
         bV3KQDdfAm2HmOjThfw7AjkAmSWmfaYS60EULKrkuwGrNNa2DBJrn3zG+bPdANFvpMKJ
         bVJErz4+t1y1/fvhckoNIIWKGxbqHNYAMiJ8GJfqyXQJf0nVB4t5+gXdCJJaZHUXTHKu
         HZHhVZz6JwICa1nqd7Wmjs+qkBipnr3IDKFb4mhY37bPTXAQAVED5IaJeJMGrRqWTEYD
         ZDf9TszYLHLBneHrac1PpreEqRZQUIGG0OtTFr1CyAXP4ib4YwJOBmaNcFEFMtbAdJYZ
         a1zA==
X-Gm-Message-State: AOAM533VOzBouYfSGPdH6YgBlUa1HPJAtuYI2HzYXlZdiaMDZst8NBvn
        VzLVwyKdVKyKhCjEHkLDOS8=
X-Google-Smtp-Source: ABdhPJwS5J9BIXwt+G+buetpCLmAXOFuR/gX5UAID4DPPAy7GpdTArczhpDIQAnFk4qy+5/xN7f1ew==
X-Received: by 2002:ac8:7246:: with SMTP id l6mr1816360qtp.145.1598996336093;
        Tue, 01 Sep 2020 14:38:56 -0700 (PDT)
Received: from LeoBras (179-125-130-62.dynamic.desktop.com.br. [179.125.130.62])
        by smtp.gmail.com with ESMTPSA id w20sm2865190qki.108.2020.09.01.14.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 14:38:55 -0700 (PDT)
Message-ID: <c381d7e60d0924e432b0f36dce9a44b89733a129.camel@gmail.com>
Subject: Re: [PATCH v1 01/10] powerpc/pseries/iommu: Replace hard-coded page
 shift
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Oliver O'Halloran <oohall@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
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
Date:   Tue, 01 Sep 2020 18:38:48 -0300
In-Reply-To: <1bba12c6-f1ec-9f1e-1d3e-c1efa5ceb7c7@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-2-leobras.c@gmail.com>
         <6232948f-033d-8322-e656-544f12c5f784@ozlabs.ru>
         <31e913d842693b6e107cb2b8e51fd45118b1bd2c.camel@gmail.com>
         <1e77a3d9-dff9-f58b-45be-77be7cbea41a@ozlabs.ru>
         <93037398c7afaabc0411890998f3f29f741c8aff.camel@gmail.com>
         <aaaf993a-d233-f5be-b809-5911a6a9872d@ozlabs.ru>
         <CAOSf1CG49ztvNoG43hcSHyLB9UY6Nc8maY_q6nvQmiyFQOAp3A@mail.gmail.com>
         <1bba12c6-f1ec-9f1e-1d3e-c1efa5ceb7c7@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-31 at 13:48 +1000, Alexey Kardashevskiy wrote:
> > > > Well, I created this TCE_RPN_BITS = 52 because the previous mask was a
> > > > hardcoded 40-bit mask (0xfffffffffful), for hard-coded 12-bit (4k)
> > > > pagesize, and on PAPR+/LoPAR also defines TCE as having bits 0-51
> > > > described as RPN, as described before.
> > > > 
> > > > IODA3 Revision 3.0_prd1 (OpenPowerFoundation), Figure 3.4 and 3.5.
> > > > shows system memory mapping into a TCE, and the TCE also has bits 0-51
> > > > for the RPN (52 bits). "Table 3.6. TCE Definition" also shows it.
> > > > In fact, by the looks of those figures, the RPN_MASK should always be a
> > > > 52-bit mask, and RPN = (page >> tceshift) & RPN_MASK.
> > > 
> > > I suspect the mask is there in the first place for extra protection
> > > against too big addresses going to the TCE table (or/and for virtial vs
> > > physical addresses). Using 52bit mask makes no sense for anything, you
> > > could just drop the mask and let c compiler deal with 64bit "uint" as it
> > > is basically a 4K page address anywhere in the 64bit space. Thanks,
> > 
> > Assuming 4K pages you need 52 RPN bits to cover the whole 64bit
> > physical address space. The IODA3 spec does explicitly say the upper
> > bits are optional and the implementation only needs to support enough
> > to cover up to the physical address limit, which is 56bits of P9 /
> > PHB4. If you want to validate that the address will fit inside of
> > MAX_PHYSMEM_BITS then fine, but I think that should be done as a
> > WARN_ON or similar rather than just silently masking off the bits.
> 
> We can do this and probably should anyway but I am also pretty sure we
> can just ditch the mask and have the hypervisor return an error which
> will show up in dmesg.

Ok then, ditching the mask.
Thanks!

