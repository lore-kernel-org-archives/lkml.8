Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B359C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737B620774
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgGFIl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:41:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgGFIl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:41:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A4A6AE6D;
        Mon,  6 Jul 2020 08:41:56 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id EB878602E3; Mon,  6 Jul 2020 10:41:55 +0200 (CEST)
Date:   Mon, 6 Jul 2020 10:41:55 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH entry v2 3/6] x86/entry/xen: Route #DB correctly on Xen PV
Message-ID: <20200706084155.ndltt24ipognh67e@lion.mk-sys.cz>
References: <cover.1593795633.git.luto@kernel.org>
 <4163e733cce0b41658e252c6c6b3464f33fdff17.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4163e733cce0b41658e252c6c6b3464f33fdff17.1593795633.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:02:55AM -0700, Andy Lutomirski wrote:
> On Xen PV, #DB doesn't use IST.  We still need to correctly route it
> depending on whether it came from user or kernel mode.
> 
> This patch gets rid of DECLARE/DEFINE_IDTENTRY_XEN -- it was too
> hard to follow the logic.  Instead, route #DB and NMI through
> DECLARE/DEFINE_IDTENTRY_RAW on Xen, and do the right thing for #DB.
> Also add more warnings to the exc_debug* handlers to make this type
> of failure more obvious.
> 
> This fixes various forms of corruption that happen when usermode
> triggers #DB on Xen PV.
> 
> Fixes: 4c0dcd8350a0 ("x86/entry: Implement user mode C entry points for #DB and #MCE")
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/idtentry.h | 24 ++++++------------------
>  arch/x86/kernel/traps.c         | 12 ++++++++++++
>  arch/x86/xen/enlighten_pv.c     | 28 ++++++++++++++++++++++++----
>  arch/x86/xen/xen-asm_64.S       |  5 ++---
>  4 files changed, 44 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index cf51c50eb356..94333ac3092b 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
[...]
> @@ -570,11 +554,15 @@ DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
>  
>  /* NMI */
>  DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
> -DECLARE_IDTENTRY_XEN(X86_TRAP_NMI,	nmi);
> +#ifdef CONFIG_XEN_PV
> +DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
> +#endif
>  
>  /* #DB */
>  DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
> -DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug);
> +#ifdef CONFIG_XEN_PV
> +DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	xenpv_exc_debug);
> +#endif
>  
>  /* #DF */
>  DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);

Hello,

this patch - now in mainline as commit 13cbc0cd4a30 ("x86/entry/32: Fix
#MC and #DB wiring on x86_32") - seems to break i586 builds with
CONFIG_XEN_PV=y as xenpv_exc_nmi and xenpv_exc_debug are only defined
with CONFIG_X86_64:

[ 1279s] ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_nmi':
[ 1279s] /home/abuild/rpmbuild/BUILD/kernel-pae-5.8.rc4/linux-5.8-rc4/linux-obj/../arch/x86/include/asm/idtentry.h:557: undefined reference to `xenpv_exc_nmi'
[ 1279s] ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_debug':
[ 1279s] /home/abuild/rpmbuild/BUILD/kernel-pae-5.8.rc4/linux-5.8-rc4/linux-obj/../arch/x86/include/asm/idtentry.h:567: undefined reference to `xenpv_exc_debug'

Michal Kubecek
