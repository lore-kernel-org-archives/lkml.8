Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1C7C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E029C20700
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="h+zIYo6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDYI6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgDYI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:58:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39084C09B04A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 01:58:10 -0700 (PDT)
Received: from zn.tnic (p200300EC2F2A110038DA0814AB9A5F9F.dip0.t-ipconnect.de [IPv6:2003:ec:2f2a:1100:38da:814:ab9a:5f9f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 672301EC0C89;
        Sat, 25 Apr 2020 10:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587805086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3Y4V1uVz2ZFfCyhURzs0bYXQDQsiH4z6rVXjpkd4EA=;
        b=h+zIYo6OzDqCmKYjla0c3j+uqIn2RNYYZqPs42836G8Ri+qS+ebhncWZb6xmb6Er95AAS6
        NzW8l0r679yN+ffI+oMgcDzBIV702f0Hgqfu31tXKNdVc9FYQYDVBGGrdrzwGYoYMzGdfw
        YsFyDZA+BazaPSEtblmlkmJZtkNCbEU=
Date:   Sat, 25 Apr 2020 10:57:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>, boris.ostrovsky@oracle.com,
        jgross@suse.com
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200425085759.GA24294@zn.tnic>
References: <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic>
 <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
 <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic>
 <20200423161126.GD26021@zn.tnic>
 <20200425014657.GA2191784@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200425014657.GA2191784@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 09:46:57PM -0400, Arvind Sankar wrote:
> The comment above boot_init_stack_canary's definition should be updated
> to note that it needs to be called from a function that, in addition to
> not returning, either has stackprotector disabled or avoids ending in a
> tail call.

How's that?

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 91e29b6a86a5..237a54f60d6b 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -55,8 +55,12 @@
 /*
  * Initialize the stackprotector canary value.
  *
- * NOTE: this must only be called from functions that never return,
- * and it must always be inlined.
+ * NOTE: this must only be called from functions that never return, it must
+ * always be inlined and it should be called from a compilation unit for
+ * which stack protector is disabled.
+ *
+ * Alternatively, the caller should not end with a function call which gets
+ * tail-call optimized as that would lead to checking a modified canary value.
  */
 static __always_inline void boot_init_stack_canary(void)
 {

> There are also other calls that likely need to be fixed as well -- in
> init/main.c, arch/x86/xen/smp_pv.c, and there is a powerpc version of
> start_secondary in arch/powerpc/kernel/smp.c which may also be affected.

Yes, there was an attempt to fix former:

https://lkml.kernel.org/r/20200413123535.10884-1-frederic.pierret@qubes-os.org

I probably should point the folks to this thread. CCed.

Boris O, Jürgen, I'm guessing I should fix cpu_bringup_and_idle() too,
see:

https://lkml.kernel.org/r/20200423161126.GD26021@zn.tnic

or do you prefer a separate patch?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
