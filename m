Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED93C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60A520738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DEgcNUgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgFVXAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgFVXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:00:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF6DC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:00:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so9098354pfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=83TCNCBjNohNVrqhGduE8K74z3IQ6/Lu6H9fSwHcKBI=;
        b=DEgcNUgmnqgavBlvTgADYfLgOafyX/H5FdDRdvi9Bb6S/WBs7kYll9YiPjRSOvgAEG
         v7bulz7OBSDhmA+jwBGRGVdMGRWVjDRy6+FOm9QURTY20m2IeGFzm5+8yMNEN2Dr6Oa1
         ibe8QqZwP9MNkKA71L+uamdauQHqW1Qj57tvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83TCNCBjNohNVrqhGduE8K74z3IQ6/Lu6H9fSwHcKBI=;
        b=El77Bk34l+2r4K7MseJxdqtjL1mQ+bWxOlr0vpSKNyz6aHWIKl5vNQ7cFYx3Q/RwtQ
         CHYYhgedwWsRG1IzjuCB2+CFrlnO/rLhklXYEAFk9mRgEtqucgEnaHchpiC/4+IKXooL
         zrAUBHJYOEnck5du3H17HMnFgR3zSi8xlrPM1axZicx1P4SDI3rLxEv0ttwhMkqQL2pv
         gacjaaoCXvOkXdiUIAk1odbMSBMYv0XuPOPeHToayRypmxcYflXib/1Rb0GJVxuSVB7I
         hYYgp0OK4POsQ+FG2wt0FzF7EWj09Vx6v1AJCF2VaYvXngRsrMAwnzCV/t19zvD/vCP+
         tAZw==
X-Gm-Message-State: AOAM531aMzyCiyP4EK2Dpuh1eaVRJdxHwAwTpivCSkH1M0k2l8BKYOb5
        zrncSzQenlMeYP1KnHG4FlDiXQ==
X-Google-Smtp-Source: ABdhPJzDfln86XAWzAEV3/P8Jj4TpYbAS/ch7Sm25KrySby0/SNFjM433WHLKjjRx44/ZmqpW6wv+w==
X-Received: by 2002:a63:df56:: with SMTP id h22mr14511327pgj.140.1592866814612;
        Mon, 22 Jun 2020 16:00:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v7sm14485890pfn.147.2020.06.22.16.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:00:13 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:00:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <202006221600.81F5586@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
 <20200622220628.t5fklwmbtqoird5f@google.com>
 <202006221543.EA2FCFA2FF@keescook>
 <20200622224928.o2a7jkq33guxfci4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622224928.o2a7jkq33guxfci4@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:49:28PM -0700, Fangrui Song wrote:
> On 2020-06-22, Kees Cook wrote:
> > On Mon, Jun 22, 2020 at 03:06:28PM -0700, Fangrui Song wrote:
> > > LLD may report warnings for 3 synthetic sections if they are orphans:
> > > 
> > > ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
> > > ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
> > > ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
> > > 
> > > Are they described?
> > 
> > Perhaps:
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index db600ef218d7..57e9c142e401 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -792,6 +792,9 @@
> > 		.stab.exclstr 0 : { *(.stab.exclstr) }			\
> > 		.stab.index 0 : { *(.stab.index) }			\
> > 		.stab.indexstr 0 : { *(.stab.indexstr) }		\
> > +		.symtab 0 : { *(.symtab) }				\
> > +		.strtab 0 : { *(.strtab) }				\
> > +		.shstrtab 0 : { *(.shstrtab) }				\
> > 		.comment 0 : { *(.comment) }
> > 
> > #ifdef CONFIG_GENERIC_BUG
> 
> This LGTM. Nit: .comment before .symtab is a more common order.

Adjusted.

> Reviewed-by: Fangrui Song <maskray@google.com>

Thanks!

-- 
Kees Cook
