Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFCFC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8293F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EFwrmKls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgBMVV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:21:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38523 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgBMVV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:21:26 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so7057608oth.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGsKTwmXZKkhgFvhpGRDEU0YJwm0F82TSOoNgccUJWs=;
        b=EFwrmKlscNSkDz4PTNnaFK6o1tRIerj9Wx3vR0EhvSuOklj8Fl892cSjNi+1vE1SEi
         A8W2LUABtLqi3ObjLd4VB8bVDo+ya3e2tAzUF5bsBfw0mtEkI9BW0L1BQz1D0191ZZP8
         fNwmyD4ePeGipnp5V7F5jXPWHbSOeA47W3GOVyHrZijfg6pUEJhoHpiKiGgD7J3X9aOc
         gITLUZ0Bi4G8tZyBJKXoFVMjdz+z/HGwDwHOlbKjI5ESfr4OaRt9hupuUFU6p7tytw0T
         gY5D4jtOeDKfWyEXKADwn0Bqc8nZZjFZkvTbUHQB8OsEKz/ja0Ho/BzmgrpU3kgH0N8A
         fYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGsKTwmXZKkhgFvhpGRDEU0YJwm0F82TSOoNgccUJWs=;
        b=r9i8KbAQaf76j0RRSIbNv2Yw2TDNCk5YdY/z9bXY94seIVlPW+Bsh/LjQoObzWZM4Y
         cwHvpCR0FFTZFx29Xd8igGrF9sl61aNNSaWuYb+K1YQqRWehnygrpvR6a7H+0m7Zv6he
         gkoHT/UHUNYSeVFX7FPoFJfL1IzZI75CgvOzhkAcAn21a0vtr87KJcc3Tz7lG3DXPCpG
         QPsUYstP4YbC8hGDc+WtHzI0ND2luMp7waGnMQCBCrGy6htUcyNenI4Xrr8JcQ5dbv2x
         YjO4HlAqGCgU+1STPRaroGGuP1O4+DbWw/AHEcAe1YQw7u0orZwjWsMDYbQU9Uq7EDub
         0ImA==
X-Gm-Message-State: APjAAAUAsz55Ix7QAkVpWKxGqhwVf+BSt5Ril3F+4MPID9sZAK5ouuve
        zKhZSwPftxRcOgNlIuuEl15gCQj99RrIg959aIEhRw==
X-Google-Smtp-Source: APXvYqxqSR6Goyr2KCN3goF6e96KcdmhwnR4SgD29bhp+Sk6iKS8Im4RLkbyZSHY/3GL5iAhFPf2ezlKNv406KBKVUI=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr8517375oti.207.1581628885704;
 Thu, 13 Feb 2020 13:21:25 -0800 (PST)
MIME-Version: 1.0
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
 <877e0q3f68.fsf@nanos.tec.linutronix.de>
In-Reply-To: <877e0q3f68.fsf@nanos.tec.linutronix.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Feb 2020 13:21:14 -0800
Message-ID: <CAPcyv4gNYS_MCF9PgMUFfC-WChbk3VJF8qkNUV4wGaLk0SjL0g@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 3:22 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > +#ifdef CONFIG_KEEP_NUMA
> > +#define __initdata_numa
> > +#else
> > +#define __initdata_numa __initdata
> > +#endif
>
> TBH, I find this conditional annotation mightingly confusing.
>
> __initdata_numa still suggest that this is __initdata, just a different
> section and some extra rules or whatever.
>
> Something like __initdata_or_keepnuma (sorry I could not come up with
> something prettier, but you get the idea.

Yes, and to dovetail with Ingo's feedback I think
__initdata_or_meminfo conveys it's optionally init vs runtime data.
