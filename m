Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3D9C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DE420801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoIByrGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgBSTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:06:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32872 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgBSTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:06:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so1207424qkm.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m/aJSG1GnO/FT6DkcizY0uaRrvb/5pvLMIdj8tnZKx8=;
        b=XoIByrGDv6i82eVAV//K7wSt8/qjjE4WRdFaDTsnvyoaOczAZrPomz2G6fvczEljhO
         QUK/NFCscW2+/b/4kZ7Oz9cUXubB0OaO3eAzmzAdMt59Ino3V2JJNpklqOh9NxaCJwlt
         CDJM5nyxfJMCKzbsuCKGsTVJTAwYZIkjlnZV8H4Rp4bdzKa72tmsBQh3C5ZUxIeDQLUl
         KgdxHVs8LKaBfhSSX2Fleo/A+ZUDA8Dx+u6WXZGWMFeBmZQK8LWO0+jXCfNeORrxX0ay
         vDvWNJP2eTO+2yWwRzwEBC4aUrlU2ZBsYrnTgMp5h6ITZt1XNLkbZ3R8R0Clq3Cg3Lic
         oe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/aJSG1GnO/FT6DkcizY0uaRrvb/5pvLMIdj8tnZKx8=;
        b=jRAt4EH3z22IlE14NjjZ31W1SvwVN48iX2338Yaz0dD4407uk+ptxPWxj4cGE09I9Y
         UufX5AmdTJFL9O43sgTW0eXxP3R1A+jMIisHr9+eu48IjwaxGcFJ9a6NoTfBhYunLe55
         tzlsGi2QuZ3ovSb8qmggmfVMXh38Qbrwr/BpXKcd6ZDQ734Jm1lTTCphaNp8LhqGGmMY
         QmG7yiKd9dpSpqFsWg5P+Ef0NGV+sVUe4sNWvqnXyOvYSWagDhd4sjO0CMetwGAT2dY1
         5WsqGxA2J/tFyk53NRyRYMIlCxqWl2jWHkXPhslnokq1g0kwIsz4daYB1lEa0FhsU18I
         0KlQ==
X-Gm-Message-State: APjAAAVUxtl70zIRKGAUkT0t0CkBVhv9ZMN1feJxRPBUyI/Ey+QdamNX
        CFtl6VGtx8tDr+nmhMzkQt0Lu/Yk
X-Google-Smtp-Source: APXvYqwUwOZpW1fVd3kaNR02Zf66B6fIWhv1+GJ5XEdDawDsImh3meHEQ4eCe+CPIGSZPG7nnJejAg==
X-Received: by 2002:a05:620a:1332:: with SMTP id p18mr2119777qkj.283.1582139202217;
        Wed, 19 Feb 2020 11:06:42 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r1sm434566qtu.83.2020.02.19.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:06:42 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 19 Feb 2020 14:06:40 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200219190640.GA1926073@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200205162921.GA318609@rani.riverdale.lan>
 <20200218180353.GA930230@rani.riverdale.lan>
 <20200219120938.GB30966@zn.tnic>
 <20200219175717.GA1892094@rani.riverdale.lan>
 <20200219182230.GG30966@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219182230.GG30966@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 07:22:30PM +0100, Borislav Petkov wrote:
> On Wed, Feb 19, 2020 at 12:57:17PM -0500, Arvind Sankar wrote:
> > There isn't any particular urgency (at least until fg-kaslr patches try
> 
> Ok, I was just making sure you're not pinging because there's something
> more urgent here. See below.
> 
> > to make it 64MiB bigger), but it's unclear how long to wait before
> > sending a reminder -- Documentation/process suggests that comments
> > should be received in a week or so, pinging after 4 and 6 weeks seemed
> > reasonable. If x86 has a longer queue, might be worth documenting that
> > somewhere?
> 
> We try to track all stuff but x86 is super crazy most of the time,
> especially currently, so stuff gets prioritized based on urgency and we
> also try to round-robin through all submitters so that stuff doesn't get
> left out.
> 
> Thus the one-week thing will never work with x86. Once a month ping
> maybe.
> 
> In your case, since it is an improvement which is good to have but not
> absolutely a must and not a bugfix, it is understandable that it would
> get pushed back in priority.
> 
> But stuff usually won't be forgotten and we'll get to it eventually - it
> is just that we're mega swamped all the time. :-\
> 

Ok, thanks.
