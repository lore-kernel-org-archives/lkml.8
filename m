Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E38C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8F920810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jrlDg3O4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgE2Taz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgE2Tay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:30:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D286C08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:30:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so1633864plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l1M0XSXyeU2e0pe6gWxiPX/b/pI4C8uR1ZRScXdAhj4=;
        b=jrlDg3O45xwEwCvNIufi5+Ac7Ca3Ik2CpN27YrotC/WC7VM3mdb9PV57Z0MFgp0Fip
         EIz/h3lxCV7ayd2bxy8wrBonqnAYIK9n0V78dHHjtKri6MjFrleFBmsqb+agI6ejdtMQ
         pE0Z2eysllLV2XjNmg/O+3SJy9nEvbyJB76BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1M0XSXyeU2e0pe6gWxiPX/b/pI4C8uR1ZRScXdAhj4=;
        b=FekrVrI5jD07xKLDmpt+148gldhyiP4E2vGws1DHWOm8tJwJznqJUkzEsMSosFSQl/
         CV/i7l1Iy3PYe2F5u/BH4z8TGAuLFjWpMQjlFcInoHIOg0F6mtN9ys3pU+hqeQMUtNyg
         5Kit3h87Fh7gyIfe+amxPOTYUAmZ4O/gh+WRpU4M/UGzYhoBfRmKvv1ZJ+/zV69O02ai
         AN1vej5/f+0v39gqRe8DnCjfU50UtKB2wo45mnJM3XAlA9S02hMHzdOmh6R2U9y6xq7x
         4VX1qhaS6DdATt7SNydyBXhmpEdBPQuBVLlFQdnZSX1ZUgh5IimKjDz03qEmH+pYeFa7
         YKsw==
X-Gm-Message-State: AOAM530pEpT6G1FdkHOtdB+wPvU8OJw/Byr4tIMEUyzhBlOf87HvY0qe
        toSYLY3eqfnXUmK5UBk2UK24FA==
X-Google-Smtp-Source: ABdhPJyRHztaxHxX+p+Q+1VGTGF14FEpM+nlldyJQJqrvG/E2zmOqW2PbBTa2cXbKAdd+dK2odwS5g==
X-Received: by 2002:a17:902:aa48:: with SMTP id c8mr1570744plr.128.1590780653881;
        Fri, 29 May 2020 12:30:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1sm8103265pfg.205.2020.05.29.12.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:30:52 -0700 (PDT)
Date:   Fri, 29 May 2020 12:30:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for May 14 (objtool 2/2)
Message-ID: <202005291229.37DE69E@keescook>
References: <20200514210716.30b416ee@canb.auug.org.au>
 <742521db-1e8c-0d7a-1ed4-a908894fb497@infradead.org>
 <20200528154404.74sjv4bdj3myacn6@treble>
 <202005282258.94570AF@keescook>
 <20200529175456.tbedus7okjrlkao7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529175456.tbedus7okjrlkao7@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:54:56PM -0500, Josh Poimboeuf wrote:
> On Thu, May 28, 2020 at 11:06:32PM -0700, Kees Cook wrote:
> > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > index 929211039bac..27bcc2568c95 100644
> > --- a/lib/Kconfig.ubsan
> > +++ b/lib/Kconfig.ubsan
> > @@ -63,7 +63,7 @@ config UBSAN_SANITIZE_ALL
> >  config UBSAN_ALIGNMENT
> >         bool "Enable checks for pointers alignment"
> >         default !HAVE_EFFICIENT_UNALIGNED_ACCESS
> > -       depends on !X86 || !COMPILE_TEST
> > +       depends on !UBSAN_TRAP
> >         help
> >           This option enables the check of unaligned memory accesses.
> >           Enabling this option on architectures that support unaligned
> > 
> > How about that?
> 
> But I thought you said the alignment traps might be useful on other
> arches?  Should it be
> 
> 	depends on !X86 || !UBSAN_TRAP
> 
> ?

I was just trying to avoid objtool there, but really, UBSAN_TRAP is
likely insane for unaligned access checks entirely. If anyone ever needs
it, they can adjust. :)

-- 
Kees Cook
