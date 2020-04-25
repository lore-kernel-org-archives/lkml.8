Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C302C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4F520706
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUXzjlY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgDYWZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 18:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726232AbgDYWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 18:25:08 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57211C09B04F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 15:25:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b1so7520053qtt.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xuQcmX1KuUHGcvDHgPS1loxSumVbQobQeCIW/Qnf+WU=;
        b=DUXzjlY0Gb6oeL/I2LT28x1KTxIhrpTcB8nsZp0Bj6bBweC03HPMYVSwd8cOGoavMV
         pPZu+ng+/FIsmudg/jkmH4Mf1+sXsDntxyGjEnwqAsgLxmrJwdTKPuJvZk1vvlqSaUtF
         AI51Wt7EKHFOEqDfoSMQmAJto565MqJtsgyRSaWQK0yZkIADmeo0ZQ1B6MZ8POxeBqj6
         rjBSjKWMF2C4sssgW/Qf+pinfy1pA9Gt47I6tK284HM1w3iGCELctfTm5+v+qfVN1rTf
         EGLW5NS/0jUXu10M22D0ezOtNRlTj3EF6BjOZStMkpD0mKCVbRLyMJgGRKuHxvuxFzoy
         NriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xuQcmX1KuUHGcvDHgPS1loxSumVbQobQeCIW/Qnf+WU=;
        b=f35mfBoZmRtlYiFKN4bzSLjcX437r4KmuPxCfHiWRanL3iQ9b4ohDdLfJ/ZD1N54S2
         p/SWOolDV4iZNgyHbi4QpAl4liOmzpYabM4pQpcYlRpW549luh9WadgS9QhJes1wV6U6
         aTT6rcP7KF6mQNj7/7fB/hHYQJpveEg7opR9EtAIff3SZkeGPRQlD+itJ8iJC00RMmif
         kkqYXPWu3Gvzrg3yE9zWwXOLNPxZAZVD3m5gCCV1BQADhbblNmzcOjdcve6LHi8rlbm/
         mc0jzdacwdr6Db/P64WqRinMgyvEHBo3yUF+04/rGSMCfIFNyo6fSk1CuzvFCvIsIGRQ
         r2DQ==
X-Gm-Message-State: AGi0PubWKNZoynEuSMbleAGxrwofiTOBqFcMoS7ev3/wcgIFUFsUpy7A
        Vd6cpQvqG9QDgJxRuiU04bY=
X-Google-Smtp-Source: APiQypLxynL7JE9q+IReY89tAIdlSibLu7fiLFyDHSVDYQXBdXJyuz24+DnZFevMiJ8c7hxElV6KNA==
X-Received: by 2002:aed:2de7:: with SMTP id i94mr16651310qtd.248.1587853506847;
        Sat, 25 Apr 2020 15:25:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i5sm6631996qtw.97.2020.04.25.15.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 15:25:06 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 25 Apr 2020 18:25:04 -0400
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>, jgross@suse.com,
        x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, Michael Matz <matz@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200425222504.GA1080319@rani.riverdale.lan>
References: <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic>
 <20200423161126.GD26021@zn.tnic>
 <20200425014657.GA2191784@rani.riverdale.lan>
 <20200425085759.GA24294@zn.tnic>
 <20200425150440.GA470719@rani.riverdale.lan>
 <20200425173140.GB24294@zn.tnic>
 <20200425183701.GE17645@gate.crashing.org>
 <20200425185313.GD24294@zn.tnic>
 <20200425191549.GF17645@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200425191549.GF17645@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 02:15:49PM -0500, Segher Boessenkool wrote:
> On Sat, Apr 25, 2020 at 08:53:13PM +0200, Borislav Petkov wrote:
> > On Sat, Apr 25, 2020 at 01:37:01PM -0500, Segher Boessenkool wrote:
> > > That is a lot more typing then
> > > 	asm("");
> > 
> > That's why a macro with a hopefully more descriptive name would be
> > telling more than a mere asm("").
> 
> My point is that you should explain at *every use* of this why you cannot
> have tail calls *there*.  This is very unusual, after all.
> 
> There are *very* few places where you want to prevent tail calls, that's
> why there is no attribute for it.
> 
> 
> Segher

Well, there is -fno-optimize-sibling-calls, but we wouldn't be able to
use it via the optimize attribute for the same reason we couldn't use
no-stack-protector.
