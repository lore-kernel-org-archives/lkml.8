Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782DDC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498F1206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKuDdVwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgAMXGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:06:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44168 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgAMXGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:06:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so10375196qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 15:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GeX4pnIKRQ0zR69Ue2KwTIka7U9do+Z/Em7N3Ha5GRA=;
        b=bKuDdVwHGWAisFgFojxSx8bAK5C0LdXrhAxOZtwjddLfnrDVrdlV/5AF1V85d8Akd+
         AlorQVjwAGsQsJxc0/dvXmZyy4WY4snAQXt4Q79C0RHlWCC5fcqMpUs+7E66rC2BRUpk
         b4SKtFVAsE5HeVPv1VXYVw6V594Ly5Du5pZCeviDUl2PbvvnifZn5qNY7t7dSFDPEwRD
         BckwmoF+NlijL11teJqQ30bEXvyP7hq4/2ZJE69kjGdlkSzjONojz6WaYDBxg1KmPiUO
         Sd4zVWssUAmrXIusqjRuzlSZG6++4FLnywZwpW/Cov0ylPe0rOUYG8UCZ9QYiAQeOkmy
         LPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GeX4pnIKRQ0zR69Ue2KwTIka7U9do+Z/Em7N3Ha5GRA=;
        b=rPoBIx7D23sFwIFlwiBPgbgKHZRJ0YGIUBaosQKsiv+iHpy9UORkB50wi8juzObXSF
         rgdLkC+T+F4ZECsC22cFVqrEGV4+1Z5jUfoAV34S+ehgloJZQ8FdjYQ+aNCZTP3boErV
         74zJ2AIq6HykNYUR9P7L4G3MeakS9bnb0+3ncUIvmeD9MNnGq371LqoK4SJv47+UPng4
         AZ0SnvmQAp19Wtkr+J3MXOnM8PMcqImUALvTQ45Xko0rB5EsRFV+R/hZx2D0EvU1cRas
         AarS8rUQLcPf254Hex3Mb/97Lac5vhGQyfs514xy1yQDf2vYLbUUCnI41Vm2zkMbL85e
         vwyw==
X-Gm-Message-State: APjAAAUzv24phmXFd3gHoPsIznUH4TB0qs/Lcy1spmYNgI1z+Phumpz2
        5hLazoRzppgPg1Jq/haFns0=
X-Google-Smtp-Source: APXvYqxg+XoOvInftauHiXdNqO8fGEwgIeM4RGQ93zDzLNO2om8k+QHcYuamFiHBDpVFL003/RNX+A==
X-Received: by 2002:ae9:f442:: with SMTP id z2mr14127285qkl.130.1578956805248;
        Mon, 13 Jan 2020 15:06:45 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u15sm5693513qku.67.2020.01.13.15.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:06:44 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 Jan 2020 18:06:43 -0500
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
Message-ID: <20200113230642.GA2000869@rani.riverdale.lan>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <3e46154d-6e5e-1c16-90fe-f2c5daa44b60@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e46154d-6e5e-1c16-90fe-f2c5daa44b60@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 03:46:04PM -0600, Tom Lendacky wrote:
> > @@ -372,7 +374,7 @@ SECTIONS
> >  	 * explicitly reserved using memblock_reserve() or it will be discarded
> >  	 * and treated as available memory.
> >  	 */
> > -	__end_of_kernel_reserve = .;
> > +	__end_of_kernel_reserve = __bss_stop;
> 
> The only thing I worry about is if someone inserts a section between
> the bss section and here and doesn't update this value.
> 
> Thanks,
> Tom

Could do something like this, or maybe with just the comment?

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bad4e22384dc..25aa1b30068e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -373,9 +373,16 @@ SECTIONS
 	 * automatically reserved in setup_arch(). Anything after here must be
 	 * explicitly reserved using memblock_reserve() or it will be discarded
 	 * and treated as available memory.
+	 *
+	 * Note that this is defined to use __bss_stop rather than dot for
+	 * compatibility with binutils <2.23, so the definition MUST be updated
+	 * if another section is added after .bss.
 	 */
 	__end_of_kernel_reserve = __bss_stop;
 
+	/* Used for build-time check that __end_of_kernel_reserve is correct */
+	__end_of_kernel_reserve_check = .;
+
 	. = ALIGN(PAGE_SIZE);
 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
@@ -451,6 +458,9 @@ INIT_PER_CPU(irq_stack_backing_store);
 
 #endif /* CONFIG_X86_32 */
 
+. = ASSERT(__end_of_kernel_reserve == __end_of_kernel_reserve_check,
+	   "__end_of_kernel_reserve is incorrectly defined");
+
 #ifdef CONFIG_KEXEC_CORE
 #include <asm/kexec.h>
 
