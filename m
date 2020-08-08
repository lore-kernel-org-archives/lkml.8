Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D4C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FC4206B5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVNW+y9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHHXIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHHXIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:08:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05277C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:08:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c16so5747472ejx.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zAaByrVsjAb8vkDODtWIHOdYlEgt3BUanXR86wDnYY8=;
        b=KVNW+y9kpxQQr+a9b39ZyonobIptGqRr7IUHfHN20hS/wnnFnufklnyEB/93fviJ+7
         Tv5QZXRlXmNXIvNaI7LpomsQPAJbQntM0YY19Nd1q34IKVzlBCYesu7TrzlJ9+ir91/l
         kpCHA5zOQnntbUAgkjHlrTTF0DlL15tYGz4RXJ5Iqzx8ube2iTYy7Dtru7CQcr+/X0Vr
         5n7p43OYCIVdPUfLLPUmwCpH4gsCZrz5AM1D+IJbYYjentOrU0n2EOJ0XLHJP8+tWCHt
         bncy1S4TNdQ75G319IAquwzSSrnmTwYfe843M/1EALN9WcU9HF22sEqyech7ew9amrXn
         2BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zAaByrVsjAb8vkDODtWIHOdYlEgt3BUanXR86wDnYY8=;
        b=EIPkvFQoB8yc1flp2KAJH3eMBKHwv+HDmX5NfqK4W29SU/DATCfYp3/WK4bpB6VNc+
         yk5PVRBiumUy20KedLKGvtXPTNtiyoRNlxIeAyTZi55Djc/KnDXLAQMZy3amn/CxmaSX
         aDK9W0O/pEd2YhpltXEDhnREApcr5h3P89sYtGZslD+DyUeLBYkNXzHZE5JesWCqCp4m
         vOhYtx4YI6kF3g9LpL+1Ipmwb1SiR5c4mqq74cxTsS5WTH0xYwmiSbZTPIeEbJ6RoPRh
         kQRJMLG8lwSLhN9tWanrkLSgYaXu5kuQUiM/FiElsfqpOPaZWogI1+tydSSII/yN+pjN
         QZqA==
X-Gm-Message-State: AOAM533hZsfGUAIfag9RNmnGrc38wMNwDv2g9mw7KHoz9ofrHJva+UVb
        DpZaENXM3Prii8IuCnlWs34=
X-Google-Smtp-Source: ABdhPJyP5jl7/2J/NXBdipAl6ngjmA4FZxLt8ho9+qZHMgHxuaGiWoeQVK9/R6TblDdzHI86FLNgew==
X-Received: by 2002:a17:906:fcb3:: with SMTP id qw19mr16283026ejb.271.1596928124697;
        Sat, 08 Aug 2020 16:08:44 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:6d1d:82a1:4f64:b708])
        by smtp.gmail.com with ESMTPSA id cm22sm8864099edb.44.2020.08.08.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 16:08:44 -0700 (PDT)
Date:   Sun, 9 Aug 2020 01:08:42 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 5/6] openrisc: signal: Fix sparse address space
 warnings
Message-ID: <20200808230842.4bdwrvuz3lbgkcom@ltop.local>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200805210725.310301-6-shorne@gmail.com>
 <20200806190449.xqflhmbiiv5btusf@ltop.local>
 <20200808224822.GQ80756@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808224822.GQ80756@lianli.shorne-pla.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 07:48:22AM +0900, Stafford Horne wrote:
> On Thu, Aug 06, 2020 at 09:04:49PM +0200, Luc Van Oostenryck wrote:
> > On Thu, Aug 06, 2020 at 06:07:24AM +0900, Stafford Horne wrote:
> > > ---
> > >  arch/openrisc/kernel/signal.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> > > index 4f0754874d78..7ce0728412f6 100644
> > > --- a/arch/openrisc/kernel/signal.c
> > > +++ b/arch/openrisc/kernel/signal.c
> > > @@ -76,7 +76,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
> > >  	 * then frame should be dword aligned here.  If it's
> > >  	 * not, then the user is trying to mess with us.
> > >  	 */
> > > -	if (((long)frame) & 3)
> > > +	if (((__force unsigned long)frame) & 3)
> > >  		goto badframe;
> > 
> > Same as patch 6, the __force is not needed.
> 
> Thanks,  I thought this was complaining before, I tested now and there is no
> problem so I must have been mixed up with something else.

Sparse should have complained with with the cast to long but
purposely doesn't with unsigned long (or uintptr_t).
So, no mix up, I think.
 
Cheers,
-- Luc
