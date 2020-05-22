Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDB0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1FB2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PrjvHlWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgEVNiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbgEVNiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:38:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E8C05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 06:38:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f13so10716449qkh.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YBx0QmgBlhkPaubO0vtt6QDHFJk7HKYLiMKXWU9gGLs=;
        b=PrjvHlWoGx0tOv0xWyqyUec5LfWVpFdXT95xXV2W7uO6uczntwzYivL0XfeTSyxKOJ
         rbS28lT8ArAQ3vl6VS9se8TLJFiS/+VqDagHUXwvaY6okiRqnr4r7mqZYeA6/3rhZrMG
         f9jVGK3EDVQgrJYwc+PXdgKKGw7FOdxNKC/pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YBx0QmgBlhkPaubO0vtt6QDHFJk7HKYLiMKXWU9gGLs=;
        b=e/k26ejN9JfrttHfmdgI8a8G9HN2dLGLyl4Tar6s3q1fOuQGlCrxbUY595D10/jvd+
         Z47Ir9f2KwdHSsmbMCpJF8POu1MnmscXoJm/MnskWDKzmwzXtZ54ljuVGXGNlu9chBpB
         6+/U0F+qW4ybNPox9soYMi56AcjsWUjtLX13Zni4HrAcJJyc2rUFRgpRs2mK7WMktKIR
         7Db5P2NNZMAtlgxv9ygkT/k3zXi95bknNkmRFeVJg0Mwbdlx+NizoQGjax9nFX0CZysc
         0szb14H/GUb9Q57Ro2kVacYLHL2TXNRE/Lqz4lEROzO/z7jMkqfQvS6ERtzPTryfwPJp
         2bjg==
X-Gm-Message-State: AOAM530MgyWiJobZmmaYWGShCh6NN2xAjhVvqSxyI0sFromchhMJOq03
        uLbFuBzJTzY2JzvlmMRbbjaP5g==
X-Google-Smtp-Source: ABdhPJwIySgd5FjYEb2seaX5kyI0Ej2bREBDLCoGNYAWJMUC5WkeYKNtC90051dOURxepwzIcfAp0Q==
X-Received: by 2002:a05:620a:6b7:: with SMTP id i23mr14461310qkh.156.1590154697354;
        Fri, 22 May 2020 06:38:17 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m33sm7675398qte.17.2020.05.22.06.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 06:38:16 -0700 (PDT)
Date:   Fri, 22 May 2020 09:38:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Blecker <matthewb@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Mike Frysinger <vapier@google.com>,
        Christian Brauner <christian@brauner.io>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        vineethrp@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC] sched/headers: Fix sched_setattr userspace
 compilation issues
Message-ID: <20200522133816.GB210175@google.com>
References: <20200521155346.168413-1-joel@joelfernandes.org>
 <CAEXW_YTj83gO0STovrOuL9zgDwEYWRJusUZ3ebVw_jOG6yJxTg@mail.gmail.com>
 <20200522131355.f4bdc2f4h2zyqbku@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522131355.f4bdc2f4h2zyqbku@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 03:13:55PM +0200, Christian Brauner wrote:
> On Thu, May 21, 2020 at 11:55:21AM -0400, Joel Fernandes wrote:
> > On Thu, May 21, 2020 at 11:53 AM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > On a modern Linux distro, compiling the following program fails:
> > >  #include<stdlib.h>
> > >  #include<stdint.h>
> > >  #include<pthread.h>
> > >  #include<linux/sched/types.h>
> > >
> > >  void main() {
> > >          struct sched_attr sa;
> > >
> > >          return;
> > >  }
> > >
> > > with:
> > > /usr/include/linux/sched/types.h:8:8: \
> > >                         error: redefinition of ‘struct sched_param’
> > >     8 | struct sched_param {
> > >       |        ^~~~~~~~~~~
> > > In file included from /usr/include/x86_64-linux-gnu/bits/sched.h:74,
> > >                  from /usr/include/sched.h:43,
> > >                  from /usr/include/pthread.h:23,
> > >                  from /tmp/s.c:4:
> > > /usr/include/x86_64-linux-gnu/bits/types/struct_sched_param.h:23:8:
> > > note: originally defined here
> > >    23 | struct sched_param
> > >       |        ^~~~~~~~~~~
> > >
> > > This is also causing a problem on using sched_attr Chrome. The issue is
> > > sched_param is already provided by glibc.
> > >
> > > Guard the kernel's UAPI definition of sched_param with __KERNEL__ so
> > > that userspace can compile.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > If it is more preferable, another option is to move sched_param to
> > include/linux/sched/types.h
> 
> Might it be worth Ccing libc-alpha here? Seems like one of those classic
> header conflicts.

sched_param is defined by POSIX from my reading of the manpage. Is the kernel
supposed to define it in the UAPI at all? I guarded it with __KERNEL__ as you
can see.

Resent with libc-alpha CC'd per your suggestion.

thanks,

 - Joel


