Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5147AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9B52067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgF2Tb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:31:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:36734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732448AbgF2Tb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 326E3AD76;
        Mon, 29 Jun 2020 05:17:22 +0000 (UTC)
Subject: Re: [PATCH fsgsbase v2 4/4] x86/fsgsbase: Fix Xen PV support
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <cover.1593192140.git.luto@kernel.org>
 <f07c08f178fe9711915862b656722a207cd52c28.1593192140.git.luto@kernel.org>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <714d4c04-5907-885f-e23b-baef662f1080@suse.com>
Date:   Mon, 29 Jun 2020 07:17:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f07c08f178fe9711915862b656722a207cd52c28.1593192140.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.20 19:24, Andy Lutomirski wrote:
> On Xen PV, SWAPGS doesn't work.  Teach __rdfsbase_inactive() and
> __wrgsbase_inactive() to use rdmsrl()/wrmsrl() on Xen PV.  The Xen
> pvop code will understand this and issue the correct hypercalls.
> 
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>   arch/x86/kernel/process_64.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index cb8e37d3acaa..457d02aa10d8 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -163,9 +163,13 @@ static noinstr unsigned long __rdgsbase_inactive(void)
>   
>   	lockdep_assert_irqs_disabled();
>   
> -	native_swapgs();
> -	gsbase = rdgsbase();
> -	native_swapgs();
> +	if (!static_cpu_has(X86_FEATURE_XENPV)) {
> +		native_swapgs();
> +		gsbase = rdgsbase();
> +		native_swapgs();
> +	} else {
> +		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
> +	}
>   
>   	return gsbase;
>   }
> @@ -182,9 +186,13 @@ static noinstr void __wrgsbase_inactive(unsigned long gsbase)
>   {
>   	lockdep_assert_irqs_disabled();
>   
> -	native_swapgs();
> -	wrgsbase(gsbase);
> -	native_swapgs();
> +	if (!static_cpu_has(X86_FEATURE_XENPV)) {
> +		native_swapgs();
> +		wrgsbase(gsbase);
> +		native_swapgs();
> +	} else {
> +		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
> +	}
>   }
>   
>   /*
> 

Another possibility would be to just do (I'm fine either way):

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index acc49fa6a097..b78dd373adbf 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -318,6 +318,8 @@ static void __init xen_init_capabilities(void)
  		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
  		setup_clear_cpu_cap(X86_FEATURE_OSXSAVE);
  	}
+
+	setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
  }

  static void xen_set_debugreg(int reg, unsigned long val)


Juergen
