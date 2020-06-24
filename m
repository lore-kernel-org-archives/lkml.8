Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63502082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ity7y8rG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391308AbgFXTnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391221AbgFXTnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:43:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C3C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:43:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 207so1468972pfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WCT8Mp1fiF4Iw+yjIn+C6cOd3D8sms76UQBr6znEpWk=;
        b=Ity7y8rGEc4oXEiXH3BGiprKBtYxV9crm+SUp0bxSrD2vqsQpgiAGySgg9bKC7LzJV
         MvzzUHrbKRWE0ccNr7TR1xFfDhtPE+sOVldl9vLooehH6TKNQKk4H23pnw3+Yywmxc3X
         Gf1bDrSN+lJP7Y5X+I+PBa3FqpnMes7qV+nio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WCT8Mp1fiF4Iw+yjIn+C6cOd3D8sms76UQBr6znEpWk=;
        b=p5YS1eJnEYdY2/ZydQLXMKl4VQAesfJwg87kcaz+dSlEyuGCm6wrdEMmiu1w5KXVVr
         d597g3InBlTq4438r/swdk3esxKJ4dnpVLSv1by7WYzt4K0tkxw8x8jlHWkA+NCd2SHj
         o6T3GvRygc23q6Nyr09WPL7AwanRl0N8mtrCSglTlJeoiYTggPSLqQcKK0Z1mDF4981C
         etsUTnmw08+TWycCXsSQylhN/k3IUFbp00PY18jGeQIZqbVBomeh37isdnORqlE8ey0L
         R0X+wYAAP2LO59Fqj4ECGKu/0g1L9DAqNzMGC2TsCucWqCNdm82z7etX7KzxoZAefEjO
         +l2Q==
X-Gm-Message-State: AOAM533p5R8U6F8hcPNWnSmGyPJr4nvLtXVzT9dTqIfYXJnP77zrWUoZ
        zUqFzQrYkBAea19Xb41XY1UcJA==
X-Google-Smtp-Source: ABdhPJwP/uUgjETkk5aFs5K2MQeLa9UJBGY/bZTj/5fR8QMrKjmZ3xMU7b9faBxVf+JpeANaqXIF+g==
X-Received: by 2002:a63:c004:: with SMTP id h4mr23300961pgg.385.1593027823302;
        Wed, 24 Jun 2020 12:43:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j126sm20542728pfg.95.2020.06.24.12.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 12:43:42 -0700 (PDT)
Date:   Wed, 24 Jun 2020 12:43:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@quicinc.com>
Subject: Re: [PATCH v2 1/2] arm/build: Warn on orphan section placement
Message-ID: <202006241242.9A6E0E2387@keescook>
References: <20200622204915.2987555-1-keescook@chromium.org>
 <20200622204915.2987555-2-keescook@chromium.org>
 <CAKwvOdmYa6V=W2eupEmHcuF8+479F8XHxm1NAo0s2N=sawbKAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmYa6V=W2eupEmHcuF8+479F8XHxm1NAo0s2N=sawbKAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:03:46PM -0700, Nick Desaulniers wrote:
> On Mon, Jun 22, 2020 at 1:49 PM Kees Cook <keescook@chromium.org> wrote:
> > [...]
> > @@ -37,6 +38,13 @@
> >                 *(.idmap.text)                                          \
> >                 __idmap_text_end = .;                                   \
> >
> > +#define ARM_COMMON_DISCARD                                             \
> > +               *(.ARM.attributes)                                      \
> 
> I could have sworn that someone (Eli?) once told me that this section
> (.ARM.attributes) is used for disambiguating which ARM version or
> which optional extensions were used when compiling, and that without
> this section, one would not be able to disassemble 32b ARM precisely.
> If that's the case, we might not want to discard it?

Perhaps we want to treat it like .comment and include it in the ELF?

> > +#define ARM_STUBS_TEXT                                                 \
> > +               *(.gnu.warning)                                         \
> > +               *(.glue_7t)                                             \
> > +               *(.glue_7)                                              \
> 
> This changes the order of .glue_7t relative to .glue_7.  Maybe that
> doesn't matter.

Good point. I'll swap it just for consistency.

Thanks!

-- 
Kees Cook
