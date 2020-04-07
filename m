Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4755C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53F2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDGVs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDGVs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:48:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A33220748;
        Tue,  7 Apr 2020 21:48:25 +0000 (UTC)
Date:   Tue, 7 Apr 2020 17:48:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200407174824.5e97a597@gandalf.local.home>
In-Reply-To: <20200407111007.429362016@infradead.org>
References: <20200407110236.930134290@infradead.org>
        <20200407111007.429362016@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Apr 2020 13:02:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Since we now have infrastructure to analyze module text, disallow
> modules that write to CRn and DRn registers.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/module.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -266,6 +266,22 @@ static bool insn_is_vmx(struct insn *ins
>  	return false;
>  }
>  
> +static bool insn_is_mov_CRn(struct insn *insn)
> +{
> +	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x22)
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool insn_is_mov_DRn(struct insn *insn)
> +{
> +	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x23)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int decode_module(struct module *mod, void *text, void *text_end, bool sld_safe)
>  {
>  	bool allow_vmx = sld_safe || !split_lock_enabled();
> @@ -285,6 +301,11 @@ static int decode_module(struct module *
>  			return -ENOEXEC;
>  		}
>  
> +		if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
> +			pr_err("Module writes to CRn or DRn, please use the proper accessors: %s\n", mod->name);
> +			return -ENOEXEC;
> +		}

Hmm, wont this break jailhouse?

-- Steve

> +
>  		text += insn.length;
>  	}
>  
> 

