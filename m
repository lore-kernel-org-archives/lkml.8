Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DD9C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8008206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epPAQj4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgBVQWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:22:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40206 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:22:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id b7so4871705qkl.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MdqxzzXPoIcQtN1yVVsOrdqBL5LnseCidtxS+ZQd6qM=;
        b=epPAQj4dws//isTKjVJBUDjl5lSvkK614XMZSc0uMGC9R01p7/7s+f0pP5ziNpAv9L
         8Wen+P5IceyxmpZOsLlk4aulUvGS0du2OJH2BMrm17X/moKuMP7hHCbfsBdr9jolZ2jL
         jHDdHdu6Ji3jPpu/WLvA/C32QirrIyMm2HvX4BUCe/QZAalfVzDj3AS8eb82zGe+lEZb
         DTqxRuhUNEpeZ9D/mpJu7bF5ZOpn6a+9VD4P2ho9efGLkrq5PHpKV5yzGFUUkWPkuRfH
         twf6/9wc5I8Vt9DKX2KmG6c4M/3Tg6qOzcpWfZLcOiv4ZzcMSgz24zKxxm/hqCJErUWc
         h2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MdqxzzXPoIcQtN1yVVsOrdqBL5LnseCidtxS+ZQd6qM=;
        b=efk5NE/6Ef583mUUiyHJp9hMuUmwg00o2HKWXfMRc0aU7d7//+cZOOgOgs1I0Cs3Qp
         3REXB6sTfk+3uoICkclEyJZsVBnf41MQ6k0sDXlMY7trisG6xdfDOVMvGP1HmkUfZ4JI
         Ihr0ILWgH5DJo5jSRkNlHwyaR26ii6gY9lI9z92kkBQXvgY3S/Qo8s7EIWJQYgXFbBw0
         pOsx4C5aFvIUlrDoY2T3Hj8jg2ZH77kopmmt+OArVlLKVRuLJBaFq6/CduFycjgiOTn7
         rgt+N17k6RaBxOpwojP+kKHCs0VHp5x2sncefb+Gsu++FFEi8GwDbta389FeWoxYoRMY
         prcQ==
X-Gm-Message-State: APjAAAVI9QnvKBp8rlYXjB0OntD+Kw6RtBT67yWuURUynLfXxxKkb+Eb
        xaeRwCsISItEo9oXRIESr/s=
X-Google-Smtp-Source: APXvYqy1KFrbIID6qeLfxbrfGELlGF+h3XJ6cIcK0ATEzyBhpziZaA5ggZgSIuJIjDr6bzEvcVF6vA==
X-Received: by 2002:a37:6650:: with SMTP id a77mr34249151qkc.343.1582388547911;
        Sat, 22 Feb 2020 08:22:27 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g19sm3212418qkk.91.2020.02.22.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 08:22:27 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 22 Feb 2020 11:22:25 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222162225.GA3326744@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222074254.GB11284@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 08:42:54AM +0100, Borislav Petkov wrote:
> On Fri, Feb 21, 2020 at 11:21:44PM -0800, Fangrui Song wrote:
> > In GNU ld, it seems that .shstrtab .symtab and .strtab are special
> > cased. Neither the input section description *(.shstrtab) nor *(*)
> > discards .shstrtab . I feel that this is a weird case (probably even a bug)
> > that lld should not implement.
> 
> Ok, forget what the tools do for a second: why is .shstrtab special and
> why would one want to keep it?
> 
> Because one still wants to know what the section names of an object are
> or other tools need it or why?
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

.shstrtab is required by the ELF specification. The e_shstrndx field in
the ELF header is the index of .shstrtab, and each section in the
section table is required to have an sh_name that points into the
.shstrtab.
