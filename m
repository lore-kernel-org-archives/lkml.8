Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8277020707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9UhGvPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFPJ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:29:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbgFPJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592299779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w27PppGCNHa7BlqB4ZmBJJKBjKDuXsEEjvN7xI5y/wY=;
        b=f9UhGvPhZPB3NFWEx7qgkmiuRDi09eOM5p2E9k3BLaB3nVuFiSVLCA7/G/rp8dlUM0Osu4
        vogan1aywmtAAEoQCvNY+th5PfbLI2atXnCkmMf8DyjBvkf1wwq/XXBiwEZO+BHlsF9pK1
        Q1rKpYwS39PzoT02H+QvL65BgDZeTI4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-FaA1qR56OCWHhYSP1STpGw-1; Tue, 16 Jun 2020 05:29:38 -0400
X-MC-Unique: FaA1qR56OCWHhYSP1STpGw-1
Received: by mail-ej1-f70.google.com with SMTP id a20so9135839ejt.19
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=w27PppGCNHa7BlqB4ZmBJJKBjKDuXsEEjvN7xI5y/wY=;
        b=lewu9r9bHeynuddv2pu4mAmqOtE3YbPqc5vps8pZgVAU3/mxye/iffM3oviXqck4Nl
         Me78nlZx2LUlG5oH7hCyxBDNu7LwoSfS6JtNT0U1tRFCRshYNdYeSPXN77E9IyiqrOXx
         fLAmj5B7KWuKVNprU26JP/ESU5vHOODXfpH0K03FgX7ZseI6DrO4WYDn+B8pxDt0WlWB
         pOYz9sN0I9L5SBEweEqbT42eBlfQ7VHbWulpVBfw8Duntp1i16tLLemv8fUtRI67+Mbu
         pgJubF/dLrgcJXQ3x3P2iIV4B2/W7fJWGknX4OR2iWS4oAaMGBL2QQgBrSlE5KY6pFtZ
         mJvg==
X-Gm-Message-State: AOAM531nPHi9uhnM6SiWxwZ7tdYhzAcnK3gGJgQ3HSlZPupfNjIZfTbn
        jyx0c654Q5m1olhx4PuFyZjTbqVYnDQxwrcrwlXGmuJc6CRLooI7G3Q43RqQfPzsXlhOPOO/Fsn
        hpugE+3dLD3ptsCUk41iVi2cH
X-Received: by 2002:a50:a661:: with SMTP id d88mr1750436edc.34.1592299775724;
        Tue, 16 Jun 2020 02:29:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7r8cYFV60rjN5o4yKdkb8nWDxUEa81BhQvUY5yHr8NVP+hKyKpOqlSIbnDs5cmA4czkq4Yg==
X-Received: by 2002:a50:a661:: with SMTP id d88mr1750417edc.34.1592299775484;
        Tue, 16 Jun 2020 02:29:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b26sm10694420eju.6.2020.06.16.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:29:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@lst.de>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: hv_hypercall_pg page permissios
In-Reply-To: <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
Date:   Tue, 16 Jun 2020 11:29:33 +0200
Message-ID: <87blljicjm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

>> From: linux-hyperv-owner@vger.kernel.org
>> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Dexuan Cui
>> Sent: Monday, June 15, 2020 10:42 AM
>> > >
>> > > Hi hch,
>> > > The patch is merged into the mainine recently, but unluckily we noticed
>> > > a warning with CONFIG_DEBUG_WX=y
>> > >
>> > > Should we revert this patch, or figure out a way to ask the DEBUG_WX
>> > > code to ignore this page?
>> >
>> > Are you sure it is hv_hypercall_pg?
>> Yes, 100% sure. I printed the value of hv_hypercall_pg and and it matched the
>> address in the warning line " x86/mm: Found insecure W+X mapping at
>> address".
>
> I did this experiment:
>   1. export vmalloc_exec and ptdump_walk_pgd_level_checkwx.
>   2. write a test module that calls them.
>   3. It turns out that every call of vmalloc_exec() triggers such a warning.
>
> vmalloc_exec() uses PAGE_KERNEL_EXEC, which is defined as
>    (__PP|__RW|   0|___A|   0|___D|   0|___G)
>
> It looks the logic in note_page() is: for_each_RW_page, if the NX bit is unset,
> then report the page as an insecure W+X mapping. IMO this explains the
> warning?

Yea, bummer.

it seems we need something like PAGE_KERNEL_READONLY_EXEC but we don't
seem to have one on x86. Hypercall page is special in a way that the
guest doesn't need to write there at all. vmalloc_exec() seems to have
only one other user on x86: module_alloc() and it has other needs. On
ARM, alloc_insn_page() does the following:

arch/arm64/kernel/probes/kprobes.c:     page = vmalloc_exec(PAGE_SIZE);
arch/arm64/kernel/probes/kprobes.c-     if (page) {
arch/arm64/kernel/probes/kprobes.c-             set_memory_ro((unsigned long)page, 1);
arch/arm64/kernel/probes/kprobes.c-             set_vm_flush_reset_perms(page);
arch/arm64/kernel/probes/kprobes.c-     }

What if we do the same? (almost untested):

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e2137070386a..31aadfea589b 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/cpuhotplug.h>
 #include <linux/syscore_ops.h>
+#include <linux/set_memory.h>
 #include <clocksource/hyperv_timer.h>
 
 void *hv_hypercall_pg;
@@ -383,6 +384,8 @@ void __init hyperv_init(void)
                wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
                goto remove_cpuhp_state;
        }
+       set_memory_ro((unsigned long)hv_hypercall_pg, 1);
+       set_vm_flush_reset_perms(hv_hypercall_pg);
 
        rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
        hypercall_msr.enable = 1;

-- 
Vitaly

