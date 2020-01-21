Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A1CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B7E21569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ok4jwoHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAUPTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:19:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35261 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgAUPTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:19:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so3256495oto.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mm7jpijz5VXxprpWuSYA/86oxtT/8g9q1t5VxERKtr4=;
        b=Ok4jwoHuT1OPsDWsm1pQ3a/gWcBTb5b/iBdXDz8AU0J8iIpZCNl/zKSLz/BXyyCDlG
         tkJYcVKtfS0j6pccZnIYfVAC4ejrM7qZ7H/9bVtwdUuqzbmNgGjtH9DYWHL3stFuugRU
         5FFgzD1SrNiYhz3vUn1a9d6vOXdPs1RDnp9b6MJovQ02nI9bX3mv4RY7/l+rKvFGXlI+
         bYCM5eYALG++z8f/W/ZObu1mzpKPmLuCwbYAFRYcG6Qry6P3Io2ttLEPcU3aiasuj3ML
         qf17h42V2Pn7IstpILkGGSRLAOVPOaTgSTOCEWX1SAVCQi6HP0U57yfZZN7DB7+OztLD
         VLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mm7jpijz5VXxprpWuSYA/86oxtT/8g9q1t5VxERKtr4=;
        b=sLpPRUV331bhT8AlgTcrIJ/C2Mar/Rp19+nFGRwAb6ed+9F33dx1CQYrNasTZzQ36u
         vbEMSAmXnKQcfetxnYkF/4D2uhxcybhe8BVgenftD3NjLujf9DTltdeZ5wk+SH/n/0IY
         x8cdOa8V6zidyV6woGXAJZEWrXlTtAYGoCskeWIXz+H/b2HgkW5zTi0wV3x+tPAN4B4U
         YhcGWWxJJctb3hZzeYuB4SYWeI+cD+XjgM3XsEkuc4UghrWaPTynPEoY8T7gpotxiF5m
         GJvFn247qUrKNRjAFb2gMG6fHNRcHKbfphzMk7rjm0uXpSmy8OFSEc1w9ZntyTLVs1RF
         gPIQ==
X-Gm-Message-State: APjAAAUiSCweDjqBAKg00kOE1JJr+ba2xzNGfTQ7pJOaT+Ek3qawTQjc
        MnNq820tjFFTacqS3CYZst8h4CfGJZc67xLnlUx37w==
X-Google-Smtp-Source: APXvYqzeJwk8Ov1ogtRIq3ib5e2DbgSzjJiG0VHAVlsSX+5ELefyp4eW+NWh+QG5KLeOHYtCc4CtQvlbyb505VPXbXs=
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr3643148oti.251.1579619973684;
 Tue, 21 Jan 2020 07:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20200121151503.2934-1-cai@lca.pw>
In-Reply-To: <20200121151503.2934-1-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jan 2020 16:19:22 +0100
Message-ID: <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 at 16:15, Qian Cai <cai@lca.pw> wrote:
>
> Macro Elver mentioned,
>
> "Yes. I was finally able to reproduce this data race on linux-next (my
> system doesn't crash though, maybe not enough cores?). Here is a trace
> with line numbers:
>
> read to 0xffffffffaa59a000 of 8 bytes by interrupt on cpu 7:
> cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> __change_page_attr+0x10cf/0x1840 arch/x86/mm/pat/set_memory.c:1514
> __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> __set_pages_np+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2148
> __kernel_map_pages+0xb0/0xc8 arch/x86/mm/pat/set_memory.c:2178
> kernel_map_pages include/linux/mm.h:2719 [inline]
> <snip>
>
> write to 0xffffffffaa59a000 of 8 bytes by task 1 on cpu 6:
> cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> __change_page_attr+0x10ea/0x1840 arch/x86/mm/pat/set_memory.c:1514
> __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> __set_pages_p+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2129
> __kernel_map_pages+0x2e/0xc8 arch/x86/mm/pat/set_memory.c:2176
> kernel_map_pages include/linux/mm.h:2719 [inline]
> <snip>
>
> Both accesses are due to the same "cpa_4k_install++" in
> cpa_inc_4k_install. Now you can see that a data race here could be
> potentially undesirable: depending on compiler optimizations or how
> x86 executes a non-LOCK'd increment, you may lose increments, corrupt
> the counter, etc. Since this counter only seems to be used for
> printing some stats, this data race itself is unlikely to cause harm
> to the system though."

Thank you for the patch!

Could you remove the verbatim copy of my email? Maybe something like:

"Increments to cpa_4k_install may happen concurrently, as detected by KCSAN:

<....... the stack traces ......>

Since the counter is only used to count stats, a data race will not be
harmful, thus we mark it as an intentional data race with the
'data_race()' macro.

Otherwise, this may generate a lot of noise on a debug kernel with
debug_pagealloc
with KCSAN enabled which could render the system unusable."

Thanks,
-- Marco

> This will generate a lot of noise on a debug kernel with debug_pagealloc
> with KCSAN enabled which could render the system unusable. Silence it by
> using the data_race() macro.
>
> Suggested-by: Macro Elver <elver@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 20823392f4f2..a5c35e57905e 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
>
>  static inline void cpa_inc_4k_install(void)
>  {
> -       cpa_4k_install++;
> +       data_race(cpa_4k_install++);
>  }
>
>  static inline void cpa_inc_lp_sameprot(int level)
> --
> 2.21.0 (Apple Git-122.2)
>
