Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.skyhub.de ([5.9.137.197]:40062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730052AbgCKQRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:17:49 -0400
Date: Wed, 11 Mar 2020 17:17:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Qian Cai <cai@lca.pw>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, elver@google.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH -next] x86/mm/pat: mark an intentional data race
Message-ID: <20200311161756.GE3470@zn.tnic>
References: <1581343816-6490-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581343816-6490-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+ Paul.

On Mon, Feb 10, 2020 at 09:10:16AM -0500, Qian Cai wrote:
> cpa_4k_install could be accessed concurrently as noticed by KCSAN,
> 
> read to 0xffffffffaa59a000 of 8 bytes by interrupt on cpu 7:
> cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> __change_page_attr+0x10cf/0x1840 arch/x86/mm/pat/set_memory.c:1514
> __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> __set_pages_np+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2148
> __kernel_map_pages+0xb0/0xc8 arch/x86/mm/pat/set_memory.c:2178
> kernel_map_pages include/linux/mm.h:2719 [inline] <snip>
> 
> write to 0xffffffffaa59a000 of 8 bytes by task 1 on cpu 6:
> cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> __change_page_attr+0x10ea/0x1840 arch/x86/mm/pat/set_memory.c:1514
> __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> __set_pages_p+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2129
> __kernel_map_pages+0x2e/0xc8 arch/x86/mm/pat/set_memory.c:2176
> kernel_map_pages include/linux/mm.h:2719 [inline] <snip>
> 
> Both accesses are due to the same "cpa_4k_install++" in
> cpa_inc_4k_install. A data race here could be potentially undesirable:
> depending on compiler optimizations or how x86 executes a non-LOCK'd
> increment, it may lose increments, corrupt the counter, etc. Since this
> counter only seems to be used for printing some stats, this data race
> itself is unlikely to cause harm to the system though. Thus, mark this
> intentional data race using the data_race() marco.
> 
> Suggested-by: Macro Elver <elver@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index c4aedd00c1ba..ea0b6df950ee 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
>  
>  static inline void cpa_inc_4k_install(void)
>  {
> -	cpa_4k_install++;
> +	data_race(cpa_4k_install++);
>  }
>  
>  static inline void cpa_inc_lp_sameprot(int level)
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

