Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7576C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D20206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3PLCcId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgHHWfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 18:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHWfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 18:35:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C2C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 15:35:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so2740277pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I/495s6jK4+K+lb6gJ13kJw9U3KMzAEyRbv/wQPm9f8=;
        b=H3PLCcIdqUB3EIjsg8we5jSGI9NkkuDvWgva4xebovhozPZytq9rBepnyTmSuYCkKO
         8E7+pKxRjIoIvtunYP1O+4A+yPxtXwNYXUi1ToAzG8O0kgjOpUP5WdbULMZ0zpx2bPmh
         qzlcpfMbk2iDSkMqBQNDNL83I3ZOB6RajjCDS6khFj4cYF89Cmi6bxq+EpDduudOc16s
         OEYAVV2uA2Hmz6WgWKCSSa6bJazvH9z06VGgg7RbEd7l0VQYngs4gFnMo8rHJLCCXHwG
         X9SecNqMrx3wv/M4bGKVLlEgbhdYLmHSAiU1WrHFx96fo/BKuX4uGtYOJRtYUoxGORvv
         5jEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I/495s6jK4+K+lb6gJ13kJw9U3KMzAEyRbv/wQPm9f8=;
        b=Lb1DJmkfJ9YaOXZTBQ6W45UPxRwWPQv1Pro22hnOgTyhNa6IlEoqNvMKl0dd3FKaRq
         YiO+1RM6oGPlCRYzxpa3QBU+Sgu2VTgXC+S/wF1/B0eK32Rlk7Vm6fgUw9HGIMRuuZ7v
         vOCWCYf5YQFY7hWmWEY2eq1BuACuf44St1kbkG4lB3B00cwwckp2k7xj8paQbMK6Mia+
         MMi2Um+hMkh4/QoHc9sdOGxgy7dW3PSPdfrlrZZTaFnVe/yQzrZ1NMlljaerC8FtsMG4
         8NEE17JIkQ4Zud2s/4RHBdOU338RJx+5DMoDl64x+zWbrPqN3c/67R3KSlw62JL6/+hw
         A+lA==
X-Gm-Message-State: AOAM531MYmQgpAFXCo1rdjwTxnwWjZAHo5b7SuPLiKJYI0+oOi8dHfc0
        a93sccE9qIiosa4ff8aAIWw=
X-Google-Smtp-Source: ABdhPJy18GEJMoZI66OE79WvxRq8YUz5aQXgKLgGrq2t6mfzL2oSPYvAGnuZyP8XL9T0CkaQJuQ9og==
X-Received: by 2002:a17:90a:1a42:: with SMTP id 2mr18451210pjl.16.1596926104709;
        Sat, 08 Aug 2020 15:35:04 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id y196sm18148356pfc.202.2020.08.08.15.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 15:35:03 -0700 (PDT)
Date:   Sun, 9 Aug 2020 07:35:01 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 6/6] openrisc: uaccess: Add user address space check
 to access_ok
Message-ID: <20200808223501.GP80756@lianli.shorne-pla.net>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200805210725.310301-7-shorne@gmail.com>
 <20200806190229.b7jbmkavu7qqzegy@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806190229.b7jbmkavu7qqzegy@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 09:02:29PM +0200, Luc Van Oostenryck wrote:
> On Thu, Aug 06, 2020 at 06:07:25AM +0900, Stafford Horne wrote:
> > Now that __user annotations are fixed for openrisc uaccess api's we can
> > add checking to the access_ok macro.  This patch adds the __chk_user_ptr
> > check, on normal builds the added check is a nop.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  arch/openrisc/include/asm/uaccess.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
> > index 85a55359b244..53ddc66abb3f 100644
> > --- a/arch/openrisc/include/asm/uaccess.h
> > +++ b/arch/openrisc/include/asm/uaccess.h
> > @@ -57,7 +57,8 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
> >  
> >  #define access_ok(addr, size)						\
> >  ({ 									\
> > -	__range_ok((unsigned long)(addr), (size));			\
> > +	__chk_user_ptr(addr);						\
> > +	__range_ok((__force unsigned long)(addr), (size));		\
> >  })
> 
> Just for info, __force is not needed when casting a pointer to
> unsigned long (or uintptr_t). It's not incorrect to use one
> but I think it's to avoid __force as much as possible.

Thanks, I didn't realize that.  I will fix.

-Stafford
