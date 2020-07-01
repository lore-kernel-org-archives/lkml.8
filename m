Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E099C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2568C206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1rO08Qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgGAN2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbgGAN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:28:10 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB50C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:28:10 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m8so6740468qvk.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=Y/vZ0IaH6Uw3eP/ISe3M+HbULBx3TPd+u4JIT5Z3fII=;
        b=A1rO08QkgPZhsED3RVZ+ZqDVen4OR0gzB2qMM0S8Kku4IJn6vBsKt27YiE4kHW8KFm
         p1KAW+mE+L/3x6XxIJFQJfFntNSqKuY6n+rDDL0P061Q7FuOVf/BRnHYUCr/uVVPHtx6
         vFQWI4Wv5ktyjLp/PCN69/7jC7WDYdaSbd0AFkuYcmiO/iIHHxaiQttsc6v3cczcywhM
         Duze3SKjWqbuT/HdoyFmH5vRByF1YRHXen4RvRzwnmLbn7tR6w73wdZQ8UrPHDZoF/C/
         LKtAQkekuwjXHp6AdqoGNTI09FGVRWq24j8IaK16749iCejHcuArxfqcvUZDqjYDPTl9
         fiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y/vZ0IaH6Uw3eP/ISe3M+HbULBx3TPd+u4JIT5Z3fII=;
        b=Gvcp6slegKCIeTnx1h30w0iACJ9UVcqRGuiPRiOwBPbz0RNhEjseziEl+/+3K056Ad
         uJA3kPeFNkqbPsDf1Ve7PxcDt4VVNS+BPULlfdDCPv3Gj5il+VClOVNkAxw4HUblCEpG
         ep+Oj3J2T1GApgoaXBsiifnxPnTFakoatPBPvv6uzNmOKB9l7SNqywlyYhoqOETuudEJ
         sfTbotPXZJ6BVIwe5wjT70X7Xy0Sde8aO14Vc1yCe6QMqhtS67lic70AGsfyLUjjoZzV
         mUjk/8J04yRbcsDpzzyWCP2xDsurIN1lh9w7mlZRU3LlphUkUAknsxD8679VLgyFAusA
         QNBA==
X-Gm-Message-State: AOAM532GrNoGCX+awaBEb5rdvcDQ92V7D+YpmgdJIvatlPjV0Funi3I0
        TUfvr6Qii04HHWCCvjZAPyo=
X-Google-Smtp-Source: ABdhPJw3huwWuQG/EdrGuTHYYm3gTieFnFjw1EBMeRiZdWUlp7fgVj5eowMXqInAwJJRpPTtZncaZA==
X-Received: by 2002:a0c:99e1:: with SMTP id y33mr22349026qve.90.1593610089419;
        Wed, 01 Jul 2020 06:28:09 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id i8sm5333510qtr.90.2020.07.01.06.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:28:08 -0700 (PDT)
Message-ID: <01443a2f1d58a595ddff03fd14fd56f4c26171bf.camel@gmail.com>
Subject: Re: [PATCH v2 1/6] powerpc/pseries/iommu: Create defines for
 operations in ibm,ddw-applicable
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 10:28:03 -0300
In-Reply-To: <b0caaaa0-14c9-51de-bb92-5be8ccaa418d@ozlabs.ru>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-2-leobras.c@gmail.com>
         <b0caaaa0-14c9-51de-bb92-5be8ccaa418d@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 18:16 +1000, Alexey Kardashevskiy wrote:
> 
> On 24/06/2020 16:24, Leonardo Bras wrote:
> > Create defines to help handling ibm,ddw-applicable values, avoiding
> > confusion about the index of given operations.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 40 +++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 6d47b4a3ce39..68d2aa9c71a8 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -39,6 +39,11 @@
> >  
> >  #include "pseries.h"
> >  
> > +#define DDW_QUERY_PE_DMA_WIN	0
> > +#define DDW_CREATE_PE_DMA_WIN	1
> > +#define DDW_REMOVE_PE_DMA_WIN	2
> > +#define DDW_APPLICABLE_SIZE	3
> 
> #define DDW_APPLICABLE_SIZE  (DDW_REMOVE_PE_DMA_WIN + 1)
> 
> thanks,

Thanks for the feedback!
About this (and patch #2), would it be better to use enum ?
enum {
	DDW_QUERY_PE_DMA_WIN,
	DDW_CREATE_PE_DMA_WIN,
	DDW_REMOVE_PE_DMA_WIN,

	DDW_APPLICABLE_SIZE
}
IMO, it looks better than all the defines before.

What do you think?

Best regards,

