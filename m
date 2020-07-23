Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D26C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C50C22BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFO2OGvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGWKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgGWKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:33:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5A7C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 03:33:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so4643185wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kMkunFqI5uWPQg1SZXJZmt2gqQjySBObshw2va86iQQ=;
        b=OFO2OGvUrgy6OrO/vKz3+aZM1MTpeJmspJ6zeyJBzkJ4nRGtTeizL49JH9jm4/I1Hg
         EjFaPIZh2gcU8XsnDxMrLvBTSK6JYe92EZhk2zTWnI+5KyH4r4o9hsKjU3P4/vtLBJ5L
         m3PxH+ndtIIBNi1935/i3w9UF8mgpjIgRRnEVKqVEvjjffz/OeLh2GTM35Q+cBMd3xZI
         rKkuyKLutX0OC2ZcK7eIlChL22/giiWw4s2XNEZbLJS+AmNQmUsJ1hzz9bruZ37w/aXe
         7bHT3Oi/r1ogtK9crH3bVaXw/Od7Ouaf6iDvJFRmGvyD51zF9bnBVN5c52vzYtpwi/K1
         vJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kMkunFqI5uWPQg1SZXJZmt2gqQjySBObshw2va86iQQ=;
        b=UgVV6BsPBSSo2oC7DKEg8RPUGcrBq/JZu9mLoIufyxk2RQkKSkd7UqPzg828uujJ/u
         sjrsAmPu+l1tB9V8ZGV3CTu6AB4YHiRsKlHAuHuEn/dm5lsuHWsurXesavt78vEgvLBL
         I0SMxfl6NGajDaw2MG4HRl+ExbKKN11Z6+7vLixKyxYWrfWLZfivqXi8/cp68IZrB6VB
         M3AkoFXacb2AMFREfGCYV5vHevaq/ZC42GrQ/a/87Se7qEy3ebw/kszvj+zmWOPFjraH
         xbHEV9Ujd3nHS1D77AGXgAvs/53307MpuRX/MB4Aj6CvoMeircC1aKE1GqFl89gyrF6A
         eqCQ==
X-Gm-Message-State: AOAM533GJ7Hp1hLT9+TnAxJjfa5NQgOMBXZ9x52F3x37Mf/7+TW4r7Mo
        6Yljua6LtTHGOrdZ3DfwgAhHyJ7SvFI=
X-Google-Smtp-Source: ABdhPJxyLN+/fszuexUqbwt0xNpd7bdd53jw406nAcySRsW80tqliv95EtP+9Dh7NZ6fQjW9lDTsNw==
X-Received: by 2002:adf:f785:: with SMTP id q5mr2583020wrp.298.1595500415904;
        Thu, 23 Jul 2020 03:33:35 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id i9sm2920657wmb.11.2020.07.23.03.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 03:33:35 -0700 (PDT)
Date:   Thu, 23 Jul 2020 11:33:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/1] doc:it_IT: process: coding-style.rst: Correct
 __maybe_unused compiler label
Message-ID: <20200723103333.GO3533@dell>
References: <20200715122328.3882187-1-lee.jones@linaro.org>
 <4e50d1ee2ebd55f8f87fcd5c631e97f3@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e50d1ee2ebd55f8f87fcd5c631e97f3@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020, Federico Vaga wrote:

> Of course, you are right! Thanks
> 
> On 2020-07-15 14:23, Lee Jones wrote:
> > Flag is __maybe_unused, not __maybe_used.
> > 
> > Cc: Federico Vaga <federico.vaga@vaga.pv.it>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > Cc: clang-built-linux@googlegroups.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>

Any idea who will/should take this?

> > ---
> >  Documentation/translations/it_IT/process/coding-style.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/translations/it_IT/process/coding-style.rst
> > b/Documentation/translations/it_IT/process/coding-style.rst
> > index 6f4f85832deea..a346f1f2ce21f 100644
> > --- a/Documentation/translations/it_IT/process/coding-style.rst
> > +++ b/Documentation/translations/it_IT/process/coding-style.rst
> > @@ -1097,7 +1097,7 @@ la direttiva condizionale su di esse.
> > 
> >  Se avete una variabile o funzione che potrebbe non essere usata in
> > alcune
> >  configurazioni, e quindi il compilatore potrebbe avvisarvi circa la
> > definizione
> > -inutilizzata, marcate questa definizione come __maybe_used piuttosto
> > che
> > +inutilizzata, marcate questa definizione come __maybe_unused piuttosto
> > che
> >  racchiuderla in una direttiva condizionale del preprocessore.
> > (Comunque,
> >  se una variabile o funzione è *sempre* inutilizzata, rimuovetela).
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
