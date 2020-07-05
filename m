Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF19C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 05:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4772088E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 05:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3O12iI2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgGEFrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 01:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGEFrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 01:47:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC9C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 22:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=4qY9OjUIgaxXnuAuS1ury4SidM23kgQAcoG5OlSPyBE=; b=3O12iI2xcJ+P2JAvDlypgqjgh/
        miZ2CXQ5YEJDB+0DVEkVJ7L5DDTixjT4xSSux6r4kFYOCMlutnQaSJJRxSljNLOp9p2IJLNE3jDiZ
        1n+IrdtmBK76VPCQ/aUTwsbxooSG1UUY67l5s58khN7eJC0gHQtHr4umu48E/RGgrnLHMwzSIOcaf
        yexhMgUo5I96s8kZB6TDfJLxWmMBy/FErK02boEz7WhaZLHBQiRQi54WHGZ5Bxda3L3/isLu95vw0
        YDBjWH8L1lWlr5d0jZFIlPUJvL7lsFs61387lA0wArLRqJThzgUWid8g1dbm7caSz2rpksh+HpOO0
        7PncVi/w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrxUK-0003Pg-Eg; Sun, 05 Jul 2020 05:46:53 +0000
Subject: Re: [PATCH v3 1/3] Correct asm VMXOFF side effects
To:     "David P. Reed" <dpreed@deepplum.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200629214956.GA12962@linux.intel.com>
 <20200704203809.76391-1-dpreed@deepplum.com>
 <20200704203809.76391-2-dpreed@deepplum.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <66a04b73-32ad-6982-f4c9-c85b890e37b1@infradead.org>
Date:   Sat, 4 Jul 2020 22:46:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200704203809.76391-2-dpreed@deepplum.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/20 1:38 PM, David P. Reed wrote:
> Tell gcc that VMXOFF instruction clobbers condition codes
> and memory when executed.
> Also, correct original comments to remove kernel-doc syntax
> per Randy Dunlap's request.

Looks good. Thanks.  For the comment changes:
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: David P. Reed <dpreed@deepplum.com>
> ---
>  arch/x86/include/asm/virtext.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
> index 9aad0e0876fb..0ede8d04535a 100644
> --- a/arch/x86/include/asm/virtext.h
> +++ b/arch/x86/include/asm/virtext.h
> @@ -30,7 +30,7 @@ static inline int cpu_has_vmx(void)
>  }
>  
>  
> -/** Disable VMX on the current CPU
> +/* Disable VMX on the current CPU
>   *
>   * vmxoff causes a undefined-opcode exception if vmxon was not run
>   * on the CPU previously. Only call this function if you know VMX
> @@ -38,7 +38,7 @@ static inline int cpu_has_vmx(void)
>   */
>  static inline void cpu_vmxoff(void)
>  {
> -	asm volatile ("vmxoff");
> +	asm volatile ("vmxoff" ::: "cc", "memory");
>  	cr4_clear_bits(X86_CR4_VMXE);
>  }
>  
> @@ -47,7 +47,7 @@ static inline int cpu_vmx_enabled(void)
>  	return __read_cr4() & X86_CR4_VMXE;
>  }
>  
> -/** Disable VMX if it is enabled on the current CPU
> +/* Disable VMX if it is enabled on the current CPU
>   *
>   * You shouldn't call this if cpu_has_vmx() returns 0.
>   */
> @@ -57,7 +57,7 @@ static inline void __cpu_emergency_vmxoff(void)
>  		cpu_vmxoff();
>  }
>  
> -/** Disable VMX if it is supported and enabled on the current CPU
> +/* Disable VMX if it is supported and enabled on the current CPU
>   */
>  static inline void cpu_emergency_vmxoff(void)
>  {
> 


-- 
~Randy

